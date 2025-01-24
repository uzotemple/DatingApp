import 'package:flutter/material.dart';
import 'package:love_bird/api/profile_api.dart';
import 'package:love_bird/config/routes.dart';
import 'package:love_bird/providers/api_helper.dart';
import 'package:love_bird/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;
import 'dart:convert';

class NicknameProvider with ChangeNotifier {
  String _nickname = '';

  String get nickname => _nickname;

  void setNickname(String newNickname) {
    _nickname = newNickname;
    notifyListeners();
    developer.log('Your nickname is: $nickname');
  }

  Future<void> updateName(
      BuildContext context, AuthProvider authProvider, String name) async {
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    try {
      // Retrieve the profile first
      await _retrieveProfile(context, authProvider, profileProvider);

      if (profileProvider.getProfileData == null) {
        _showErrorDialog(context, "Failed to retrieve profile data.");
        return;
      }

      // Prepare profile data for the request
      final profileData = profileProvider.getProfileData;
      final body = _buildProfileData(profileData, name);

      // API request
      final response = await _makeApiRequest(authProvider, body);

      // Handle response
      _handleResponse(context, response);
    } catch (e) {
      developer.log('Error creating profile: $e');
      _showErrorDialog(context, "An error occurred. Please try again.");
    }
  }

  Future<void> _retrieveProfile(BuildContext context, AuthProvider authProvider, ProfileProvider profileProvider) async {
    await profileProvider.retieveProfile(context, authProvider);
  }

  Map<String, dynamic> _buildProfileData(Map<String, dynamic>? profileData, String nickname) {
    if (profileData == null) return {};

    return {
      "nickname": nickname,
      "dob": "2025-01-20T10:00:48.484Z",
      "age": 0,
      "gender": "MALE",
      "relationshipGoals": "DATING",
      "latitude": 0,
      "longitude": 0,
      "profession": profileData["profession"] ?? "Unknown",
      "weight": profileData["weight"]?.toDouble() ?? 0.0,
      "height": profileData["height"]?.toDouble() ?? 0.0,
      "country": profileData["country"] ?? "Unknown",
      "city": profileData["city"] ?? "Unknown",
      "bio": profileData["bio"] ?? "Unknown",
      "educationLevel": profileData["educationLevel"] ?? "Unknown",
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
  }

  Future<dynamic> _makeApiRequest(AuthProvider authProvider, Map<String, dynamic> body) async {
    const url = 'http://138.68.150.48:7001/profile/profile-detailed';
    const method = 'POST';
    final headers = {'Content-Type': 'application/json'};

    return await makeApiRequest(
      url,
      method,
      headers,
      authProvider,
      body: body,
    );
  }

  void _handleResponse(BuildContext context, dynamic response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      developer.log('Profile updated successfully: ${response.body}');
      Navigator.pushNamed(context, celebrateYouScreen);
    } else {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final errorMessage = responseBody['message'] ?? 'Unknown error';
      developer.log(
          'Failed to create profile. Status code: ${response.statusCode}, Error: $errorMessage');
      _showErrorDialog(context, "Error: $errorMessage");
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
