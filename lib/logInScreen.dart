// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ibrgy/googleSignup.dart';
import 'package:ibrgy/home.dart';
import 'signUp.dart';
import 'forgotpassword.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool passwordVisible = true; // Declare passwordVisible here

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  void signInWithEmailAndPassword() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );

      if (credential.user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('User not found for email: ${_email.text}');
        showErrorMessage('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for user: ${_email.text}');
        showErrorMessage('Wrong password provided for that user.');
      } else {
        print('Unexpected error: $e');
        showErrorMessage(
            'An unexpected error occurred. Kindly check your email or password if it is correct');
      }
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          // New user, navigate to GoogleSignUpUser screen to collect more information
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => GoogleSignUpUser()),
          );
        } else if (!userCredential.user!.emailVerified) {
          // Existing user not verified, navigate to GoogleSignUpUser
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => GoogleSignUpUser()),
          );
        } else {
          // User is already verified, navigate to Home
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        }
      }
    } catch (e) {
      print("Google Sign-In Error: $e");
      showErrorMessage('Failed to sign in with Google.');
    }
  }

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        decoration: const BoxDecoration(color: Colors.white70),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 50),
                Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 100),
                        const Image(
                          image: AssetImage('pics/login.png'),
                          height: 40,
                        ),
                        const SizedBox(height: 20),
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                                controller: _email,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  label: const Text('Email Address',
                                      style: TextStyle(fontSize: 14)),
                                  fillColor: Colors.white,
                                  filled: true,
                                ))),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextFormField(
                            controller: _password,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Please enter a complete password';
                              }
                              return null;
                            },
                            obscureText: passwordVisible,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              label: const Text('Password',
                                  style: TextStyle(fontSize: 14)),
                              helperText:
                                  "Password must contain special character",
                              helperStyle: const TextStyle(color: Colors.grey),
                              fillColor: Colors.white,
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
                        Padding(
                          padding: const EdgeInsets.only(left: 200),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .end, // Align children to the right
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ForgotPassword(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 50,
                          width: 300,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                signInWithEmailAndPassword();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              backgroundColor: const Color(0xffffe89d),
                              padding: const EdgeInsets.all(
                                15,
                              ),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            '------------------------- Or Login With -------------------------',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                signInWithGoogle();
                              },
                              child: Image(
                                image: AssetImage('pics/google.png'),
                                height: 40,
                                width: 40,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Image(
                                image: AssetImage('pics/apple.png'),
                                height: 40,
                                width: 40,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Image(
                                image: AssetImage('pics/facebook.png'),
                                height: 40,
                                width: 40,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't Have an Account?",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()),
                                );
                              },
                              child: const Text(
                                'Sign up',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                    alignment: Alignment.bottomCenter,
                    child: Image(
                      height: 110,
                      width: 110,
                      image: AssetImage('pics/ibrgy_title.png'),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
