import 'package:flutter/material.dart';
import 'package:love_bird/config/routes.dart';
import 'package:love_bird/providers/api_helper.dart';
import 'package:love_bird/providers/auth_provider.dart';
import 'dart:developer' as developer;
import 'dart:convert';
// class CelebrateYouProvider with ChangeNotifier {
//   String _month = '';
//   String _day = '';
//   String _year = '';
//   String _dob = '';
//   DateTime now = DateTime.now().toUtc();
//   String get month => _month;
//   String get day => _day;
//   String get year => _year;
//   String get dob => _dob;
//   void setMonth(String value) {
//     _month = value;
//     notifyListeners();
//   }

//   void setDay(String value) {
//     _day = value;
//     notifyListeners();
//   }

//   void setYear(String value) {
//     _year = value;
//     notifyListeners();
//   }

//   String get dobBirth {
//     if (_year.isNotEmpty && _month.isNotEmpty && _day.isNotEmpty) {
//       _dob =
//           '${_year}-${_month}-${_day}T${now.hour}:${now.minute}:${now.second}.000Z';
//     }
//     return _dob;
//   }
// }

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

  String get dobBirth {
    if (_year.isNotEmpty && _month.isNotEmpty && _day.isNotEmpty) {
      _dob =
          '$_year-$_month-${_day}T${now.hour}:${now.minute}:${now.second}.000Z';
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
    try {
      // Define API request details
      const url = 'http://138.68.150.48:7001/profile/profile-detailed';
      const method =
          'POST'; // Consider using a constant or enum for HTTP methods
      final headers = {'Content-Type': 'application/json'};

      // API request body
      final body = {"dob": dob, "age": age};

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
        developer.log('Profile updated successfully: ${response.body}');
        Navigator.pushNamed(context, gender);
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
}
