// import 'package:flutter/material.dart';
// import 'package:love_bird/model/likes_model.dart';
// import 'package:love_bird/model/likes_services.dart';
// import 'package:love_bird/providers/auth_provider.dart';

// class LikeProvider with ChangeNotifier {
//   List<Like> _likes = [];
//   bool _isLoading = false;
//   final AuthProvider authProvider; // Inject AuthProvider

//   LikeProvider(this.authProvider);

//   List<Like> get likes => _likes;
//   bool get isLoading => _isLoading;

//   Future<void> fetchLikes() async {
//     final authToken = authProvider.accessToken;

//     if (authToken == null || authToken.isEmpty) {
//       throw Exception('Auth token is missing');
//     }

//     _isLoading = true;
//     notifyListeners();

//     try {
//       final fetchedLikes = await LikeService.fetchLikes(authToken);
//       _likes = fetchedLikes;
//     } catch (error) {
//       throw Exception('Failed to load likes: $error');
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:love_bird/model/likes_model.dart';
import 'package:love_bird/model/likes_services.dart';
import 'package:love_bird/providers/auth_provider.dart';

class LikeProvider with ChangeNotifier {
  List<Like> _likes = [];
  bool _isLoading = false;
  final AuthProvider authProvider; // Inject AuthProvider

  LikeProvider(this.authProvider);

  List<Like> get likes => _likes;
  bool get isLoading => _isLoading;

  Future<void> fetchLikes() async {
    final authToken = authProvider.accessToken;

    if (authToken == null || authToken.isEmpty) {
      debugPrint("🚨 Auth token is missing!");
      return;
    }

    debugPrint("🔑 Auth Token: $authToken"); // Log token for debugging

    _isLoading = true;
    notifyListeners();

    try {
      final fetchedLikes = await LikeService.fetchLikes(authToken);
      _likes = fetchedLikes;
      debugPrint("✅ Likes fetched successfully: ${_likes.length}");
    } on DioException catch (dioError) {
      debugPrint("❌ DioException: ${dioError.message}");
      if (dioError.response != null) {
        debugPrint("🚨 Response Data: ${dioError.response?.data}");
        debugPrint("🔴 Status Code: ${dioError.response?.statusCode}");
        debugPrint("📌 Headers: ${dioError.response?.headers}");
      }
    } catch (error) {
      debugPrint("❌ Failed to load likes: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
