import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:deals_dray/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  final String userId;
  const Register({required this.userId});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Form key for validation
  String _email = '';
  String _password = '';
  String _referralCode = '';

  // void _handleRegistration() async {
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save(); // Save form data

  //     // **Security Note:** Never print email, password, or referral code directly.
  //     // Instead, use them for secure authentication or storage mechanisms.
  //     print('Registration successful: Email: $_email, Password (hidden)');

  //     // Implement your registration logic here, e.g., using a backend service

  //     // Clear form fields (optional)
  //     _formKey.currentState!.reset();
  //     _email = '';
  //     _password = '';
  //     _referralCode = '';
  //   } else {
  //     print('Please fix form errors before registering.');
  //   }
  // }

  Future<Map<String, dynamic>> _newRegister(
      String email, String password, String referralCode, String userId) async {
    final apiEndpoint =
        'http://devapiv4.dealsdray.com/api/v2/user/email/referral';
    final response = await http.post(
      Uri.parse(apiEndpoint),
      body: {
        'email': email,
        'password': password,
        'referralCode': referralCode,
        'userId': userId
      },
    );

    if (response.statusCode == 200) {
      try {
        final responseData = jsonDecode(response.body);
        print(responseData);

        if (responseData['status'] == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
          );
        }
      } catch (e) {
        print('Error sending OTP: ${e.toString()}');
      }
    }

    return {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(30),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://ouch-cdn2.icons8.com/3FLtWLPFHQqSyYkKFwR9NqCqOtk7xN8QXBVMn3xghJw/rs:fit:368:368/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvNzU3/L2RiMzZlZmMyLTIy/MzEtNDk4MS1iOGRh/LWRkYmM4NDFhYTRj/Mi5zdmc.png',
                  width: 200,
                  fit: BoxFit.cover,
                ),
                FadeInDown(
                  child: const Text(
                    "Lets Begin!",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
                  ),
                ),
                FadeInDown(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      "Please Enter Your Credentials To Procede ",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                ),
                FadeInDown(
                  child: Form(
                    key: _formKey, // Assign form key
                    child: Column(
                      children: [
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: "Enter Your Email"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email address.';
                            }
                            return null;
                          },
                          onSaved: (value) =>
                              _email = value!, // Save email on form submission
                        ),
                        SizedBox(height: 50),
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: " Create Password"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password.';
                            }
                            // Add more robust password validation here (e.g., minimum length, complexity)
                            return null;
                          },
                          onSaved: (value) => _password =
                              value!, // Save password on form submission
                          obscureText: true, // Hide password input
                        ),
                        SizedBox(height: 50),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: "Referral Code (Optional)"),
                          onSaved: (value) => _referralCode =
                              value!, // Save referral code on form submission
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 180),
                FadeInDown(
                  child: MaterialButton(
                    onPressed: () {
                      // _handleRegistration();
                      print(_email);
                      print(_password);
                      print(_referralCode);
                      print(widget.userId);
                      _newRegister(
                          _email, _password, _referralCode, widget.userId);
                    },
                    // Call the registration handler
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    minWidth: double.infinity,
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
