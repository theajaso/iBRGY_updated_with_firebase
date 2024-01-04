import 'package:flutter/material.dart';

class CustomDateBox extends StatelessWidget {
  const CustomDateBox({
    Key? key,
    required this.dateText,
    required this.documentType,
  }) : super(key: key);

  final String dateText;
  final String documentType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: 330, // Set your desired width
        height: 150, // Set your desired height
        decoration: BoxDecoration(
          color: const Color(0xffffe89d),
          border: Border.all(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(fontSize: 15, color: Colors.black),
                children: [
                  const TextSpan(
                    text: 'Type of Document: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: '$documentType\n'),
                  const TextSpan(
                    text: 'Date Requested: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: '$dateText'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
