// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:ibrgy/home.dart';

class aboutScreen extends StatelessWidget {
  const aboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffffeeb6),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              );
            },
            icon: const Icon(Icons.arrow_back_rounded),
            splashRadius: 30,
          ),
          title: const Text(
            'About ',
            style: TextStyle(fontSize: 17),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          decoration: const BoxDecoration(color: Colors.white70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Center(
                child: Image(
                  image: AssetImage('pics/ibrgy_logo.png'),
                  height: 100,
                ),
              ),
              const Center(
                child: Image(
                  image: AssetImage('pics/ibrgytitle.png'),
                  height: 50,
                  width: 100,
                ),
              ),
              const Center(
                child: Text(
                  'for mobile devices',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(25),
                  height: 400,
                  width: 380,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xffd4e7f9),
                  ),
                  child: const Center(
                    child: Text(
                      'iBRGY! and the iBRGY! logos are \n'
                      'trademarks of Paper Cups Group.\n'
                      'All rights Reserved 2023.\n\n'
                      'iBRGY! is developed using Flutter,\n'
                      'an open-source UI.\n\n'
                      'If there are concerns about the \n'
                      'application contact us on our \n'
                      'email: paper.cups@gmail.com \n'
                      'contact number: 0123-456-789',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
