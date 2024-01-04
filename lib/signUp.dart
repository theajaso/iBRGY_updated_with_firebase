import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ibrgy/logInScreen.dart';
import 'main.dart';
import 'main.dart';
import 'signUp2.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignUp extends StatefulWidget {
  createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  UserData User = UserData();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _bdateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            icon: const Icon(Icons.arrow_back_rounded),
            splashRadius: 30,
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          decoration: const BoxDecoration(color: Colors.white70),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                            controller: _fullNameController,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Full Name is empty';
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
                              label: const Text(
                                  'Full Name (First Name, Last Name)',
                                  style: TextStyle(fontSize: 14)),
                              filled: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            controller: _middleNameController,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Middle Name is empty';
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
                              helperText:
                                  'Write N/A if the field is not applicable',
                              label: const Text('Middle Name',
                                  style: TextStyle(fontSize: 14)),
                              filled: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextField(
                            controller: _bdateController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Color(0xfffff4ce)),
                              ),
                              fillColor: const Color(0xfffff4ce),
                              label: const Text('Birth date',
                                  style: TextStyle(fontSize: 14)),
                              suffixIcon:
                                  const Icon(Icons.calendar_month_rounded),
                              filled: true,
                            ),
                            readOnly: true,
                            onTap: () {
                              _selectDate();
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            controller: _addressController,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Address is empty';
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
                              label: const Text('Address',
                                  style: TextStyle(fontSize: 14)),
                              suffixIcon: const Icon(
                                Icons.location_city,
                              ),
                              filled: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: IntlPhoneField(
                            controller: _phoneNumController,
                            decoration: InputDecoration(
                              label: const Text('Phone Number',
                                  style: TextStyle(fontSize: 14)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Color(0xfffff4ce)),
                              ),
                              fillColor: const Color(0xfffff4ce),
                              filled: true,
                            ),
                            initialCountryCode: 'PH',
                            onChanged: (phone) {
                              print(phone.completeNumber);
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            onPressed: (){
                              User.fullName = _fullNameController.text;
                              User.midName = _middleNameController.text;
                              User.BirthDate = _bdateController.text;
                              User.Address = _addressController.text;
                              User.PhoneNum = _phoneNumController.text;
                              // Navigate to the next screen or perform other actions
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder:(context) => SignUp2(User)),
                              );
                            },
                            icon: const Icon(Icons.arrow_forward_ios_rounded),
                            splashRadius: 35,
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
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.dark(
                  primary: Colors.grey,
                  onSecondary: Colors.black,
                  onPrimary: Colors.black,
                  surface: Color.fromARGB(255, 253, 232, 163),
                  onSurface: Colors.black,
                  secondary: Colors.black),
              dialogBackgroundColor: const Color(0xfffff9e7),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                    foregroundColor: Colors.black, // button text color
                    textStyle: const TextStyle(
                      fontSize: 18, color: Colors.grey, // button text size
                    )),
              ),
            ),
            child: child!,
          );
        });
    if (_picked != null) {
      setState(() {
        _bdateController.text = _picked.toString().split(" ")[0];
      });
    }
  }

}


class UserData{
  String fullName = '';
  String midName = '';
  String BirthDate = '';
  String Address = '';
  String PhoneNum = '';
}
