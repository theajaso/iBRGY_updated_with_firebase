// ignore_for_file: unused_field, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ibrgy/appointment_pages/scheduling_cert.dart';

class BrgyCertScreen extends StatefulWidget {
  const BrgyCertScreen({Key? key}) : super(key: key);

  @override
  State<BrgyCertScreen> createState() => _BrgyCertScreenState();
}

class _BrgyCertScreenState extends State<BrgyCertScreen> {

  final _formKey = GlobalKey<FormState>();
  String _CertificateType = "-1"; // Add this line

  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _addsCertController = TextEditingController();
  TextEditingController _purpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    User? users = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffffeeb6),
        title: const Text(
          'Request Barangay Certificate',
          style: TextStyle(fontSize: 17),
        ),
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
                  image: AssetImage('pics/brgycert.png'),
                  height: 70,
                  width: 400,
                ),
                const Text(
                  'Fill out the necessary information.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: TextFormField(
                    controller: _fullNameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      label: const Text('Full Name (FN, MN, LN)',
                          style: TextStyle(fontSize: 14)),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: TextFormField(
                    controller: _addsCertController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      label:
                      const Text('Address', style: TextStyle(fontSize: 14)),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.location_city,
                        color: Colors.black,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: TextFormField(
                    controller: _purpController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      label:
                      const Text('Purpose', style: TextStyle(fontSize: 14)),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.filter_none,
                        color: Colors.black,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the purpose';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.pages_outlined,
                        color: Colors.black,
                      ),
                    ),
                    value: _CertificateType,
                    items: const [
                      DropdownMenuItem(
                        value: "-1",
                        child: Text("-Types of Certificate-"),
                      ),
                      DropdownMenuItem(
                        value: "Building Permit",
                        child: Text("Building Permit"),
                      ),
                      DropdownMenuItem(
                        value: "Clearance",
                        child: Text("Clearance"),
                      ),
                      DropdownMenuItem(
                        value: "Employment",
                        child: Text("Employment"),
                      ),
                      DropdownMenuItem(
                        value: "Excavation Permit",
                        child: Text("Excavation Permit"),
                      ),
                      DropdownMenuItem(
                        value: "Indigency",
                        child: Text("Indigency"),
                      ),
                      DropdownMenuItem(
                        value: "Residency",
                        child: Text("Residency"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _CertificateType = value.toString();
                      });
                    },
                    validator: (value) {
                      if (value == null || value == "-1") {
                        return 'Please select a type of certificate';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: (){
                      if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SchedulingCert(
                                fullName: _fullNameController.text,
                                address: _addsCertController.text,
                                purpose: _purpController.text,
                                selectedCertificateType: _CertificateType,
                              ),
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
