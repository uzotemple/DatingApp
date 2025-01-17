// import 'package:flutter/foundation.dart';

// class GenderProvider extends ChangeNotifier {
//   int _selectedGender = 0; // MALE, 1: , 2: FEMALE, 3: prefer not to say

//   int get selectedGender => _selectedGender;

//   void setGender(int gender) {
//     _selectedGender = gender;
//     notifyListeners(); // Notifny listeners of the state change
//   }
// }

import 'package:flutter/material.dart';
import 'package:love_bird/config/routes.dart';

import 'api_helper.dart';
import 'auth_provider.dart';
import 'dart:developer' as developer;
import 'dart:convert';

class GenderProvider extends ChangeNotifier {
  int _selectedGender = 0; // Default is 0 (not selected)

  // Getter for selectedGender
  int get selectedGender => _selectedGender;

  // Method to set the selected gender
  void setGender(int gender) {
    _selectedGender = gender;
    notifyListeners(); // Notify listeners about the state change
  }

  // Method to get the selected gender as a string
  String get genderString {
    switch (_selectedGender) {
      case 1:
        return "MALE";
      case 2:
        return "FEMALE";
      case 3:
        return "I'D PREFER NOT TO SAY";
      default:
        return "Not selected";
    }
  }

  Future<void> updateGender(
      BuildContext context, AuthProvider authProvider) async {
    try {
      // Define API request details
      const url = 'http://138.68.150.48:7001/profile/profile-detailed';
      const method =
          'POST'; // Consider using a constant or enum for HTTP methods
      final headers = {'Content-Type': 'application/json'};

      // API request body
      final body = {
        "gender": genderString,
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
        Navigator.pushNamed(context, relationshipGoalsScreen);
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
