// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:ibrgy/appointment_pages/reusable_widgets/custom_button.dart';

import 'package:ibrgy/home.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class BrgyRecord extends StatefulWidget {
  const BrgyRecord({Key? key}) : super(key: key);

  @override
  State<BrgyRecord> createState() => _BrgyRecordState();
}

class _BrgyRecordState extends State<BrgyRecord> {
  TextEditingController _dateController = TextEditingController();
  var _value = "-1";
  final _formKey = GlobalKey<FormState>(); // Add a global key for the form

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xffffeeb6),
          title: const Text(
            'Request Barangay Records',
            style: TextStyle(fontSize: 17),
          )),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
        decoration: const BoxDecoration(color: Colors.white70),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, // Assign the key to the form
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                const Image(
                  image: AssetImage('pics/brgyrecord.png'),
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
                    value: _value,
                    items: const [
                      DropdownMenuItem(
                        value: "-1",
                        child: Text("-Type of Application-"),
                      ),
                      DropdownMenuItem(
                        value: "Blotter",
                        child: Text("Blotter"),
                      ),
                      DropdownMenuItem(
                        value: "Incident Report",
                        child: Text("Incident Report"),
                      ),
                    ],
                    validator: (value) {
                      if (value == "-1") {
                        return 'Please select a type of record';
                      }
                      return null;
                    },
                    onChanged: (v) {
                      setState(() {
                        _value = v.toString();
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: TextFormField(
                    controller: _dateController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      fillColor: Colors.white,
                      label: const Text('Date of Appointment',
                          style: TextStyle(fontSize: 14)),
                      prefixIcon: const Icon(
                        Icons.calendar_month_rounded,
                        color: Colors.black,
                      ),
                      filled: true,
                    ),
                    readOnly: true,
                    onTap: () {
                      _selectDate();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the date of appointment';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'We will contact you on the number you have provided as soon as we receive your concern. Thank you!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                customButton(
                  buttonText: "Done",
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      // Form is valid, navigate to the next screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 30,
                )
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
