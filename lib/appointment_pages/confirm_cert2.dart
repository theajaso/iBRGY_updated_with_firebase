import 'package:flutter/material.dart';
import 'package:ibrgy/appointment_pages/reusable_widgets/custom_box.dart';
import 'package:ibrgy/appointment_pages/reusable_widgets/custom_button2.dart';
import 'package:ibrgy/appointment_pages/reusable_widgets/success_dialog.dart';
import 'package:ibrgy/home.dart';

class CertDatePage2 extends StatelessWidget {
  final DateTime? requestDate;
  final String selectedCertificateType;

  const CertDatePage2({
    Key? key,
    required this.requestDate,
    required this.selectedCertificateType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffffeeb6),
        title: const Text('Confirmation',
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 25,
                ),
                const Image(
                  image: AssetImage('pics/successful.png'),
                  height: 70,
                  width: 400,
                ),
                CustomDateBox(
                  documentType: selectedCertificateType,
                  dateText: requestDate == null
                      ? 'No date selected'
                      : '${requestDate!.day}/${requestDate!.month}/${requestDate!.year}',
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Processing requests will take at least 1-2 business days and a maximum of 3 days depending on the complexity of the document.',
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
                const Text(
                  'Please bring the following requirements upon claiming your requested document.',
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'EXCAVATION:',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '• Letter of Intent',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: Text(
                              '• Drawing Plan / Sketch of \n            Affected Area',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'BUILDING:',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '• Letter of Intent',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '• Drawing Plan / Sketch',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '• List of Manpower',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                customButton2(
                  buttonText: "Done",
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AppointmentSuccessDialog();
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
