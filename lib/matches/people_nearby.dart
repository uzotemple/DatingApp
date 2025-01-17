import 'package:flutter/material.dart';
import 'package:love_bird/config/constants.dart';
import 'package:love_bird/config/routes.dart';
import 'package:love_bird/grids/nearby_grid.dart';

import 'package:love_bird/homeScreen/preference.dart';

import 'package:love_bird/modals/extra_sheet.dart';

class PeopleNearbyPage extends StatefulWidget {
  const PeopleNearbyPage({super.key});

  @override
  State<PeopleNearbyPage> createState() => _PeopleNearbyPageState();
}

class _PeopleNearbyPageState extends State<PeopleNearbyPage> {
  int _currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, size: 30),
          onPressed: () {
            Navigator.pop(context);
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
                width: screenSize.width * 0.08,
              ),
            ),
            //   SizedBox(width: screenSize.width * 0.05),
            const Expanded(
              child: Center(
                child: Text(
                  'People Nearby',
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
          SizedBox(width: screenSize.width * 0.01),
          IconButton(
            icon: const Icon(Icons.filter_list, size: 30),
            onPressed: () {
              showFilterOptions(context, (int startAge, int endAge) {});
            },
          ),
          SizedBox(width: screenSize.width * 0.04),
        ],
      ),
      body: Column(children: [
        SizedBox(height: screenSize.height * 0.025),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildContinueButton(screenSize, 'People NearBy'),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, profilevisits);
              },
              child: Container(
                width: screenSize.width * 0.4,
                height: screenSize.height * 0.06,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(149, 140, 250, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'Profile Visitors',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: screenSize.height * 0.025),
        // Use a SizedBox for fixed height
        Expanded(
          // Adjust height as needed
          child: PeopleNearbyGrid(),
        ),
      ]),
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

  Widget _buildContinueButton(
    Size screenSize,
    String text,
  ) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: screenSize.width * 0.4,
        height: screenSize.height * 0.06,
        decoration: BoxDecoration(
          color: blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
