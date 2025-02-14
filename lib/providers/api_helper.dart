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
//       case 'DELETE':
//         return await http.delete(
//           Uri.parse(url),
//           headers: headers,
//         );
//       default:
//         throw Exception('HTTP method $method not supported.');
//     }
//   }

//   try {
//     final accessToken = await secureStorage.read(key: 'accessToken');
//     if (accessToken != null) {
//       headers['Authorization'] = 'Bearer $accessToken';
//     } else {
//       throw Exception('No access token available.');
//     }

//     http.Response response = await makeRequest();

//     if (response.statusCode == 403) {
//       developer.log('Access token expired, attempting to refresh token...');

//       await authProvider.refreshToken();

//       final refreshedAccessToken = await secureStorage.read(key: 'accessToken');
//       if (refreshedAccessToken == null) {
//         throw Exception('Failed to retrieve refreshed access token.');
//       }

//       headers['Authorization'] = 'Bearer $refreshedAccessToken';

//       response = await makeRequest();
//     }

//     return response;
//   } catch (e) {
//     developer.log('Error making API request: $e');
//     rethrow;
//   }
// }

import 'dart:convert';
import 'package:dio/dio.dart';
import 'auth_provider.dart';
import 'dart:developer' as developer;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<Response> makeApiRequest(
  String url,
  String method,
  Map<String, String> headers,
  AuthProvider authProvider, {
  Map<String, dynamic>? body,
}) async {
  const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  Dio dio = Dio();

  // Helper function to make request based on method
  Future<Response> makeRequest() async {
    try {
      switch (method.toUpperCase()) {
        case 'POST':
          return await dio.post(
            url,
            options: Options(headers: headers),
            data: body != null ? jsonEncode(body) : null,
          );
        case 'GET':
          return await dio.get(
            url,
            options: Options(headers: headers),
          );
        case 'DELETE':
          return await dio.delete(
            url,
            options: Options(headers: headers),
          );
        default:
          throw Exception('HTTP method $method not supported.');
      }
    } catch (e) {
      developer.log('Error making request: $e');
      rethrow;
    }
  }

  try {
    final accessToken = await secureStorage.read(key: 'accessToken');
    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    } else {
      throw Exception('No access token available.');
    }

    Response response = await makeRequest();

    // Handle 403 error (access token expired)
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
