import 'package:flutter/material.dart';
import 'package:love_bird/api/profile_api.dart';

import 'package:love_bird/config/routes.dart';
import 'package:provider/provider.dart';

import 'api_helper.dart';
import 'auth_provider.dart';
import 'dart:developer' as developer;
import 'dart:convert';

class InterestsProvider extends ChangeNotifier {
  final List<String> _interests = [
    'Travel',
    'Cooking',
    'Hiking',
    'Yoga',
    'Gaming',
    'Movies',
    'Photography',
    'Music',
    'Pets',
    'Painting',
    'Art',
    'Fitness',
    'Reading',
    'Dancing',
    'Sport',
    'Board games',
    'Technology',
    'Fashion',
    'Motorcycling',
    'Others'
  ];

  final List<String> _selectedInterests = [];
  List<String> _filteredInterests = [];
  String _searchQuery = '';

  final Map<String, String> _interestIcons = {
    'Travel': 'assets/images/icons/interest/travel.png',
    'Cooking': 'assets/images/icons/interest/cooking.png',
    'Hiking': 'assets/images/icons/interest/hiking.png',
    'Yoga': 'assets/images/icons/interest/yoga.png',
    'Gaming': 'assets/images/icons/interest/gaming.png',
    'Movies': 'assets/images/icons/interest/movies.png',
    'Photography': 'assets/images/icons/interest/photography.png',
    'Music': 'assets/images/icons/interest/music.png',
    'Pets': 'assets/images/icons/interest/pets.png',
    'Painting': 'assets/images/icons/interest/painting.png',
    'Art': 'assets/images/icons/interest/art.png',
    'Fitness': 'assets/images/icons/interest/fitness.png',
    'Reading': 'assets/images/icons/interest/reading.png',
    'Dancing': 'assets/images/icons/interest/dancing.png',
    'Sport': 'assets/images/icons/interest/sports.png',
    'Board games': 'assets/images/icons/interest/board_games.png',
    'Technology': 'assets/images/icons/interest/technology.png',
    'Fashion': 'assets/images/icons/interest/fashion.png',
    'Motorcycling': 'assets/images/icons/interest/motorcycling.png',
    'Others': 'assets/images/icons/interest/motorcycling.png',
  };

  List<String> get interests => _interests;
  List<String> get selectedInterests => _selectedInterests;
  List<String> get filteredInterests => _filteredInterests;
  String get searchQuery => _searchQuery;

  Map<String, String> get interestIcons => _interestIcons;
  String? get firstSelectedInterest {
    return _selectedInterests.isNotEmpty ? _selectedInterests.first : null;
  }

  InterestsProvider() {
    _filteredInterests = List.from(_interests);
  }

  void toggleInterest(String interest) {
    if (_selectedInterests.contains(interest)) {
      _selectedInterests.remove(interest);
    } else if (_selectedInterests.length < 6) {
      _selectedInterests.add(interest);
    }
    notifyListeners();
  }

  void onSearchQueryChanged(String query) {
    _searchQuery = query;
    _filteredInterests = _interests
        .where(
            (interest) => interest.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  Future<void> updateInterest(
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
      String location = profileData?["location"] ?? "Unknown";
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
        "interest": firstSelectedInterest,
        "isPicsVerified": true,
        "location": location,
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
        Navigator.pushNamed(context, uploadPicturesScreen);
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
