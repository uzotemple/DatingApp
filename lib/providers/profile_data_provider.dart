// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class ProfileDataProvider with ChangeNotifier {
//   final _secureStorage = const FlutterSecureStorage(); // Secure storage for profileId
//   String? _profileId; // Profile ID of the user
//   Map<String, dynamic>? _profileData; // Store additional profile data if needed

//   String? get profileId => _profileId; // Getter for profileId
//   Map<String, dynamic>? get profileData => _profileData; // Getter for profile data

//   // Fetch profile data from the server
//   Future<void> fetchProfile(String authToken) async {
//     final url = Uri.parse('http://138.68.150.48:7001/profile'); // Endpoint to fetch profile
//     final headers = {
//       'Authorization': 'Bearer $authToken',
//       'Content-Type': 'application/json',
//     };

//     print('Fetching profile data from $url with headers: $headers');

//     try {
//       final response = await http.get(url, headers: headers);
//       print('Response status: ${response.statusCode}');
//       print('Response body: ${response.body}');

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         print('Profile data received: $data');
        
//         _profileId = data['profileId']; // Assuming the profile ID is returned as 'profileId'
//         _profileData = data; // Store full profile data if needed
//         print('Profile ID set to: $_profileId');

//         await _secureStorage.write(key: 'profileId', value: _profileId); // Save profileId
//         print('Profile ID saved to secure storage.');

//         notifyListeners();
//       } else {
//         print('Failed to fetch profile data: ${response.body}');
//         throw Exception('Failed to fetch profile data: ${response.body}');
//       }
//     } catch (error) {
//       print('Error fetching profile: $error');
//       throw Exception('Error fetching profile: $error');
//     }
//   }

//   // Load profileId from secure storage
//   Future<void> loadProfileId() async {
//     try {
//       _profileId = await _secureStorage.read(key: 'profileId');
//       print('Loaded profile ID from secure storage: $_profileId');
//       notifyListeners();
//     } catch (error) {
//       print('Error loading profile ID from secure storage: $error');
//       throw Exception('Error loading profile ID: $error');
//     }
//   }

//   // Clear profile data on logout
//   Future<void> clearProfileData() async {
//     try {
//       await _secureStorage.delete(key: 'profileId');
//       print('Profile ID removed from secure storage.');
//       _profileId = null;
//       _profileData = null;
//       notifyListeners();
//     } catch (error) {
//       print('Error clearing profile data: $error');
//       throw Exception('Error clearing profile data: $error');
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfileDataProvider with ChangeNotifier {
  final _secureStorage = const FlutterSecureStorage(); // Secure storage for profileId
  String? _profileId; // Profile ID of the user
  Map<String, dynamic>? _profileData; // Store additional profile data if needed

  String? get profileId => _profileId; // Getter for profileId
  Map<String, dynamic>? get profileData => _profileData; // Getter for profile data

  final Dio dio = Dio(); // Instantiate Dio

  // Fetch profile data from the server
  Future<void> fetchProfile(String authToken) async {
    const url = 'http://138.68.150.48:7001/profile'; // Endpoint to fetch profile
    final headers = {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json',
    };

    print('Fetching profile data from $url with headers: $headers');

    try {
      // Sending GET request using Dio
      final response = await dio.get(
        url,
        options: Options(
          headers: headers,
        ),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data; // Access response body

        print('Profile data received: $data');
        
        _profileId = data['profileId']; // Assuming the profile ID is returned as 'profileId'
        _profileData = data; // Store full profile data if needed
        print('Profile ID set to: $_profileId');

        await _secureStorage.write(key: 'profileId', value: _profileId); // Save profileId
        print('Profile ID saved to secure storage.');

        notifyListeners();
      } else {
        print('Failed to fetch profile data: ${response.data}');
        throw Exception('Failed to fetch profile data: ${response.data}');
      }
    } catch (error) {
      print('Error fetching profile: $error');
      throw Exception('Error fetching profile: $error');
    }
  }

  // Load profileId from secure storage
  Future<void> loadProfileId() async {
    try {
      _profileId = await _secureStorage.read(key: 'profileId');
      print('Loaded profile ID from secure storage: $_profileId');
      notifyListeners();
    } catch (error) {
      print('Error loading profile ID from secure storage: $error');
      throw Exception('Error loading profile ID: $error');
    }
  }

  // Clear profile data on logout
  Future<void> clearProfileData() async {
    try {
      await _secureStorage.delete(key: 'profileId');
      print('Profile ID removed from secure storage.');
      _profileId = null;
      _profileData = null;
      notifyListeners();
    } catch (error) {
      print('Error clearing profile data: $error');
      throw Exception('Error clearing profile data: $error');
    }
  }
}
