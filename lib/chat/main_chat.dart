import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:love_bird/chat/chat_screen.dart';

import 'package:love_bird/chat/liveChat.dart';
import 'package:love_bird/config/constants.dart';
import 'package:love_bird/config/routes.dart';
import 'package:love_bird/providers/auth_provider.dart';
import 'package:love_bird/providers/story_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import 'dart:math';

class Mainchat extends StatefulWidget {
  const Mainchat({super.key});

  @override
  State<Mainchat> createState() => _MainchatState();
}

class _MainchatState extends State<Mainchat> {
  @override
  void initState() {
    super.initState();
    filteredChatItems = chatItems;
    searchController.addListener(_filterChatItems);
    Future.delayed(Duration.zero, () {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final token = authProvider.accessToken;
      if (token != null) {
        Provider.of<StoryProvider>(context, listen: false).loadStories(token);
      }
    });
  }

  Future<void> _addStory(File file) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final token = authProvider.accessToken;

    if (token == null) {
      // Handle the case where the user is not authenticated
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be logged in to add a story')),
      );
      return;
    }

    try {
      await Provider.of<StoryProvider>(context, listen: false)
          .addStory(token, file);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Story added successfully!')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add story: $error')),
      );
    }
  }

  int _currentIndex = 2;
  List<List<Map<String, String>>> stories = [[]];

  List<Map<String, dynamic>> chatItems = [
    {
      "name": "Lil Mama",
      "message": "Are you available for a call?",
      "imagePath": "assets/images/homeImage.png",
      "isOnline": true
    },
    {
      "name": "Katy Butch",
      "message": "Just saw your profile, let’s chat.",
      "imagePath": "assets/images/homeImage.png",
      "isOnline": false
    },
  ];
  List<int> selectedChatIndexes = [];
  bool isSearchVisible = false;

  List<Map<String, dynamic>> filteredChatItems = [];
  TextEditingController searchController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   filteredChatItems = chatItems;
  //   searchController.addListener(_filterChatItems);
  // }

  void _filterChatItems() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredChatItems = chatItems
          .where((chat) => chat["name"].toLowerCase().contains(query))
          .toList();

      filteredChatItems.sort((a, b) {
        final nameA = a["name"].toLowerCase();
        final nameB = b["name"].toLowerCase();
        final startsWithQueryA = nameA.startsWith(query);
        final startsWithQueryB = nameB.startsWith(query);

        if (startsWithQueryA && !startsWithQueryB) return -1;
        if (!startsWithQueryA && startsWithQueryB) return 1;

        // If both start with the query or both don't, sort by appearance in name
        return nameA.indexOf(query).compareTo(nameB.indexOf(query));
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'Chats',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, size: 30),
          onPressed: () {
            setState(() {
              isSearchVisible = !isSearchVisible;
            });
            if (isSearchVisible) {
              searchController.clear();
            }
          },
        ),
        if (selectedChatIndexes.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              _confirmDelete(context);
            },
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
            child: Column(
              children: [
                if (isSearchVisible)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        controller: searchController,
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          hintText: 'Search by name',
                          hintStyle: TextStyle(
                            color: Theme.of(context).hintColor,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: blue,
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: blue,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('Likes And Matches',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 5),
                // Consumer<StoryProvider>(
                //   builder: (context, storyProvider, child) {
                //     return SizedBox(
                //       height: 100,
                //       child: ListView(
                //         scrollDirection: Axis.horizontal,
                //         children: [
                //           // Add Story Button
                //           GestureDetector(
                //             onTap: () => _showAddStatusOptions(context),
                //             child: profileAvatarMain(
                //                 "Add Story", "assets/images/homeImage.png"),
                //           ),

                //           // Show loading indicator if loading
                //           if (storyProvider.isLoading)
                //             const Center(child: CircularProgressIndicator())

                //           // Show stories if available
                //           else if (storyProvider.stories.isNotEmpty)
                //             ...storyProvider.stories.map((story) {
                //               return GestureDetector(
                //                 onTap: () {
                //                   Navigator.push(
                //                     context,
                //                     MaterialPageRoute(
                //                       builder: (context) => StoryViewerScreen(
                //                         storyPaths: story[
                //                             'media'], // Pass media list to StoryViewerScreen
                //                       ),
                //                     ),
                //                   );
                //                 },
                //                 child: profileAvatarMainStory(
                //                   "Your Story",
                //                   story['media'][
                //                       0], // Assuming 'media' contains URLs or paths to images
                //                 ),
                //               );
                //             }).toList(),
                //         ],
                //       ),
                //     );
                //   },
                // ),

              Consumer<StoryProvider>(
                  builder: (context, storyProvider, child) {
                    return SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          // Show "Add Story" if no stories exist
                          if (storyProvider.stories.isEmpty)
                            GestureDetector(
                              onTap: () => _showAddStatusOptions(context),
                              child: profileAvatarMain(
                                  "Add Story", "assets/images/homeImage.png"),
                            )
                          else
                            // Show stories if available
                            ...storyProvider.stories.map((story) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => StoryViewerScreen(
                                          storyPaths: story[
                                              'media'], // Pass media list to StoryViewerScreen
                                        ),
                                      ),
                                    );
                                  },
                                  child:

                                      // profileAvatarMainStory(
                                      //   "Your Story",
                                      //   story['media'][0], true, // Assuming 'media' contains URLs or paths to images
                                      // ),

                                      profileAvatarMainStory(
                                    "Your Story",
                                    story['media'][0],
                                    storyProvider.stories
                                        .isNotEmpty, // Ensuring this updates correctly
                                  ));
                            }).toList(),

                          // Show loading indicator if loading
                          if (storyProvider.isLoading)
                            const Center(child: CircularProgressIndicator()),
                        ],
                      ),
                    );
                  },
                ),

                const Divider(
                  thickness: 1,
                  color: Color(0xFF3628DD),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Messages",
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                loveChatItem("Zenkonect", "You have 3 new messages!", true),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredChatItems.length,
                    itemBuilder: (context, index) {
                      final chat = filteredChatItems[index];
                      return chatItem(
                        context,
                        index: index,
                        name: chat["name"],
                        message: chat["message"],
                        imagePath: chat["imagePath"],
                        isOnline: chat["isOnline"],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 20,
              right: 40,
              child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, chatbotWelcomeScreen);
                  },
                  child: Image.asset('assets/images/robot.png'))),
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
              currentIndex: _currentIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, size: 28), // Home icon
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.location_on, size: 28), // Location icon
                  label: 'People Nearby',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat, size: 28), // Chat icon
                  label: 'Chats',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite, size: 28), // Matches icon
                  label: 'Matches',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person, size: 28), // Profile icon
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
              selectedItemColor:
                  blue, // Make selected item icon and label black
              unselectedItemColor:
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.white // Dark mode, use white
                      : Colors.black,
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

  Widget profileAvatar(
      String name, String imagePath, bool isOnline, bool story) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Column(
        children: [
          Stack(
            children: [
              if (story)
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, storyPage);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(35),
                    ),
                    padding: const EdgeInsets.all(1.5),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(imagePath),
                      ),
                    ),
                  ),
                )
              else
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35),
                  ),
                  padding: const EdgeInsets.all(1.5),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(imagePath),
                    ),
                  ),
                ),
              if (isOnline)
                Positioned(
                  right: 9,
                  bottom: 2,
                  child: Container(
                    height: 12,
                    width: 12,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget loveChatItem(
    String name,
    String message,
    bool chat,
  ) {
    return ListTile(
      leading: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22.0),
            child: Image.asset('assets/images/icons/lovechat.png'),
          ),
          if (chat) // Red container when chat is true
            Positioned(
              top: 0,
              right: 0.0, // Matches the padding of the image
              child: Container(
                width: 10, // Adjust size as needed
                height: 10,

                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
      title: Text(name,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              )),
      subtitle: Text(
        chat ? 'No new messages' : message,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LiveChatScreen()),
              );
            },
            child: Image.asset('assets/images/icons/live.png'),
          ),
          Text(
            'Live',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Conversation'),
          content: const Text(
              'Are you sure you want to delete selected conversations?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                setState(() {
                  selectedChatIndexes.sort((a, b) => b.compareTo(a));
                  for (var index in selectedChatIndexes) {
                    chatItems.removeAt(index);
                  }
                  selectedChatIndexes.clear(); // Clear selections
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget chatItem(BuildContext context,
      {required int index,
      required String name,
      required String message,
      required String imagePath,
      required bool isOnline}) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          if (selectedChatIndexes.contains(index)) {
            selectedChatIndexes.remove(index);
          } else {
            selectedChatIndexes.add(index);
          }
        });
      },
      child: Container(
        color: selectedChatIndexes.contains(index)
            ? Colors.blue.withOpacity(0.3)
            : Colors.transparent,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(imagePath),
          ),
          title: Text(
            name,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          subtitle: Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
          ),
          onTap: () {
            if (selectedChatIndexes.isEmpty) {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ChatDetailScreen(
              //       name: name,
              //       profileImage: imagePath,
              //       lastMessage: message,
              //     ),
              //   ),
              // );
            } else {
              setState(() {
                if (selectedChatIndexes.contains(index)) {
                  selectedChatIndexes.remove(index);
                } else {
                  selectedChatIndexes.add(index);
                }
              });
            }
          },
        ),
      ),
    );
  }

  Widget profileAvatarMain(String name, String imagePath) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 34,
                backgroundImage: AssetImage(imagePath),
              ),
              Positioned(
                right: 6,
                bottom: 0,
                child: GestureDetector(
                  onTap: () {
                    _showAddStatusOptions(context);
                  },
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: const BoxDecoration(
                      color: blue,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(name, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  // Widget profileAvatarMainStory(String name, String imagePath) {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 8, right: 8),
  //     child: Column(
  //       children: [
  //         Stack(
  //           children: [
  //             // Container to add a red circular border

  //             Container(
  //               decoration: BoxDecoration(
  //                 color: Colors.red,
  //                 borderRadius: BorderRadius.circular(35),
  //               ),
  //               padding: const EdgeInsets.all(1.5),
  //               child: Container(
  //                 padding: const EdgeInsets.all(4),
  //                 decoration: const BoxDecoration(
  //                   color: Colors.white,
  //                   shape: BoxShape.circle,
  //                 ),
  //                 child: CircleAvatar(
  //                   radius:
  //                       30, // Half of container's height/width for centering
  //                   backgroundImage: AssetImage(imagePath),
  //                 ),
  //               ),
  //             ),
  //             Positioned(
  //               right: 6,
  //               bottom: 0,
  //               child: GestureDetector(
  //                 onTap: () {
  //                   _showAddStatusOptions(context);
  //                 },
  //                 child: Container(
  //                   height: 20,
  //                   width: 20,
  //                   decoration: const BoxDecoration(
  //                     color: blue,
  //                     shape: BoxShape.circle,
  //                   ),
  //                   child: const Center(
  //                     child: Icon(
  //                       Icons.add,
  //                       color: Colors.white,
  //                       size: 15,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: 4),
  //         Text(name, style: const TextStyle(fontSize: 12)),
  //       ],
  //     ),
  //   );
  // }

  Widget profileAvatarMainStory(String name, String imagePath, bool hasStory) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: [
          Stack(
            children: [
              // Container to add a red circular border
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(35),
                ),
                padding: const EdgeInsets.all(1.5),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius:
                        30, // Half of container's height/width for centering
                    backgroundImage: AssetImage(imagePath),
                  ),
                ),
              ),

              // Show "Add" button only if the user has no story
              if (!hasStory)
                Positioned(
                  right: 6,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () {
                      _showAddStatusOptions(context);
                    },
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: const BoxDecoration(
                        color: blue,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(name, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  void _showAddStatusOptions(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    // final storyProvider = Provider.of<StoryProvider>(context, listen: false);
    // final authProvider = Provider.of<AuthProvider>(context,
    // listen: false); // Assuming AuthProvider stores token
    // String token = authProvider.accessToken ?? '';

    showModalBottomSheet(
      context: context,
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
      builder: (context) {
        return SizedBox(
          height: screenSize.height * 0.35,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt,color: isDarkMode ? Colors.white : Colors.black),
                title: Text('Take a photo', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),),
                onTap: () async {
                  final pickedFile =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    File imageFile = File(pickedFile.path);
                    await _addStory(
                        imageFile); // Use _addStory instead of storyProvider.addStory
                  }
                  // if (pickedFile != null) {
                  //   File imageFile = File(pickedFile.path);
                  //   await storyProvider.addStory(
                  //       token, imageFile); // Pass the single image here
                  // }
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.image, color: isDarkMode ? Colors.white : Colors.black),
                title: Text('Choose from gallery', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),),
                onTap: () async {
                  final pickedFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    File imageFile = File(pickedFile.path);
                    await _addStory(imageFile); // Pass the single image here
                  }
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.video_library, color: isDarkMode ? Colors.white : Colors.black),
                title: Text('Choose a video', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),),
                onTap: () async {
                  final pickedFile = await ImagePicker()
                      .pickVideo(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      if (stories.isEmpty) {
                        stories.add([
                          {'type': 'video', 'path': pickedFile.path}
                        ]);
                      } else {
                        stories[0]
                            .add({'type': 'video', 'path': pickedFile.path});
                      }
                    });
                  }
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.cancel, color: isDarkMode ? Colors.white : Colors.black),
                title: Text('Cancel', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class StoryViewerScreen extends StatefulWidget {
  final List<Map<String, String>> storyPaths;

  const StoryViewerScreen({
    super.key,
    required this.storyPaths,
  });

  @override
  // ignore: library_private_types_in_public_api
  _StoryViewerScreenState createState() => _StoryViewerScreenState();
}

class _StoryViewerScreenState extends State<StoryViewerScreen> {
  int _currentStoryIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _showNextStory() {
    if (_currentStoryIndex < widget.storyPaths.length - 1) {
      setState(() {
        _currentStoryIndex++;
      });
    } else {
      Navigator.pop(context);
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentStoryIndex = index;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Story'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.storyPaths.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      width: 10.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: _currentStoryIndex == index ? blue : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: _showNextStory,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.storyPaths.length,
                    onPageChanged: _onPageChanged,
                    itemBuilder: (context, index) {
                      final media = widget.storyPaths[index];
                      if (media['type'] == 'image') {
                        return Image.file(
                          File(media['path']!),
                          fit: BoxFit.cover,
                        );
                      } else if (media['type'] == 'video') {
                        return VideoPlayerWidget(videoPath: media['path']!);
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20.0,
            left: 0,
            right: 0,
            child: Center(
              child: InkWell(
                onTap: () {
                  showViewsPopup(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: blue,
                  ),
                  height: screenSize.height * 0.05,
                  width: screenSize.width * 0.25,
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const Text(
                        'Views',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors
                              .white, // Ensures visibility on darker images
                        ),
                      ),
                      SizedBox(width: screenSize.width * 0.01),
                      const Icon(Icons.remove_red_eye_outlined,
                          color: Colors.white // Heart color
                          ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoPath;

  const VideoPlayerWidget({super.key, required this.videoPath});

  @override
  // ignore: library_private_types_in_public_api
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : const Center(child: CircularProgressIndicator());
  }
}

void showViewsPopup(BuildContext context) {
  // const Color blue = Color.fromRGBO(54, 40, 221, 1.0);

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    builder: (BuildContext context) {
      final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;

      return Container(
          padding: EdgeInsets.only(
            top: screenHeight * 0.02, // 2% of screen height
            left: screenWidth * 0.05, // 5% of screen width
            right: screenWidth * 0.05,
          ),
          height: screenHeight * 0.4, // 40% of screen height
          child: const Center(child: Text('No views yet')));
    },
  );
}

class HeartAnimationScreen extends StatefulWidget {
  const HeartAnimationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HeartAnimationScreenState createState() => _HeartAnimationScreenState();
}

class _HeartAnimationScreenState extends State<HeartAnimationScreen> {
  final List<Widget> _hearts = [];

  void _showHearts() {
    setState(() {
      for (int i = 0; i < 10; i++) {
        _hearts.add(_buildHeart());
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _hearts.clear(); // Clear hearts after animation
      });
    });
  }

  Widget _buildHeart() {
    final random = Random();
    final duration =
        Duration(milliseconds: 3000 + random.nextInt(1000)); // Longer duration
    final startX = MediaQuery.of(context).size.width * 0.5 +
        random.nextDouble() *
            MediaQuery.of(context).size.width *
            0.5; // Center to right
    final size = 20.0 + random.nextDouble() * 20.0; // Heart size variation
    final rotation = random.nextDouble() * 0.5 - 0.25; // Random slight rotation

    return Positioned(
      bottom: 50,
      left: startX,
      child: AnimatedHeart(
        duration: duration,
        endY: MediaQuery.of(context).size.height * 0.5 +
            random.nextDouble() * 200,
        size: size,
        rotation: rotation,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _showHearts,
        child: Stack(
          children: [
            const Positioned.fill(
              child: Center(
                child: Text(
                  'Tap to send hearts',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            ..._hearts,
          ],
        ),
      ),
    );
  }
}

class AnimatedHeart extends StatefulWidget {
  final Duration duration;
  final double endY;
  final double size;
  final double rotation;

  const AnimatedHeart({
    super.key,
    required this.duration,
    required this.endY,
    required this.size,
    required this.rotation,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedHeartState createState() => _AnimatedHeartState();
}

class _AnimatedHeartState extends State<AnimatedHeart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _positionAnimation;
  late final Animation<double> _opacityAnimation;
  late final double _startY;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _startY = 0;

    _positionAnimation =
        Tween<double>(begin: _startY, end: widget.endY).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
    _opacityAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.translate(
            offset: Offset(0, -_positionAnimation.value),
            child: Transform.rotate(
              angle: widget.rotation,
              child: child,
            ),
          ),
        );
      },
      child: Icon(
        Icons.favorite,
        color: Colors.pink,
        size: widget.size,
      ),
    );
  }
}
