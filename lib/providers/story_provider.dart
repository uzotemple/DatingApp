import 'dart:io';

import 'package:flutter/material.dart';
import 'package:love_bird/services/story_service.dart';

class StoryProvider extends ChangeNotifier {
  final StoryService _storyService = StoryService();
  List<dynamic> _stories = [];
  bool _isLoading = false;

  List<dynamic> get stories => _stories;
  bool get isLoading => _isLoading;

  Future<void> loadStories(String token) async {
    _isLoading = true;
    notifyListeners();
    try {
      _stories = await _storyService.fetchStories(token);
    } catch (e) {
      _stories = [];
    }
    _isLoading = false;
    notifyListeners();
  }

  // Future<void> addStory(String token, File image, {String? message}) async {
  //   bool success = await _storyService.addStory(token, image, message: message);
  //   if (success) await loadStories(token);
  //   notifyListeners();
  // }

  Future<void> addStory(String token, File image, {String? message}) async {
  _isLoading = true;
  notifyListeners();

  try {
    bool success = await _storyService.addStory(token, image, message: message);
    if (success) {
      await loadStories(token); 
    }
  } catch (error) {
    print("❌ Error adding story: $error");
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}


  Future<void> deleteStory(String token, String statusId) async {
    bool success = await _storyService.deleteStory(token, statusId);
    if (success) await loadStories(token);
    notifyListeners();
  }
}
