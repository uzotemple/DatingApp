import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:developer' as developer;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:love_bird/config/routes.dart';
import 'package:love_bird/providers/auth_provider.dart';

class ApiService {
  static const String uploadUrl = "http://localhost:7001/profile/add-image";

  Future<void> uploadImages(BuildContext context, List<File?> images,
      AuthProvider authProvider) async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();

    try {
      final accessToken = await secureStorage.read(key: 'accessToken');

      if (accessToken == null) {
        developer.log('No access token available. Please log in.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('No access token available. Please log in.')),
        );
        return;
      }

      var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));
      request.headers['Authorization'] = 'Bearer $accessToken';

      for (int i = 0; i < images.length; i++) {
        if (images[i] != null) {
          request.files.add(
            await http.MultipartFile.fromPath('images', images[i]!.path),
          );
        }
      }

      var response = await request.send();

      if (response.statusCode == 403) {
        developer.log('Access token expired, attempting to refresh token...');

        await authProvider.refreshToken();
        final refreshedAccessToken =
            await secureStorage.read(key: 'accessToken');

        if (refreshedAccessToken == null) {
          developer.log('Failed to retrieve refreshed access token.');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                    'Failed to retrieve refreshed access token. Please log in again.')),
          );
          return;
        }

        var retryRequest = http.MultipartRequest('POST', Uri.parse(uploadUrl));
        retryRequest.headers['Authorization'] = 'Bearer $refreshedAccessToken';

        for (int i = 0; i < images.length; i++) {
          if (images[i] != null) {
            request.files.add(
              await http.MultipartFile.fromPath('images', images[i]!.path),
            );
          }
        }

        response = await retryRequest.send();
      }
      http.Response responseBody = await http.Response.fromStream(response);

      // Get the response body
      String responseBodyString = responseBody.body;

      if (response.statusCode == 202) {
        developer.log('Images uploaded successfully!:$responseBodyString');
        Navigator.pushNamed(context, photoVerificationOne);
      } else {
        developer.log('Upload failed with status: ${response.statusCode}');
        _showErrorDialog(context, responseBodyString);
      }
    } catch (e) {
      developer.log('Error making API request: $e');
      rethrow;
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
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

// import 'dart:io';
// import 'package:http/http.dart' as http;

// class ApiService {
//   static const String uploadUrl = "http://localhost:7001/profile/add-image";

//   Future<void> uploadImages(List<File?> images, String token) async {
//     try {
//       var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));

//       // Add authorization header
//       request.headers['Authorization'] = 'Bearer $token';

//       // Add each image as multipart data
//       for (int i = 0; i < images.length; i++) {
//         if (images[i] != null) {
//           request.files.add(
//             await http.MultipartFile.fromPath('images', images[i]!.path),
//           );
//         }
//       }

//       // Send the request
//       var response = await request.send();

//       if (response.statusCode == 202) {
//         print("Images uploaded successfully");
//       } else {
//         print("Upload failed with status: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error uploading images: $e");
//     }
//   }
// }
