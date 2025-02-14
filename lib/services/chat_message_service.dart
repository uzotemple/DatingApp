// import 'dart:io';
// import 'package:dio/dio.dart';

// class ChatApi {
//   final Dio _dio =
//       Dio(BaseOptions(baseUrl: 'http://138.68.150.48:7001'));

//   Future<Response> sendMessage({
//     File? file,
//     required String senderId,
//     required String receiverId,
//     required String message,
//   }) async {
//     try {
//       FormData formData = FormData.fromMap({
//         "senderId": senderId,
//         "receiverId": receiverId,
//         "message": message,
//         if (file != null)
//           "file": await MultipartFile.fromFile(file.path,
//               filename: file.path.split('/').last),
//       });

//       Response response = await _dio.post('/messaging', data: formData);
//       return response;
//     } catch (e) {
//       print("Error sending message: $e");
//       rethrow;
//     }
//   }
// }
