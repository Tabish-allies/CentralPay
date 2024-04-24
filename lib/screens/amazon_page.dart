import 'package:flutter/material.dart';
import 'package:novacash1/model/adress_model.dart';
import 'package:novacash1/provider/auth_provider.dart';
import 'package:novacash1/screens/emi_bottom_sheet.dart';
import 'package:provider/provider.dart';

class AmazonProductDetailPage extends StatefulWidget {
  final VoidCallback showCardCallback; // Callback function

  const AmazonProductDetailPage({Key? key, required this.showCardCallback})
      : super(key: key);

  @override
  State<AmazonProductDetailPage> createState() =>
      _AmazonProductDetailPageState();
}

class _AmazonProductDetailPageState extends State<AmazonProductDetailPage> {
  bool showEmiCard = false;
  TextEditingController linkController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  double _downPayment = 0.0;
  double _totalAmount = 0.0;
  int tenure = 0; // Define tenure variable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Amazon Store",
          style: TextStyle(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // Main card
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      const Text(
                        "Shop Upto ₹2500",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const Text(
                        "Amazon Shopping on EMI",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const Text(
                        "1234 people bought in last 30 days",
                        style: TextStyle(
                          fontSize: 8,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "You can paste the Amazon product Link here",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: linkController,
                        style: const TextStyle(),
                        decoration: const InputDecoration(
                          hintText: "Paste the Amazon link here",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Enter the price of the Product",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: amountController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                          signed: true,
                        ),
                        style: const TextStyle(),
                        decoration: const InputDecoration(
                          hintText: "Amount",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (linkController.text.isNotEmpty &&
                              amountController.text.isNotEmpty) {
                            double amount =
                                double.parse(amountController.text);
                            _downPayment = amount * 0.10; // 10% down payment
                            double remainingAmount =
                                amount - _downPayment; // Remaining amount after down payment
                            double interestRate = showEmiCard
                                ? (tenure == 3 ? 0.10 : 0.20)
                                : 0.10; // 10% for 3 months, 20% for 6 months
                            double interest =
                                remainingAmount * interestRate; // Calculate interest
                            _totalAmount =
                                remainingAmount + interest; // Total amount to pay

                            setState(() {
                              showEmiCard = true; // Update showEmiCard to true
                            });
                          } else {
                            // Show a snackbar or any other indication to the user that both fields need to be filled
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please fill both fields to reveal the EMI card.',
                                ),
                              ),
                            );
                          }
                        },
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.blue),
                          foregroundColor:
                              MaterialStatePropertyAll(Colors.white),
                        ),
                        child: const Text("See EMI Plans"),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),
              // EMI Card
              if (showEmiCard)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
                        Row(
                          children: [
                            const Icon(Icons.money_off_csred_outlined),
                            Text(
                                "Pay Now: ₹${(_downPayment % 1 == 0) ? _downPayment.toStringAsFixed(0) : _downPayment.toStringAsFixed(2)} Downpayment")
                          ],
                        ),
                        const Text("Choose EMI Tenure",
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        Row(
                          children: [
                            Text(
                                "₹${(_totalAmount / 3).toStringAsFixed(2)} x 3 months"),
                            const Spacer(),
                            Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                width: 110,
                                height: 30,
                                child: TextButton(
                                  onPressed: () {
                                    tenure = 3; // Set tenure to 3 months
                                    _showEmiBottomSheet(
                                        context, 3); // Pass the context and the tenure (3 months)
                                  },
                                  style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.blue),
                                    foregroundColor:
                                        MaterialStatePropertyAll(Colors.white),
                                  ),
                                  child: const Text(
                                    "Buy on 3 months EMI",
                                    style: TextStyle(fontSize: 8),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEmiBottomSheet(BuildContext context, int tenure) {
    // Get the Amazon link from the controller
    String amazonLink = linkController.text;
    _fetchUserAddresses().then((addresses) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          // Pass the Amazon link to the EmiBottomSheet
          return EmiBottomSheet(
            addresses: addresses,
            downPayment: _downPayment,
            tenure: tenure,
            amazonLink: amazonLink,
            linkController: linkController,
            totalAmount: _totalAmount,
          
          );
        },
      );
    }).catchError((error) {
      // Handle error if fetching addresses fails
      print('Error fetching addresses: $error');
    });
  }

  Future<List<AddressModel>> _fetchUserAddresses() async {
    try {
      final List<AddressModel> addresses = await Provider.of<AuthProvider>(
              context,
              listen: false)
          .getUserAddresses();
      return addresses;
    } catch (error) {
      print('Error fetching addresses: $error');
      throw error; // Rethrow the error to handle it where the function is called
    }
  }

}