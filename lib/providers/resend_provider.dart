import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class ResendProvider extends ChangeNotifier {
  bool isLoading = false;

  Future<void> resendverifyOtp(BuildContext context, String userId) async {
    final url = Uri.parse("http://localhost:7001/auth/resend-otp")
        .replace(queryParameters: {"userId": userId});

    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        url,
      );

      developer.log('Response status: ${response.statusCode}');
      developer.log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        developer.log('OTP sent Successfully: ${responseData['message']}',
            name: 'OtpProvider');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Code has been resent'),
            duration: Duration(seconds: 2),
          ),
        );
      } else if (response.statusCode == 400) {
        final responseData = jsonDecode(response.body);
        developer.log('OTP failed: ${responseData['message']}',
            name: 'OtpProvider');
        _showErrorDialog(context, 'OTP  failed: ${responseData['message']} ');
      } else {
        developer.log('Unexpected error: ${response.body}',
            name: 'OtpProvider');
        _showErrorDialog(context, 'Unexpected error: ${response.body}');
      }
    } catch (error) {
      developer.log('Unexpected error: $error', name: 'OtpProvider');
      _showErrorDialog(
        context,
        'Unexpected error: $error',
      );
    } finally {
      isLoading = false;
      notifyListeners();
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
