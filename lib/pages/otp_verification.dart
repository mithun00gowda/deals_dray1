import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:deals_dray/home.dart';
import 'package:deals_dray/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class OtpVerification extends StatefulWidget {
  final String userId, deviceId, phoneNumber;
  const OtpVerification({
    super.key,
    required this.deviceId,
    required this.userId,
    required this.phoneNumber,
  });

  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  String enteredOtp = "";
  int _resendOtpCooldown = 60; // Resend cooldown in seconds (optional)
  bool _isResendButtonDisabled = false;

  bool _isOtpValid() {
    if (enteredOtp.length <= 4) {
      return true;
    } else {
      enteredOtp = "";
      return false;
    }
  }

  Future<Map<String, dynamic>> otpVerification(
      String otp, String userId, String deviceId) async {
    const apiEndpoint =
        'http://devapiv4.dealsdray.com/api/v2/user/otp/verification';
    final response = await http.post(
      Uri.parse(apiEndpoint),
      body: {'otp': otp, 'deviceId': deviceId, 'userId': userId},
    );

    if (response.statusCode == 200) {
      try {
        final responseData = jsonDecode(response.body);
        print(responseData);

        if (responseData['data']['registration_status'] == 'Incomplete') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Register(
                userId: widget.userId,
              ),
            ),
          );
        } else if (responseData['data']['registration_status'] == 'Complete') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Home(),
            ),
          );
        }
      } on FormatException catch (e) {
        print('Error decoding response: $e');
        // Handle JSON decoding error gracefully
      } catch (e) {
        print('Error sending OTP: ${e.toString()}');
      }
    }
    return {};
  }

  Future<void> resendOtp(
    String deviceId,
    String mobileNumber,
  ) async {
    // Implement resend OTP logic here (e.g., call API)
    const apiEndpoint =
        'http://devapiv4.dealsdray.com/api/v2/user/otp/resendhttp://devapiv4.dealsdray.com/api/v2/user/otp';
    final response = await http.post(
      Uri.parse(apiEndpoint),
      body: {'mobileNumber': mobileNumber, 'deviceId': deviceId},
    );

    if (response.statusCode == 200) {
      // Handle successful resend
      print('OTP resent successfully');
    } else {
      // Handle error
      print('Error resending OTP: ${response.statusCode}');
    }

    setState(() {
      _isResendButtonDisabled = true;
      _resendOtpCooldown = 60; // Reset cooldown timer
    });

    // Start a timer to re-enable the resend button
    Future.delayed(Duration(seconds: _resendOtpCooldown), () {
      setState(() {
        _isResendButtonDisabled = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String number = widget.phoneNumber;
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
                  'https://ouch-cdn2.icons8.com/zAyOpnPO_QYtMtZJEaeTxuhsWsfzpIASq7ib1FUIgDI/rs:fit:368:368/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvMzQy/LzExZmRhNTZmLWMw/ZDQtNGI2MC1hODkz/LTRlY2YyYjlmOTI4/Ni5wbmc.png',
                  width: 150,
                  fit: BoxFit.cover,
                ),
                FadeInDown(
                  child: const Text(
                    "OTP VERIFICATION",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                  ),
                ),
                FadeInDown(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      "We have Sent a Unique OTP number to Your mobile +91 $number",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                ),
                const SizedBox(height: 80),
                FadeInDown(
                  child: OtpTextField(
                    numberOfFields: 4,
                    onCodeChanged: (otp) {
                      setState(() {
                        enteredOtp += otp;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't receive OTP? ",
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_isResendButtonDisabled) {
                          resendOtp(widget.deviceId, widget.phoneNumber);
                        }
                      },
                      child: Text(
                        _isResendButtonDisabled
                            ? 'Resend OTP in ${_resendOtpCooldown}s'
                            : 'Resend OTP',
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 300),
                FadeInDown(
                  child: MaterialButton(
                    onPressed: () {
                      print("Entered OTP: $enteredOtp");
                      if (_isOtpValid()) {
                        otpVerification(
                            enteredOtp, widget.userId, widget.deviceId);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter valid OTP'),
                          ),
                        );
                        enteredOtp = " ";
                      }
                    },
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 50),
                    minWidth: double.infinity,
                    child: const Text(
                      "Verify OTP",
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
