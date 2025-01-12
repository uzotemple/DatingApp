// // import 'package:flutter/material.dart';
// // import 'api_helper.dart';
// // import 'auth_provider.dart';
// // import 'dart:developer' as developer;

// // class ProfileProvider with ChangeNotifier {
// //   Future<void> createProfile(AuthProvider authProvider) async {
// //     try {
// //       final response = await makeApiRequest(
// //         'http://localhost:7001/profile/initial-addition',
// //         'POST',
// //         {'Content-Type': 'application/json'},
// //         authProvider,
// //         body: {
// //           "profession": 'Developer',
// //           "weight": 75,
// //           "height": 180,
// //           "country": 'USA',
// //           "city": 'New York',
// //           "bio": 'I love codes!',
// //           "educationLevel": 'None',
// //         },
// //       );

// //       if (response.statusCode != 200) {
// //         throw Exception('Failed to create profile: ${response.body}');
// //       }
// //       developer.log('Profile created successfully');
// //     } catch (e) {
// //       developer.log('Error creating profile: $e');
// //       //    rethrow;
// //     }
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'api_helper.dart';
// import 'auth_provider.dart';
// import 'dart:developer' as developer;

// class ProfileProvider with ChangeNotifier {
//   Future<void> createProfile(AuthProvider authProvider) async {
//     try {
//       // Define API request details
//       final url = 'http://localhost:7001/profile/initial-addition';
//       final method =
//           'POST'; // Consider using a constant or enum for HTTP methods
//       final headers = {'Content-Type': 'application/json'};

//       // API request body
//       final body = {
//         "profession": 'Developer',
//         "weight": 75,
//         "height": 180,
//         "country": 'USA',
//         "city": 'New York',
//         "bio": 'I love codes!',
//         "educationLevel": 'None',
//       };

//       // Send the request using makeApiRequest
//       final response = await makeApiRequest(
//         url,
//         method,
//         headers,
//         authProvider,
//         body: body,
//       );

//       // Check for successful response
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         developer.log('Profile created successfully: ${response.body}');
//       } else {
//         throw Exception(
//             'Failed to create profile. Status code: ${response.statusCode}, Response: ${response.body}');
//       }
//     } catch (e) {
//       developer.log('Error creating profile: $e');
//     }
//   }
// }
