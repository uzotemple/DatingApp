import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:love_bird/config/routes.dart';
import 'package:love_bird/providers/api_helper.dart';
import 'package:love_bird/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LogOutProvider extends ChangeNotifier {
  Future<void> logOut(
    BuildContext context,
    AuthProvider authProvider,
  ) async {
    try {
      // Define API request details
      const String url = 'http://138.68.150.48:7001/auth/logout';
      const method =
          'DELETE'; // Consider using a constant or enum for HTTP methods
      final headers = {'Content-Type': 'application/json'};

      // Send the request using makeApiRequest
      final response = await makeApiRequest(
        url,
        method,
        headers,
        authProvider,
      );

      // Check for successful response
      if (response.statusCode == 200 || response.statusCode == 201) {
        developer.log('love ya');
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        await authProvider.logout();
        Navigator.pushReplacementNamed(context, loginPage);
      } else {
        final Map<String, dynamic> responseBody = jsonDecode(response.data);
        final errorMessage = responseBody['message'] ?? 'Unknown error';

        //  Print and log the error
        developer.log(
            'Failed to log out. Status code: ${response.statusCode}, Error: $errorMessage');

        _showErrorDialog(context, "Error: $errorMessage");
        throw Exception(
            'Failed to logout. Status code: ${response.statusCode}, Response: ${response.data}');

        //  return;
      }
    } catch (e) {
      developer.log('Error logging out: $e');
      _showErrorDialog(context, "An error occurred. Please try again.");
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
