import 'package:flutter/material.dart';
import 'package:ibrgy/appointment_pages/reusable_widgets/custom_button2.dart';

import 'package:ibrgy/home.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class OtherConcern extends StatefulWidget {
  const OtherConcern({Key? key}) : super(key: key);

  @override
  State<OtherConcern> createState() => _OtherConcernState();
}

class _OtherConcernState extends State<OtherConcern> {
  //var _value = "-1";
  DateTime? _appointmentDate;
  final _formKey = GlobalKey<FormState>();

  Future<void> _dateAppointment(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _appointmentDate ?? DateTime.now(),
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

    if (picked != null && picked != _appointmentDate) {
      setState(() {
        _appointmentDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xffffeeb6),
          title: const Text(
            'Other Concerns',
            style: TextStyle(fontSize: 17),
          )),
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
                    image: AssetImage('pics/otherconcerns.png'),
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
                        label: const Text('Address',
                            style: TextStyle(fontSize: 14)),
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
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        label: const Text('State your concern',
                            style: TextStyle(fontSize: 14)),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.filter_none,
                          color: Colors.black,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please state your concern';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () =>
                              _dateAppointment(context), // Corrected here
                          child: Container(
                            width: 450,
                            height: 55,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color.fromARGB(255, 70, 70, 70)),
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
                                    _appointmentDate == null
                                        ? 'Request Date'
                                        : '${_appointmentDate!.day}/${_appointmentDate!.month}/${_appointmentDate!.year}',
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
                  customButton2(
                    buttonText: "Done",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        if (_appointmentDate != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                          );
                        } else {
                          // Show a pop-up or snackbar indicating that the date is required.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Please select the date of appointment.'),
                            ),
                          );
                        }
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
