import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import 'package:love_bird/config/routes.dart';

class OtpVerificationProvider extends ChangeNotifier {
  bool isLoading = false;

  Future<void> verifyOtp(
      BuildContext context, String otp, String userId) async {
    final url = Uri.parse("http://138.68.150.48:7001/auth/verify-otp")
        .replace(queryParameters: {"userId": userId});

    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "otp": otp, // OTP is sent in the header
        },
      );

      developer.log('Response status: ${response.statusCode}');
      developer.log('Response body: ${response.body}');
// User Verified successfully to server for message
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        developer.log('OTP verified successfully: ${responseData['message']}',
            name: 'OtpProvider');
        Navigator.pushNamed(context, loginCreate);

        // Navigator.pushNamed(context, captchaVerificationPage);
      } else if (response.statusCode == 400) {
        //No user is present for the given OTP
        final responseData = jsonDecode(response.body);
        developer.log('OTP verification failed: ${responseData['message']}',
            name: 'OtpProvider');
        _showErrorDialog(
            context, 'OTP verification failed: ${responseData['message']} ');
      } else {
        developer.log('Unexpected error: ${response.body}',
            name: 'OtpProvider');
        _showErrorDialog(context, 'Unexpected error: ${response.body}');
      }
    } catch (error) {
      developer.log('Failed to verify OTP: $error', name: 'OtpProvider');
      _showErrorDialog(
        context,
        'Failed to verify OTP: $error',
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
