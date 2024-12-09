import 'package:flutter/material.dart';
import 'package:love_bird/config/constants.dart';
import 'package:love_bird/config/routes.dart';
import 'package:love_bird/edit%20profile%20screens/edit_low_profile_screen.dart';

import 'package:love_bird/setting_screen/setting_screen.dart';
import 'package:love_bird/safety_privacy_screens/safety_screen.dart';

class NotificationItem extends StatelessWidget {
  final String assetImage;
  final String title;
  final String message;
  final String time;
  final VoidCallback onDelete;

  const NotificationItem({
    super.key,
    required this.assetImage,
    required this.title,
    required this.message,
    required this.time,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, userProfilePage);
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    assetImage,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        message,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const Divider(thickness: 2, color: Colors.black),
          ],
        ),
      ),
    );
  }
}

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    //final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.02,
            vertical: MediaQuery.of(context).size.height * 0.01,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, size: 30),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, chatbotWelcomeScreen);
                    },
                    child: Image.asset('assets/images/robot.png'),
                  ),
                  const Spacer(),
                  const Text('Notifications',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
                  const Spacer(),
                  const Spacer(),
                ],
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    const Divider(thickness: 2, color: Colors.black),
                    const Text(
                      'Today',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    NotificationItem(
                      assetImage: 'assets/images/homeImage.png',
                      title: 'New Match Alert!',
                      message:
                          'You have got a new match waiting to connect with you. Start a conversation now.',
                      time: '10:00am',
                      onDelete: () {
                        // Handle delete action
                      },
                    ),
                    const Text(
                      'Yesterday',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    NotificationItem(
                      assetImage: 'assets/images/homeImage.png',
                      title: 'New Match Alert!',
                      message:
                          'You have got a new match waiting to connect with you. Start a conversation now.',
                      time: '10:00am',
                      onDelete: () {
                        // Handle delete action
                      },
                    ),
                    NotificationItem(
                      assetImage: 'assets/images/homeImage.png',
                      title: 'New Match Alert!',
                      message:
                          'You have got a new match waiting to connect with you. Start a conversation now.',
                      time: '10:00am',
                      onDelete: () {
                        // Handle delete action
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showPopup(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true, // Dismiss when tapped outside
    barrierLabel: 'Dismiss',
    // Add a background overlay
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation1, animation2) {
      return Align(
        alignment: Alignment.topRight, // Align the dialog to the right
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 90, horizontal: 20),
            child: Container(
              width: 200, // Set the width of your popup
              height: 335, // Set the height of your popup
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      showSharePopup(context);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.share),
                        SizedBox(width: 5),
                        Text('Share this profile',
                            style: TextStyle(fontSize: 17)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15), // Space between items
                  InkWell(
                    onTap: () {
                      showBlockPopup(context);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.block),
                        SizedBox(width: 5),
                        Text('Block', style: TextStyle(fontSize: 17)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15), // Space between items
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, reportPage);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.report),
                        SizedBox(width: 5),
                        Text('Report', style: TextStyle(fontSize: 17)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15), // Space between items
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/datingPicture');
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.tips_and_updates),
                        SizedBox(width: 5),
                        Text('Dating Tips', style: TextStyle(fontSize: 17)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15), // Space between items
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditLowProfileScreen()),
                      );
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(width: 5),
                        Text('Edit profile', style: TextStyle(fontSize: 17)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15), // Space between items
                  InkWell(
                    onTap: () {},
                    child: const Row(
                      children: [
                        Icon(Icons.money),
                        SizedBox(width: 5),
                        Text('Plans', style: TextStyle(fontSize: 17)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15), // Space between items
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SafetyScreen()),
                      );
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.safety_check),
                        SizedBox(width: 5),
                        Text('Safety', style: TextStyle(fontSize: 17)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15), // Space between items
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsScreen()),
                      );
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.settings),
                        SizedBox(width: 5),
                        Text('Settings', style: TextStyle(fontSize: 17)),
                      ],
                    ),
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
        position: Tween<Offset>(
          begin: const Offset(1, 0), // Slide in from the right
          end: const Offset(0, 0),
        ).animate(animation1),
        child: child,
      );
    },
  );
}

void showSharePopup(BuildContext context) {
  showGeneralDialog(
      context: context,
      barrierDismissible: true, // Dismiss when tapped outside
      barrierLabel: 'Dismiss',
      // barrierColor: Colors.black54, // Add a background overlay
      pageBuilder: (context, animation1, animation2) {
        return Align(
            alignment: Alignment.bottomCenter, // Align the dialog to the bottom
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Material(
                    color: Colors
                        .transparent, // Transparent to show rounded corners
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // Background color
                        borderRadius:
                            BorderRadius.circular(20), // Circular borders
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // Changes position of shadow
                          ),
                        ],
                      ),
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: SingleChildScrollView(
                        // Add scroll view
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Share this profile',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            const SizedBox(height: 10),

                            // Recent People Section
                            const Row(
                              children: [
                                Text(
                                  'Recent People',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                                SizedBox(width: 3),
                                Expanded(
                                  child: Divider(
                                      thickness: 2,
                                      color:
                                          Colors.black), // The line in the Row
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  _buildProfileAvatar(
                                    'John',
                                    'Powell',
                                    'assets/images/homeImage.png',
                                  ),
                                  _buildProfileAvatar(
                                    'Peter',
                                    'Mark',
                                    'assets/images/homeImage.png',
                                  ),
                                  _buildProfileAvatar(
                                    'Billy',
                                    'Born',
                                    'assets/images/homeImage.png',
                                  ),
                                  _buildProfileAvatar(
                                    'Richard',
                                    'Apple',
                                    'assets/images/homeImage.png',
                                  ),
                                  _buildProfileAvatar(
                                    'Leo',
                                    'Wizzer',
                                    'assets/images/homeImage.png',
                                  ),
                                  _buildProfileAvatar(
                                    'Eden',
                                    'Porter',
                                    'assets/images/homeImage.png',
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Social Media Icons Section
                            const Row(
                              children: [
                                Text(
                                  'Social Media',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                                SizedBox(width: 3),
                                Expanded(
                                  child: Divider(
                                      thickness: 1, color: Colors.black),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _buildSocialMediaIcon(
                                      'assets/images/icons/whatsapp.png'),
                                  _buildSocialMediaIcon(
                                      'assets/images/icons/facebook.png'),
                                  _buildSocialMediaIcon(
                                      'assets/images/icons/instagram.png'),
                                  _buildSocialMediaIcon(
                                      'assets/images/icons/x.png'),
                                  _buildSocialMediaIcon(
                                      'assets/images/icons/tiktok.png'),
                                  _buildSocialMediaIcon(
                                      'assets/images/icons/telegram.png'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))));
      });
}

void showSharePopupp(BuildContext context) {
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height *
              0.4, // Adjust height as needed
          child: SingleChildScrollView(
            // Add scroll view
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Share this profile',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                // Recent People Section
                const Row(
                  children: [
                    Text(
                      'Recent People',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(width: 3),
                    Expanded(
                      child: Divider(
                          thickness: 2,
                          color: Colors.black), // The line in the Row
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildProfileAvatar(
                        'John',
                        'Powell',
                        'assets/images/homeImage.png',
                      ),
                      _buildProfileAvatar(
                        'Peter',
                        'Mark',
                        'assets/images/homeImage.png',
                      ),
                      _buildProfileAvatar(
                        'Billy',
                        'Born',
                        'assets/images/homeImage.png',
                      ),
                      _buildProfileAvatar(
                        'Richard',
                        'Apple',
                        'assets/images/homeImage.png',
                      ),
                      _buildProfileAvatar(
                        'Leo',
                        'Wizzer',
                        'assets/images/homeImage.png',
                      ),
                      _buildProfileAvatar(
                        'Eden',
                        'Porter',
                        'assets/images/homeImage.png',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Social Media Icons Section
                const Row(
                  children: [
                    Text(
                      'Social Media',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(width: 3),
                    Expanded(
                      child: Divider(thickness: 1, color: Colors.black),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSocialMediaIcon('assets/images/icons/whatsapp.png'),
                      _buildSocialMediaIcon(
                          'assets/images/icons/facebook-48.png'),
                      _buildSocialMediaIcon(
                          'assets/images/icons/instagram.png'),
                      _buildSocialMediaIcon(
                          'assets/images/icons/icons8-x-50.png'),
                      _buildSocialMediaIcon('assets/images/icons/tiktok.png'),
                      _buildSocialMediaIcon(
                          'assets/images/icons/icons8-telegram-logo-94.png'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

Widget _buildProfileAvatar(String name, String lname, String i) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(10),
        child: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey[300],
          child: ClipOval(
            child: Image.asset(
              i,
              fit: BoxFit.cover,
              width: 60,
              height: 60,
            ),
          ),
        ),
      ),
      const SizedBox(height: 10),
      Text(
        name,
        style: const TextStyle(fontSize: 14, color: Colors.black),
      ),
      Text(
        lname,
        style: const TextStyle(fontSize: 14),
      )
    ],
  );
}

Widget _buildSocialMediaIcon(String social) {
  return Padding(
      padding: const EdgeInsets.all(10),
      child: Image.asset(
        social,
        // fit: BoxFit.cover,
        width: 60,
        height: 60,
      ));
}

void verify(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true, // Dismiss when tapped outside
    barrierLabel: 'Dismiss',
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation1, animation2) {
      return Align(
        alignment: Alignment.topRight,
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.13,
              horizontal: MediaQuery.of(context).size.width * 0.03,
            ),
            child: Container(
                width: 250,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Image.asset('assets/images/icons/verblue.png',
                        width: 30, height: 30),
                    const Text('Daniel is Photo Verified',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black))
                  ],
                )),
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

void showBlockPopup(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true, // Dismiss when tapped outside
    barrierLabel: 'Dismiss',
    barrierColor: Colors.black54, // Add a background overlay
    pageBuilder: (context, animation1, animation2) {
      return Align(
        alignment: Alignment.bottomCenter, // Align the dialog to the bottom
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Material(
            color: Colors.transparent, // Transparent to show rounded corners
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // Background color
                borderRadius: BorderRadius.circular(20), // Circular borders
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // Changes position of shadow
                  ),
                ],
              ),
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.9,
              child: SingleChildScrollView(
                // Add scroll view
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 2),
                    const Text(
                      'Block Mark?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const Divider(thickness: 1, color: Colors.black),
                    const SizedBox(height: 12),
                    const Row(children: [
                      Icon(Icons.person_remove),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          'They will not be able to find your profile or send you messages.',
                          style: TextStyle(fontSize: 13, color: Colors.black),
                        ),
                      ),
                    ]),
                    const SizedBox(height: 12),
                    const Row(children: [
                      Icon(Icons.notifications_none),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          'They will not be notified if you block them.',
                          style: TextStyle(fontSize: 13, color: Colors.black),
                        ),
                      ),
                    ]),
                    const SizedBox(height: 12),
                    const Row(children: [
                      Icon(Icons.settings),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          'You can unblock them anytime in Settings.',
                          style: TextStyle(fontSize: 13, color: Colors.black),
                        ),
                      ),
                    ]),
                    const SizedBox(height: 20),
                    // Wrap the buttons with SingleChildScrollView
                    Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize
                              .min, // Use min size to prevent Row from taking full width
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close the dialog
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(149, 140, 250, 1),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                ),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context); // Perform action
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      blue, // Assuming 'blue' is defined
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                ),
                                child: const Text(
                                  'Yes, Block',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
