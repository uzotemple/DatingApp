import 'package:flutter/material.dart';
import 'package:love_bird/api/profile_api.dart';
import 'package:love_bird/config/routes.dart';
import 'package:provider/provider.dart';

import 'api_helper.dart';
import 'auth_provider.dart';
import 'dart:developer' as developer;
import 'dart:convert';

class DistanceProvider extends ChangeNotifier {
  double _currentSliderValue = 50; // Default value

  double get currentSliderValue => _currentSliderValue;

  set currentSliderValue(double value) {
    _currentSliderValue = value;
    notifyListeners(); // Notify listeners when the value changes
  }

  Future<void> updateDistance(
      BuildContext context, AuthProvider authProvider) async {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);

    try {
      await profileProvider.retieveProfile(context, authProvider);

      if (profileProvider.getProfileData == null) {
        developer.log('Profile data retrieval failed.');
        _showErrorDialog(context, "Failed to retrieve profile data.");
        return;
      }

      Map<String, dynamic>? profileData = profileProvider.getProfileData;
      developer.log('Retrieved profile data: $profileData');

      String profession = profileData?["profession"] ?? "Unknown";
      double weight = profileData?["weight"]?.toDouble() ?? 0.0;
      double height = profileData?["height"]?.toDouble() ?? 0.0;
      String country = profileData?["country"] ?? "Unknown";
      String city = profileData?["city"] ?? "Unknown";
      String bio = profileData?["bio"] ?? "Unknown";
      String educationLevel = profileData?["educationLevel"] ?? "Unknown";
      String name = profileData?["nickname"] ?? "Unknown";
      double age = profileData?["age"]?.toDouble() ?? 0.0;
      String dobString = profileData?["dob"] ?? "Unknown";

      DateTime? dob;
      if (dobString != "Unknown") {
        dob = DateTime.tryParse(
            dobString); // Parse the string into a DateTime object
      }
      String genderString = profileData?["gender"] ?? "Unknown";
      String goal = profileData?["relationshipGoals"] ?? "Unknown";
      const url = 'http://138.68.150.48:7001/profile/profile-detailed';
      const method = 'POST';
      final headers = {'Content-Type': 'application/json'};

      final body = {
        "nickname": name,
        "dob": dob,
        "age": age,
        "gender": genderString,
        "relationshipGoals": goal,
        "latitude": 0,
        "longitude": 0,
        "profession": profession,
        "weight": weight,
        "height": height,
        "country": country,
        "city": city,
        "bio": bio,
        "educationLevel": educationLevel,
        "interest": "string",
        "isPicsVerified": true,
        "location": currentSliderValue,
        "children": "string",
        "pet": "string",
        "religion": "string",
        "personality": "string",
        "sexuality": "string",
        "smoking": "string",
        "relationshipStatus": "string",
        "drinkings": "string",
        "starSign": "string",
        "language": "string"
      };

      final response = await makeApiRequest(
        url,
        method,
        headers,
        authProvider,
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        developer.log('Profile updated successfully: ${response.body}');
        Navigator.pushNamed(context, interestsSelectionScreen);
      } else {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final errorMessage = responseBody['message'] ?? 'Unknown error';

        developer.log(
            'Failed to create profile. Status code: ${response.statusCode}, Error: $errorMessage');

        _showErrorDialog(context, "Error: $errorMessage");
        throw Exception(
            'Failed to create profile. Status code: ${response.statusCode}, Response: ${response.body}');
      }
    } catch (e) {
      developer.log('Error creating profile: $e');
      _showErrorDialog(context, "An error occurred. Please try again.");
    }
  }
}
// Future<void> updateDistance(
//     BuildContext context, AuthProvider authProvider) async {
//   try {
//     // Define API request details
//     const url = 'http://138.68.150.48:7001/profile/profile-detailed';
//     const method =
//         'POST'; // Consider using a constant or enum for HTTP methods
//     final headers = {'Content-Type': 'application/json'};

//     // API request body
//     final body = {"location": 'currentSliderValue'};

//     // Send the request using makeApiRequest
//     final response = await makeApiRequest(
//       url,
//       method,
//       headers,
//       authProvider,
//       body: body,
//     );

//     // Check for successful response
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       developer.log('Profile created successfully: ${response.body}');
//       Navigator.pushNamed(context, interestsSelectionScreen);
//     } else {
//       final Map<String, dynamic> responseBody = jsonDecode(response.body);
//       final errorMessage = responseBody['message'] ?? 'Unknown error';

//       //  Print and log the error
//       developer.log(
//           'Failed to create profile. Status code: ${response.statusCode}, Error: $errorMessage');

//       _showErrorDialog(context, "Error: $errorMessage");
//       throw Exception(
//           'Failed to create profile. Status code: ${response.statusCode}, Response: ${response.body}');

//       //  return;
//     }
//   } catch (e) {
//     developer.log('Error creating profile: $e');
//     _showErrorDialog(context, "An error occurred. Please try again.");
//   }
// }

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
