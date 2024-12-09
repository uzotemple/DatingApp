import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:love_bird/config/routes.dart';
import 'dart:developer' as developer;

class LoginProvider with ChangeNotifier {
  final _secureStorage = const FlutterSecureStorage();

  bool _showLoading = false;
  bool _dimBackground = false;
  bool _isChecked = false;

  bool get showLoading => _showLoading;
  bool get dimBackground => _dimBackground;
  bool get isChecked => _isChecked;

  void toggleLoading(bool value) {
    _showLoading = value;
    notifyListeners();
  }

  void toggleDimBackground(bool value) {
    _dimBackground = value;
    notifyListeners();
  }

  void toggleRememberMe() {
    _isChecked = !_isChecked;
    notifyListeners();
  }

  Future<void> handleLogin(BuildContext context, GlobalKey<FormState> formKey,
      String email, String password) async {
    if (formKey.currentState!.validate()) {
      toggleDimBackground(true);

      try {
        final response = await _loginUser(email, password);

        developer.log('Response status: ${response.statusCode}');
        developer.log('Response body: ${response.body}');

        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        final String message =
            responseBody['message']?.toString() ?? 'Unknown error occurred';

        if (response.statusCode == 202 ||
            response.statusCode == 201 ||
            response.statusCode == 200) {
          _showSubmissionDialog(context);
        } else if (message == 'User Inactive') {
          _showErrorDialogForOtp(context, 'Please verify your mail');
        } else if (message == 'User not found by given Email') {
          _showErrorDialog(context, 'No user with this mail');
        } else if (message == 'Incorrect Password') {
          _showErrorDialog(context, 'Incorrect Password');
        } else {
          _showErrorDialog(context, "Unexpected error: $message");
        }
      } catch (e) {
        developer.log('Error: $e');
        _showErrorDialog(context, "An error occurred. Please try again.");
      } finally {
        toggleLoading(false);
        toggleDimBackground(false);
      }
    }
  }

  Future<http.Response> _loginUser(String email, String password) async {
    const String url = 'http://localhost:7001/auth/login';
    return await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'entrypoint': email,
        'password': password,
      }),
    );
  }

  Future<void> _saveTokens(String accessToken, String refreshToken) async {
    await _secureStorage.write(key: 'accessToken', value: accessToken);
    await _secureStorage.write(key: 'refreshToken', value: refreshToken);
  }

  Future<String?> _getAccessToken() async {
    return await _secureStorage.read(key: 'accessToken');
  }

  Future<String?> _getRefreshToken() async {
    return await _secureStorage.read(key: 'refreshToken');
  }

  Future<http.Response> _refreshToken() async {
    const String url = 'http://localhost:7001/auth/refresh-token';
    final refreshToken = await _getRefreshToken();

    if (refreshToken == null) {
      throw Exception('No refresh token available');
    }

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refreshToken': refreshToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _saveTokens(data['accessToken'], data['refreshToken']);
    } else {
      throw Exception('Failed to refresh token');
    }

    return response;
  }

  Future<http.Response> _makeAuthenticatedRequest(
      String url, Map<String, dynamic> body) async {
    String? accessToken = await _getAccessToken();
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 401) {
      // Token expired, refresh and retry
      await _refreshToken();
      accessToken = await _getAccessToken();
      return await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(body),
      );
    }

    return response;
  }

  void _showSubmissionDialog(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/icons/loginIcon.png'),
                const SizedBox(height: 20),
                const Text(
                  'Login Successful!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(54, 40, 221, 1),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Please wait....\nYou will be redirected to the homepage",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
      Navigator.pushNamed(context, homeScreen);
    });
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

  void _showErrorDialogForOtp(BuildContext context, String messages) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(messages),
          actions: [
            TextButton(
              onPressed: () => Navigator.pushNamed(context, verifyEmailRoute),
              //  () => Navigator.pushNamed(context, oTPVerificationPage),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

// recent one from chatgpt just incase the above does not work
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // For storing tokens securely

// class LoginProvider with ChangeNotifier {
//   bool _showLoading = false;
//   final _storage = FlutterSecureStorage(); // Secure storage for tokens

//   bool get showLoading => _showLoading;

//   void toggleLoading(bool value) {
//     _showLoading = value;
//     notifyListeners();
//   }

//   Future<void> handleLogin(BuildContext context, GlobalKey<FormState> formKey,
//       String email, String password) async {
//     if (formKey.currentState!.validate()) {
//       toggleLoading(true);
//       try {
//         final response = await _loginUser(email, password);
//         if (response.statusCode == 200) {
//           // Parse and save tokens
//           var responseBody = json.decode(response.body);
//           await _saveTokens(responseBody['accessToken'], responseBody['refreshToken']);
          
//           // Redirect user after successful login
//           Navigator.pushReplacementNamed(context, '/home'); // Home screen route
//         } else {
//           // Handle failure (invalid credentials, etc.)
//           _showErrorDialog(context, "Login failed. Check your credentials.");
//         }
//       } catch (e) {
//         _showErrorDialog(context, "An error occurred. Please try again.");
//       } finally {
//         toggleLoading(false);
//       }
//     }
//   }

//   Future<http.Response> _loginUser(String email, String password) async {
//     const String url = 'http://localhost:7001/auth/login';
//     final response = await http.post(
//       Uri.parse(url),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'entrypoint': email,
//         'password': password,
//       }),
//     );
//     return response;
//   }

//   // Save tokens securely
//   Future<void> _saveTokens(String accessToken, String refreshToken) async {
//     await _storage.write(key: 'accessToken', value: accessToken);
//     await _storage.write(key: 'refreshToken', value: refreshToken);
//   }

//   // Show error dialog
//   void _showErrorDialog(BuildContext context, String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Error'),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // Fetch and refresh access token when expired
//   Future<String?> _getNewAccessToken() async {
//     final refreshToken = await _storage.read(key: 'refreshToken');
//     if (refreshToken == null) {
//       return null;
//     }

//     final response = await _refreshToken(refreshToken);

//     if (response.statusCode == 200) {
//       var responseBody = json.decode(response.body);
//       await _saveTokens(responseBody['accessToken'], responseBody['refreshToken']);
//       return responseBody['accessToken'];
//     }
//     return null;
//   }

//   Future<http.Response> _refreshToken(String refreshToken) async {
//     const String url = 'http://localhost:7001/auth/refresh-token';
//     final response = await http.post(
//       Uri.parse(url),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'refreshToken': refreshToken}),
//     );
//     return response;
//   }

//   // Make authenticated API request
//   Future<http.Response> _makeAuthenticatedRequest(String url) async {
//     String? accessToken = await _storage.read(key: 'accessToken');
//     if (accessToken == null) {
//       return http.Response('Unauthorized', 401);
//     }

//     final response = await http.get(
//       Uri.parse(url),
//       headers: {'Authorization': 'Bearer $accessToken'},
//     );

//     // If the access token expired, attempt to refresh it
//     if (response.statusCode == 401) {
//       accessToken = await _getNewAccessToken();
//       if (accessToken == null) {
//         return http.Response('Unauthorized', 401);
//       }
//       return await http.get(
//         Uri.parse(url),
//         headers: {'Authorization': 'Bearer $accessToken'},
//       );
//     }
//     return response;
//   }
// }
