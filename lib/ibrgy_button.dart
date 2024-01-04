import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ibrgyButton extends StatefulWidget {
  const ibrgyButton({super.key});

  @override
  State<ibrgyButton> createState() => _ibrgyButtonState();
}

class _ibrgyButtonState extends State<ibrgyButton> {
  int myIndex = 0;
  final screens = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(

        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: Colors.white),
        margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 50),
              const Image(
                image: AssetImage('pics/developerInfo.png'),
                height: 70,
                width: 400,
              ),
              const Text(
                'Meet our skilled development team, experts\n'
                'in cutting-edge technologies.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.yellow,
                      child: CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage('pics/maria.png'))),
                  Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                      color: const Color(0xffffeeb6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Maria Lyn Fajardo',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.yellow,
                      child: CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage('pics/thea.png'))),
                  Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                      color: const Color(0xfffbbbbb),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Thea Nicole Jaso',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.yellow,
                      child: CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage('pics/mariela.png'))),
                  Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                      color: const Color(0xffffeeb6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Mariela Pantaliano',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.yellow,
                      child: CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage('pics/alyssa.png'))),
                  Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                      color: const Color(0xfffbbbbb),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Alyssa Nicole Rabano',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.yellow,
                      child: CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage('pics/heleina.png'))),
                  Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                      color: const Color(0xffffeeb6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Heleina Villaalba',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
