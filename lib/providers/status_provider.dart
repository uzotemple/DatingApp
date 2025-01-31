// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class StatusProvider extends ChangeNotifier {
//   final Dio _dio = Dio();
//   final _storage = const FlutterSecureStorage();
//   bool _isLoading = false;
//   String? _errorMessage;

//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;

//   Future<void> addStatus(List<File> images, String message) async {
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();

//     try {
//       final token = await _storage.read(key: 'authToken');
//       _dio.options.headers['Authorization'] = 'Bearer $token';

//       // Create FormData for the request
//       FormData formData = FormData();
//       for (var image in images) {
//         formData.files.add(
//           MapEntry(
//             "images",
//             await MultipartFile.fromFile(
//               image.path,
//               filename: image.path.split('/').last,
//             ),
//           ),
//         );
//       }
//       formData.fields.add(MapEntry('message', message));

//       // Make the POST request
//       final response = await _dio.post(
//         'https://your-backend-url.com/add-status',
//         data: formData,
//       );

//       if (response.statusCode == 200) {
//         _errorMessage = null;
//       } else {
//         _errorMessage = 'Failed to add status';
//       }
//     } catch (e) {
//       _errorMessage = 'Error: $e';
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }


import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StatusProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  List<Map<String, dynamic>> _statuses = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Map<String, dynamic>> get statuses => _statuses;

  Future<void> addStatus(List<File> images, String message) async {
    _isLoading = true;
    notifyListeners();

    try {
      final uri = Uri.parse('https://your-api-url.com/status/add-status');
      final request = http.MultipartRequest('POST', uri)
        ..fields['message'] = message;

      for (var image in images) {
        request.files.add(await http.MultipartFile.fromPath(
          'images',
          image.path,
        ));
      }

      final response = await request.send();
      if (response.statusCode == 200) {
        _errorMessage = null;
      } else {
        _errorMessage = 'Failed to add status';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserStatuses() async {
    _isLoading = true;
    notifyListeners();

    try {
      final uri = Uri.parse('http://localhost:7001/profile/add-status');
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer your_access_token',
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _statuses = List<Map<String, dynamic>>.from(data['statuses'] ?? []);
        _errorMessage = null;
      } else {
        _errorMessage = 'Failed to fetch statuses';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
