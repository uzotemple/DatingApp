import 'package:dio/dio.dart';
import 'package:love_bird/model/likes_model.dart';

class LikeService {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://138.68.150.48:7001',
    contentType: 'application/json',
  ));

  // 📌 Fetch Likes
  static Future<List<Like>> fetchLikes(String authToken) async {
    try {
      final response = await _dio.get(
        '/like',
        options: Options(
          headers: {'Authorization': 'Bearer $authToken'},
        ),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.data}');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((item) => Like.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load likes, status: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error fetching likes: $e');
      throw Exception('Error fetching likes: $e');
    }
  }
}
