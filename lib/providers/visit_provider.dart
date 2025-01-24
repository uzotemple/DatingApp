import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VisitProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _message;

  bool get isLoading => _isLoading;
  String? get message => _message;

  Future<void> addVisit({
    required String? visitorId,  // ID of the visitor the action is performed on
    required String action,     // Action ('LIKE', 'SUPERLIKE', or 'DISLIKE')
    required String authToken,  // Authentication token
  }) async {
    final url = Uri.parse('http://138.68.150.48:7001/visit');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',
    };

    final body = jsonEncode({
      'visitorId': visitorId,  // Visitor ID (the profile the user is interacting with)
      'action': action,        // Action ('LIKE', 'SUPERLIKE', 'DISLIKE')
    });

    print('Sending POST request to $url');
    print('Headers: $headers');
    print('Body: $body');

    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(url, headers: headers, body: body);

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Success response data: $responseData');

        _message = responseData['message'] ?? 'Action performed successfully!';
      } else {
        final errorData = jsonDecode(response.body);
        print('Error response data: $errorData');

        _message = errorData['error'] ?? 'An error occurred.';
      }
    } catch (error) {
      print('Exception occurred: $error');
      _message = 'Failed to connect to the server.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
