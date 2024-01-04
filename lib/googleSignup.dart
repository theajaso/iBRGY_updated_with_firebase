import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'home.dart';

class GoogleSignUpUser extends StatefulWidget {
  @override
  _GoogleSignUpUserState createState() => _GoogleSignUpUserState();
}
class _GoogleSignUpUserState extends State<GoogleSignUpUser> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  // Reference to the Firestore collection
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
    // Check if the user is signed in
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // If user is signed in, pre-fill the email field
      _email.text = user.email ?? '';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Personal Details',
                style: TextStyle(fontSize: 30,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(labelText: 'Full Name(First Name, Last Name)'),
              ),
              IntlPhoneField(
                controller: _contactNumberController,
                decoration: InputDecoration(
                  labelText: 'Contact Number',
                ),
                initialCountryCode: 'PH',
                onChanged: (phone) {
                  print(phone.completeNumber);
                },
              ),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextFormField(
                controller: _email,
                decoration: InputDecoration(labelText: 'Email'),
                enabled: false,
              ),

              SizedBox(height: 25.0),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      // Get the current user
                      User? user = FirebaseAuth.instance.currentUser;

                      if (user != null) {
                        // Save the additional information to Firestore
                        await usersCollection.doc(user.uid).set({
                          'fullName': _fullNameController.text,
                          'email': _email.text,
                          'PhoneNum': _contactNumberController.text,
                          'username': _usernameController.text,
                        });

                        // Navigate back to Home screen or any other screen
                        Navigator.pop(context); // Pop the AdditionalInfoScreen from the navigation stack
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                      } else {
                        // Handle the case where the user is not signed in
                        print('User is not signed in.');
                      }
                    } catch (e) {
                      // Handle any potential errors during Firestore update
                      print('Error updating Firestore: $e');
                    }

                  },style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: const Color(0xfffff4ce),
                ),
                  child: Text('Save', style: TextStyle(color: Colors.black),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
