import 'package:flutter/material.dart';
import 'package:ibrgy/home.dart';

class AppointmentSuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(''),
      content: const SizedBox(
        height: 120.0, // Adjust the height as needed
        child: Column(
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 60.0,
            ),
            SizedBox(height: 10.0),
            Text(
              'Appointment request has been successfully processed.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Home(),
              ),
            );
          },style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffffe89d), // Change the button color
        ),
          child: const Text('OK',
          style: TextStyle(color: Colors.black),),
        ),
      ],
    );
  }
}
