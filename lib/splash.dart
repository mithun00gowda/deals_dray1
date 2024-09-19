import 'dart:convert';
import 'dart:io';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:deals_dray/pages/phone_verification.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:device_info/device_info.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Center(
            child: LottieBuilder.asset(
                'assets/Lottie/Animation - 1723400052821.json'),
          )
        ],
      ),
      nextScreen: FutureBuilder<Map<String, dynamic>>(
        future: getDeviceInfoAndMakeApiCall(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator()); // Show loading indicator
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('Error fetching device info or making API call'));
          } else {
            // Handle API response and navigate to appropriate screen
            Map<String, dynamic> data = snapshot.data!;
            if (data['status'] == 1) {
              final deviceId = data['data']['deviceId'];
              print(deviceId);
              return PhoneNumber_verification(deviceId: deviceId);
              // Navigate to specific screen based on deviceId
            } else {
              // Handle API error and navigate to appropriate screen
              return const Center(child: Text('API call failed'));
            }
          }
        },
      ),
      duration: 3500,
      splashIconSize: 400,
      backgroundColor: Colors.white,
    );
  }

  Future<Map<String, dynamic>> getDeviceInfoAndMakeApiCall() async {
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        Map<String, String> deviceData = {
          'deviceName': androidInfo.model,
          'operatingSystem': 'Android',
          'operatingSystemVersion': androidInfo.version.release,
          'deviceIdentifier': androidInfo.androidId,
        };

        // Make API call with device data
        final response = await http.post(
          Uri.parse('http://devapiv4.dealsdray.com/api/v2/user/device/add'),
          body: jsonEncode(deviceData),
        );

        if (response.statusCode == 200) {
          // API call successful, return success response
          print(deviceData);
          return jsonDecode(response.body);
        } else {
          // Handle API error
          return {'status': 0, 'message': 'API call failed'};
        }
      }
    } catch (e) {
      // Handle errors
      return {
        'status': 0,
        'message': 'Error fetching device info or making API call'
      };
    }
    return {};
  }
}
