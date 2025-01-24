import 'package:flutter/material.dart';
import 'package:love_bird/api/likes_api_service.dart';
import 'package:love_bird/model/profile_model.dart'; // Replace with your actual model

class LikesProvider with ChangeNotifier {
  List<Profile> likedProfiles = [];
  bool isLoading = false;
  String errorMessage = '';

  Future<void> fetchLikedProfiles(String userId, String authToken) async {
    try {
      isLoading = true;
      errorMessage = '';
      notifyListeners();

      // Call the API to fetch liked profiles
      likedProfiles = await LikeApi.fetchLikedProfiles(userId, authToken);

      isLoading = false;
      notifyListeners();
    } catch (error) {
      isLoading = false;
      errorMessage = 'Failed to fetch liked profiles: $error';
      notifyListeners();
    }
  }
}
