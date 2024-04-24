import 'package:flutter/material.dart';
import 'package:novacash1/model/adress_model.dart';
import 'package:novacash1/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class EmiBottomSheet extends StatefulWidget {
  final List<AddressModel> addresses;
  final double downPayment;
  final int tenure;
  final String amazonLink;
  final TextEditingController linkController;
  final double totalAmount; // New property to accept total amount


  const EmiBottomSheet({
    required this.addresses,
    required this.downPayment,
    required this.tenure,
    required this.amazonLink,
    required this.linkController,
    required this.totalAmount, // Pass total amount here

  });

  @override
  _EmiBottomSheetState createState() => _EmiBottomSheetState();
}

class _EmiBottomSheetState extends State<EmiBottomSheet> {
  AddressModel? _selectedAddress;

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: const Text(
            'Select Address',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.addresses.length,
            itemBuilder: (context, index) {
              AddressModel address = widget.addresses[index];
              return Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                color: _selectedAddress == address
                    ? Colors.blue.withOpacity(0.1)
                    : null,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedAddress = address;
                    });
                  },
                  child: ListTile(
                    title: Text(address.street),
                    subtitle: Text(
                        '${address.city}, ${address.state} ${address.postalCode}'),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed:
                  _selectedAddress != null ? _continueToPay : null,
              child: const Text('Continue to pay'),
            ),
          ),
        ),
      ],
    );
  }

  void _continueToPay() {
    if (_selectedAddress != null) {
      AuthProvider authProvider =
          Provider.of<AuthProvider>(context, listen: false);
      String? phoneNumber = authProvider.userModel.phoneNumber;
      String? email = authProvider.userModel.email;

      Razorpay razorpay = Razorpay();
      var options = {
        'key': 'rzp_test_BKu1HuKKGYAWtN',
        'amount': (widget.downPayment * 100).toInt(),
        'name': 'CentralPay',
        'description':
            'Amazon Link: ${widget.amazonLink}\nShipping to: ${_selectedAddress!.street}, ${_selectedAddress!.city}, ${_selectedAddress!.state} ${_selectedAddress!.postalCode}',
        'method': {'netbanking': '1', 'card': '1', 'upi': '1', 'wallet': '1'},
        'retry': {'enabled': true, 'max_count': 1},
        'send_sms_hash': true,
        'prefill': {'contact':phoneNumber, 'email': email},
        'Notes': 'this is order',
        'external': {
          'wallets': ['paytm']
        }
      };
      razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
      razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,handlePaymentSuccessResponse);
      razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,handleExternalWalletSelected);
      razorpay.open(options);
    }
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    showAlertDialog(
        context,
        "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    showAlertDialog(
        context, "Payment Successful", "Payment ID: ${response.paymentId}");

  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        ElevatedButton(
          child: const Text("Continue"),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}