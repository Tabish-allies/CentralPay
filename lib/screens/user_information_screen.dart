import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:novacash1/model/user_model.dart';
import 'package:novacash1/provider/auth_provider.dart';
import 'package:novacash1/screens/home_screen.dart';
import 'package:novacash1/utils/utils.dart';
import 'package:novacash1/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class UserInfromationScreen extends StatefulWidget {
  const UserInfromationScreen({super.key});

  @override
  State<UserInfromationScreen> createState() => _UserInfromationScreenState();
}

class _UserInfromationScreenState extends State<UserInfromationScreen> {
  File? aadharFrontImage;
  File? aadharBackImage;
  File? panCardImage;
  final nameController = TextEditingController();
  final genderController = TextEditingController();
  final dobController = TextEditingController();
  final emailController = TextEditingController();
  final aadharNumberController = TextEditingController();
  final panNumberController = TextEditingController();
 

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    genderController.dispose();
    dobController.dispose();
    panNumberController.dispose();
    emailController.dispose();
    aadharNumberController.dispose();
  }
  
  // selecting aadhar front image
  void selectAadharImage() async{
    aadharFrontImage= await pickImage(context);
    setState(() {});
  }

  void selectAadharBImage() async{
    aadharBackImage= await pickImage(context);
    setState(() {});
  }
  // selecting pan Card image
    void selectPanImage() async{
    panCardImage= await pickImage(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("KYC INFORMATION"),
      ),
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            : SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 25.0, horizontal: 5.0),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        margin: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            // name field
                            textFeld(
                              hintText: "Enter Your Name As Per Aadhar Card",
                              icon: Icons.account_circle,
                              inputType: TextInputType.name,
                              maxLines: 1,
                              controller: nameController,
                            ),

                            // gender field
                            textFeld(
                              hintText: "Gender",
                              icon: Icons.account_circle,
                              inputType: TextInputType.name,
                              maxLines: 1,
                              controller: genderController,
                            ),

                            // Date of Birth Field
                            textFeld(
                              hintText: "Enter Your Date of Birth (DD/MM/YYYY)",
                              icon: Icons.calendar_today,
                              inputType: TextInputType.datetime,
                              maxLines: 1,
                              controller: dobController,
                            ),
                            // Pan Number Field
                            textFeld(
                              hintText: "Enter Your Pan Number",
                              icon: Icons.account_circle,
                              inputType: TextInputType.name,
                              maxLines: 1,
                              controller: panNumberController,
                            ),
                            // aadhar Number Field
                            textFeld(
                              hintText: "Enter Your Aadhar Number",
                              icon: Icons.account_circle,
                              inputType: TextInputType.number,
                              maxLines: 1,
                              controller: aadharNumberController,
                            ),
                             // email
                            textFeld(
                              hintText: "abc@example.com",
                              icon: Icons.email,
                              inputType: TextInputType.emailAddress,
                              maxLines: 1,
                              controller: emailController,
                            ),

                            //aadhar front image field
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Aadhar Front Image', // Add label text here
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                InkWell(
                                  onTap: () => selectAadharImage(),
                                  child: aadharFrontImage == null
                                    ? const Icon(
                                        Icons.add_photo_alternate,
                                        size: 50,
                                        color: Colors.blue,
                                      )
                                    : Image.file(aadharFrontImage!),
                                ),
                              ],
                            ),


                            //aadhar Back image field
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Aadhar Back Image', // Add label text here
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                InkWell(
                                  onTap: () => selectAadharBImage(),
                                  child: aadharBackImage == null
                                    ? const Icon(
                                        Icons.add_photo_alternate,
                                        size: 50,
                                        color: Colors.blue,
                                      )
                                    : Image.file(aadharBackImage!),
                                ),
                              ],
                            ),

                            //Pan Card Image Field
                             Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Pan Card Image', // Add label text here
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                InkWell(
                                  onTap: () => selectPanImage(),
                                  child: panCardImage == null
                                    ? const Icon(
                                        Icons.add_photo_alternate,
                                        size: 50,
                                        color: Colors.blue,
                                      )
                                    : Image.file(panCardImage!),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: CustomButton(
                          text: "Continue",
                          onPressed: () => storeData(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget textFeld({
    required String hintText,
    required IconData icon,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller,
    Function()? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        cursorColor: Colors.purple,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.blue,
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          hintText: hintText,
          alignLabelWithHint: true,
          border: InputBorder.none,
          fillColor: Colors.blue.shade50,
          filled: true,
        ),
      ),

    );
  }
  // store user data to database
  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    if (nameController.text.trim().isEmpty ||
      aadharNumberController.text.trim().isEmpty ||
      panNumberController.text.trim().isEmpty ||
      emailController.text.trim().isEmpty ||
      dobController.text.trim().isEmpty||
      genderController.text.trim().isEmpty){
        showSnackBar(context, "Please fill all the required fields");
    return; // Exit function early if any required field is empty
      }
  // Parse and format the date of birth
  DateTime dob;
  try {
    dob = DateFormat('dd/MM/yyyy').parse(dobController.text);
  } catch (error) {
    showSnackBar(context, "Please enter a valid date of birth (DD/MM/YYYY)");
    return; // Exit function if DOB is invalid
  }
   String formattedDOB = '${dob.day}/${dob.month}/${dob.year}';

   
    UserModel userModel = UserModel(
      name: nameController.text.trim(),
      gender:genderController.text.trim(),
      dob: formattedDOB,
      aadharNumber:aadharNumberController.text.trim(),
      panNumber:panNumberController.text.trim(),
      email: emailController.text.trim(),
      aadharFrontImg: "",
      aadharBackImg: "",
      panCardImg:"",
      createdAt: "",
      phoneNumber: "",
      uid: "",

    );
    if (aadharFrontImage != null && aadharBackImage != null && panCardImage != null) {
      ap.saveUserDataToFirebase(
        context: context,
        userModel: userModel,
        aadharFrontImg: aadharFrontImage!,
        aadharBackImg:aadharBackImage!,
        panCardImg:panCardImage!,
        onSuccess: () {
          ap.saveUserDataToSP().then(
                (value) => ap.setSignIn().then(
                      (value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                          (route) => false),
                    ),
              );
        },
      );
    } else {
      showSnackBar(context, "Please upload the required documents");
    }
  }
}
