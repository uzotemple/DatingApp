import 'package:flutter/material.dart';
import 'package:love_bird/config/routes.dart';
import 'api_helper.dart';
import 'auth_provider.dart';
import 'dart:developer' as developer;
import 'dart:convert';

class PaymentProvider extends ChangeNotifier {
  Future<void> verifyPayment(BuildContext context, AuthProvider authProvider,
      String transactionId) async {
    try {
      // Define API request details
      final url =
          'http://138.68.150.48:7001/payment/$transactionId'; // Include transactionId in URL
      const method = 'POST';

      // Add transactionId in headers
      final headers = {
        'Content-Type': 'application/json',
        'transactionId': transactionId, // Adding transactionId to headers
      };
      // API request body
      final body = {
        "userId": "string",
        "amount": 0,
        "duration": 0,
        "packageType": "NORMAL"
      };

      // Send the request using makeApiRequest
      final response = await makeApiRequest(
        url,
        method,
        headers,
        authProvider,
        body: body,
      );

      // Check for successful response
      if (response.statusCode == 200 || response.statusCode == 201) {
        developer.log('Money recieved: ${response.data}');
        Navigator.pushNamed(context, homeScreen);
      } else {
        final Map<String, dynamic> responseBody = jsonDecode(response.data);
        final errorMessage = responseBody['message'] ?? 'Unknown error';

        //  Print and log the error
        developer.log(
            'Failed to verify transaction. Status code: ${response.statusCode}, Error: $errorMessage');

        _showErrorDialog(context, "Error: $errorMessage");
        throw Exception(
            'Failed to verify transaction. Status code: ${response.statusCode}, Response: ${response.data}');

        //  return;
      }
    } catch (e) {
      developer.log('Error creating profile: $e');
      _showErrorDialog(context, "An error occurred. Please try again.");
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error', style: TextStyle(color: Colors.black)),
          content: Text(message, style: const TextStyle(color: Colors.black)),
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
