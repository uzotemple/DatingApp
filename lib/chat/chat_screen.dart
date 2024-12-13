import 'dart:io';
import 'package:love_bird/config/constants.dart';
import 'package:love_bird/config/routes.dart';

import 'package:open_file/open_file.dart';
import 'package:flutter/material.dart';

import 'package:love_bird/chat/video_call.dart';
import 'package:love_bird/chat/voiceCall.dart';

import 'package:love_bird/homeScreen/notification.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:just_audio/just_audio.dart';

class ChatDetailScreen extends StatefulWidget {
  final String name;
  final String profileImage;
  final bool isOnline;
  final String lastMessage;

  const ChatDetailScreen({
    super.key,
    required this.name,
    required this.profileImage,
    this.isOnline = false,
    required this.lastMessage,
  });

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = []; // List to store messages
  String selectedOption = '';

  void _selectAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null && result.files.single.path != null) {
      String audioPath = result.files.single.path!;
      setState(() {
        _messages.add({
          'audio': audioPath,
          'time': TimeOfDay.now().format(context),
          'isMe': true,
        });
      });
    }
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add({
          'message': _messageController.text,
          'time': TimeOfDay.now().format(context),
          'isMe': true,
        });
        _messageController.clear();
      });
    }
  }

  void _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      String filePath = result.files.single.path!;
      setState(() {
        _messages.add({
          'file': filePath, // Store the file path
          'time': TimeOfDay.now().format(context),
          'isMe': true,
        });
      });
    }
  }

  final ImagePicker _picker = ImagePicker();

  void _selectImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery, // Use ImageSource.camera for camera
        imageQuality: 85, // Optional: Adjust the quality if needed
      );

      if (image != null) {
        String filePath = image.path;
        setState(() {
          _messages.add({
            'image': filePath,
            'time': TimeOfDay.now().format(context),
            'isMe': true,
          });
        });
      } else {
        print("No image selected.");
      }
    } catch (e) {
      print("Error selecting image: $e");
    }
  }

  void _selectCameraImage() async {
    PermissionStatus permission = await Permission.camera.request();
    if (permission.isGranted) {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        setState(() {
          _messages.add({
            'image': pickedImage.path,
            'time': TimeOfDay.now().format(context),
            'isMe': true,
          });
        });
      }
    }
  }

  Widget _buildImageBubble({
    required String imagePath,
    required String time,
    required bool isMe,
  }) {
    final screenSize = MediaQuery.of(context).size;
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            // Container(
            //   width: screenSize.width * 0.6,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     image: DecorationImage(
            //       image: imagePath.startsWith('assets/')
            //           ? AssetImage(imagePath) as ImageProvider
            //           : FileImage(File(imagePath)),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            //   height: 150,
            // ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreenImage(imagePath: imagePath),
                  ),
                );
              },
              child: Container(
                width: screenSize.width * 0.6,
                height: screenSize.height * 0.23,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: imagePath.startsWith('assets/')
                        ? AssetImage(imagePath) as ImageProvider
                        : FileImage(File(imagePath)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenSize.height * 0.002),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  time,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showAttachmentPopup(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    showGeneralDialog(
      context: context,
      barrierLabel: 'AttachmentPopup',
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) {
        return Padding(
          padding: EdgeInsets.only(bottom: screenSize.height * 0.12),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.07,
                    vertical: screenSize.height * 0.02),
                width: screenSize.width * 0.8,
                height: screenSize.height * 0.13,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AttachmentOption(
                        icon: Icons.insert_drive_file,
                        color: Colors.pink,
                        label: 'Files',
                        onPressed: () {
                          _selectFile();
                        }),
                    AttachmentOption(
                      icon: Icons.camera_alt,
                      color: Colors.red,
                      label: 'Camera',
                      onPressed: () async {
                        _selectCameraImage();
                      },
                    ),
                    AttachmentOption(
                      icon: Icons.photo,
                      color: Colors.blue,
                      label: 'Gallery',
                      onPressed: () {
                        _selectImage();
                      },
                    ),
                    AttachmentOption(
                      icon: Icons.audiotrack,
                      color: Colors.orange,
                      label: 'Audio',
                      onPressed: () async {
                        // Access Audio Files
                        _selectAudio();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation1, animation2, child) {
        return SlideTransition(
          position:
              Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0))
                  .animate(animation1),
          child: child,
        );
      },
    );
  }

  void showFlowers(BuildContext context) async {
    final selectedImage = await Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return _ImageGridPopup();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset(0.0, 0.0);
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );

    if (selectedImage is String) {
      // Check if selectedImage is a String
      setState(() {
        _messages.add({
          'image': selectedImage,
          'time': TimeOfDay.now().format(context),
          'isMe': true,
        });
      });
    } else {
      // Handle the case where selectedImage is null or not a String
    }
  }

  void showOptionsPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // Dialog will close when tapping outside
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned(
              top: 50, // Adjust the top position as per need
              right: 10, // Align the dialog to the top-right
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 150, // Set width as per your design
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildPopupOption('Edit'),
                      _buildPopupOption('Copy'),
                      _buildPopupOption('Reply'),
                      _buildPopupOption('Delete'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPopupOption(String option) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedOption = option; // Updates the selected option
        });
      },
      child: Container(
        color: selectedOption == option ? blue : Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: Text(
                option,
                style: TextStyle(
                  color: selectedOption == option ? Colors.white : Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(97, 86, 234, 0.09),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_outlined)),
        title: InkWell(
          onTap: () {
            Navigator.pushNamed(context, userProfilePage);
          },
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(widget.profileImage),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    widget.isOnline ? 'Online 2 hrs ago' : 'Offline',
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.call, size: 30),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CallScreen(
                    name: 'Lil Mama',
                    profileImage: 'assets/images/profile_lil_mama.png',
                    callDuration: '10:00',
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.videocam, size: 30),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const VideoCallScreen(
                    name: 'Lil Mama',
                    profileImage: 'assets/images/homeImage.png',
                    callDuration: '10:00',
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, size: 30),
            onPressed: () {
              _showChatPopup(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final messageData = _messages[index];
                  if (messageData['message'] != null) {
                    return _buildMessageBubble(
                      message: messageData['message'],
                      time: messageData['time'],
                      isMe: messageData['isMe'],
                    );
                  } else if (messageData['image'] != null) {
                    return _buildImageBubble(
                      imagePath: messageData['image'],
                      time: messageData['time'],
                      isMe: messageData['isMe'],
                    );
                  } else if (messageData['file'] != null) {
                    return _buildFileBubble(
                      filePath: messageData['file'],
                      time: messageData['time'],
                      isMe: messageData['isMe'],
                    );
                  } else if (messageData.containsKey('audio')) {
                    // Display audio message bubble
                    return AudioBubble(
                      audioPath: messageData['audio'],
                      time: messageData['time'],
                      isMe: messageData['isMe'],
                    );
                  }
                  //  else if (messageData['image2'] != null) {
                  //   return _buildImageBubble2(
                  //     imagePath: messageData['image2'],
                  //     time: messageData['time'],
                  //     isMe: messageData['isMe'],
                  //   );
                  // }

                  return Container(); // Return an empty container if no message or image
                }),
          ),
          _buildMessageInputField(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.03, // 3% of screen width
          right: MediaQuery.of(context).size.width * 0.03,
          top: MediaQuery.of(context).size.height * 0.01, // 1% of screen height
          bottom:
              MediaQuery.of(context).size.height * 0.03, // 3% of screen height
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(97, 86, 234, 0.19),
            borderRadius: BorderRadius.circular(50),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    Theme.of(context).brightness == Brightness.dark
                        ? 'assets/images/icons/homeWhite.png'
                        : 'assets/images/icons/homeBlack.png',
                    width: MediaQuery.of(context).size.width * 0.08,
                    height: MediaQuery.of(context).size.width * 0.08,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    Theme.of(context).brightness == Brightness.dark
                        ? 'assets/images/icons/locationWhite.png'
                        : 'assets/images/icons/localcon.png',
                    width: MediaQuery.of(context).size.width * 0.08,
                    height: MediaQuery.of(context).size.width * 0.08,
                  ),
                  label: 'People Nearby',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    Theme.of(context).brightness == Brightness.dark
                        ? 'assets/images/icons/blueChat.png'
                        : 'assets/images/icons/blueChat.png',
                    width: MediaQuery.of(context).size.width * 0.08,
                    height: MediaQuery.of(context).size.width * 0.08,
                  ),
                  label: 'Chats',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    Theme.of(context).brightness == Brightness.dark
                        ? 'assets/images/icons/matchWhite.png'
                        : 'assets/images/icons/matches.png',
                    width: MediaQuery.of(context).size.width * 0.08,
                    height: MediaQuery.of(context).size.width * 0.08,
                  ),
                  label: 'Matches',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    Theme.of(context).brightness == Brightness.dark
                        ? 'assets/images/icons/profileWhite.png'
                        : 'assets/images/icons/personIcon.png',
                    width: MediaQuery.of(context).size.width * 0.07,
                    height: MediaQuery.of(context).size.width * 0.07,
                  ),
                  label: 'Profile',
                ),
              ],
              selectedLabelStyle: TextStyle(
                color: Colors.black, // Ensure selected text is black
                fontSize: MediaQuery.of(context).size.width * 0.03,
              ),
              unselectedLabelStyle: TextStyle(
                color: Colors.black, // Ensure unselected text is black
                fontSize: MediaQuery.of(context).size.width * 0.03,
              ),
              selectedItemColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white // Dark mode, use white
                  : Colors.black, // Make selected item icon and label black
              unselectedItemColor:
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.white // Dark mode, use white
                      : Colors.black, // Make unselected item icon black
              onTap: (index) {
                // Handle navigation based on the index
                switch (index) {
                  case 0:
                    Navigator.pushNamed(context, homeScreen);

                    break;
                  case 1:
                    Navigator.pushNamed(context, peopleNearbyPage);
                    break;
                  case 2:
                    Navigator.pushNamed(context, mainchat);
                    break;
                  case 3:
                    Navigator.pushNamed(context, likes);
                    break;
                  case 4:
                    Navigator.pushNamed(context, profile);
                    break;
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFileBubble({
    required String filePath,
    required String time,
    required bool isMe,
  }) {
    final screenSize = MediaQuery.of(context).size;
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                OpenFile.open(filePath); // Open file on tap
              },
              child: Container(
                width: screenSize.width * 0.6,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isMe
                      ? const Color.fromRGBO(149, 140, 250, 1)
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(Icons.insert_drive_file,
                        color: isMe ? Colors.white : Colors.black87),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        filePath.split('/').last, // Display the file name
                        style: TextStyle(
                            color: isMe ? Colors.white : Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  time,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble({
    required String message,
    required String time,
    required bool isMe,
    bool isSeen = false,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bubbleWidth = screenWidth * 0.6;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onDoubleTap: () {
                showOptionsPopup(context);
              },
              child: Container(
                width: bubbleWidth, // Set the width to 60% of the screen width
                decoration: BoxDecoration(
                  color: isMe
                      ? const Color.fromRGBO(149, 140, 250, 1)
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(12),
                child: Text(
                  message,
                  style: TextStyle(
                    color: isMe ? Colors.white : Colors.black87,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  time,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                if (isMe && isSeen)
                  const Padding(
                    padding: EdgeInsets.only(left: 4.0),
                    child: Text(
                      'Seen',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInputField() {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              maxLines: 2,
              controller: _messageController,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: 'Message',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: blue,
                    width: 2,
                  ),
                ),
                // prefixIcon: IconButton(
                //   icon: const Icon(Icons.insert_emoticon, color: blue),
                //   onPressed: () {},
                // ),

                // prefixIcon:  IconButton(
                //         icon: const Icon(Icons.insert_emoticon, color: Colors.blue),
                //         onPressed: () {
                //           setState(() {
                //             _isEmojiVisible = !_isEmojiVisible;
                //           });
                //         },
                //       ),

                // prefixIcon: IconButton(
                //   onPressed: () async {
                //     await showModalBottomSheet(
                //       context: context,
                //       builder: (_) => EmojiPicker(
                //         onEmojiSelected: (category, emoji) {
                //           setState(() {
                //             _messageController.text += emoji.emoji;
                //           });
                //         },
                //         config:
                //             const Config(), // Basic config without additional parameters
                //       ),
                //     );
                //   },
                // icon: const Icon(Icons.insert_emoticon, color: Colors.blue),
                // ),

                // prefixIcon: IconButton(
                //   icon:
                //       const Icon(Icons.insert_emoticon, color: Colors.blue),
                //   onPressed: () {
                //     setState(() {
                //       isEmojiPickerVisible = !isEmojiPickerVisible;
                //     });
                //   },
                // ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.local_florist_outlined,
                          color: Colors.pink),
                      onPressed: () {
                        showFlowers(context); // Call showFlowers function
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.attach_file, color: blue),
                      onPressed: () {
                        showAttachmentPopup(context);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.camera_alt_outlined, color: blue),
                      onPressed: () async {
                        // Access Camera
                        PermissionStatus permission =
                            await Permission.camera.request();
                        if (permission.isGranted) {
                          final pickedImage = await ImagePicker()
                              .pickImage(source: ImageSource.camera);
                          if (pickedImage != null) {
                            setState(() {
                              _messages.add({
                                'image': pickedImage.path,
                                'time': TimeOfDay.now().format(context),
                                'isMe': true,
                              });
                            });

                            // print('Camera Image selected: ${pickedImage.path}');
                          }
                        } else {
                          print('Camera permission denied');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),

          IconButton(
            icon: const Icon(Icons.send, color: blue),
            onPressed: _sendMessage,
          ),
          // Voice note button container
          GestureDetector(
            onTap: () {
              showVoiceNote(context);
            },
            child: Container(
              width: screenSize.width * 0.09,
              height: screenSize.height * 0.04,
              decoration: BoxDecoration(
                color: blue,
                borderRadius: BorderRadius.circular(40),
              ),
              child: const Center(
                child: Icon(
                  Icons.mic,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _showChatPopup(BuildContext context) {
  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Dismiss',
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation1, animation2) {
      return Align(
        alignment: Alignment.topRight,
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
            child: Container(
              width: screenWidth * 0.4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        showFontPopup(context);
                      },
                      child: const Text('Change Font Style',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.black)),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Mute Notifications',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.black)),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Search',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.black)),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, reportPage);
                      },
                      child: const Text('Report',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.black)),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    TextButton(
                      onPressed: () {
                        showBlockPopup(context);
                      },
                      child: const Text('Block',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.black)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, animation1, animation2, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0), // Slide in from the right
          end: const Offset(0, 0),
        ).animate(animation1),
        child: child,
      );
    },
  );
}

void showFontPopup(BuildContext context) {
  final screenSize = MediaQuery.of(context).size;

  String? selectedValue = 'Default';

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: SizedBox(
          width: screenSize.width * 0.9,
          height: screenSize.height * 0.4,
          child: Column(
            children: [
              Container(
                color: blue,
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Font Style',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      buildCustomRadioButton(context, 'Default', selectedValue,
                          (String? value) {
                        if (value != null) {
                          selectedValue = value;
                          (context as Element).markNeedsBuild();
                        }
                      }),
                      buildCustomRadioButton(
                          context, 'Italianno', selectedValue, (String? value) {
                        if (value != null) {
                          selectedValue = value;
                          (context as Element).markNeedsBuild();
                        }
                      }),
                      buildCustomRadioButton(context, 'Sanchez', selectedValue,
                          (String? value) {
                        if (value != null) {
                          selectedValue = value;
                          (context as Element).markNeedsBuild();
                        }
                      }),
                      buildCustomRadioButton(context, 'Ranga', selectedValue,
                          (String? value) {
                        if (value != null) {
                          selectedValue = value;
                          (context as Element).markNeedsBuild();
                        }
                      }),
                      buildCustomRadioButton(
                          context, 'Shadow into light', selectedValue,
                          (String? value) {
                        if (value != null) {
                          selectedValue = value;
                          (context as Element).markNeedsBuild();
                        }
                      }),
                      buildCustomRadioButton(
                          context, 'Cherry Swash', selectedValue,
                          (String? value) {
                        if (value != null) {
                          selectedValue = value;
                          (context as Element).markNeedsBuild();
                        }
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

// Helper method to create a custom radio button
Widget buildCustomRadioButton(BuildContext context, String title,
    String? groupValue, Function(String?) onChanged) {
  return GestureDetector(
    onTap: () {
      onChanged(title); // Change the selected value when tapped
    },
    child: Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
          ),
        ),
        Radio<String>(
          value: title,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: blue,
        ),
      ],
    ),
  );
}

void showVoiceNote(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const VoiceNoteDialog();
    },
  );
}

class VoiceNoteDialog extends StatefulWidget {
  const VoiceNoteDialog({super.key});

  @override
  _VoiceNoteDialogState createState() => _VoiceNoteDialogState();
}

class _VoiceNoteDialogState extends State<VoiceNoteDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 200,
        width: 50,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Stop talking To Send',
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            const SizedBox(height: 5),
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(54, 40, 221, 0.19),
                  borderRadius: BorderRadius.circular(40),
                ),
                width: 70,
                height: 75,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: blue,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    width: 55,
                    height: 55,
                    child: const Icon(
                      Icons.mic_none_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text('Try Saying Something',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.black)),
            const SizedBox(height: 5),
            const Text('Listening.........',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.black)),
          ],
        ),
      ),
    );
  }
}

// Widget for attachment options
class AttachmentOption extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onPressed;

  const AttachmentOption({
    super.key,
    required this.icon,
    required this.color,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        children: [
          InkWell(
            onTap: onPressed,
            child: CircleAvatar(
              backgroundColor: color,
              radius: 20,
              child: Icon(icon, color: Colors.white, size: 20),
            ),
          ),
          const SizedBox(height: 5),
          Text(label),
        ],
      ),
    );
  }
}

class _ImageGridPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> imageUrls = [
      'assets/images/flower1.png',
      'assets/images/flower2.png',
      'assets/images/flower3.png',
      'assets/images/flower4.png',
      'assets/images/flower5.png',
      'assets/images/flower6.png',
      'assets/images/flower7.png',
      'assets/images/flower8.png',
      'assets/images/flower9.png',
    ];

    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap:
              () {}, // Prevents the tap inside the container from closing the popup
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.5,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Stickers',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: GridView.builder(
                        itemCount: imageUrls.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // 3 columns
                          crossAxisSpacing: 14.0,
                          mainAxisSpacing: 14.0,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pop(
                                  context,
                                  imageUrls[
                                      index]); // Ensure this returns a String
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0.0),
                              child: Image.asset(
                                imageUrls[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AudioBubble extends StatefulWidget {
  final String audioPath;
  final String time;
  final bool isMe;

  const AudioBubble({
    super.key,
    required this.audioPath,
    required this.time,
    required this.isMe,
  });

  @override
  _AudioBubbleState createState() => _AudioBubbleState();
}

class _AudioBubbleState extends State<AudioBubble> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.setFilePath(widget.audioPath);

    // Listen to the player state to update the play/pause icon
    _audioPlayer.playerStateStream.listen((state) {
      setState(() {
        _isPlaying = state.playing;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlayPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final audioFileName = widget.audioPath.split('/').last;

    return Align(
      alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment:
              widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              width: screenSize.width * 0.6,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: widget.isMe
                    ? const Color.fromRGBO(149, 140, 250, 1)
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      color: widget.isMe ? Colors.white : Colors.black,
                    ),
                    onPressed: _togglePlayPause,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      audioFileName,
                      style: TextStyle(
                        color: widget.isMe ? Colors.white : Colors.black,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.time,
                    style: TextStyle(
                      color: widget.isMe ? Colors.white : Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imagePath;

  const FullScreenImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image(
          image: imagePath.startsWith('assets/')
              ? AssetImage(imagePath) as ImageProvider
              : FileImage(File(imagePath)),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
