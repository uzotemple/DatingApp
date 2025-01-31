import 'package:flutter/material.dart';
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
      throw Exception('Auth token is missing');
    }

    _isLoading = true;
    notifyListeners();

    try {
      final fetchedLikes = await LikeService.fetchLikes(authToken);
      _likes = fetchedLikes;
    } catch (error) {
      throw Exception('Failed to load likes: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}


// import 'package:flutter/material.dart';
// import 'package:love_bird/model/likes_model.dart';
// import 'package:love_bird/model/likes_services.dart';
// import 'package:love_bird/providers/auth_provider.dart';
// import 'package:provider/provider.dart'; // Import provider

// class LikeProvider with ChangeNotifier {
//   List<Like> _likes = [];
//   bool _isLoading = false;

//   List<Like> get likes => _likes;
//   bool get isLoading => _isLoading;

  
//   Future<void> fetchLikes(BuildContext context) async {
//     // Access the AuthProvider instance to get the auth token
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     final authToken = authProvider.accessToken;

//     // Check if the token exists
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
