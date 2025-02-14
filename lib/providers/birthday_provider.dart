import 'package:flutter/material.dart';
import 'package:love_bird/api/profile_api.dart';
import 'package:love_bird/config/routes.dart';
import 'package:love_bird/providers/api_helper.dart';
import 'package:love_bird/providers/auth_provider.dart';
import 'dart:developer' as developer;
import 'dart:convert';

import 'package:provider/provider.dart';
class CelebrateYouProvider with ChangeNotifier {
  String _month = '';
  String _day = '';
  String _year = '';
  String _dob = '';
  DateTime now = DateTime.now().toUtc();

  String get month => _month;
  String get day => _day;
  String get year => _year;
  String get dob => _dob;

  void setMonth(String value) {
    _month = value;
    notifyListeners();
  }

  void setDay(String value) {
    _day = value;
    notifyListeners();
  }

  void setYear(String value) {
    _year = value;
    notifyListeners();
  }

  // String get dobBirth {
  //   if (_year.isNotEmpty && _month.isNotEmpty && _day.isNotEmpty) {
  //     _dob =
  //         '$_year-$_month-${_day}T${now.hour}:${now.minute}:${now.second}.000Z';
  //   }
  //   return _dob;
  // }
  String get dobBirth {
    if (_year.isNotEmpty && _month.isNotEmpty && _day.isNotEmpty) {
      _dob = '${_year.padLeft(4, '0')}-'
          '${_month.padLeft(2, '0')}-'
          '${_day.padLeft(2, '0')}T'
          '${now.hour.toString().padLeft(2, '0')}:'
          '${now.minute.toString().padLeft(2, '0')}:'
          '${now.second.toString().padLeft(2, '0')}.000Z';
    }
    return _dob;
  }

  // Method to calculate the age
  int get age {
    if (_year.isNotEmpty && _month.isNotEmpty && _day.isNotEmpty) {
      DateTime birthDate = DateTime.parse(dobBirth);
      int age = now.year - birthDate.year;

      // Check if the birthday has occurred this year
      if (now.month < birthDate.month ||
          (now.month == birthDate.month && now.day < birthDate.day)) {
        age--;
      }

      return age;
    }
    return 0; // Return 0 if the date of birth is incomplete
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

  Future<void> updateDob(
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

      const url = 'http://138.68.150.48:7001/profile/profile-detailed';
      const method = 'POST';
      final headers = {'Content-Type': 'application/json'};

      final body = {
        "nickname": name,
        "dob": dob,
        "age": age,
        "gender": "MALE",
        "relationshipGoals": "DATING",
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
        "location": "string",
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
        developer.log('Profile updated successfully: ${response.data}');
        Navigator.pushNamed(context, gender);
      } else {
        final Map<String, dynamic> responseBody = jsonDecode(response.data);
        final errorMessage = responseBody['message'] ?? 'Unknown error';

        developer.log(
            'Failed to create profile. Status code: ${response.statusCode}, Error: $errorMessage');

        _showErrorDialog(context, "Error: $errorMessage");
        throw Exception(
            'Failed to create profile. Status code: ${response.statusCode}, Response: ${response.data}');
      }
    } catch (e) {
      developer.log('Error creating profile: $e');
      _showErrorDialog(context, "An error occurred. Please try again.");
    }
  }
}
//   Future<void> updateDob(
//       BuildContext context, AuthProvider authProvider) async {
//     try {
//       // Define API request details
//       const url = 'http://138.68.150.48:7001/profile/profile-detailed';

//       const method =
//           'POST'; // Consider using a constant or enum for HTTP methods
//       final headers = {'Content-Type': 'application/json'};

//       // API request body
//       final body = {"dob": dob, "age": age};

//       // Send the request using makeApiRequest
//       final response = await makeApiRequest(
//         url,
//         method,
//         headers,
//         authProvider,
//         body: body,
//       );

//       // Check for successful response
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         developer.log('Profile updated successfully: ${response.body}');
//         Navigator.pushNamed(context, gender);
//       } else {
//         final Map<String, dynamic> responseBody = jsonDecode(response.body);
//         final errorMessage = responseBody['message'] ?? 'Unknown error';

//         //  Print and log the error
//         developer.log(
//             'Failed to create profile. Status code: ${response.statusCode}, Error: $errorMessage');

//         _showErrorDialog(context, "Error: $errorMessage");
//         throw Exception(
//             'Failed to create profile. Status code: ${response.statusCode}, Response: ${response.body}');

//         //  return;
//       }
//     } catch (e) {
//       developer.log('Error creating profile: $e');
//       _showErrorDialog(context, "An error occurred. Please try again.");
//     }
//   }
// }
