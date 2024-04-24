import 'package:flutter/material.dart';
import 'package:novacash1/model/adress_model.dart'; // Import your AddressModel
import 'package:novacash1/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class UserAddress extends StatefulWidget {
  const UserAddress({super.key});

  @override
  _UserAddressState createState() => _UserAddressState();
}

class _UserAddressState extends State<UserAddress> {
  List<AddressModel> _addresses = []; // List to store user addresses

  @override
  void initState() {
    super.initState();
    _fetchUserAddresses(); // Fetch user addresses when the widget is initialized
  }

  Future<void> _fetchUserAddresses() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      List<AddressModel> addresses = await authProvider.getUserAddresses(); // Fetch addresses from Firestore
      setState(() {
        _addresses = addresses;
      });
    } catch (error) {
      // Handle error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Addresses"),
      ),
      body: _addresses.isEmpty
          ? const Center(child: Text('No addresses available'))
          : ListView.builder(
              itemCount: _addresses.length,
              itemBuilder: (context, index) {
                AddressModel address = _addresses[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(address.street),
                    subtitle: Text('${address.city}, ${address.state} ${address.postalCode}'),
                  ),
                );
              },
            ),
    );
  }
}
