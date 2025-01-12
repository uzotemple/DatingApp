import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_provider.dart';
import 'dart:developer' as developer;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// Future<http.Response> makeApiRequest(
//   String url,
//   String method,
//   Map<String, String> headers,
//   AuthProvider authProvider, {
//   Map<String, dynamic>? body,
// }) async {
//   String? accessToken = authProvider.accessToken;

//   headers['Authorization'] = 'Bearer $accessToken';

//   http.Response response;
//   try {
//     switch (method.toUpperCase()) {
//       case 'POST':
//         response = await http.post(
//           Uri.parse(url),
//           headers: headers,
//           body: body != null ? jsonEncode(body) : null,
//         );
//         break;
//       case 'GET':
//         response = await http.get(Uri.parse(url), headers: headers);
//         break;
//       default:
//         throw Exception('HTTP method $method not supported.');
//     }

//     if (response.statusCode == 403) {
//       try {
//         await authProvider.refreshToken();
//         accessToken = authProvider.accessToken;

//         if (accessToken == null) {
//           throw Exception('Unable to refresh token. Please log in again.');
//         }

//         headers['Authorization'] = 'Bearer $accessToken';

//         switch (method.toUpperCase()) {
//           case 'POST':
//             response = await http.post(
//               Uri.parse(url),
//               headers: headers,
//               body: body != null ? jsonEncode(body) : null,
//             );
//             break;
//           case 'GET':
//             response = await http.get(Uri.parse(url), headers: headers);
//             break;
//           default:
//             throw Exception('HTTP method $method not supported.');
//         }
//       } catch (e) {
//         throw Exception('Failed to refresh token and retry request: $e');
//       }
//     }

//     return response;
//   } catch (e) {
//     rethrow;
//   }
// }
// Future<http.Response> makeApiRequest(
//   String url,
//   String method,
//   Map<String, String> headers,
//   AuthProvider authProvider, {
//   Map<String, dynamic>? body,
// }) async {
//   final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

//   Future<http.Response> _makeRequest() async {
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
//     // Attempt the API request
//     http.Response response = await _makeRequest();

//     // Check if token expired (403) and attempt refresh
//     if (response.statusCode == 403) {
//       developer.log('Access token expired, attempting to refresh token...');

//       // Refresh the token
//       await authProvider.refreshToken();

//       // Reload tokens from secure storage
//       final accessToken = await secureStorage.read(key: 'accessToken');
//       if (accessToken == null) {
//         throw Exception('Failed to retrieve refreshed access token.');
//       }

//       // Update headers with the new access token
//       headers['Authorization'] = 'Bearer $accessToken';

//       // Retry the original API request with updated headers
//       response = await _makeRequest();
//     }

//     return response;
//   } catch (e) {
//     developer.log('Error making API request: $e');
//     rethrow;
//   }
// }
// Future<http.Response> makeApiRequest(
//   String url,
//   String method,
//   Map<String, String> headers,
//   AuthProvider authProvider, {
//   Map<String, dynamic>? body,
// }) async {
//   final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

//   Future<http.Response> _makeRequest() async {
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
//     // Attempt the API request
//     http.Response response = await _makeRequest();

//     // Check if token expired (403) and attempt refresh
//     if (response.statusCode == 403) {
//       developer.log('Access token expired, attempting to refresh token...');

//       // Refresh the token
//       await authProvider.refreshToken();

//       // Reload tokens from secure storage (or you could call authProvider.loadTokens() if needed)
//       final accessToken = await secureStorage.read(key: 'accessToken');
//       if (accessToken == null) {
//         throw Exception('Failed to retrieve refreshed access token.');
//       }

//       // Check if Authorization header already exists
//       if (headers['Authorization'] == null) {
//         headers['Authorization'] = 'Bearer $accessToken';
//       }

//       // Retry the original API request with updated headers
//       response = await _makeRequest();
//     }

//     return response;
//   } catch (e) {
//     developer.log('Error making API request: $e');
//     rethrow;
//   }
// }
Future<http.Response> makeApiRequest(
  String url,
  String method,
  Map<String, String> headers,
  AuthProvider authProvider, {
  Map<String, dynamic>? body,
}) async {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<http.Response> _makeRequest() async {
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
    // Load access token from storage or the AuthProvider
    final accessToken = await secureStorage.read(key: 'accessToken');
    if (accessToken != null) {
      // Add the Authorization header with the access token
      headers['Authorization'] = 'Bearer $accessToken';
    } else {
      throw Exception('No access token available.');
    }

    // Attempt the API request
    http.Response response = await _makeRequest();

    // Check if token expired (403) and attempt refresh
    if (response.statusCode == 403) {
      developer.log('Access token expired, attempting to refresh token...');

      // Refresh the token
      await authProvider.refreshToken();

      // Reload tokens from secure storage
      final refreshedAccessToken = await secureStorage.read(key: 'accessToken');
      if (refreshedAccessToken == null) {
        throw Exception('Failed to retrieve refreshed access token.');
      }

      // Update the Authorization header with the refreshed token
      headers['Authorization'] = 'Bearer $refreshedAccessToken';

      // Retry the original API request with updated headers
      response = await _makeRequest();
    }

    return response;
  } catch (e) {
    developer.log('Error making API request: $e');
    rethrow;
  }
}
