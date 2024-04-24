import 'package:flutter/material.dart';
import 'package:novacash1/provider/auth_provider.dart'; // Import your AuthProvider
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart'; // Import Razorpay package

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  late AuthProvider _authProvider; // Instance of AuthProvider
  late Razorpay _razorpay; // Instance of Razorpay

  List<Installment> installments = [];
  double _downPayment = 0.0; // Example downpayment amount, initially 0
  Installment? selectedInstallment;
  double _monthlyInstallment = 0.0;
  Set<Installment> paidInstallments = Set();

  @override
  void initState() {
    super.initState();
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    // Initialize Razorpay
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    // Fetch downpayment amount when the widget initializes
    fetchDownPayment();
  }

  @override
  void dispose() {
    // Dispose Razorpay instance
    _razorpay.clear();
    super.dispose();
  }

  // Method to handle payment error
  void handlePaymentError(PaymentFailureResponse response) {
    // Handle payment error
    print('Payment Error: ${response.message}');
  }

  // Method to handle payment success
  void handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle payment success
    print('Payment Success: ${response.paymentId}');

    // Mark the selected installment as paid
    setState(() {
      if (selectedInstallment != null) {
        paidInstallments.add(selectedInstallment!);
      }
    });
  }

  // Method to fetch downpayment amount from AuthProvider and calculate monthly installment
  void fetchDownPayment() async {
    double? downpayment = await _authProvider.getDownpaymentAmount();
    if (downpayment != null) {
      double remainingAmount = downpayment * 10 - (downpayment * 0.1);
      _monthlyInstallment = remainingAmount / 3;
      setState(() {
        _downPayment = downpayment;
        installments = [
          Installment(
            month: 'Month 1',
            amount: _monthlyInstallment,
            isPaid: false,
          ),
          Installment(
            month: 'Month 2',
            amount: _monthlyInstallment,
            isPaid: false,
          ),
          Installment(
            month: 'Month 3',
            amount: _monthlyInstallment,
            isPaid: false,
          ),
        ];
      });
    }
  }

  // Method to initiate Razorpay payment
  void initiateRazorpayPayment() {
    if (selectedInstallment != null) {
      String? phoneNumber = _authProvider.userModel.phoneNumber;
      String? email = _authProvider.userModel.email;

      var options = {
        'key': 'rzp_test_BKu1HuKKGYAWtN',
        'amount': (selectedInstallment!.amount * 100).toInt(),
        'name': 'EMI Payment',
        'description': 'Payment for ${selectedInstallment!.month}',
        'prefill': {'contact': phoneNumber, 'email': email},
        'external': {'wallets': ['paytm']}
      };
      _razorpay.open(options);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EMI Wallet'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Installment Schedule
          Card(
            child: Column(
              children: [
                // Downpayment
                ListTile(
                  title: Text('Downpayment Paid'),
                  trailing: Text('₹$_downPayment'),
                ),
                ListTile(
                  title: Text('Installment Schedule'),
                ),
                ListTile(
                  title: Text('Month'),
                  trailing: Text('Amount'),
                ),
                // Display installment details here
                for (var installment in installments)
                  if (!paidInstallments.contains(installment))
                    ListTile(
                      title: Text(installment.month),
                      trailing: Text(
                        '₹${installment.amount.toStringAsFixed(2)}',
                      ),
                      onTap: () {
                        setState(() {
                          selectedInstallment = installment;
                        });
                      },
                    ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          // Continue Pay Button
          Visibility(
            visible: selectedInstallment != null &&
                !paidInstallments.contains(selectedInstallment),
            child: ElevatedButton(
              onPressed: initiateRazorpayPayment,
              child: Text(
                'Continue Pay for ${selectedInstallment?.month ?? ""}',
              ),
            ),
          ),
          SizedBox(height: 16.0),
          // Monthly installment amount
          if (_monthlyInstallment != 0.0)
            ListTile(
              title: Text('Monthly Installment Amount'),
              trailing: Text('₹${_monthlyInstallment.toStringAsFixed(2)}'),
            ),
          SizedBox(height: 16.0),
          // Display paid installments
          for (var installment in installments)
            if (paidInstallments.contains(installment))
              ListTile(
                title: Text(installment.month),
                subtitle: Text('Paid'),
              )
        ],
      ),
    );
  }
}

class Installment {
  final String month;
  final double amount;
  bool isPaid;

  Installment({
    required this.month,
    required this.amount,
    required this.isPaid,
  });
}
