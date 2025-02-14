import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'auth_provider.dart'; // Import the AuthProvider
class ChatProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  String? _messageResponse;
  String? get messageResponse => _messageResponse;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // This function will handle sending a message using Dio
  Future<void> sendMessage({
    required String receiverId,
    required String message,
    String? filePath, // Optional file upload
    required BuildContext context, // Add context to access AuthProvider
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Access the userId and token from AuthProvider
      final userId = Provider.of<AuthProvider>(context, listen: false).userId;
      final token = Provider.of<AuthProvider>(context, listen: false).accessToken;

      if (userId == null) {
        _messageResponse = 'Unauthorized: No userId found';
        _isLoading = false;
        notifyListeners();
        return;
      }

      if (token == null) {
        _messageResponse = 'Unauthorized: No token found';
        _isLoading = false;
        notifyListeners();
        return;
      }

      const url = 'http://138.68.150.48:7001/messaging';

      FormData formData = FormData.fromMap({
        'senderId': userId, // Use userId from AuthProvider
        'receiverId': receiverId, // This comes dynamically from selected user
        'message': message,
        if (filePath != null) 'file': await MultipartFile.fromFile(filePath),
      });

      final response = await _dio.post(
        url,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        _messageResponse = 'Message sent successfully';
      } else {
        _messageResponse = 'Failed to send message';
      }
    } catch (e) {
      _messageResponse = 'Error sending message: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

// WEB SOCKECT IMPLEMENTATION


// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:provider/provider.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:web_socket_channel/status.dart' as status;
// import 'auth_provider.dart'; // Import the AuthProvider

// class ChatProvider extends ChangeNotifier {
//   final Dio _dio = Dio();
//   WebSocketChannel? _channel;
//   StreamSubscription? _socketSubscription;

//   final List<String> _messages = []; // Store messages
//   List<String> get messages => _messages;

//   String? _messageResponse;
//   String? get messageResponse => _messageResponse;

//   bool _isLoading = false;
//   bool get isLoading => _isLoading;

//   final String wsUrl = 'ws://138.68.150.48:7001/messaging/socket';
//   int _reconnectAttempts = 0;

//   /// 🔹 Connect to WebSocket
//   void connectWebSocket(String token) {
//     closeWebSocket();

//     _channel = WebSocketChannel.connect(Uri.parse('$wsUrl?token=$token'));

//     _socketSubscription = _channel!.stream.listen(
//       (message) {
//         print("📩 New WebSocket Message: $message");
//         _messages.add(message); // Store message
//         notifyListeners(); // Notify UI
//       },
//       onError: (error) {
//         print("❌ WebSocket Error: $error");
//         reconnectWebSocket(token);
//       },
//       onDone: () {
//         print("🔌 WebSocket Closed");
//       },
//     );
//   }

//   /// 🔄 Reconnect WebSocket with progressive delay
//   void reconnectWebSocket(String token) {
//     if (_reconnectAttempts < 5) {
//       _reconnectAttempts++;
//       int delay = _reconnectAttempts * 3; // 3s, 6s, 9s...

//       Future.delayed(Duration(seconds: delay), () {
//         print("🔄 Reconnecting WebSocket (Attempt $_reconnectAttempts)...");
//         connectWebSocket(token);
//       });
//     } else {
//       print("❌ Max WebSocket reconnect attempts reached.");
//     }
//   }

//   /// 🔻 Close WebSocket when not in use
//   void closeWebSocket() {
//     _socketSubscription?.cancel();
//     _socketSubscription = null;
//     _channel?.sink.close(status.goingAway);
//     _channel = null;
//     _reconnectAttempts = 0;
//   }

//   /// 📨 Send a message via WebSocket
//   void sendMessageViaWebSocket(String senderId, String receiverId, String message) {
//     if (_channel != null) {
//       final jsonMessage = jsonEncode({
//         "senderId": senderId,
//         "receiverId": receiverId,
//         "message": message
//       });
//       _channel!.sink.add(jsonMessage);
//       print("🚀 Sent via WebSocket: $jsonMessage");
//     } else {
//       print("⚠️ WebSocket disconnected, reconnecting...");
//       reconnectWebSocket(senderId);
//     }
//   }

//   /// 🌐 Send a message via HTTP as a fallback
//   Future<void> sendMessage({
//     required String receiverId,
//     required String message,
//     String? filePath,
//     required BuildContext context,
//   }) async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       final userId = Provider.of<AuthProvider>(context, listen: false).userId;
//       final token = Provider.of<AuthProvider>(context, listen: false).accessToken;

//       if (userId == null || token == null) {
//         _messageResponse = 'Unauthorized: No userId or token found';
//         _isLoading = false;
//         notifyListeners();
//         return;
//       }

//       if (_channel != null) {
//         sendMessageViaWebSocket(userId, receiverId, message);
//         _messageResponse = "Message sent via WebSocket";
//       } else {
//         const url = 'http://138.68.150.48:7001/messaging';

//         FormData formData = FormData.fromMap({
//           'senderId': userId,
//           'receiverId': receiverId,
//           'message': message,
//           if (filePath != null) 'file': await MultipartFile.fromFile(filePath),
//         });

//         final response = await _dio.post(
//           url,
//           data: formData,
//           options: Options(
//             headers: {
//               'Authorization': 'Bearer $token',
//               'Content-Type': 'multipart/form-data',
//             },
//           ),
//         );

//         if (response.statusCode == 200) {
//           _messageResponse = 'Message sent successfully via HTTP';
//         } else {
//           _messageResponse = 'Failed to send message via HTTP';
//         }
//       }
//     } catch (e) {
//       _messageResponse = 'Error sending message: $e';
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }
