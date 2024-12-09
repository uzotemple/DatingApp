// import 'package:flutter/material.dart';
// import 'package:story/story_image.dart';
// import 'package:story/story_page_view.dart';

// class UserModel {
//   UserModel(this.stories, this.userName, this.imageUrl);

//   final List<StoryModel> stories;
//   final String userName;
//   final String imageUrl;
// }

// class StoryModel {
//   StoryModel(this.imageUrl);

//   final String imageUrl;
// }

// final sampleUsers = [
//   UserModel([
//     StoryModel("assets/images/homeImage.png"),
//     StoryModel("assets/images/avatar1.png"),
//     StoryModel("assets/images/avatar2.png"),
//     StoryModel("assets/images/avatar3.png"),
//   ], "User1", "assets/images/homeImage.png"),
//   UserModel([
//     StoryModel("assets/images/homeImage.png"),
//   ], "User2", "assets/images/homeImage.png"),
//   UserModel([
//     StoryModel("assets/images/homeImage.png"),
//     StoryModel("assets/images/homeImage.png"),
//     StoryModel("assets/images/homeImage.png"),
//   ], "User3", "assets/images/homeImage.png"),
// ];

// class StoryPage extends StatefulWidget {
//   const StoryPage({super.key});

//   @override
//   _StoryPageState createState() => _StoryPageState();
// }

// class _StoryPageState extends State<StoryPage> {
//   late ValueNotifier<IndicatorAnimationCommand> indicatorAnimationController;

//   @override
//   void initState() {
//     super.initState();
//     indicatorAnimationController = ValueNotifier<IndicatorAnimationCommand>(
//         IndicatorAnimationCommand.resume);
//   }

//   @override
//   void dispose() {
//     indicatorAnimationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StoryPageView(
//         itemBuilder: (context, pageIndex, storyIndex) {
//           final user = sampleUsers[pageIndex];
//           final story = user.stories[storyIndex];
//           return Stack(
//             children: [
//               Positioned.fill(
//                 child: Container(color: Colors.black),
//               ),
//               Positioned.fill(
//                 child: StoryImage(
//                   key: ValueKey(story.imageUrl),
//                   imageProvider: AssetImage(
//                     story.imageUrl,
//                   ),
//                   fit: BoxFit.fitWidth,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 44, left: 8),
//                 child: Row(
//                   children: [
//                     // Circular Image
//                     Container(
//                       height: 32,
//                       width: 32,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage(user.imageUrl),
//                           fit: BoxFit.cover,
//                         ),
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 8,
//                     ),
//                     // Combine Username and Time into a single row
//                     Expanded(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text(
//                             user.userName,
//                             style: const TextStyle(
//                               fontSize: 17,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                           const Text(
//                             "10 minutes ago",
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//         gestureItemBuilder: (context, pageIndex, storyIndex) {
//           return Stack(children: [
//             Align(
//               alignment: Alignment.topRight,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 32),
//                 child: IconButton(
//                   padding: EdgeInsets.zero,
//                   color: Colors.white,
//                   icon: const Icon(Icons.close),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//             ),
//             // Center(
//             //   child: ElevatedButton(
//             //     child: const Text('show modal bottom sheet'),
//             //     onPressed: () async {
//             //       indicatorAnimationController.value =
//             //           IndicatorAnimationCommand.pause;
//             //       await showModalBottomSheet(
//             //         context: context,
//             //         builder: (context) => SizedBox(
//             //           height: MediaQuery.of(context).size.height / 2,
//             //           child: Padding(
//             //             padding: const EdgeInsets.all(24),
//             //             child: Text(
//             //               'Look! The indicator is now paused\n\n'
//             //               'It will be coutinued after closing the modal bottom sheet.',
//             //               style: Theme.of(context).textTheme.headlineSmall,
//             //               textAlign: TextAlign.center,
//             //             ),
//             //           ),
//             //         ),
//             //       );
//             //       indicatorAnimationController.value =
//             //           IndicatorAnimationCommand.resume;
//             //     },
//             //   ),
//             // ),
//             TextField(
//           focusNode: _textFieldFocusNode,
//           decoration: InputDecoration(
//             labelText: 'Type something',
//             hintText: 'Click to pause the indicator',
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//         ),
//           ]);
//         },
//         indicatorAnimationController: indicatorAnimationController,
//         initialStoryIndex: (pageIndex) {
//           if (pageIndex == 0) {
//             return 1;
//           }
//           return 0;
//         },
//         pageLength: sampleUsers.length,
//         storyLength: (int pageIndex) {
//           return sampleUsers[pageIndex].stories.length;
//         },
//         onPageLimitReached: () {
//           Navigator.pop(context);
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:story/story_image.dart';
import 'package:story/story_page_view.dart';

class UserModel {
  UserModel(this.stories, this.userName, this.imageUrl);

  final List<StoryModel> stories;
  final String userName;
  final String imageUrl;
}

class StoryModel {
  StoryModel(this.imageUrl);

  final String imageUrl;
}

final sampleUsers = [
  UserModel([StoryModel("assets/images/homeImage.png")], "User1",
      "assets/images/homeImage.png"),
  UserModel([StoryModel("assets/images/avatar1.png")], "User2",
      "assets/images/avatar1.png"),
  UserModel([StoryModel("assets/images/avatar2.png")], "User3",
      "assets/images/avatar2.png"),
];

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  late ValueNotifier<IndicatorAnimationCommand> indicatorAnimationController;
  final FocusNode _textFieldFocusNode = FocusNode();
  bool isLoved = false;

  @override
  void initState() {
    super.initState();
    indicatorAnimationController = ValueNotifier<IndicatorAnimationCommand>(
        IndicatorAnimationCommand.resume);

    _textFieldFocusNode.addListener(() {
      if (_textFieldFocusNode.hasFocus) {
        // Pause animation when TextField is focused
        indicatorAnimationController.value = IndicatorAnimationCommand.pause;
      } else {
        // Resume animation when TextField loses focus
        indicatorAnimationController.value = IndicatorAnimationCommand.resume;
      }
    });
  }

  @override
  void dispose() {
    indicatorAnimationController.dispose();
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
              child: StoryPageView(
                itemBuilder: (context, pageIndex, storyIndex) {
                  final user = sampleUsers[pageIndex];
                  final story = user.stories[storyIndex];
                  return Stack(
                    children: [
                      Positioned.fill(
                        child: Container(color: Colors.black),
                      ),
                      Positioned.fill(
                        child: StoryImage(
                          key: ValueKey(story.imageUrl),
                          imageProvider: AssetImage(story.imageUrl),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 44, left: 8),
                        child: Row(
                          children: [
                            // Circular Image
                            Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(user.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            // Combine Username and Time into a single row
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    user.userName,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    "10 minutes ago",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                gestureItemBuilder: (context, pageIndex, storyIndex) {
                  return Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        color: Colors.white,
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  );
                },
                indicatorAnimationController: indicatorAnimationController,
                initialStoryIndex: (pageIndex) {
                  return 0;
                },
                pageLength: sampleUsers.length,
                storyLength: (pageIndex) {
                  return sampleUsers[pageIndex].stories.length;
                },
                onPageLimitReached: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Positioned(
              bottom: 30,
              left: 20,
              right: 16,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      focusNode: _textFieldFocusNode,
                      decoration: InputDecoration(
                        hintText: 'Tap to pause the indicator',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _textController.text.isNotEmpty
                          ? Icons.send // Show send icon when text is not empty
                          : Icons.favorite, // Show heart icon otherwise
                    ),
                    color: _textController.text.isNotEmpty
                        ? Colors.blue // Blue for send icon
                        : (isLoved
                            ? Colors.red
                            : Colors.grey), // Heart icon color
                    onPressed: () {
                      if (_textController.text.isNotEmpty) {
                        // If send icon is shown, clear the text
                        setState(() {
                          _textController.clear(); // Clear the text field
                        });
                      } else {
                        // Toggle heart icon
                        setState(() {
                          isLoved = !isLoved;
                        });
                      }
                    },
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
