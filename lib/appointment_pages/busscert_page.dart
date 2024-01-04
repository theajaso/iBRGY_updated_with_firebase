import 'package:flutter/material.dart';
import 'package:ibrgy/appointment_pages/scheduling_busscert.dart';

class BussinessCert extends StatefulWidget {
  const BussinessCert({Key? key}) : super(key: key);

  @override
  State<BussinessCert> createState() => _BussinessCertState();
}

class _BussinessCertState extends State<BussinessCert> {
  String _CertificateType = "-1";
  final _formKey = GlobalKey<FormState>();

  TextEditingController _fNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _businessNameController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xffffeeb6),
          title: const Text(
            'Request Business Certificate',
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
                  image: AssetImage('pics/businesscert.png'),
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
                    controller: _fNameController,
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
                // Add validation for other text fields similarly
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
                  child: TextFormField(
                    controller: _businessNameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      label: const Text('Business Name',
                          style: TextStyle(fontSize: 14)),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.business,
                        color: Colors.black,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your business name';
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
                      label: const Text('Type of Business',
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
                        return 'Please enter the type of business';
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
                          value: "-1", child: Text("-Type of Application-")),
                      DropdownMenuItem(value: "New", child: Text("New")),
                      DropdownMenuItem(value: "Renewal", child: Text("Renewal")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _CertificateType= value.toString();
                      });
                    },
                    validator: (value) {
                      if (value == null || value == "-1") {
                        return 'Please select a type of application';
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Form is valid, navigate to the next screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  SchedulingBuss(
                                fName: _fNameController.text,
                                address: _addressController.text,
                                businessName: _businessNameController.text,
                                businessType: _CertificateType,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
