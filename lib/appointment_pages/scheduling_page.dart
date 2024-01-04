// ignore_for_file: unused_import, library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:ibrgy/appointment_pages/appointment_page.dart';
import 'package:ibrgy/appointment_pages/reusable_widgets/custom_button.dart';
import 'package:ibrgy/appointment_pages/reusable_widgets/custom_button2.dart';
import 'package:ibrgy/appointment_pages/reusable_widgets/custom_textfield.dart';
import 'package:ibrgy/home.dart';
import 'package:ibrgy/main.dart';

class Scheduling extends StatefulWidget {
  const Scheduling({super.key});

  @override
  _SchedulingState createState() => _SchedulingState();
}

class _SchedulingState extends State<Scheduling> {
  DateTime? requestDate;
  DateTime? _pickupDate; // Use DateTime? (nullable DateTime)

  Future<void> _dateRequest(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: requestDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
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
      initialDate: _pickupDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _pickupDate) {
      setState(() {
        _pickupDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xffffeeb6),
          title: const Text(
            'Request Schedule Date',
            style: TextStyle(fontSize: 17),
          )),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
        decoration: const BoxDecoration(color: Colors.white70),
        child: SingleChildScrollView(
          child: Form(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                const SizedBox(
                  height: 25,
                ),
                const Image(
                  image: AssetImage('pics/scheduling.png'),
                  height: 100,
                  width: 300,
                ),
                const SizedBox(
                  height: 20,
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
                                child: Icon(Icons.calendar_today),
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
                                child: Icon(Icons.calendar_today),
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
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                customButton2(
                  buttonText: "Done",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
                  },
                ),
              ])),
        ),
      ),
    );
  }
}
