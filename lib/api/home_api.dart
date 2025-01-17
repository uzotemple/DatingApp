// import 'dart:convert';

// import 'package:love_bird/config/constants.dart';
// import 'package:love_bird/homeScreen/profiles.dart';
// import 'package:love_bird/providers/api_helper.dart';
// import 'package:love_bird/providers/auth_provider.dart';

// import 'package:http/http.dart' as http;

// Future<void> getRequest(AuthProvider authProvider) async {

//   // Define the body as per your request.
//   Map<String, dynamic> body = {
//     "filters": [],
//     "sorts": [],
//     "search": [],
//     "searchFilters": [],
//     "absoulteFilters": [],
//     "page": 0,
//     "size": 10
//   };

//   final headers = {
//     'Content-Type': 'application/json',
//   };

//   // Specify the URL for your request.
//   String url = baseurl + '/profile/list'; // Replace with your actual URL

//   try {
//     // Make the POST request using your helper method.
//     http.Response response = await makeApiRequest(
//       url,
//       'POST',
//       headers,
//       authProvider,
//       body: body,
//     );

//     if (response.statusCode == 200) {
//       // If the request was successful, you can parse the response body here.
//       print('Response body: ${response.body}');
//     }
//     else {
//       // Handle errors based on status code.
//       print('Request failed with status: ${response.statusCode}');
//     }
//   } catch (e) {
//     // Handle any errors that occurred during the request.
//     print('Error: $e');
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:love_bird/config/constants.dart';
import 'package:love_bird/model/profile_model.dart';

import 'package:love_bird/providers/api_helper.dart';
import 'package:love_bird/providers/auth_provider.dart';

class ProfileService {
  static Future<List<Profile>> fetchProfiles(AuthProvider authProvider) async {
    // Define the body as per your request.
    Map<String, dynamic> body = {
      "filters": [],
      "sorts": [],
      "search": [],
      "searchFilters": [],
      "absoulteFilters": [],
      "page": 0,
      "size": 10
    };

    final headers = {
      'Content-Type': 'application/json',
    };

    // API Endpoint
    String url = baseurl + '/profile/list'; // Replace with your actual URL

    try {
      // Make the API call using your helper method
      http.Response response = await makeApiRequest(
        url,
        'POST',
        headers,
        authProvider,
        body: body,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> profilesJson = data["object"];

        return profilesJson.map((json) => Profile.fromJson(json)).toList();
      } else {
        print('Request failed with status: ${response.statusCode}');
        throw Exception("Failed to load profiles");
      }
    } catch (e) {
      print('Error: $e');
      throw Exception("Error fetching profiles: $e");
    }
  }
}
