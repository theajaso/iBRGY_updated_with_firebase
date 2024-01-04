import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class customButton extends StatelessWidget {
  const customButton({super.key, required this.buttonText, this.onTap});

  final String buttonText;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.grey,
        child: Container(
          width: 300,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xffffe89d),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              buttonText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                //),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
