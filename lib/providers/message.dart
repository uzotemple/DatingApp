import 'package:flutter/material.dart';

class ChatModel extends ChangeNotifier {
  final List<Map<String, dynamic>> _messages = [];

  List<Map<String, dynamic>> get messages => _messages;

  void addMessage(Map<String, dynamic> message) {
    _messages.add(message);
    notifyListeners(); // Notify listeners when the state changes
  }

  void clearMessages() {
    _messages.clear();
    notifyListeners();
  }
}
