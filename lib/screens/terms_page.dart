import 'package:flutter/material.dart';

class TermsConditionPage extends StatelessWidget {
  const TermsConditionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms Condition"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(height: 12),
                      Text(
                        "1. Introduction",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                          "1.1. These terms and conditions govern your use of the services provided by Central Pay Finance Technology Private Limited By accessing or using our services, you agree to be bound by these Terms. If you do not agree to these Terms, you may not access or use our services."),
                      SizedBox(height: 12),
                      Text(
                        "2. Service Description",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                          "2.1. Central Pay Finance Technology Private Limited offers a service that allows users to purchase products through installment payments with added interest."),
                      SizedBox(height: 12),
                      Text(
                        "3. User Registration",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                          "3.1. In order to use our services, you must register an account with us. You agree to provide accurate and complete information during the registration process.\n\n3.2. You are responsible for maintaining the confidentiality of your account credentials and are liable for any unauthorized use of your account."),
                      SizedBox(height: 12),
                      Text(
                        "4. Purchasing Process",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                          "4.1. Users may select products from approved online platforms and submit the product link to Central Pay Finance Technology Private Limited for purchase.\n\n4.2. Central Pay Finance Technology Private Limited will place the order on behalf of the user after receiving the necessary downpayment and confirmation.\n\n4.3. Users agree to pay the remaining balance in monthly installments, including applicable interest charges, as specified in the payment plan."),
                      SizedBox(height: 12),
                      Text(
                        "5. Payments",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                          "5.1. Users must make timely payments according to the agreed-upon schedule. Late payments may result in additional fees or penalties.\n\n5.2. All payments made to Central Pay Finance Technology Private Limited are non-refundable, except as otherwise specified in these Terms or required by law."),
                      SizedBox(height: 8),
                      Text(
                        "6. Product Delivery",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                          "6.1. Upon completion of all installment payments, Central Pay Finance Technology Private Limited will arrange for the delivery of the purchased product to the user's designated address.\n\n6.2. Central Pay Finance Technology Private Limited is not responsible for any damages, defects, or discrepancies related to the delivered product. Users should refer to the original seller's terms and conditions for product warranties or returns."),
                      SizedBox(height: 12),
                      Text(
                        "7. Privacy Policy",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                          "7.1. We collect, use, and disclose personal information in accordance with our Privacy Policy, available at [link to Privacy Policy]."),
                      SizedBox(height: 12),
                      Text(
                        "8. Limitation of Liability",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                          "8.1. Central Pay Finance Technology Private Limited shall not be liable for any indirect, incidental, special, or consequential damages arising out of or in connection with the Service, including but not limited to loss of profits, data, or goodwill."),
                      SizedBox(height: 12),
                      Text(
                        "9. Termination",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                          "9.1. We reserve the right to terminate or suspend access to the Service at any time, with or without cause and without prior notice."),
                      SizedBox(height: 12),
                      Text(
                        "10. Governing Law and Dispute Resolution",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                          "10.1. These Terms shall be governed by and construed in accordance with the laws of [Your Jurisdiction], without regard to its conflict of law provisions."),
                      SizedBox(height: 12),
                      Text(
                        "11. Changes to Terms & Conditions",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                          "11.1. We reserve the right to modify or replace these Terms at any time. Any changes will be effective immediately upon posting on our website or app. Continued use of the Service after any such changes constitutes acceptance of the revised Terms."),
                      SizedBox(height: 14),
                    ],
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
