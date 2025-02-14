import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:love_bird/config/constants.dart';
import 'package:love_bird/config/routes.dart';
import 'package:love_bird/edit%20profile%20screens/chart/line_chart.dart';

class YourActivityScreen extends StatefulWidget {
  const YourActivityScreen({super.key});

  @override
  State<YourActivityScreen> createState() => _YourActivityScreenState();
}

class _YourActivityScreenState extends State<YourActivityScreen> {
  // This variable simulates the screen activity (e.g., network requests, user actions, etc.)
  double activityLevel = 0.2; // Activity level ranges from 0 to 1
  int _currentIndex = 4;
  // Function to simulate activity change
  void _simulateActivityChange() {
    setState(() {
      // Toggle between low and high activity
      activityLevel = activityLevel == 0.2
          ? 0.8
          : 0.2; // Switch between low and high activity
    });
  }

  // Initialize currentDate directly
  String currentDate = DateFormat('MMM dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
            const SizedBox(width: 50),
            InkWell(
              onTap: () {
                _simulateActivityChange();
              },
              child: Image.asset(
                "images/your activity.png",
              ),
            ),
          ],
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Chart
            LineChartWithLegend(),
            
          ],
        ),
      ),
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
