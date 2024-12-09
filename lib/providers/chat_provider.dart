import 'package:flutter/material.dart';

class Message {
  final String text;
  final bool isSent;
  final DateTime timestamp;
  final bool isFlower;
  final String? filePath; // For files (e.g., images, documents)
  final String? audioPath; // For audio messages
  final String? imagePath; // For images

  Message({
    required this.text,
    required this.isSent,
    required this.timestamp,
    this.isFlower = false,
    this.filePath,
    this.audioPath,
    this.imagePath,
  });
}

class Chatprovider with ChangeNotifier {
  final List<Message> _messages = [];

  List<Message> get messages => _messages;

  void addMessage(String text,
      {String? imagePath,
      String? audioPath,
      String? filePath,
      bool isFlower = false,
      required String message}) {
    messages.add(Message(
      text: text,
      imagePath: imagePath,
      audioPath: audioPath,
      filePath: filePath,
      timestamp: DateTime.now(),
      isSent: true, // or false, depending on the sender
    ));
    notifyListeners(); // This notifies the UI of changes
  }

  // void addMessage(String selectedFlower, {
  //   required String message,
  //   String? filePath,
  //   String? audioPath,
  //   String? imagePath,
  //   bool isFlower = false,
  // }) {
  //   _messages.add(
  //     Message(
  //       text: message,
  //       isSent: true,
  //       timestamp: DateTime.now(),
  //       isFlower: isFlower,
  //       filePath: filePath,
  //       audioPath: audioPath,
  //       imagePath: imagePath,
  //     ),
  //   );
  //   notifyListeners();
  // }

  void receiveMessage({
    required String message,
    String? filePath,
    String? audioPath,
    String? imagePath,
  }) {
    _messages.add(
      Message(
        text: message,
        isSent: false,
        timestamp: DateTime.now(),
        filePath: filePath,
        audioPath: audioPath,
        imagePath: imagePath,
      ),
    );
    notifyListeners();
  }
}
