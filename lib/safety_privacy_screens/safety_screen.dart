import 'package:love_bird/config/constants.dart';
import 'package:love_bird/config/routes.dart';
import 'package:love_bird/homeScreen/homeScreen.dart';

import 'package:love_bird/safety_privacy_screens/get_help_screen.dart';
import 'package:love_bird/safety_privacy_screens/incognito_mode.dart';
import 'package:love_bird/safety_privacy_screens/privacy_screen.dart';
import 'package:flutter/material.dart';

class SafetyScreen extends StatefulWidget {
  const SafetyScreen({super.key});

  @override
  State<SafetyScreen> createState() => _SafetyScreenState();
}

class _SafetyScreenState extends State<SafetyScreen> {
  // State variables for the first modal
  bool _allowEveryone1 = false;
  bool _allowLiked1 = false;

  // State variables for the second modal
  bool _allowEveryone2 = false;
  bool _allowLiked2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, geminiBot);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Image.asset(
                  "images/ai.png",
                ),
              ),
            ),
            const SizedBox(width: 45),
            const Text(
              'Safety',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15.0),
        children: [
          _buildContainer(
            'images/help.png',
            'Get help from Zenkonect',
            'Send us a message if you have any concerns',
            showArrow: false,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GetHelp()),
              );
            },
          ),
          _buildContainer(
            'images/setting.png',
            'Control your experience',
            'Manage who can see or message you',
            showArrow: true,
            onTap: () {
              _showControlExperienceModal(context);
            },
          ),
          _buildContainer(
            'images/privately.png',
            'Turn on incognito mode',
            'Go invisible to browse privately',
            showArrow: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const IncognitoModeScreen()),
              );
            },
          ),
          _buildContainer(
            'images/help.png',
            'Manage your privacy',
            'Choose what information you share',
            showArrow: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PrivacyScreen()),
              );
            },
          ),
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
                    'assets/images/icons/homeBlack.png',
                    width:
                        MediaQuery.of(context).size.width * 0.08, // 7% of width
                    height: MediaQuery.of(context).size.width * 0.08,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/icons/localcon.png',
                    width: MediaQuery.of(context).size.width * 0.08,
                    height: MediaQuery.of(context).size.width * 0.08,
                  ),
                  label: 'People Nearby',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/icons/chatIcon.png',
                    width: MediaQuery.of(context).size.width * 0.08,
                    height: MediaQuery.of(context).size.width * 0.08,
                  ),
                  label: 'Chats',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/icons/matches.png',
                    width: MediaQuery.of(context).size.width * 0.08,
                    height: MediaQuery.of(context).size.width * 0.08,
                  ),
                  label: 'Matches',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/icons/blueProfile.png',
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

  Widget _buildContainer(String imagePath, String title, String subtitle,
      {bool showArrow = true, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: blue, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              if (showArrow)
                const Opacity(
                  opacity: 0.5,
                  child: Icon(Icons.arrow_forward_ios, color: Colors.black),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showControlExperienceModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            height: 400, // Set a height for the modal
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back_ios,
                              color: Colors.black)),
                      Image.asset("images/who can see your message.png"),
                      const Icon(Icons.close, color: Colors.black),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Who can message you?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  CheckboxListTile(
                    title: const Text('Everyone'),
                    value: _allowEveryone1, // Use the state variable
                    onChanged: (bool? value) {
                      setState(() {
                        _allowEveryone1 = value ?? false; // Update state
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('People I’ve liked'),
                    value: _allowLiked1, // Use the state variable
                    onChanged: (bool? value) {
                      setState(() {
                        _allowLiked1 = value ?? false; // Update state
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'If everyone can message you, you’re more likely to get more matches.',
                    style: TextStyle(fontSize: 11, color: Colors.black),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        '(1/4)',
                        style: TextStyle(color: Colors.black),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _showControllExperienceModal(context);
                        },
                        icon: const Icon(Icons.arrow_forward_ios,
                            color: Colors.black),
                      ),
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

  void _showControllExperienceModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            height: 410, // Set a height for the modal
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back_ios,
                              color: Colors.black)),
                      Image.asset("images/who do you want to chat with.png"),
                      const Icon(Icons.close, color: Colors.black),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Who do you want to chat with?',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  CheckboxListTile(
                    title: const Text('Everyone'),
                    value: _allowEveryone2, // Use the state variable
                    onChanged: (bool? value) {
                      setState(() {
                        _allowEveryone2 = value ?? false; // Update state
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Verified People'),
                    value: _allowLiked2, // Use the state variable
                    onChanged: (bool? value) {
                      setState(() {
                        _allowLiked2 = value ?? false; // Update state
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'When people are verified, it means we’re sure they’re real. This helps us keep Zenkonect safe.',
                    style: TextStyle(fontSize: 11, color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        '(2/4)',
                        style: TextStyle(color: Colors.black),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _showControlllExperienceModal(context);
                        },
                        icon: const Icon(Icons.arrow_forward_ios),
                      ),
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

  void _showControlllExperienceModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            height: 410, // Set a height for the modal
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back_ios,
                              color: Colors.black)),
                      Image.asset("images/When should we notify you.png"),
                      const Icon(Icons.close, color: Colors.black),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'When should we notify you?',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  CheckboxListTile(
                    title: const Text('When i get a message',
                        style: TextStyle(color: Colors.black)),
                    value: _allowEveryone2, // Use the state variable
                    onChanged: (bool? value) {
                      setState(() {
                        _allowEveryone2 = value ?? false; // Update state
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('When i make a match'),
                    value: _allowLiked2, // Use the state variable
                    onChanged: (bool? value) {
                      setState(() {
                        _allowLiked2 = value ?? false; // Update state
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('When someone likes me'),
                    value: _allowLiked2, // Use the state variable
                    onChanged: (bool? value) {
                      setState(() {
                        _allowLiked2 = value ?? false; // Update state
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  // const Text(
                  //   'When people are verified, it means we’re sure they’re real. This helps us keep Zenkonect safe.',
                  //   style: TextStyle(fontSize: 11),
                  // ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text('(3/4)',
                          style: TextStyle(color: Colors.black)),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _showControllllExperienceModal(context);
                        },
                        icon: const Icon(Icons.arrow_forward_ios,
                            color: Colors.black),
                      ),
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

  void _showControllllExperienceModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            height: 410, // Set a height for the modal
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back_ios,
                              color: Colors.black)),
                      Image.asset("images/Want to show when you’re online.png"),
                      const Icon(Icons.close, color: Colors.black),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Want to show when you’re online?',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  CheckboxListTile(
                    title: const Text('Yes'),
                    value: _allowEveryone2, // Use the state variable
                    onChanged: (bool? value) {
                      setState(() {
                        _allowEveryone2 = value ?? false; // Update state
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('No'),
                    value: _allowLiked2, // Use the state variable
                    onChanged: (bool? value) {
                      setState(() {
                        _allowLiked2 = value ?? false; // Update state
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'If you hide when you’re online, you won’t see when other people are online.',
                    style: TextStyle(fontSize: 11, color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        '(4/4)',
                        style: TextStyle(color: Colors.black),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _showControlllllExperienceModal(context);
                        },
                        icon: const Icon(Icons.arrow_forward_ios,
                            color: Colors.black),
                      ),
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

  void _showControlllllExperienceModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            height: 410, // Set a height for the modal
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back_ios,
                              color: Colors.black)),
                      Image.asset("images/You’re all done!.png"),
                      const Icon(Icons.close, color: Colors.black),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'You’re all done!',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'Great - you’re all set for a better experience. Time to make some meaningful and amazing connections.',
                      style: TextStyle(fontSize: 11, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Start Swiping',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    },
                    child: const Text(
                      'Go to Settings',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
