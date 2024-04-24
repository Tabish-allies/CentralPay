import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:novacash1/provider/auth_provider.dart';


// Import InstallmentProvider

import 'package:novacash1/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),


        // Add other providers here as needed
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CentralPay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(),
    );
  }
}
