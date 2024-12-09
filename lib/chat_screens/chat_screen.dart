import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:love_bird/chat_screens/flowers.dart';
import 'package:love_bird/config/constants.dart';
import 'package:love_bird/providers/chat_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart'; // Import emoji picker

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  bool _isEmojiVisible = false; // Flag to control emoji visibility
  bool isUserOnline =
      true; // This flag will control the user's online/offline status

  // Send a text message
  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      if (mounted) {
        context.read<Chatprovider>().addMessage(
              _messageController.text, message: '', // Positional argument
            );
        _messageController.clear();
      }
    }
  }

  void _selectImage() async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (image != null) {
      if (mounted) {
        context.read<Chatprovider>().addMessage(
              "", // Positional argument
              imagePath: image.path, message: '', // Named argument
            );
      }
    }
  }

  void _selectAudio() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null && result.files.single.path != null) {
      String audioPath = result.files.single.path!;
      if (mounted) {
        context.read<Chatprovider>().addMessage(
              "", // Positional argument
              audioPath: audioPath, message: '', // Named argument
            );
      }
    }
  }

  void _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      String filePath = result.files.single.path!;
      if (mounted) {
        context.read<Chatprovider>().addMessage(
              "", // Positional argument
              filePath: filePath, message: '', // Named argument
            );
      }
    }
  }

  // Show attachment options dialog
  void _showAttachmentOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.only(
            left: 40,
            right: 40,
            bottom: MediaQuery.of(context).viewInsets.bottom +
                100, // Adjust as needed
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // File Icon with Name
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.pink,
                        foregroundColor: Colors.white,
                        child: IconButton(
                          icon: const Icon(Icons.insert_drive_file),
                          onPressed: _selectFile,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text("File", style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  // Camera Icon with Name
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt),
                          onPressed: _selectImage,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text("Camera", style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  // Photo Icon with Name
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        child: IconButton(
                          icon: const Icon(Icons.photo),
                          onPressed: _selectImage,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text("Photo", style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  // Audio Icon with Name
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        child: IconButton(
                          icon: const Icon(Icons.audiotrack),
                          onPressed: _selectAudio,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text("Audio", style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Method to show the flower picker screen
  void _showFlowerPicker() async {
    final selectedFlower = await showDialog<String>(
      context: context,
      builder: (context) => const FlowersScreen(),
    );

    // Check if the widget is still mounted before calling setState or accessing context
    if (!mounted) return;

    if (selectedFlower != null) {
      // Send the selected flower as a message
      context
          .read<Chatprovider>()
          .addMessage(selectedFlower, isFlower: true, message: '');
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<Chatprovider>(context);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: -5,
        leading: IconButton(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius:
                  MediaQuery.of(context).size.width * 0.08, // Responsive radius
              backgroundImage: const AssetImage('images/profile.png'),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width *
                    0.03), // Responsive spacing
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User Name',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width *
                        0.04, // Responsive font size
                  ),
                ),
                Text(
                  isUserOnline ? 'Online' : 'Offline',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    color: isUserOnline ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.video_call),
              iconSize: MediaQuery.of(context).size.width * 0.08,
              onPressed: () {
                // Add action for video call here
              },
            ),
            IconButton(
              icon: const Icon(Icons.call),
              iconSize: MediaQuery.of(context).size.width * 0.08,
              onPressed: () {
                // Add action for call here
              },
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              iconSize: MediaQuery.of(context).size.width * 0.08,
              onPressed: () {
                // Add action for more options here
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatProvider.messages.length,
              itemBuilder: (context, index) {
                final message = chatProvider.messages[index];
                final messageTime =
                    DateFormat('h:mm a').format(message.timestamp);

                return Align(
                  alignment: message.isSent
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: message.isSent
                          ? Colors.blueAccent
                          : Colors.grey[200], // Distinct color for incoming
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(12),
                        topRight: const Radius.circular(12),
                        bottomLeft: message.isSent
                            ? const Radius.circular(12)
                            : const Radius.circular(0),
                        bottomRight: message.isSent
                            ? const Radius.circular(0)
                            : const Radius.circular(12),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (message.imagePath != null)
                          Image.file(File(message.imagePath!)),
                        if (message.audioPath != null)
                          IconButton(
                            icon: const Icon(Icons.play_arrow),
                            onPressed: () {
                              // Play audio file
                            },
                          ),
                        if (message.filePath != null)
                          Text("File: ${message.filePath!.split('/').last}"),
                        if (message.text.isNotEmpty)
                          Text(
                            message.text,
                            style: TextStyle(
                                color: message.isSent
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        const SizedBox(height: 4),
                        Text(
                          messageTime,
                          style: TextStyle(
                              fontSize: 10,
                              color: message.isSent
                                  ? Colors.white70
                                  : Colors.black54),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    onSubmitted: (text) {
                      _sendMessage();
                    },
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.emoji_emotions),
                        onPressed: () {
                          setState(() {
                            _isEmojiVisible = !_isEmojiVisible;
                          });
                        },
                      ),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.local_florist),
                            onPressed:
                                _showFlowerPicker, // Show flower picker on click
                          ),
                          IconButton(
                            icon: const Icon(Icons.attach_file),
                            onPressed: _showAttachmentOptions,
                          ),
                          IconButton(
                            icon: const Icon(Icons.camera_alt),
                            onPressed: _showAttachmentOptions,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
                CircleAvatar(
                  backgroundColor: blue,
                  foregroundColor: Colors.white,
                  child: IconButton(
                    icon: const Icon(Icons.mic),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
          if (_isEmojiVisible)
            EmojiPicker(
              onEmojiSelected: (category, emoji) {
                setState(() {
                  _messageController.text += emoji.emoji;
                });
              },
            ),
        ],
      ),
    );
  }
}
