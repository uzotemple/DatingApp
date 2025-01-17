// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:url_launcher/url_launcher.dart';

// class PaymentPage extends StatelessWidget {
//   final String apiUrl = "https://api.flutterwave.com/v3/payments";
//   final String secretKey = "FLWSECK_TEST-faffbda43bef79f5570201bf1cb899d0-X";

//   const PaymentPage({super.key});

//   Future<void> makePayment(BuildContext context) async {
//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: {
//         "Authorization": "Bearer $secretKey",
//         "Content-Type": "application/json",
//       },
//       body: jsonEncode({
//         "tx_ref": DateTime.now().toIso8601String(),
//         "amount": "100",
//         "currency": "USD",
//         "redirect_url": "https://your-redirect-url.com",
//         "payment_options": "card,mobilemoney,ussd,banktransfer,paypal",
//         "customer": {
//           "email": "customer@example.com",
//           "name": "Customer Name",
//         },
//         "customizations": {
//           "title": "Zenkonnect",
//           "description": "Purchase of goods and services",
//           "logo": "https://your-logo-url.com/logo.png",
//         }
//       }),
//     );

//     if (response.statusCode == 200) {
//       final responseBody = jsonDecode(response.body);
//       if (responseBody['status'] == 'success') {
//         final checkoutUrl = Uri.parse(responseBody['data']['link']);
//         try {
//           await _launchInBrowser(checkoutUrl);
//         } catch (e) {
//           print("Could not launch URL: $e");
//         }
//       } else {
//         print("Payment Initialization Failed");
//       }
//     } else {
//       print("Error: ${response.body}");
//     }
//   }

//   Future<void> _launchInBrowser(Uri url) async {
//     if (!await launchUrl(
//       url,
//       mode: LaunchMode.externalApplication, // Opens in the default browser
//     )) {
//       throw Exception('Could not launch $url');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Flutterwave API Integration")),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => makePayment(context),
//           child: const Text("Make Payment"),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:love_bird/providers/auth_provider.dart';
import 'package:love_bird/providers/login_provider.dart';
import 'package:love_bird/providers/paymentProvider.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class PaymentService {
  final String apiUrl = "https://api.flutterwave.com/v3/payments";
  final String secretKey = "FLWSECK_TEST-faffbda43bef79f5570201bf1cb899d0-X";

  Future<void> makePayment(BuildContext context, double amount, String currency,
      String description) async {
    final paymentProvider = Provider.of<PaymentProvider>(context);

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final email = Provider.of<LoginProvider>(context, listen: false).email;
    final userName =
        Provider.of<LoginProvider>(context, listen: false).userName;
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Authorization": "Bearer $secretKey",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "tx_ref": DateTime.now().toIso8601String(),
        "amount": amount.toString(),
        "currency": currency,
        "redirect_url": "https://your-redirect-url.com",
        "payment_options": "all",
        "customer": {
          "email": email,
          "name": userName,
        },
        "customizations": {
          "title": "Zenkonnect",
          "description": description,
          "logo": "https://images.app.goo.gl/AXAdPm8ousxhJ5Vz5",
        }
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final Map<String, dynamic> responseBody2 = jsonDecode(response.body);
      if (responseBody['status'] == 'success') {
        //add rohit for verification
        String transactionId = responseBody2['transactionid'];
        paymentProvider.verifyPayment(context, authProvider, transactionId);
        final checkoutUrl = Uri.parse(responseBody['data']['link']);
        await _launchInBrowser(checkoutUrl);
      } else {
        print("Payment Initialization Failed");
      }
    } else {
      print("Error: ${response.body}");
    }
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
