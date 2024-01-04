import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ibrgy/logInScreen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ibrgy/signUp.dart';


class SignUp2 extends StatefulWidget {

  final UserData User;
  SignUp2(this. User);

  SignUp2State createState() => SignUp2State();
}


class SignUp2State extends State<SignUp2> {
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _uNameController = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  createUserWithEmailAndPassword() async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'fullName': widget.User.fullName,
      'midName': widget.User.midName,
      'BirthDate':widget.User.BirthDate,
      'Address':widget.User.Address,
      'PhoneNum': widget.User.PhoneNum,
        'username': _uNameController.text,
        'email': _email.text,
        'password': _password.text,
      });
      // If the user is created successfully, navigate to the login page
      Navigator.pushReplacement(
        context, // Make sure you have access to the context variable in your widget
        MaterialPageRoute(
            builder: (context) =>
                LoginScreen()), // Replace LoginPage with your actual login page
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  TextEditingController inputcontroller = TextEditingController();

  void Validate(String email) {
    bool isvalid = EmailValidator.validate(email);
    print(isvalid);
  }

  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Column(
            children: [
              ColoredBox(color: Colors.white),
              Text(
                'Are you sure you want to go back?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                'Changes you made may not be saved',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('No', style: TextStyle(color: Colors.black)),
              onPressed: () => Navigator.pop(context, false),
            ),
            TextButton(
              child: const Text('Yes', style: TextStyle(color: Colors.black)),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        ),
      );
  @override
  Widget build(BuildContext context) => WillPopScope(
      onWillPop: () async {
        print(
          'You pressed the back button',
        );
        final shouldPop = await showWarning(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: const BackButton(),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          decoration: const BoxDecoration(color: Colors.white70),
          child: SingleChildScrollView(
              child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      const Image(
                        image: AssetImage('pics/signup.png'),
                        height: 40,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: _uNameController,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Please enter your desired username';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(color: Color(0xfffff4ce)),
                            ),
                            fillColor: const Color(0xfffff4ce),
                            label: const Text('Username',
                                style: TextStyle(fontSize: 14)),
                            filled: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: _email,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Email is empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(color: Color(0xfffff4ce)),
                            ),
                            fillColor: const Color(0xfffff4ce),
                            label: const Text('Email Address',
                                style: TextStyle(fontSize: 14)),
                            filled: true,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: _password,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Password is empty';
                            }
                            return null;
                          },
                          obscureText: passwordVisible,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(color: Color(0xfffff4ce)),
                            ),
                            label: const Text('Enter Password',
                                style: TextStyle(fontSize: 14)),
                            helperText:
                                "Password must contain special character",
                            helperStyle: const TextStyle(color: Colors.grey),
                            fillColor: const Color(0xfffff4ce),
                            suffixIcon: IconButton(
                              icon: Icon(passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                            ),
                            alignLabelWithHint: false,
                            filled: true,
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          obscureText: passwordVisible,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(color: Color(0xfffff4ce)),
                            ),
                            label: const Text('Confirm Password',
                                style: TextStyle(fontSize: 14)),
                            helperStyle: const TextStyle(color: Colors.grey),
                            fillColor: const Color(0xfffff4ce),
                            suffixIcon: IconButton(
                              icon: Icon(passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                            ),
                            alignLabelWithHint: false,
                            filled: true,
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: 50,
                          width: 300,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                // Form is valid, proceed with signup
                                createUserWithEmailAndPassword();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              backgroundColor: const Color(0xffeeeeee),
                            ),
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Align(
                        alignment: Alignment.bottomCenter,
                        child: Image(
                          height: 110,
                          width: 110,
                          image: AssetImage('pics/ibrgy_title.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
        ),
      ));
}
