import 'package:flutter/material.dart';
import 'package:novacash1/model/adress_model.dart';
import 'package:novacash1/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class SavedAddress extends StatefulWidget {
  const SavedAddress({super.key});

  @override
  State<SavedAddress> createState() => _SavedAddressState();
}

class _SavedAddressState extends State<SavedAddress> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isAddressVisible = false;

  final addressNameController = TextEditingController();
  final houseNumberController = TextEditingController();
  final streetNameController = TextEditingController();
  final pinCodeController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final phController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    addressNameController.dispose();
    houseNumberController.dispose();
    streetNameController.dispose();
    pinCodeController.dispose();
    cityController.dispose();
    stateController.dispose();
    phController.dispose();
  }

  void _toggleAddress() {
    setState(() {
      _isAddressVisible = !_isAddressVisible;
    });
  }

  void _saveAddress() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      AddressModel address = AddressModel(
        addressName: addressNameController.text,
        houseNumber: houseNumberController.text,
        id: '', // You may generate a unique ID or leave it empty if Firestore will auto-generate it
        street: streetNameController.text,
        city: cityController.text,
        state: stateController.text,
        postalCode: pinCodeController.text,
        country: 'India',
        phoneNumber: phController.text,
         // Update this according to your requirements
      );

      await ap.saveUserAddress(address);

      addressNameController.clear();
      houseNumberController.clear();
      streetNameController.clear();
      pinCodeController.clear();
      cityController.clear();
      stateController.clear();
      phController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Address'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _toggleAddress,
          ),
        ],
      ),
      body: _isAddressVisible
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: addressNameController,
                        decoration: const InputDecoration(labelText: 'Address Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the address name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: houseNumberController,
                        decoration: const InputDecoration(labelText: 'House Number'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the house number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: streetNameController,
                        decoration: const InputDecoration(labelText: 'Street Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the street name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: pinCodeController,
                        decoration: const InputDecoration(labelText: 'Pin Code'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the pin code';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: cityController,
                        decoration: const InputDecoration(labelText: 'City'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the city';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: stateController,
                        decoration: const InputDecoration(labelText: 'State'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the state';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: phController,
                        decoration: const InputDecoration(labelText: 'Phone Number'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _saveAddress,
                        child: const Text('Save Address'),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : const Center(
              child: Text('No Address Available'),
            ),
    );
  }
}
