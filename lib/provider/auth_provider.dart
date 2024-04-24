import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:novacash1/model/adress_model.dart';
import 'package:novacash1/model/user_model.dart';
import 'package:novacash1/screens/otp_screen.dart';
import 'package:novacash1/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _uid;
  String get uid => _uid!;
  UserModel? _userModel;
  UserModel get userModel => _userModel!;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  AuthProvider() {
    checkSign();
  }

  void checkSign() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_signedin") ?? false;
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedin", true);
    _isSignedIn = true;
    notifyListeners();
  }

  // signin
  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpScreen(verificationId: verificationId),
              ),
            );
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  // verify otp
  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);

      User? user = (await _firebaseAuth.signInWithCredential(creds)).user;

      if (user != null) {
        // carry our logic
        _uid = user.uid;
        onSuccess();
      }
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  // DATABASE OPERTAIONS
  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection("users").doc(_uid).get();
    if (snapshot.exists) {
      print("USER EXISTS");
      return true;
    } else {
      print("NEW USER");
      return false;
    }
  }

  
   // Method to save user address
  Future<void> saveUserAddress(AddressModel address) async {
    try {
      // Get the current user's UID
      String uid = _firebaseAuth.currentUser!.uid;

      // Reference to the user's document
      DocumentReference userDocRef = _firebaseFirestore.collection('users').doc(uid);

      // Add the address to a subcollection named 'addresses'
      await userDocRef.collection('addresses').add(address.toMap());
    } catch (error) {
      print('Error saving user address: $error');
      // Handle error as needed
      throw error; // Rethrow the error to handle it in the UI
    }
  }

 void saveUserDataToFirebase({
  required BuildContext context,
  required UserModel userModel,
  required File aadharFrontImg,
  required File aadharBackImg,
  required File panCardImg,
  required Function onSuccess,
}) async {
  _isLoading = true;
  notifyListeners();
  try {
    // Uploading Aadhar Front image to Firebase Storage
    String aadharFrontImageURL = await storeFileToStorage("aadharFrontImage/$_uid", aadharFrontImg);
    // Uploading Aadhar Backcimage to Firebase Storage
    String aadharBackImageURL = await storeFileToStorage("aadharBackImage/$_uid", aadharBackImg);
    // Uploading Pan image to Firebase Storage
    String panImageUrl = await storeFileToStorage("panCardImage/$_uid", panCardImg);
    // Set the URLs in the userModel
    userModel.aadharFrontImg = aadharFrontImageURL;
    userModel.aadharBackImg = aadharBackImageURL;
    userModel.panCardImg=panImageUrl;


    // Set other user data
    userModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
    userModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
    userModel.uid = _firebaseAuth.currentUser!.phoneNumber!;

    _userModel = userModel;

    // Upload user data to Firestore
    await _firebaseFirestore
        .collection("users")
        .doc(_uid)
        .set(userModel.toMap())
        .then((value) {
      onSuccess();
      _isLoading = false;
      notifyListeners();
    });
  } catch (e) {
    showSnackBar(context, e.toString());
    _isLoading = false;
    notifyListeners();
  }
}
  Future<double?> getDownpaymentAmount() async {
    try {
      String uid = _firebaseAuth.currentUser!.uid;
      DocumentSnapshot snapshot = await _firebaseFirestore.collection('users').doc(uid).get();
    if (snapshot.exists) {
      Map<String, dynamic>? userData = snapshot.data() as Map<String, dynamic>?; // Cast snapshot.data() to Map<String, dynamic>?
      if (userData != null) {
        return userData['downPayment']?.toDouble() ?? 0.0;
      }
    }
      return null;
    } catch (error) {
      print('Error fetching downpayment amount: $error');
      throw error;
    }
  }
    Future<void> updateDownpaymentAmount(double downpaymentAmount) async {
    try {
      String uid = _firebaseAuth.currentUser!.uid;
      DocumentReference userDocRef = _firebaseFirestore.collection('users').doc(uid);
      await userDocRef.update({'downPayment': downpaymentAmount});
    } catch (error) {
      print('Error updating downpayment amount: $error');
      throw error;
    }
  }


Future<List<AddressModel>> getUserAddresses() async {
  try {
    String uid = _firebaseAuth.currentUser!.uid;
    QuerySnapshot snapshot = await _firebaseFirestore.collection('users').doc(uid).collection('addresses').get();
    List<AddressModel> addresses = snapshot.docs.map((doc) => AddressModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
    return addresses;
  } catch (error) {
    print('Error fetching user addresses: $error');
    throw error;
  }
}




  Future<String> storeFileToStorage(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future getDataFromFirestore() async {
    await _firebaseFirestore
        .collection("users")
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      _userModel = UserModel(
        name: snapshot['name'],
        gender:snapshot['gender'],
        dob: snapshot['Date Of Birth'],
        aadharNumber:snapshot['aadharNumber'],
        panNumber: snapshot['panNumber'],
        email: snapshot['email'],
        createdAt: snapshot['createdAt'],
        uid: snapshot['uid'],
        aadharFrontImg:snapshot['aadharFrontImg'],
        aadharBackImg: snapshot['aadharBackImg'],
        panCardImg: snapshot['panCardImg'],
        phoneNumber: snapshot['phoneNumber'],


      );
      _uid = userModel.uid;
    });
  }

  // STORING DATA LOCALLY
  Future saveUserDataToSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("user_model", jsonEncode(userModel.toMap()));
  }

  Future getDataFromSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("user_model") ?? '';
    _userModel = UserModel.fromMap(jsonDecode(data));
    _uid = _userModel!.uid;
    notifyListeners();
  }

  Future userSignOut() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await _firebaseAuth.signOut();
    _isSignedIn = false;
    notifyListeners();
    s.clear();
  }

    Future<void> storeDownpaymentAmount(double downpaymentAmount) async {
    try {
      // Get the current user's UID
      String uid = _firebaseAuth.currentUser!.uid;

      // Reference to the user's document
      DocumentReference userDocRef = _firebaseFirestore.collection('users').doc(uid);

      // Update the downpayment amount field in the user's document
      await userDocRef.update({'downpaymentAmount': downpaymentAmount});
    } catch (error) {
      print('Error storing downpayment amount: $error');
      throw error; // Rethrow the error to handle it in the UI
    }
  }

  signUpWithPhoneNumber(String phoneNumber) {}
}
