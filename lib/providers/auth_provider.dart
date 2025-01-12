// // import 'package:flutter/material.dart';
// // import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// // import 'dart:convert';
// // import 'package:http/http.dart' as http;
// // import 'dart:developer' as developer;

// // class AuthProvider with ChangeNotifier {
// //   final _storage = const FlutterSecureStorage();
// //   String? _accessToken;
// //   String? _userId;

// //   String? get accessToken => _accessToken;
// //   String? get userId => _userId;

// //   Future<void> saveTokens(String accessToken, String userId) async {
// //     _accessToken = accessToken;
// //     _userId = userId;
// //     notifyListeners();
// //     await _storage.write(key: 'accessToken', value: accessToken);
// //     await _storage.write(key: 'userId', value: userId);
// //   }

// //   Future<void> loadTokens() async {
// //     _accessToken = await _storage.read(key: 'accessToken');
// //     _userId = await _storage.read(key: 'userId');
// //     notifyListeners();
// //   }

// //   bool isTokenExpired(String token) {
// //     try {
// //       final payload = json.decode(
// //           utf8.decode(base64.decode(base64.normalize(token.split(".")[1]))));
// //       final expiry = payload['exp'] * 1000; // Convert to milliseconds
// //       return DateTime.now().millisecondsSinceEpoch >= expiry;
// //     } catch (e) {
// //       return true; // Assume expired if parsing fails
// //     }
// //   }

// //   Future<void> refreshToken() async {
// //     if (_userId == null) {
// //       throw Exception('User ID not found. Please log in again.');
// //     }

// //     const String refreshUrl = 'http://localhost:7001/auth/refresh-token';
// //     try {
// //       final response = await http.get(
// //         Uri.parse(refreshUrl),
// //         headers: {'User-ID': _userId!},
// //       );

// //       if (response.statusCode == 200) {
// //         final Map<String, dynamic> responseBody = jsonDecode(response.body);
// //         _accessToken = responseBody['accessToken'];
// //         await _storage.write(key: 'accessToken', value: _accessToken!);
// //         notifyListeners();
// //         developer.log('Access token refreshed successfully');
// //       } else {
// //         throw Exception('Failed to refresh token. Please log in again.');
// //       }
// //     } catch (e) {
// //       developer.log('Error refreshing token: $e');
// //       rethrow;
// //     }
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'dart:developer' as developer;

// class AuthProvider with ChangeNotifier {
//   final _storage = const FlutterSecureStorage();
//   String? _accessToken;
//   String? _userId;

//   String? get accessToken => _accessToken;
//   String? get userId => _userId;

//   Future<void> saveTokens(String accessToken, String userId) async {
//     _accessToken = accessToken;
//     _userId = userId;
//     notifyListeners();
//     await _storage.write(key: 'accessToken', value: accessToken);
//     await _storage.write(key: 'userId', value: userId);
//   }

//   Future<void> loadTokens() async {
//     _accessToken = await _storage.read(key: 'accessToken');
//     _userId = await _storage.read(key: 'userId');
//     notifyListeners();
//   }

//   Future<void> refreshToken() async {
//     if (_userId == null) {
//       throw Exception('User ID not found. Please log in again.');
//     }

//     const String refreshUrl = 'http://localhost:7001/auth/refresh-token';

//     try {
//       final response = await http.get(
//         Uri.parse(refreshUrl),
//         headers: {'User-ID': _userId!},
//       );

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseBody = jsonDecode(response.body);
//         _accessToken = responseBody['accessToken'];

//         if (_accessToken == null) {
//           throw Exception('Access token missing in response.');
//         }

//         await _storage.write(key: 'accessToken', value: _accessToken!);
//         notifyListeners();
//         developer.log('Access token refreshed successfully');
//       } else {
//         throw Exception('Failed to refresh token. Response: ${response.body}');
//       }
//     } catch (e) {
//       developer.log('Error refreshing token: $e');
//       rethrow;
//     }
//   }

// //   // Clear tokens (e.g., during logout)
// //   Future<void> clearTokens() async {
// //     _accessToken = null;
// //     _userId = null;
// //     notifyListeners();
// //     await _storage.delete(key: 'accessToken');
// //     await _storage.delete(key: 'userId');
// //   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'dart:developer' as developer;

// class AuthProvider with ChangeNotifier {

//   Future<void> refreshToken() async {
//     const String refreshUrl = 'http://localhost:7001/auth/refresh-token';

//     try {
//       // Send request to refresh token endpoint
//       final response = await http.get(Uri.parse(refreshUrl));

//       if (response.statusCode == 200) {

//         notifyListeners();
//         developer.log('Access token refreshed successfully');
//       } else {
//         throw Exception('Failed to refresh token. Response: ${response.body}');
//       }
//     } catch (e) {
//       developer.log('Error refreshing token: $e');
//       rethrow;
//     }
//   }
// }
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider with ChangeNotifier {
  final _secureStorage =
      const FlutterSecureStorage(); // Initialize secure storage
  String? _accessToken;
  String? _refreshToken;

  String? get accessToken => _accessToken;

  Future<void> loadTokens() async {
    // Load tokens from secure storage
    _accessToken = await _secureStorage.read(key: 'accessToken');
    _refreshToken = await _secureStorage.read(key: 'refreshToken');
    notifyListeners();
  }

  Future<void> storeTokens(String accessToken, String refreshToken) async {
    // Store tokens securely
    await _secureStorage.write(key: 'accessToken', value: accessToken);
    await _secureStorage.write(key: 'refreshToken', value: refreshToken);

    _accessToken = accessToken;
    _refreshToken = refreshToken;
    notifyListeners();
  }

  Future<void> refreshToken() async {
    const String refreshUrl = 'http://localhost:7001/auth/refresh-token';

    if (_refreshToken == null) {
      developer.log('No refresh token available. User needs to log in again.');
      return;
    }

    try {
      // Send request to refresh token endpoint with the refresh token in the cookie
      final response = await http.get(
        Uri.parse(refreshUrl),
        headers: {
          'Cookie': 'local.bg-refresh-mgmt=$_refreshToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Parse the response
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        // Extract the new tokens
        final newAccessToken = responseBody['accessToken'];
        final newRefreshToken = _extractRefreshToken(response.headers);

        if (newAccessToken != null && newRefreshToken != null) {
          // Store the new tokens securely
          await storeTokens(newAccessToken, newRefreshToken);

          developer.log('Access token refreshed successfully');
        } else {
          throw Exception('Failed to extract tokens from refresh response');
        }
      } else {
        throw Exception('Failed to refresh token. Response: ${response.body}');
      }
    } catch (e) {
      developer.log('Error refreshing token: $e');
      rethrow;
    }
  }

  Future<void> logout() async {
    // Clear stored tokens
    await _secureStorage.delete(key: 'accessToken');
    await _secureStorage.delete(key: 'refreshToken');

    _accessToken = null;
    _refreshToken = null;
    notifyListeners();
    developer.log('User logged out');
  }

  String? _extractRefreshToken(Map<String, String> headers) {
    // Extract the refresh token from the 'set-cookie' header
    final cookies = headers['set-cookie'];
    if (cookies != null) {
      // Updated regex to match your refresh token name (local.bg-refresh-mgmt)
      final refreshToken =
          RegExp(r'local.bg-refresh-mgmt=([^;]+)').firstMatch(cookies);
      return refreshToken?.group(1);
    }
    return null;
  }
}
