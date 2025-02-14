// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;

// class StoryService {
//   final String baseUrl = 'http://138.68.150.48:7001/profile';

//   // Method to fetch stories
//   Future<List<dynamic>> fetchStories(String token) async {
//     final response = await http.get(
//       Uri.parse('$baseUrl/list-all-status'),
//       headers: {'Authorization': 'Bearer $token'},
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body)['data'];
//     } else {
//       throw Exception('Failed to load stories');
//     }
//   }

//   // Method to add a story with a single image
//   Future<bool> addStory(String token, File image, {String? message}) async {
//     var request = http.MultipartRequest("POST", Uri.parse('$baseUrl/add-status'));
//     request.headers['Authorization'] = 'Bearer $token';

//     // Add the single image
//     request.files.add(await http.MultipartFile.fromPath('images', image.path)); // Ensure 'images' is the correct field name

//     if (message != null) {
//       request.fields['message'] = message;
//     }

//     try {
//       final response = await request.send();
//       print("Response status: ${response.statusCode}");  // Debugging log

//       if (response.statusCode == 200) {
//         return true;
//       } else {
//         print("Failed to upload story: ${response.statusCode}");
//         return false;
//       }
//     } catch (e) {
//       print("Error during upload: $e");
//       return false;
//     }
//   }

//   // Method to delete a story
//   Future<bool> deleteStory(String token, String statusId) async {
//     final response = await http.delete(
//       Uri.parse('$baseUrl/delete-status?statusId=$statusId'),
//       headers: {'Authorization': 'Bearer $token'},
//     );
//     return response.statusCode == 200;
//   }
// }


import 'dart:io';
import 'package:dio/dio.dart';

class StoryService {
  final Dio _dio = Dio();
  final String baseUrl = 'http://138.68.150.48:7001/profile';

  StoryService() {
    _dio.options.baseUrl = baseUrl;
  }

  // 📌 Fetch stories
  Future<List<dynamic>> fetchStories(String token) async {
    try {
      Response response = await _dio.get(
        '/list-all-status',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        throw Exception('Failed to load stories');
      }
    } catch (e) {
      throw Exception('Error fetching stories: $e');
    }
  }

  // 📌 Add a story with an image
  Future<bool> addStory(String token, File image, {String? message}) async {
    try {
      FormData formData = FormData.fromMap({
        'images': await MultipartFile.fromFile(image.path, filename: image.path.split('/').last),
        if (message != null) 'message': message,
      });

      Response response = await _dio.post(
        '/add-status',
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          contentType: 'multipart/form-data',
        ),
      );

      return response.statusCode == 200;
    } catch (e) {
      print("❌ Error uploading story: $e");
      return false;
    }
  }

  // 📌 Delete a story
  Future<bool> deleteStory(String token, String statusId) async {
    try {
      Response response = await _dio.delete(
        '/delete-status',
        queryParameters: {'statusId': statusId},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return response.statusCode == 200;
    } catch (e) {
      print("❌ Error deleting story: $e");
      return false;
    }
  }
}
