import 'package:flutter/material.dart';
import 'logInScreen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Color(0xfffff9e7),
          ),
        ),
        const Align(
          alignment: Alignment.center,
          child: Image(
            height: 400,
            width: 400,
            image: AssetImage('pics/brgy_hall.png'),
          ),
        ),
        const Positioned(
          top: 450,
          right: 0,
          left: 0,
          child: Center(
            child: Image(
              height: 150,
              width: 150,
              image: AssetImage('pics/ibrgy_title.png'),
            ),
          ),
        ),
        Positioned(
            bottom: 40,
            right: 20,
            left: 20,
            child: SizedBox(
              height: 50,
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.white70;
                    }
                    return const Color(0xffffe89d);
                  }),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                child: const Text(
                  'Get Started...',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            )),
      ],
    ));
  }
}
