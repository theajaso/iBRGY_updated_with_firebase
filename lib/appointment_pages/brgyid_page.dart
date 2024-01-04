// ignore_for_file: avoid_unnecessary_containers


import 'package:flutter/material.dart';
import 'package:ibrgy/appointment_pages/scheduling_id.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

DateTime? _selectedDate;

class BrgyID extends StatefulWidget {
  BrgyID({Key? key}) : super(key: key);

  @override
  State<BrgyID> createState() => _BrgyIDState();
}

class _BrgyIDState extends State<BrgyID> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactNumController = TextEditingController();
  final TextEditingController _guardianNameController = TextEditingController();
  final TextEditingController _guardianNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Add a global key for the form

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xffffeeb6),
          title: const Text(
            'Request Barangay ID',
            style: TextStyle(fontSize: 17),
          )),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.fromLTRB(30, 5, 30, 0),
        decoration: const BoxDecoration(color: Colors.white70),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, // Assign the key to the form
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                const Image(
                  image: AssetImage('pics/brgyid.png'),
                  height: 70,
                  width: 400,
                ),
                const Text(
                  'Fill out the necessary information.',
                  textAlign: TextAlign.left,
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
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      fillColor: Colors.white,
                      labelText: 'Birthdate',
                      labelStyle: TextStyle(fontSize: 14),
                      prefixIcon: const Icon(
                        Icons.calendar_month_rounded,
                        color: Colors.black,
                      ),
                      filled: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your birthdate';
                      }
                      return null;
                    },
                    readOnly: true,
                    onTap: () {
                      _selectDate();
                    },
                    controller: _dateController, // Add this line
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: TextFormField(
                    controller: _addressController,
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
                  child: IntlPhoneField(
                    controller:_contactNumController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: 'Contact Number',
                      labelStyle: TextStyle(fontSize: 14),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Icon(
                          Icons.phone,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    initialCountryCode: 'PH',
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                  ),
                ),
                const Text(
                  'In case of emergency (Contact Person)',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 15),
                  child: TextFormField(
                    controller:_guardianNameController ,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      label: const Text('Guardians Full Name (FN, MN, LN)',
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
                        return 'Please enter the guardian\'s full name';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: IntlPhoneField(
                    controller: _guardianNumberController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: 'Contact Number',
                      labelStyle: TextStyle(fontSize: 14),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Icon(
                          Icons.phone,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    initialCountryCode: 'PH',
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SchedulingID(
                                fullName: _fullNameController.text,
                                birthDate: _dateController.text,
                                address: _addressController.text,
                                contact: _contactNumController.text,
                                guardianName: _guardianNameController.text,
                                guardianNum: _guardianNumberController.text,

                              )),
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
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.dark(
                  primary: Colors.grey,
                  onSecondary: Colors.black,
                  onPrimary: Colors.black,
                  surface: Color.fromARGB(255, 253, 232, 163),
                  onSurface: Colors.black,
                  secondary: Colors.black),
              dialogBackgroundColor: const Color(0xfffff9e7),
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
        });
    if (_picked != null) {
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }
}
