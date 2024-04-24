import 'package:flutter/material.dart';
import 'package:novacash1/provider/auth_provider.dart';
import 'package:novacash1/screens/contact_us_page.dart';
import 'package:novacash1/screens/my_orders_page.dart';
import 'package:novacash1/screens/personal_information.dart';
import 'package:novacash1/screens/privacy_policy_page.dart';
import 'package:novacash1/screens/saved_address.dart';
import 'package:novacash1/screens/terms_page.dart';
import 'package:novacash1/screens/user_adress.dart';
import 'package:novacash1/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PersonalInfo(),
                    ),
                  );
                },
                child: const Card(
                  child: Padding(
                    padding: EdgeInsets.all(22.0),
                    child: Row(
                      children: [
                        Icon(Icons.person_3_rounded),
                        SizedBox(width: 10),
                        Text(
                          "Personal Information",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 13),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserAddress(),
                    ),
                  );
                },
                child: const Card(
                  child: Padding(
                    padding: EdgeInsets.all(22.0),
                    child: Row(
                      children: [
                        Icon(Icons.home_filled),
                        SizedBox(width: 10),
                        Text(
                          "Addresses",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 13),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SavedAddress(),
                    ),
                  );
                },
                child: const Card(
                  child: Padding(
                    padding: EdgeInsets.all(22.0),
                    child: Row(
                      children: [
                        Icon(Icons.publish_sharp),
                        SizedBox(width: 10),
                        Text(
                          "Add Address",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 13),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyOrders(),
                    ),
                  );
                },
                child: const Card(
                  child: Padding(
                    padding: EdgeInsets.all(22.0),
                    child: Row(
                      children: [
                        Icon(Icons.card_travel_rounded),
                        SizedBox(width: 10),
                        Text(
                          "My Orders",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 13),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ContactUsPage(),
                    ),
                  );
                },
                child: const Card(
                  child: Padding(
                    padding: EdgeInsets.all(22.0),
                    child: Row(
                      children: [
                        Icon(Icons.call_end_rounded),
                        SizedBox(width: 10),
                        Text(
                          "Contact Us",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 13),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PrivacyPolicy(),
                    ),
                  );
                },
                child: const Card(
                  child: Padding(
                    padding: EdgeInsets.all(22.0),
                    child: Row(
                      children: [
                        Icon(Icons.privacy_tip_rounded),
                        SizedBox(width: 10),
                        Text(
                          "Privacy Policy",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 13),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TermsConditionPage(),
                    ),
                  );
                },
                child: const Card(
                  child: Padding(
                    padding: EdgeInsets.all(22.0),
                    child: Row(
                      children: [
                        Icon(Icons.menu_book),
                        SizedBox(width: 10),
                        Text(
                          "Terms and Condition",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 13),
               GestureDetector(
                onTap: () {
                  // Show logout confirmation dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirm Logout"),
                        content: const Text("Are you sure you want to log out?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              // Perform logout
                              ap.userSignOut().then(
                                    (value) => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const WelcomeScreen(),
                                  ),
                                ),
                              );
                            },
                            child: const Text("Confirm"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Card(
                  child: Padding(
                    padding: EdgeInsets.all(22.0),
                    child: Row(
                      children: [
                        Icon(Icons.logout),
                        SizedBox(width: 10),
                        Text(
                          "Log Out",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

