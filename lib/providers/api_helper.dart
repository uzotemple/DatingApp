import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_provider.dart';
import 'dart:developer' as developer;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<http.Response> makeApiRequest(
  String url,
  String method,
  Map<String, String> headers,
  AuthProvider authProvider, {
  Map<String, dynamic>? body,
}) async {
  const FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future<http.Response> makeRequest() async {
    switch (method.toUpperCase()) {
      case 'POST':
        return await http.post(
          Uri.parse(url),
          headers: headers,
          body: body != null ? jsonEncode(body) : null,
        );
      case 'GET':
        return await http.get(
          Uri.parse(url),
          headers: headers,
        );
      default:
        throw Exception('HTTP method $method not supported.');
    }
  }

  try {
    final accessToken = await secureStorage.read(key: 'accessToken');
    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    } else {
      throw Exception('No access token available.');
    }

    http.Response response = await makeRequest();

    if (response.statusCode == 403) {
      developer.log('Access token expired, attempting to refresh token...');

      await authProvider.refreshToken();

      final refreshedAccessToken = await secureStorage.read(key: 'accessToken');
      if (refreshedAccessToken == null) {
        throw Exception('Failed to retrieve refreshed access token.');
      }

      headers['Authorization'] = 'Bearer $refreshedAccessToken';

      response = await makeRequest();
    }

    return response;
  } catch (e) {
    developer.log('Error making API request: $e');
    rethrow;
  }
}


//same code with explanation
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'auth_provider.dart';
// import 'dart:developer' as developer;
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Future<http.Response> makeApiRequest(
//   String url,
//   String method,
//   Map<String, String> headers,
//   AuthProvider authProvider, {
//   Map<String, dynamic>? body,
// }) async {
//   const FlutterSecureStorage secureStorage = FlutterSecureStorage();

//   Future<http.Response> makeRequest() async {
//     switch (method.toUpperCase()) {
//       case 'POST':
//         return await http.post(
//           Uri.parse(url),
//           headers: headers,
//           body: body != null ? jsonEncode(body) : null,
//         );
//       case 'GET':
//         return await http.get(
//           Uri.parse(url),
//           headers: headers,
//         );
//       default:
//         throw Exception('HTTP method $method not supported.');
//     }
//   }

//   try {
//     // Load access token from storage or the AuthProvider
//     final accessToken = await secureStorage.read(key: 'accessToken');
//     if (accessToken != null) {
//       // Add the Authorization header with the access token
//       headers['Authorization'] = 'Bearer $accessToken';
//     } else {
//       throw Exception('No access token available.');
//     }

//     // Attempt the API request
//     http.Response response = await makeRequest();

//     // Check if token expired (403) and attempt refresh
//     if (response.statusCode == 403) {
//       developer.log('Access token expired, attempting to refresh token...');

//       // Refresh the token
//       await authProvider.refreshToken();

//       // Reload tokens from secure storage
//       final refreshedAccessToken = await secureStorage.read(key: 'accessToken');
//       if (refreshedAccessToken == null) {
//         throw Exception('Failed to retrieve refreshed access token.');
//       }

//       // Update the Authorization header with the refreshed token
//       headers['Authorization'] = 'Bearer $refreshedAccessToken';

//       // Retry the original API request with updated headers
//       response = await makeRequest();
//     }

//     return response;
//   } catch (e) {
//     developer.log('Error making API request: $e');
//     rethrow;
//   }
// }
