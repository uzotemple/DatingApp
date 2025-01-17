import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:love_bird/config/constants.dart';
import 'package:love_bird/config/routes.dart';

class RetrieveProvider extends ChangeNotifier {
  String? _userId;
  String? get userId => _userId;
  Future<void> retrieveEmail(BuildContext context, String email) async {
    String url = 'http://138.68.150.48:7001/auth/forget-password';
    Uri uri = Uri.parse(url).replace(queryParameters: {'email': email});

    try {
      final response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody.containsKey('userId')) {
          _userId = responseBody['userId'];
          notifyListeners();
          Navigator.pushNamed(context, oTPVerificationPage);
        } else {
          throw Exception('User ID not found in response');
        }
      } else {
        final responseBody = jsonDecode(response.body);
        final message = responseBody['message']?.toString() ?? 'Unknown error';
        _showErrorDialog(context, "Error: $message");
      }
    } catch (e) {
      developer.log('Error: $e');
      _showErrorDialog(context, "An error occurred. Please try again. $e");
    }
  }

  Future<void> forgotPassword(BuildContext context, String? userId, String? otp,
      String password) async {
    String url = 'http://138.68.150.48:7001/auth/forget-password';
    userId = userId;
    Uri uri = Uri.parse(url);

    try {
      final response = await http.post(uri,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(
              {'userId': userId, 'otp': otp, 'newPassword': password}));

      if (response.statusCode == 200) {
        _showSubmissionDialog(context);
      } else {
        final responseBody = jsonDecode(response.body);
        final message = responseBody['message']?.toString() ?? 'Unknown error';
        _showErrorDialog(context, "Error: $message");
      }
    } catch (e) {
      developer.log('Error: $e');
      _showErrorDialog(context, "An error occurred. Please try again. $e");
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

  void _showSubmissionDialog(
    BuildContext context,
  ) {
    showDialog(
      barrierDismissible:
          true, // Prevent dialog from closing by tapping outside
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min, // Wrap content
              children: [
                Image.asset('assets/images/password_thumbs.png'),
                const SizedBox(height: 20),
                const Text(
                  'Reset Password Successful!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: blue,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Please wait....\nYou will be redirected to the Login page",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );

    // Wait for 2 seconds and then navigate to the next screen
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
      Navigator.pushNamed(context, loginPage);
    });
  }
}
