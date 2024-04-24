import 'package:flutter/material.dart';
import 'package:novacash1/screens/amazon_page.dart';
import 'package:novacash1/screens/flipkart_page.dart';
// Import FlipkartPage

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main Card
          SizedBox(
            width: double.infinity,
            child: Card(
              color: const Color.fromARGB(233, 95, 119, 167),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "₹2500",
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Available Credit Limit",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Our Shopping Partner",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 16),
          // Shopping app cards
          Row(
            children: [
              // Flipkart card
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FlipkartProductDetailPage(showCardCallback: () { print("Show card logic executed"); },), // Navigate to FlipkartPage
                    ),
                  );
                },
                child: Card(
                  elevation: 6,
                  child: Container(
                    width: 100,
                    padding: const EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        Image.asset(
                          'assets/flipkart-icon.png',
                          width: 50,
                          height: 45,
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              // Amazon Card
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AmazonProductDetailPage(
                        showCardCallback: () {
                          print("Show card logic executed");
                        },
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 6,
                  child: Container(
                    width: 100,
                    padding: const EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        Image.asset(
                          'assets/amazon-a-logo-icon.png',
                          width: 50,
                          height: 45,
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
