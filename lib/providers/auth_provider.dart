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
    const String refreshUrl = 'http://138.68.150.48:7001/auth/refresh-token';

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
    await _secureStorage.delete(key: 'accessToken');
    await _secureStorage.delete(key: 'refreshToken');

    _accessToken = null;
    _refreshToken = null;
    notifyListeners();
    developer.log('User logged out');
  }

  String? _extractRefreshToken(Map<String, String> headers) {
    final cookies = headers['set-cookie'];
    if (cookies != null) {
      final refreshToken =
          RegExp(r'local.bg-refresh-mgmt=([^;]+)').firstMatch(cookies);
      return refreshToken?.group(1);
    }
    return null;
  }
}
