// import 'package:flutter/material.dart';
// import 'package:love_bird/config/constants.dart';

// class VoiceNoteDialog extends StatefulWidget {
//   const VoiceNoteDialog({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _VoiceNoteDialogState createState() => _VoiceNoteDialogState();
// }

// class _VoiceNoteDialogState extends State<VoiceNoteDialog>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 1),
//       vsync: this,
//     )..repeat(reverse: true);

//     _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(_controller);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Container(
//         height: 200,
//         width: 50,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//         ),
        
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text('Stop talking To Send',
//                 style: TextStyle(
//                     fontSize: 11,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black)),
//             const SizedBox(height: 5),
//             ScaleTransition(
//               scale: _scaleAnimation,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: const Color.fromRGBO(54, 40, 221, 0.19),
//                   borderRadius: BorderRadius.circular(40),
//                 ),
//                 width: 70,
//                 height: 75,
//                 child: Center(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: blue, // Ensure this color is defined
//                       borderRadius: BorderRadius.circular(40),
//                     ),
//                     width: 55,
//                     height: 55,
//                     child: const Icon(
//                       Icons.mic_none_outlined,
//                       color: Colors.white,
//                       size: 30,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Text('Try Saying Something',
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 10,
//                     color: Colors.black)),
//             const SizedBox(height: 5),
//             const Text('Listening.........',
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 10,
//                     color: Colors.black)),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:love_bird/config/constants.dart';
// import 'package:record/record.dart'; // Ensure this import is correct
// import 'package:path_provider/path_provider.dart';

// class VoiceNoteDialog extends StatefulWidget {
//   const VoiceNoteDialog({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _VoiceNoteDialogState createState() => _VoiceNoteDialogState();
// }

// class _VoiceNoteDialogState extends State<VoiceNoteDialog>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//   final AudioRecorder _audioRecorder = AudioRecorder(); // Use AudioRecorder instead of Record
//   bool _isRecording = false;
//   String? _audioPath;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 1),
//       vsync: this,
//     )..repeat(reverse: true);

//     _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(_controller);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _audioRecorder.dispose(); // Dispose the recorder
//     super.dispose();
//   }

//   Future<void> _startRecording() async {
//     try {
//       if (await _audioRecorder.hasPermission()) {
//         final directory = await getApplicationDocumentsDirectory();
//         final path = '${directory.path}/recording.m4a';
//         await _audioRecorder.start(const RecordConfig(), path: path); // Use RecordConfig
//         setState(() {
//           _isRecording = true;
//           _audioPath = path;
//         });
//       }
//     } catch (e) {
//       print("Error starting recording: $e");
//     }
//   }

//   Future<void> _stopRecording() async {
//     try {
//       await _audioRecorder.stop();
//       setState(() {
//         _isRecording = false;
//       });
//       // Here you can add logic to send the audio file
//       _sendAudio();
//     } catch (e) {
//       print("Error stopping recording: $e");
//     }
//   }

//   void _sendAudio() {
//     if (_audioPath != null) {
//       // Implement your logic to send the audio file
//       print("Audio file path: $_audioPath");
//       // For example, you can upload the file to a server or share it via a message
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       child: Container(
//         height: 200,
//         width: 50,
//         color: Colors.white,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text('Stop talking To Send',
//                 style: TextStyle(
//                     fontSize: 11,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black)),
//             const SizedBox(height: 5),
//             ScaleTransition(
//               scale: _scaleAnimation,
//               child: GestureDetector(
//                 onTap: () {
//                   if (_isRecording) {
//                     _stopRecording();
//                   } else {
//                     _startRecording();
//                   }
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: const Color.fromRGBO(54, 40, 221, 0.19),
//                     borderRadius: BorderRadius.circular(40),
//                   ),
//                   width: 70,
//                   height: 75,
//                   child: Center(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: blue, // Ensure this color is defined
//                         borderRadius: BorderRadius.circular(40),
//                       ),
//                       width: 55,
//                       height: 55,
//                       child: Icon(
//                         _isRecording ? Icons.stop : Icons.mic_none_outlined,
//                         color: Colors.white,
//                         size: 30,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               _isRecording ? 'Recording...' : 'Try Saying Something',
//               style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 10,
//                   color: Colors.black),
//             ),
//             const SizedBox(height: 5),
//             Text(
//               _isRecording ? 'Listening.........' : 'Tap to start recording',
//               style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 10,
//                   color: Colors.black),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:love_bird/config/constants.dart';
// import 'package:record/record.dart';
// import 'package:path_provider/path_provider.dart';

// class VoiceNoteDialog extends StatefulWidget {
//   const VoiceNoteDialog({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _VoiceNoteDialogState createState() => _VoiceNoteDialogState();
// }

// class _VoiceNoteDialogState extends State<VoiceNoteDialog>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//   final AudioRecorder _audioRecorder = AudioRecorder();
//   bool _isRecording = false;
//   bool _cancelRecording = false;
//   String? _audioPath;
//   Offset _initialTouchPosition = Offset.zero;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 1),
//       vsync: this,
//     )..repeat(reverse: true);

//     _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(_controller);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _audioRecorder.dispose();
//     super.dispose();
//   }

//   Future<void> _startRecording() async {
//     try {
//       bool hasPermission = await _audioRecorder.hasPermission();
//       if (!hasPermission) {
//         print("Permission denied");
//         return;
//       }

//       final directory = await getApplicationDocumentsDirectory();
//       final path = '${directory.path}/voice_note_${DateTime.now().millisecondsSinceEpoch}.m4a';

//       await _audioRecorder.start(const RecordConfig(), path: path); // FIXED
//       setState(() {
//         _isRecording = true;
//         _cancelRecording = false;
//         _audioPath = path;
//       });
//     } catch (e) {
//       print("Error starting recording: $e");
//     }
//   }

//   Future<void> _stopRecording({bool cancel = false}) async {
//     try {
//       if (!_isRecording) return;

//       setState(() {
//         _isRecording = false;
//         _cancelRecording = cancel;
//       });

//       await _audioRecorder.stop();

//       if (!cancel && _audioPath != null) {
//         _sendAudio(_audioPath!);
//       } else {
//         print("Recording canceled");
//       }
//     } catch (e) {
//       print("Error stopping recording: $e");
//     }
//   }

//   void _sendAudio(String path) {
//   if (File(path).existsSync()) {
//     print("Audio file path: $path");

//     // Notify chat screen (use Provider, Stream, or direct callback)
//     Navigator.pop(context, path); // This sends the file path back to the chat screen
//   } else {
//     print("Error: Audio file does not exist.");
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       child: Container(
//         height: 300,
//         width: 30,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(30)
//         ),
        
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text('Hold to Record, Release to Send',
//                 style: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black)),
//             const SizedBox(height: 10),
//             ScaleTransition(
//               scale: _scaleAnimation,
//               child: GestureDetector(
//                 onLongPressStart: (details) {
//                   _initialTouchPosition = details.globalPosition;
//                   _startRecording();
//                 },
//                 onLongPressMoveUpdate: (details) {
//                   if (details.globalPosition.dy < _initialTouchPosition.dy - 100) {
//                     setState(() {
//                       _cancelRecording = true;
//                     });
//                   }
//                 },
//                 onLongPressEnd: (details) {
//                   _stopRecording(cancel: _cancelRecording);
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: _cancelRecording
//                         ? Colors.red.withOpacity(0.3)
//                         : const Color.fromRGBO(54, 40, 221, 0.19),
//                     borderRadius: BorderRadius.circular(40),
//                   ),
//                   width: 70,
//                   height: 75,
//                   child: Center(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: _cancelRecording ? Colors.red : blue,
//                         borderRadius: BorderRadius.circular(40),
//                       ),
//                       width: 55,
//                       height: 55,
//                       child: Icon(
//                         _isRecording ? Icons.mic : Icons.mic_none_outlined,
//                         color: Colors.white,
//                         size: 30,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               _isRecording
//                   ? _cancelRecording
//                       ? 'Slide up to cancel'
//                       : 'Recording...'
//                   : 'Hold to talk',
//               style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 13,
//                   color: Colors.black),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:love_bird/config/constants.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:just_audio/just_audio.dart';

class VoiceNoteDialog extends StatefulWidget {
  const VoiceNoteDialog({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VoiceNoteDialogState createState() => _VoiceNoteDialogState();
}

class _VoiceNoteDialogState extends State<VoiceNoteDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  final AudioRecorder _audioRecorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isRecording = false;
  bool _cancelRecording = false;
  bool _isPlaying = false;
  String? _audioPath;
  Offset _initialTouchPosition = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(_controller);

    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        setState(() {
          _isPlaying = false; // Stop playing when the audio finishes
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioRecorder.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _startRecording() async {
    try {
      bool hasPermission = await _audioRecorder.hasPermission();
      if (!hasPermission) {
        print("Permission denied");
        return;
      }

      final directory = await getApplicationDocumentsDirectory();
      final path =
          '${directory.path}/voice_note_${DateTime.now().millisecondsSinceEpoch}.m4a';

      await _audioRecorder.start(const RecordConfig(), path: path);
      setState(() {
        _isRecording = true;
        _cancelRecording = false;
        _audioPath = path;
      });
    } catch (e) {
      print("Error starting recording: $e");
    }
  }

  Future<void> _stopRecording({bool cancel = false}) async {
    try {
      if (!_isRecording) return;

      setState(() {
        _isRecording = false;
        _cancelRecording = cancel;
      });

      await _audioRecorder.stop();

      if (!cancel && _audioPath != null) {
        _sendAudio(_audioPath!);
      } else {
        print("Recording canceled");
      }
    } catch (e) {
      print("Error stopping recording: $e");
    }
  }

  void _sendAudio(String path) {
    if (File(path).existsSync()) {
      print("Audio file path: $path");
      Navigator.pop(context, path);
    } else {
      print("Error: Audio file does not exist.");
    }
  }

  Future<void> _playAudio() async {
    if (_audioPath == null || !File(_audioPath!).existsSync()) return;

    try {
      await _audioPlayer.setFilePath(_audioPath!);
      await _audioPlayer.play();
      setState(() {
        _isPlaying = true;
      });
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  Future<void> _stopAudio() async {
    await _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 300,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Hold to Record, Release to Send',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            ScaleTransition(
              scale: _scaleAnimation,
              child: GestureDetector(
                onLongPressStart: (details) {
                  _initialTouchPosition = details.globalPosition;
                  _startRecording();
                },
                onLongPressMoveUpdate: (details) {
                  if (details.globalPosition.dy < _initialTouchPosition.dy - 100) {
                    setState(() {
                      _cancelRecording = true;
                    });
                  }
                },
                onLongPressEnd: (details) {
                  _stopRecording(cancel: _cancelRecording);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: _cancelRecording
                        ? Colors.red.withOpacity(0.3)
                        : const Color.fromRGBO(54, 40, 221, 0.19),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  width: 70,
                  height: 75,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: _cancelRecording ? Colors.red : blue,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      width: 55,
                      height: 55,
                      child: Icon(
                        _isRecording ? Icons.mic : Icons.mic_none_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _isRecording
                  ? _cancelRecording
                      ? 'Slide up to cancel'
                      : 'Recording...'
                  : 'Hold to talk',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            if (_audioPath != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      _isPlaying ? Icons.stop : Icons.play_arrow,
                      color: Colors.blue,
                    ),
                    onPressed: _isPlaying ? _stopAudio : _playAudio,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Play Audio",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
