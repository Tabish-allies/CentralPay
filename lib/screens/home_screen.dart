import 'package:flutter/material.dart';
import 'package:novacash1/provider/auth_provider.dart';
import 'package:novacash1/screens/home1_screen.dart';
import 'package:novacash1/screens/profile_page.dart';
import 'package:novacash1/screens/wallet_page.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

    int _currentPageIndex = 0;

   final List<Widget> pages = const[
   HomeView(),
   WalletPage(),
   ProfilePage(),
  ];


  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 35, 56, 146),
        title: const Text("CentralPay",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        ),
      ),
      body: pages[_currentPageIndex],
      
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: _currentPageIndex,
      items:const [
        BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.wallet),
        label: 'Wallet',
         ),
      BottomNavigationBarItem(
        icon: Icon(Icons.supervised_user_circle),
        label: 'Profile',
         ),
    ],

        
      
      onTap: (value){
        setState(() {
           _currentPageIndex=value;
        });
      },
     ),
    );
  }
  
}
