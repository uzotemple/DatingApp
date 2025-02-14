import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';

import 'package:love_bird/providers/api_helper.dart';
import 'package:love_bird/providers/auth_provider.dart';

class UpdatePasswordProvider extends ChangeNotifier {
  Future<void> updatePassword(BuildContext context, AuthProvider authProvider,
      String oldPassword, String newPassword) async {
    try {
      // Define API request details
      String url = 'http://138.68.150.48:7001/user/update-password';
      const method =
          'POST'; // Consider using a constant or enum for HTTP methods
      final headers = {'Content-Type': 'application/json'};

      // API request body
      final body = {'oldPassword': oldPassword, 'newPassword': newPassword};

      // Send the request using makeApiRequest
      final response = await makeApiRequest(
        url,
        method,
        headers,
        authProvider,
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        developer.log('Password updated successfully.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password Updated, Go back to swiping'),
          ),
        );
      } else {
        final Map<String, dynamic> responseBody = jsonDecode(response.data);
        final errorMessage = responseBody['message'] ?? 'Unknown error';
        developer.log(
          'Password update failed. Status code: ${response.statusCode}, Error: $errorMessage',
        );
        _showErrorDialog(context, "Error: $errorMessage");
        throw Exception(
            'Failed to create profile. Status code: ${response.statusCode}, Response: ${response.data}');

        //  return;
      }
    } catch (e) {
      developer.log('Error creating profile: $e');
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
