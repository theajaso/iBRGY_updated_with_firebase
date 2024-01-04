// ignore_for_file: unused_import, library_private_types_in_public_api, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ibrgy/appointment_pages/appointment_page.dart';
import 'package:ibrgy/appointment_pages/confirm_busscert.dart';
import 'package:ibrgy/appointment_pages/confirm_id.dart';
import 'package:ibrgy/appointment_pages/reusable_widgets/custom_button.dart';
import 'package:ibrgy/appointment_pages/reusable_widgets/custom_button2.dart';
import 'package:ibrgy/appointment_pages/reusable_widgets/custom_textfield.dart';
import 'package:intl/intl.dart';

class SchedulingID extends StatefulWidget {
  final String fullName;
  final String birthDate;
  final String address;
  final String contact;
  final String guardianName;
  final String guardianNum;

  const SchedulingID({Key? key,
  required this.fullName,
  required this.birthDate,
  required this.address,
  required this.contact,
  required this.guardianName,
    required this.guardianNum,
  }) : super(key: key);

  @override
  _SchedulingState createState() => _SchedulingState();
}

class _SchedulingState extends State<SchedulingID> {
  DateTime? requestDate;
  DateTime? _pickupDate;
  final _formKey = GlobalKey<FormState>();

  Future<void> _dateRequest(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: requestDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.grey,
            colorScheme: const ColorScheme.dark(
                primary: Colors.grey,
                onSecondary: Colors.black,
                onPrimary: Colors.black,
                surface: Color.fromARGB(255, 253, 232, 163),
                onSurface: Colors.black,
                secondary: Colors.black),
            dialogBackgroundColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  primary: Colors.black, // button text color
                  textStyle: const TextStyle(
                    fontSize: 18, color: Colors.grey, // button text size
                  )),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != requestDate) {
      setState(() {
        requestDate = picked;
      });
    }
  }

  Future<void> _datePickup(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: requestDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.grey,
            colorScheme: const ColorScheme.dark(
                primary: Colors.grey,
                onSecondary: Colors.black,
                onPrimary: Colors.black,
                surface: Color.fromARGB(255, 253, 232, 163),
                onSurface: Colors.black,
                secondary: Colors.black),
            dialogBackgroundColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  primary: Colors.black, // button text color
                  textStyle: const TextStyle(
                    fontSize: 18, color: Colors.grey, // button text size
                  )),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _pickupDate) {
      setState(() {
        _pickupDate = picked;
      });
    }
  }

  Future<void> _navigateToDisplayDatePage(BuildContext context) async {
    // Get the current authenticated user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Use the user's UID as a document ID
      CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
      CollectionReference appointmentsCollection =
      userCollection.doc(user.uid).collection('appointments');

      // Add appointment information to the user's document
      await appointmentsCollection.add({
        'documentType': "Baranggay ID",
        'fullName': widget.fullName,
        'address': widget.address,
        'birthDate': widget.birthDate,
        'contactNum': widget.contact,
        'guardianName': widget.guardianName,
        'guardianNum': widget.guardianNum,
        'requestDate': requestDate != null
            ? DateFormat('yyyy-MM-dd').format(requestDate!)
            : '',
        'pickupDate': _pickupDate != null
            ? DateFormat('yyyy-MM-dd').format(_pickupDate!)
            : '',
      });

      // Navigate to the next page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IDDatePage(requestDate: requestDate),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffffeeb6),
        title: const Text('Request Schedule Date',
            style: TextStyle(
              fontSize: 17,
            )),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
        decoration: const BoxDecoration(color: Colors.white70),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                const Image(
                  image: AssetImage('pics/schedule.png'),
                  height: 70,
                  width: 400,
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => _dateRequest(context),
                        child: Container(
                          width: 400,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.calendar_month_rounded),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  requestDate == null
                                      ? 'Date Requested'
                                      : '${requestDate!.day}/${requestDate!.month}/${requestDate!.year}',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (requestDate == null)
                        const Text(
                          'Please select a date',
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Select the day that works best for you to pick up the needed document. Please be guided that processing requests will take at least 1-2 business days and a maximum of 3 days depending on the complexity of the document.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => _datePickup(context),
                        child: Container(
                          width: 400,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.calendar_month_rounded),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _pickupDate == null
                                      ? 'Date of Pick-up'
                                      : '${_pickupDate!.day}/${_pickupDate!.month}/${_pickupDate!.year}',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (_pickupDate == null)
                        const Text(
                          'Please select a date',
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      if (requestDate != null && _pickupDate != null) {
                        _navigateToDisplayDatePage(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select both dates.'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: const Color(0xffffe89d),
                      padding: const EdgeInsets.all(
                        15,
                      ),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
