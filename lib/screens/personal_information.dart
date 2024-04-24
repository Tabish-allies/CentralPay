import 'package:flutter/material.dart';
import 'package:novacash1/provider/auth_provider.dart';
import 'package:provider/provider.dart';



class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Personal Information"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child:Column(
          children: [
              Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 15),
                          const Row(
                            children: [
                              Icon(Icons.person),
                              Text("Personal Info",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),)
                            ],
                          ),
                          const SizedBox(height: 15),
                        Row(
                          children: [
                            const Text("Full Name:",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            ),
                             Expanded(child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(ap.userModel.name,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                              ),
                              ),
                              ),
                            
                      
                          ],
                        ),
                         const SizedBox(height: 12),
                       Row(
                          children: [
                            const Text("Gender",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            ),
                             Expanded(child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(ap.userModel.gender,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                              ),
                              ),
                              ),
                            ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Text("Date Of Birth",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            ),
                             Expanded(child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(ap.userModel.dob,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                              ),
                              ),
                              ),
                            ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Text("Email Id",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            ),
                             Expanded(child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(ap.userModel.email,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                              ),
                              ),
                              ),
                            ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Text("Pan Card No",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            ),
                             Expanded(child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(ap.userModel.panNumber,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                              ),
                              ),
                              ),
                            ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Text("Aadhar Card No",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            ),
                             Expanded(child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(ap.userModel.aadharNumber,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                              ),
                              ),
                              ),
                            ],
                        ),
                         const SizedBox(height: 12),
                        Row(
                          children: [
                            const Text("Mobile Number",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            ),
                             Expanded(child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(ap.userModel.phoneNumber,
                              style: const TextStyle(
                                fontSize: 15,
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
    );
  }
}