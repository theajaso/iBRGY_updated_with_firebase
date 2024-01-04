import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'logInScreen.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

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

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ForgotPasswordDone()),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showErrorMessage(e.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xffffe89d),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          title: const Text(
            'Forgot Password',
            style: TextStyle(fontSize: 17),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Image(
                    image: AssetImage('pics/forgotpassword.png'),
                    height: 230,
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text('Enter the email address',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  const Center(
                    child: Text('associated with your account',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text('We will send you a password reset link',
                        style: TextStyle(
                          fontSize: 12,
                        )),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                      padding: const EdgeInsets.all(40),
                      child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            label: const Text('Email Address',
                                style: TextStyle(fontSize: 14)),
                            fillColor: Colors.white,
                            filled: true,
                          ))),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          passwordReset();
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
                        'Send',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ));
  }
}

class ForgotPasswordDone extends StatefulWidget {
  ForgotPasswordDone({super.key});

  @override
  State<ForgotPasswordDone> createState() => _ForgotPasswordDoneState();
}

class _ForgotPasswordDoneState extends State<ForgotPasswordDone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xffffe89d),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          title: const Text(
            'Forgot Password',
            style: TextStyle(fontSize: 17),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 70),
              const Image(
                image: AssetImage('pics/forgotpassdone.png'),
                height: 230,
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text('Password Reset Link Has Been Sent!',
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                    'Your password reset link has been sent to your email.',
                    style: TextStyle(
                      fontSize: 12,
                    )),
              ),
              const Center(
                child: Text('Kindly check to safely change your password.',
                    style: TextStyle(
                      fontSize: 12,
                    )),
              ),
              const SizedBox(height: 100),
              SizedBox(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    // Form is valid, navigate to the next screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
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
                    'Done',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    // Form is valid, navigate to the next screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotPassword()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                  ),
                  child: const Text(
                    'Resend Email',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
