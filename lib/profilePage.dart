// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart'; // Add this import
import 'package:ibrgy/appointment_pages/about_screen.dart';
import 'package:ibrgy/home.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'logInScreen.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final bool _customIcon = false;
  final user = FirebaseAuth.instance.currentUser!;
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  Future<void> signUserOut(BuildContext context) async {
    try {
      // Sign out from Firebase
      await FirebaseAuth.instance.signOut();

      // Sign out from Google
      await GoogleSignIn().signOut();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      print("Sign Out Error: $e");
    }
  }

  Future<void> updateName(String newName) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'fullName': newName});
      // Update local state or trigger a rebuild if necessary
    } catch (e) {
      print('Error updating name: $e');
      // Handle the error
    }
  }

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
          'Profile',
          style: TextStyle(fontSize: 17),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid) // use the user's UID here
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading...');
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || !snapshot.data!.exists) {
                  return Text('User not found.');
                } else {
                  // Access and display additional data from Firestore
                  String? fullName = snapshot.data!.get('fullName');
                  String? username = snapshot.data!.get('username');
                  String? email = snapshot.data!.get('email');
                  String? phoneNum = snapshot.data!.get('PhoneNum');

                  return Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 90,
                              width: 90,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Image(
                                  image: AssetImage('pics/woman.png'),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 145,
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: const Text('Edit Name'),
                                    content: TextField(
                                      controller: _nameController,
                                      decoration: const InputDecoration(
                                        labelText: 'New Name',
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          String newName = _nameController.text.trim();
                                          if (newName.isNotEmpty) {
                                            updateName(newName);
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: const Text('Save'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: const Color(0xffe8e8e8),
                                ),
                                child: const Icon(
                                  LineAwesomeIcons.alternate_pencil,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        '$fullName',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('@$username', style: TextStyle(fontSize: 14)),
                      const SizedBox(height: 20),
                      Container(
                        height: 150,
                        width: 330,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xfff1f2f2),
                        ),
                        child: ExpansionTile(
                          leading: const Icon(Icons.email, color: Colors.black),
                          title: const Text('Email Address',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              )),
                          trailing: Icon(
                            _customIcon
                                ? Icons.arrow_drop_down
                                : Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          children: [
                            ListTile(
                                title: Text('$email',
                                    style: const TextStyle(
                                      fontSize: 12,
                                    )))
                          ],
                          onExpansionChanged: (bool expanded) {},
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 150,
                        width: 330,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xfff1f2f2),
                        ),
                        child: ExpansionTile(
                          leading: const Icon(Icons.contact_page, color: Colors.black),
                          title: const Text('Contact Number',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              )),
                          trailing: Icon(
                            _customIcon
                                ? Icons.arrow_drop_down
                                : Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          children: [
                            ListTile(
                                title: Text('+63$phoneNum',
                                    style: TextStyle(
                                      fontSize: 12,
                                    )))
                          ],
                          onExpansionChanged: (bool expanded) {},
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 75,
                        width: 330,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xfff1f2f2),
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.help_center_rounded,
                              color: Colors.black),
                          title: const Text('About',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              )),
                          trailing: const Icon(
                            Icons.chevron_right,
                            color: Colors.black,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const aboutScreen()));
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: 330,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text(
                                      'Are you sure you want to logout?',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black)),
                                  actions: [
                                    TextButton(
                                      child: const Text('No',
                                          style: TextStyle(color: Colors.black)),
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                    ),
                                    TextButton(
                                        child: const Text('Yes',
                                            style:
                                            TextStyle(color: Colors.black)),
                                        onPressed: () => signUserOut(context)),
                                  ],
                                ));
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: const Color(0xfffbbbbb),
                          ),
                          child: const Text(
                            'Log Out',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
