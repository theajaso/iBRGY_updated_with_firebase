// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:ibrgy/appointment_pages/brgycert_page.dart';
import 'package:ibrgy/appointment_pages/brgyid_page.dart';
import 'package:ibrgy/appointment_pages/brgyrecord_page.dart';
import 'package:ibrgy/appointment_pages/busscert_page.dart';
import 'package:ibrgy/appointment_pages/otherconcern.dart';
import 'package:ibrgy/appointment_pages/reusable_widgets/custom_button.dart';

class appointmentScreen extends StatefulWidget {
  const appointmentScreen({super.key});

  @override
  State<appointmentScreen> createState() => _appointmentScreenState();
}

class _appointmentScreenState extends State<appointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Add Appointment',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black87,
              )),
          backgroundColor: const Color(0xffffeeb6)),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
            child: Column(
              children: <Widget>[
                const Text(
                  'What do you want to request for?',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                customButton(
                  buttonText: "Barangay Certificate",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BrgyCertScreen()),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                customButton(
                  buttonText: "Barangay ID",
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BrgyID()));
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                customButton(
                  buttonText: "Business Certificate",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BussinessCert()),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                customButton(
                  buttonText: "Barangay Record",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BrgyRecord()),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                customButton(
                  buttonText: "Other Concerns",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OtherConcern()),
                    );
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                const Align(
                    alignment: Alignment.bottomCenter,
                    child: Image(
                      height: 110,
                      width: 110,
                      image: AssetImage('pics/ibrgy_title.png'),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
