import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ibrgy/appointment_pages/about_screen.dart';
import 'package:ibrgy/appointment_pages/appointment_page.dart';
import 'profilePage.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(Dashboard());

class Dashboard extends StatefulWidget {
  Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();// Call the function in initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Welcome!',
                                style: TextStyle(
                                  fontSize: 16,
                                )),
                            SizedBox(
                              height: 2,
                            ),
                            StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(user.uid) // Use the UID of the currently logged-in user
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Text('Loading...');
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else if (!snapshot.hasData || !snapshot.data!.exists) {
                                  // Handle the case where the document does not exist
                                  return Text('User not found.');
                                } else {
                                  // Access and display the username from Firestore
                                  String username = snapshot.data!.get('username');
                                  return Text(
                                    username,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfilePage()),
                              );
                            },
                            child: const CircleAvatar(
                              radius: 30,
                              foregroundImage: AssetImage('pics/woman.png'),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 120,
                    //width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xfffbbbbb),
                          Color(0xfffbbbbb),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(32),
                      color: const Color(0xfff89393),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Image(
                          image: AssetImage('pics/monitoring.png'),
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            const Center(
                              child: Image(
                                image: AssetImage('pics/ibrgytitle.png'),
                                height: 50,
                                width: 100,
                              ),
                            ),
                            Center(
                              child: Container(
                                height: 28,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10)),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const aboutScreen()));
                                  },
                                  child: const Center(
                                    child: Text('About Us',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(color: Colors.white70),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(15),
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              color: const Color(0xffd4e7f9),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      '30°C',
                                      style: TextStyle(
                                        fontSize: 26,
                                      ),
                                    ),
                                    Text(
                                      'Manila,\nPhilippines',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Mostly Cloudy\nH:34° L:26°',
                                      style: TextStyle(
                                        fontSize: 8,
                                      ),
                                    ),
                                  ],
                                ),
                                Image(
                                  alignment: Alignment.topRight,
                                  height: 50,
                                  width: 60,
                                  image: AssetImage('pics/cloudy.png'),
                                ),
                              ],
                            )),
                        const SizedBox(
                          width: 13,
                        ),
                        Container(
                            padding: const EdgeInsets.all(15),
                            height: 120,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              color: const Color(0xffd1e0b2),
                            ),
                            child: const Column(
                              children: [
                                Text(
                                  'Meet our',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 8,
                                  ),
                                ),
                                Text(
                                  'BARANGAY OFFICIALS',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Image(
                                  alignment: Alignment.center,
                                  height: 56,
                                  width: 150,
                                  image: AssetImage('pics/community.png'),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 120,
                    //  width: 320,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: const Color(0xffe0bedb),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Image(
                          alignment: Alignment.topRight,
                          height: 160,
                          width: 100,
                          image: AssetImage('pics/marketing.png'),
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 10),
                            const Text(
                              'Stay updated with the latest...',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Center(
                              child: Container(
                                height: 28,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: const Color(0xff896dba),
                                    borderRadius: BorderRadius.circular(10)),
                                child: InkWell(
                                    onTap: () {},
                                    child: const Center(
                                      child: Text('Announcements',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          )),
                                    )),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Center(
                              child: Container(
                                height: 28,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: const Color(0xff896dba),
                                    borderRadius: BorderRadius.circular(10)),
                                child: InkWell(
                                  onTap: () {},
                                  child: const Center(
                                    child: Text('Feedbacks and Stories',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'btn 2',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const appointmentScreen()),
          );
        },
        elevation: 8.0,
        backgroundColor: const Color(0xffffe89d),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(55)),
        splashColor: const Color(0xff92c7fc),
        child: const Icon(Icons.add),
      ),
    );
  }
}
