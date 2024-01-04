import 'package:flutter/material.dart';
import 'package:ibrgy/dashboard.dart';
import 'package:ibrgy/ibrgy_button.dart';
import 'package:ibrgy/pending_button.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPage = 0;
  final List<Widget> screens = [
    Dashboard(),
    const PendingButton(),
    const ibrgyButton()
  ];

  Widget currentScreen = Dashboard();
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton.large(
        backgroundColor: const Color(0xffffeeb6),
        onPressed: () {
          setState(() {
            currentScreen = const ibrgyButton();
            currentPage = 3;
          });
        },
        tooltip: "About the Developers",
        splashColor: Colors.grey,
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(55)),
        child: Ink.image(image: const AssetImage("pics/ibrgy_logo.png")),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xffffeeb6),
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: SizedBox(
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 60,
                      onPressed: () {
                        setState(() {
                          currentScreen = Dashboard();
                          currentPage = 0;
                        });
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.home,
                            size: 30,
                            color:
                                currentPage == 0 ? Colors.black : Colors.grey,
                          ),
                          Text(
                            "Home",
                            style: TextStyle(
                              color:
                                  currentPage == 0 ? Colors.black : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 160,
                    ),
                    MaterialButton(
                      minWidth: 60,
                      onPressed: () {
                        setState(() {
                          currentScreen = const PendingButton();
                          currentPage = 1;
                        });
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.pending,
                            size: 30,
                            color:
                                currentPage == 1 ? Colors.black : Colors.grey,
                          ),
                          Text(
                            "Pending",
                            style: TextStyle(
                              color:
                                  currentPage == 1 ? Colors.black : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
