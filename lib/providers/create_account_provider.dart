import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:love_bird/config/routes.dart';

class CreateAccountProvider extends ChangeNotifier {
  String email = '';
  String password = '';
  bool agreeToPolicy = false;
  String? _userId;

  String? get userId => _userId;

  void updateEmail(String newEmail) {
    email = newEmail;
    notifyListeners();
  }

  void updatePassword(String newPassword) {
    password = newPassword;
    notifyListeners();
  }

  void toggleAgreeToPolicy(bool? newValue) {
    agreeToPolicy = newValue ?? false;
    notifyListeners();
  }

  Future<void> saveToDatabase(
    BuildContext context,
  ) async {
    final url = Uri.parse("http://138.68.150.48:7001/auth/register");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      developer.log('Response status: ${response.statusCode}');
      developer.log('Response body: ${response.body}');

      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      final String message =
          responseBody['message']?.toString() ?? 'Unknown error occurred';

      if (response.statusCode == 202 ||
          response.statusCode == 201 ||
          response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        _userId = responseData['userId']; // Save the userId
        notifyListeners(); // Notify listeners to update dependent widgets
        developer.log('User registered successfully with ID: $_userId',
            name: 'UserAction');
        developer.log('Form validated successfully', name: 'UserAction');

        Navigator.pushNamed(context, verifyEmailRoute);

        notifyListeners();
        //User registered successfully to Server. Please check OTP on your registered mail
      } else if (message == 'User is already exists with given Email') {
        _showErrorDialog(context, "User already exists with given Email");
      } else {
        _showErrorDialog(context, "Unexpected error: $message");
      }
    } catch (e) {
      developer.log('Failed to register: $e', name: 'UserAction');
      _showErrorDialog(
          context, "Failed to register. Please check your connection.");
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
