import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'dart:convert';
import 'package:love_bird/providers/api_helper.dart';
import 'package:love_bird/providers/auth_provider.dart';

class ProfileProvider extends ChangeNotifier {
  // Define a variable to store the profile response data
  Map<String, dynamic>? profileData;

  Future<void> retieveProfile(
      BuildContext context, AuthProvider authProvider) async {
    try {
      // Define API request details
      const url =
          'http://138.68.150.48:7001/profile'; // Include transactionId in URL
      const method = 'GET';

      // Add headers if necessary
      final headers = {
        'Content-Type': 'application/json',
      };

      // Send the request using makeApiRequest
      final response = await makeApiRequest(
        url,
        method,
        headers,
        authProvider,
      );

      // Check for successful response
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse the response body
        profileData = jsonDecode(response.body);
        // Notify listeners so that UI can be updated
        notifyListeners();
      } else {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final errorMessage = responseBody['message'] ?? 'Unknown error';

        // Print and log the error
        developer.log(
          'Failed to retrieve Profile. Status code: ${response.statusCode}, Error: $errorMessage',
        );

        _showErrorDialog(context, "Error: $errorMessage");
        throw Exception(
          'Failed to retrieve Profile. Status code: ${response.statusCode}, Response: ${response.body}',
        );
      }
    } catch (e) {
      developer.log('Error retrieving profile: $e');
      _showErrorDialog(context, "An error occurred. Please try again.");
    }
  }

  // Getter to access the profile data
  Map<String, dynamic>? get getProfileData => profileData;

  // Method to display error dialog
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error', style: TextStyle(color: Colors.black)),
          content: Text(message, style: const TextStyle(color: Colors.black)),
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
