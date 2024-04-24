import 'dart:async';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class WalletBloc {
  double _downPayment = 0.0;
  List<Installment> _installments = [];
  Set<Installment> _paidInstallments = {};

  final _installmentsController = StreamController<List<Installment>>();
  final _downPaymentController = StreamController<double>();

  Stream<List<Installment>> get installmentsStream => _installmentsController.stream;
  Stream<double> get downPaymentStream => _downPaymentController.stream;

  Razorpay _razorpay = Razorpay();

  WalletBloc() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _fetchDownPayment();
  }

  void _fetchDownPayment() async {
    // Simulated fetching of down payment amount
    _downPayment = 2000.0;

    // Simulated calculation of installments
    double remainingAmount = _downPayment * 10 - (_downPayment * 0.1);
    double monthlyInstallment = remainingAmount / 3;

    _installments = [
      Installment(month: 'Month 1', amount: monthlyInstallment, isPaid: false),
      Installment(month: 'Month 2', amount: monthlyInstallment, isPaid: false),
      Installment(month: 'Month 3', amount: monthlyInstallment, isPaid: false),
    ];

    _emitInstallments();
    _emitDownPayment();
  }

  void _emitInstallments() {
    _installmentsController.sink.add(_installments);
  }

  void _emitDownPayment() {
    _downPaymentController.sink.add(_downPayment);
  }

  void markInstallmentPaid(Installment installment) {
    if (!_paidInstallments.contains(installment)) {
      _initiatePayment(installment);
    }
  }

  void _initiatePayment(Installment installment) {
    var options = {
      'key': 'rzp_test_BKu1HuKKGYAWtN',
      'amount': (installment.amount * 100).toInt(),
      'name': 'EMI Payment',
      'description': 'Payment for ${installment.month}',
      'external': {'wallets': ['paytm']}
    };

    _razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Installment paidInstallment = _installments.firstWhere((i) => i.month == response.orderId);
    paidInstallment.isPaid = true; // Mark installment as paid
    _paidInstallments.add(paidInstallment);
    _emitInstallments(); // Emit updated installments list
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Payment Error: ${response.message}');
  }

  void dispose() {
    _installmentsController.close();
    _downPaymentController.close();
    _razorpay.clear();
  }
}

class Installment {
  final String month;
  final double amount;
  bool isPaid;

  Installment({required this.month, required this.amount, this.isPaid = false});
}
