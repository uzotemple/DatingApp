import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:love_bird/model/profile_model.dart';

class LikeApi {
  static const String baseUrl = 'http://138.68.150.48:7001/like'; // Replace with your backend URL

  static Future<List<Profile>> fetchLikedProfiles(String userId, String authToken) async {
    final url = Uri.parse('$baseUrl/likes/$userId'); // Endpoint for fetching likes

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Profile.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch liked profiles');
    }
  }
}
