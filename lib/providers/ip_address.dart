// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:developer';

// class IpAddressProvider extends ChangeNotifier {
//   String? _ipAddress; // Store the IP address
//   String? get ipAddress => _ipAddress;

//   Future<void> fetchIpAddress() async {
//     final url = Uri.parse('http://138.68.150.48:7001/auth/remote-address');

//     try {
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         // Check if response body is not empty
//         if (response.body.isNotEmpty) {
//           try {
//             _ipAddress = jsonDecode(response.body);
//             log('IP Address: $_ipAddress', name: 'FetchIPAddress');
//             notifyListeners();
//           } catch (e) {
//             log('Failed to decode IP address: $e', name: 'FetchIPAddress');
//           }
//         } else {
//           log('Received empty response body', name: 'FetchIPAddress');
//         }
//       } else if (response.statusCode == 400 || response.statusCode == 403) {
//         // Handle error response (if the backend returns error message)
//         if (response.body.isNotEmpty) {
//           try {
//             final error = jsonDecode(response.body);
//             log('Error: ${error['message']}', name: 'FetchIPAddress');
//           } catch (e) {
//             log('Error decoding error message: $e', name: 'FetchIPAddress');
//           }
//         } else {
//           log('Received empty error response body', name: 'FetchIPAddress');
//         }
//       } else {
//         log('Unexpected error: ${response.body}', name: 'FetchIPAddress');
//       }
//     } catch (error) {
//       log('Failed to fetch IP Address: $error', name: 'FetchIPAddress');
//     }
//   }
// }

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class IpAddressProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  String? _ipAddress; // Store the IP address

  String? get ipAddress => _ipAddress;

  Future<void> fetchIpAddress() async {
    const String url = 'http://138.68.150.48:7001/auth/remote-address';

    try {
      Response response = await _dio.get(url);

      if (response.statusCode == 200 && response.data != null) {
        _ipAddress = response.data.toString();
        log('✅ IP Address: $_ipAddress', name: 'FetchIPAddress');
        notifyListeners();
      } else {
        log('⚠️ Unexpected response: ${response.data}', name: 'FetchIPAddress');
      }
    } catch (error) {
      log('❌ Failed to fetch IP Address: $error', name: 'FetchIPAddress');
    }
  }
}
