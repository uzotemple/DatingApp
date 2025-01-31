import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VisitProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _message;

  bool get isLoading => _isLoading;
  String? get message => _message;

  Future<void> addVisit({
    required String? visitorId, // ID of the visitor the action is performed on
    required String action,     // Action ('LIKE', 'SUPERLIKE', or 'DISLIKE')
    required String authToken,  // Authentication token
  }) async {
    // Validate visitorId before proceeding
    if (visitorId == null || visitorId.isEmpty) {
      _setMessage('Invalid visitor ID. Cannot perform action.');
      return;
    }

    // Validate action before sending it to backend
    if (!['LIKE', 'SUPERLIKE', 'DISLIKE'].contains(action.toUpperCase())) {
      _setMessage('Invalid action type. Supported actions: LIKE, SUPERLIKE, DISLIKE.');
      return;
    }

    final url = Uri.parse('http://138.68.150.48:7001/visit');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',
    };

    final body = jsonEncode({
      'visitorId': visitorId,
      'action': action,
    });

    _setLoadingState(true);

    try {
      final response = await http.post(url, headers: headers, body: body);
      _handleResponse(response);
    } catch (error) {
      print('Exception occurred: $error');
      _setMessage('Failed to connect to the server.');
    } finally {
      _setLoadingState(false);
    }
  }

  // Method to set loading state and notify listeners
  void _setLoadingState(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  // Method to set message and notify listeners
  void _setMessage(String message) {
    _message = message;
    notifyListeners();
  }

  // Handle the response from the API
  void _handleResponse(http.Response response) {
    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        final responseData = jsonDecode(response.body);
        _message = responseData['message']?.toString() ?? 'Action performed successfully!';
      } else {
        _message = 'Response body is empty.';
      }
    } else {
      final errorData = response.body.isNotEmpty ? jsonDecode(response.body) : {};
      _message = errorData['error']?.toString() ?? 'An error occurred: ${response.statusCode}';
    }
  }
}
