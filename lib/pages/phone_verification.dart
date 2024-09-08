import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:deals_dray/home.dart';
import 'package:deals_dray/pages/otp_verification.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumber_verification extends StatefulWidget {
  final String deviceId;
  const PhoneNumber_verification({required this.deviceId});

  @override
  State<PhoneNumber_verification> createState() =>
      _PhoneNumber_verificationState();
}

class _PhoneNumber_verificationState extends State<PhoneNumber_verification> {
  dynamic phoneNumber;
  // Store the phone number value

  bool _isPhoneNumberValid() {
    // Check if the phone number is null or empty
    if (phoneNumber != null) {
      // Extract the phone number string
      final phoneNumberString = phoneNumber;
      print('Phone Number: $phoneNumberString');
      return true;
    } else {
      return false;
    }
  }

  Future<Map<String, dynamic>> sendOTP(
      String phoneNumber, String deviceId) async {
    print(phoneNumber);
    print(deviceId);

    // Replace with your API endpoint, headers, and body
    final apiEndpoint = 'http://devapiv4.dealsdray.com/api/v2/user/otp';
    final response = await http.post(
      Uri.parse(apiEndpoint),
      body: {
        'mobileNumber': phoneNumber,
        'deviceId': deviceId,
      },
    );

    if (response.statusCode == 200) {
      // Check for 200 (Success) status code
      try {
        final responseData = jsonDecode(response.body);
        print(responseData);

        final String userId = responseData['data']['userId'];
        final String deviceId = responseData['data']['deviceId'];
        print(
            'OTP sent successfully: ${responseData['message']}'); // Print success message (if available)

        // Navigate to verification screen (assuming data is available)
        // You might want to check for specific keys in responseData before navigating
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpVerification(
              userId: userId,
              deviceId: deviceId,
              phoneNumber: phoneNumber,
              // Pass necessary data to verification screen (e.g., otp from responseData)
            ),
          ),
        );
      } on FormatException catch (e) {
        print('Error decoding response: $e');
        // Handle JSON decoding error gracefully
      } catch (e) {
        print('Error sending OTP: ${e.toString()}');
        // Handle other unexpected errors
      }
    } else {
      // Handle other status codes (e.g., 400 for bad request, 401 for unauthorized)
      print(
          'Error sending OTP: ${response.statusCode}'); // Print error status code
    }

    return {}; // Return response body if successful
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://ouch-cdn2.icons8.com/YKG2YKST0PXr0TZ0sONSrCFPSMVyeLekW6qf82696nU/rs:fit:368:368/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvMTc4/L2VhNjkzZmFiLWY5/MzUtNGRhNS04MmNk/LTVkM2M2NjI1MGJh/Mi5zdmc.png',
                  width: 250,
                  fit: BoxFit.cover,
                ),
                FadeInDown(
                  child: const Text(
                    "VERIFY",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                  ),
                ),
                FadeInDown(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      "Enter Your Phone Number to Continu, We Will Send You OTP to Verify",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                FadeInDown(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Stack(
                      children: [
                        IntlPhoneField(
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          initialCountryCode: 'IN',
                          onChanged: (phone) {
                            setState(() {
                              print(phone.number);
                              phoneNumber = phone.number;
                            });
                            print(phone.number);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 250,
                ),
                FadeInDown(
                    child: MaterialButton(
                  onPressed: () {
                    if (_isPhoneNumberValid()) {
                      // Phone number is valid, proceed with verification
                      print(
                          'Device ID: ${widget.deviceId}'); // Print the device ID here
                      sendOTP(phoneNumber, widget.deviceId);
                      // ... your verification logic here
                    } else {
                      // Phone number is empty, show a warning snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a valid phone number'),
                        ),
                      );
                    }
                  },
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  minWidth: double.infinity,
                  child: Text(
                    "Request OTP",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
