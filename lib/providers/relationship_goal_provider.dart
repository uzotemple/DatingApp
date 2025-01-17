import 'package:love_bird/config/routes.dart';

import 'package:flutter/material.dart';
import 'api_helper.dart';
import 'auth_provider.dart';
import 'dart:developer' as developer;
import 'dart:convert';

class GoalProvider extends ChangeNotifier {
  String? _selectedGoal;

  String? get selectedGoal => _selectedGoal;

  void setGoal(String goal) {
    _selectedGoal = goal;
    notifyListeners(); // Notify listeners of the state change
  }

  Future<void> updateGoal(
      BuildContext context, AuthProvider authProvider) async {
    try {
      // Define API request details
      const url = 'http://138.68.150.48:7001/profile/profile-detailed';
      const method =
          'POST'; // Consider using a constant or enum for HTTP methods
      final headers = {'Content-Type': 'application/json'};

      // API request body
      final body = {
        "relationshipGoals": selectedGoal,
      };

      // Send the request using makeApiRequest
      final response = await makeApiRequest(
        url,
        method,
        headers,
        authProvider,
        body: body,
      );

      // Check for successful response
      if (response.statusCode == 200 || response.statusCode == 201) {
        developer.log('Profile created successfully: ${response.body}');
        Navigator.pushNamed(context, distancePreferenceScreen);
      } else {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final errorMessage = responseBody['message'] ?? 'Unknown error';

        //  Print and log the error
        developer.log(
            'Failed to create profile. Status code: ${response.statusCode}, Error: $errorMessage');

        _showErrorDialog(context, "Error: $errorMessage");
        throw Exception(
            'Failed to create profile. Status code: ${response.statusCode}, Response: ${response.body}');

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
