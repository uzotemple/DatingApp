// import 'package:flutter/material.dart';
// import 'dart:developer' as developer;
// import 'package:love_bird/providers/api_helper.dart';
// import 'package:love_bird/providers/auth_provider.dart';

// class ProfileProvider extends ChangeNotifier {
//   // Define a variable to store the profile response data
//   Map<String, dynamic>? profileData;

//   Future<void> retieveProfile(
//       BuildContext context, AuthProvider authProvider) async {
//     try {
//       // Define API request details
//       const url =
//           'http://138.68.150.48:7001/profile'; // Include transactionId in URL
//       const method = 'GET';

//       // Add headers if necessary
//       final headers = {
//         'Content-Type': 'application/json',
//       };

//       // Send the request using makeApiRequest
//       final response = await makeApiRequest(
//         url,
//         method,
//         headers,
//         authProvider,
//       );

//       // Check for successful response
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         // Parse the response body
//         profileData = (response.data);
//         // Notify listeners so that UI can be updated
//         notifyListeners();
//       } else {
//         final Map<String, dynamic> responseBody = (response.data);
//         final errorMessage = responseBody['message'] ?? 'Unknown error';

//         // Print and log the error
//         developer.log(
//           'Failed to retrieve Profile. Status code: ${response.statusCode}, Error: $errorMessage',
//         );

//         _showErrorDialog(context, "Error: $errorMessage");
//         throw Exception(
//           'Failed to retrieve Profile. Status code: ${response.statusCode}, Response: ${response.data}',
//         );
//       }
//     } catch (e) {
//       developer.log('Error retrieving profile: $e');
//       _showErrorDialog(context, "An error occurred. Please try again.");
//     }
//   }

//   // Getter to access the profile data
//   Map<String, dynamic>? get getProfileData => profileData;

//   // Method to display error dialog
//   void _showErrorDialog(BuildContext context, String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Error', style: TextStyle(color: Colors.black)),
//           content: Text(message, style: const TextStyle(color: Colors.black)),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'dart:developer' as developer;
// import 'package:love_bird/providers/api_helper.dart';
// import 'package:love_bird/providers/auth_provider.dart';

// class ProfileProvider extends ChangeNotifier {
//   Map<String, dynamic>? profileData;

//   Future<void> retieveProfile(BuildContext context, AuthProvider authProvider) async {
//     try {
//       const url = 'http://138.68.150.48:7001/profile';
//       const method = 'GET';

//       final headers = {
//         'Content-Type': 'application/json',
//       };

//       final response = await makeApiRequest(url, method, headers, authProvider);

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         profileData = (response.data);
//         notifyListeners();
//       } else {
//         final Map<String, dynamic> responseBody = (response.data);
//         final errorMessage = responseBody['message'] ?? 'Unknown error';
//         developer.log('Failed to retrieve Profile: $errorMessage');
//         _showErrorDialog(context, "Error: $errorMessage");
//       }
//     } catch (e) {
//       developer.log('Error retrieving profile: $e');
//       _showErrorDialog(context, "An error occurred. Please try again.");
//     }
//   }

//   Future<bool> updateProfile(BuildContext context, AuthProvider authProvider, Map<String, dynamic> updatedData) async {
//     try {
//       const url = 'http://138.68.150.48:7001/profile/initial-addition'; 
//       const method = 'PUT';

//       final headers = {
//         'Content-Type': 'application/json',
//       };

//       final response = await makeApiRequest(url, method, headers, authProvider, body: updatedData);

//       if (response.statusCode == 200) {
//         profileData = updatedData;
//         notifyListeners();
//         return true;
//       } else {
//         final errorMessage = response.data['message'] ?? 'Failed to update profile';
//         developer.log('Profile update failed: $errorMessage');
//         _showErrorDialog(context, "Error: $errorMessage");
//       }
//     } catch (e) {
//       developer.log('Error updating profile: $e');
//       _showErrorDialog(context, "An error occurred. Please try again.");
//     }
//     return false;
//   }

//   Map<String, dynamic>? get getProfileData => profileData;

//   void _showErrorDialog(BuildContext context, String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Error', style: TextStyle(color: Colors.black)),
//           content: Text(message, style: const TextStyle(color: Colors.black)),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }


import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:love_bird/providers/api_helper.dart';
import 'package:love_bird/providers/auth_provider.dart';

class ProfileProvider extends ChangeNotifier {
  Map<String, dynamic>? profileData;
  String? educationLevel;


  Future<void> retieveProfile(BuildContext context, AuthProvider authProvider) async {
    try {
      const url = 'http://138.68.150.48:7001/profile';
      const method = 'GET';

      final headers = {
        'Content-Type': 'application/json',
      };

      final response = await makeApiRequest(url, method, headers, authProvider);

      if (response.statusCode == 200 || response.statusCode == 201) {
        profileData = response.data;
        
        // Extract and store education level separately
        educationLevel = profileData?['educationLevel'];

        notifyListeners();
      } else {
        final errorMessage = response.data['message'] ?? 'Unknown error';
        developer.log('Failed to retrieve Profile: $errorMessage');
        _showErrorDialog(context, "Error: $errorMessage");
      }
    } catch (e) {
      developer.log('Error retrieving profile: $e');
      _showErrorDialog(context, "An error occurred. Please try again.");
    }
  }

  String? get getEducationLevel => educationLevel;

  // Future<void> retieveProfile(BuildContext context, AuthProvider authProvider) async {
  //   try {
  //     const url = 'http://138.68.150.48:7001/profile';
  //     const method = 'GET';

  //     final headers = {
  //       'Content-Type': 'application/json',
  //     };

  //     final response = await makeApiRequest(url, method, headers, authProvider);

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       profileData = response.data;
  //       notifyListeners();
  //     } else {
  //       final errorMessage = response.data['message'] ?? 'Unknown error';
  //       developer.log('Failed to retrieve Profile: $errorMessage');
  //       _showErrorDialog(context, "Error: $errorMessage");
  //     }
  //   } catch (e) {
  //     developer.log('Error retrieving profile: $e');
  //     _showErrorDialog(context, "An error occurred. Please try again.");
  //   }
  // }

  Future<bool> updateProfile(BuildContext context, AuthProvider authProvider, Map<String, dynamic> updatedData) async {
  try {
    const url = 'http://138.68.150.48:7001/profile/initial-addition';
    const method = 'POST';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authProvider.accessToken}', // Ensure token is included
    };

    // Ensure profile ID is included
    if (profileData != null && profileData!.containsKey('profileId')) {
      updatedData['profileId'] = profileData!['profileId'];
    } else {
      developer.log('Profile ID is missing. Fetching profile first.');
      _showErrorDialog(context, "Profile ID is missing. Please refresh and try again.");
      return false;
    }

    developer.log('Sending profile update: ${jsonEncode(updatedData)}');

    final response = await makeApiRequest(url, method, headers, authProvider, body: updatedData);

    if (response.statusCode == 200) {
      developer.log('Profile updated successfully');

      // Fetch updated profile data
      await retieveProfile(context, authProvider);  

      return true;
    } else {
      final errorMessage = response.data?['message'] ?? response.statusMessage ?? 'Failed to update profile';
      developer.log('Profile update failed: $errorMessage');
      _showErrorDialog(context, "Error: $errorMessage");
    }
  } catch (e) {
    developer.log('Error updating profile: $e');
    _showErrorDialog(context, "An error occurred. Please try again.");
  }
  return false;
}


  Future<bool> uploadProfilePicture(BuildContext context, AuthProvider authProvider, File imageFile) async {
    try {
      const url = 'http://138.68.150.48:7001/profile/add-image'; // Adjust this URL to match your backend

      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers['Authorization'] = 'Bearer ${authProvider.accessToken}' // Ensure auth token is included
        ..files.add(await http.MultipartFile.fromPath('profilePicture', imageFile.path, filename: basename(imageFile.path)));

      var response = await request.send();

      if (response.statusCode == 200) {
        developer.log('Profile picture uploaded successfully');
        return true;
      } else {
        developer.log('Failed to upload profile picture');
        _showErrorDialog(context, "Failed to upload profile picture");
      }
    } catch (e) {
      developer.log('Error uploading profile picture: $e');
      _showErrorDialog(context, "An error occurred. Please try again.");
    }
    return false;
  }

  Map<String, dynamic>? get getProfileData => profileData;

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
