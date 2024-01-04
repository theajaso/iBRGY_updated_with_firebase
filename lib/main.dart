import 'package:flutter/material.dart';
import 'welcomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iBRGY!',
      // Application theme data, you can set the colors for the application as
      // you want
      theme: ThemeData(
          primarySwatch: Colors
              .grey), // A widget which will be started on application startup
      home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
