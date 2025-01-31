import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:love_bird/model/likes_model.dart';

class LikeService {
  static Future<List<Like>> fetchLikes(String authToken) async {
    final url = Uri.parse('http://138.68.150.48:7001/like');
    final headers = {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json',
    };

    print('Fetching Likes from: $url');
    print('Request Headers: $headers');

    final response = await http.get(url, headers: headers);

    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Like.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load likes, status: ${response.statusCode}');
    }
  }
}

