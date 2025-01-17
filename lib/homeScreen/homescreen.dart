import 'package:flutter/material.dart';

import 'package:love_bird/config/routes.dart';
import 'package:love_bird/config/constants.dart';

import 'package:love_bird/homeScreen/preference.dart';
import 'package:love_bird/homeScreen/profiles.dart';

import 'dart:async';

import 'package:love_bird/modals/extra_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  String currentMessage = '';
  Timer? popupTimer;

  @override
  void initState() {
    super.initState();
    startPopupTimer();
  }

  // Start the timer to show popup every 2 minutes
  //chnage timer as whaever they say
  void startPopupTimer() {
    popupTimer = Timer.periodic(const Duration(hours: 10), (timer) {
      showPopup();
    });
  }

  void showPopup() {
    setState(() {
      currentMessage =
          messages[(messages.indexOf(currentMessage) + 1) % messages.length];
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Container(
            padding: const EdgeInsets.only(
              top: 5,
            ),
            width: 150,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 28.0),
                          child: SizedBox(
                            width: 30,
                            height: 40,
                            child: Image.asset('assets/images/image1.png',
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close, size: 20),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 20, left: 20, right: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff6156EA).withOpacity(0.4),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          offset: Offset(10, 10),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        '"$currentMessage"',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
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

  @override
  void dispose() {
    popupTimer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, size: 30),
          onPressed: () {
            Navigator.pushNamed(context, signUpRoute);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, chatbotWelcomeScreen);
              },
              child: Image.asset(
                'assets/images/robot.png',
                width: screenWidth * 0.08,
              ),
            ),
            SizedBox(width: screenWidth * 0.07),
            const Expanded(
              child: Center(
                child: Text(
                  'Zenkonect',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.monetization_on, size: 30),
            onPressed: () {
              showExtraViewsPopup(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications, size: 30),
            onPressed: () {
              Navigator.pushNamed(context, notificationsPage);
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list, size: 30),
            onPressed: () {
              showFilterOptions(context, (int startAge, int endAge) {});
            },
          ),
          SizedBox(width: screenWidth * 0.007),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.02,
          vertical: screenHeight * 0.01,
        ),
        child: Center(child: ProfileInfo()),
      ),
      // child: const Column(
      //   children: [
      //     Expanded(
      //       child: Center(
      //         child: Column(
      //           children: [
      //             // ProfileInfo(
      //             //   profiles: [
      //             //     {
      //             //       'imageUrl': 'assets/images/homeImage.png',
      //             //       'name': 'John Doe, 25',
      //             //       'location': 'New York, USA',
      //             //     },
      //             //     {
      //             //       'imageUrl': 'assets/images/homeImage.png',
      //             //       'name': 'Jane Smith, 22',
      //             //       'location': 'Los Angeles, USA',
      //             //     },
      //             //     {
      //             //       'imageUrl': 'assets/images/homeImage.png',
      //             //       'name': 'Chris Johnson, 30',
      //             //       'location': 'Chicago, USA',
      //             //     },
      //             //   ],
      //             // ),

      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: screenWidth * 0.03, // 3% of screen width
          right: screenWidth * 0.03,
          top: screenHeight * 0.01, // 1% of screen height
          bottom: screenHeight * 0.03, // 3% of screen height
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
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, size: screenWidth * 0.08),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.location_on, size: screenWidth * 0.08),
                  label: 'People Nearby',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat, size: screenWidth * 0.08),
                  label: 'Chats',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite, size: screenWidth * 0.08),
                  label: 'Matches',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person, size: screenWidth * 0.08),
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
                      : Colors.black, // Make unselected item icon black
              onTap: (index) {
                setState(() {
                  _currentIndex = index; // Update the current index.
                });
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
}
