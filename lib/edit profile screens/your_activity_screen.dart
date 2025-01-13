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
  // void _showDialog(String title, String content) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(title),
  //         content: Text(content),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('OK'),
  //             onPressed: () {
  //               Navigator.of(context).pop(); // Close the dialog
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

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
            // const Text(
            //   "Increase your activity instantly",
            //   style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(12.0),
            //   child: SizedBox(
            //     width: MediaQuery.of(context).size.width,
            //     height: 120,
            //     child: DecoratedBox(
            //       decoration: BoxDecoration(
            //         color: Colors.transparent,
            //         border: Border.all(
            //           color: blue, // Border color
            //           width: 2.0, // Border width
            //         ),
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //       child: Column(
            //         children: [
            //           const SizedBox(height: 20),
            //           Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 15.0),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 CircleAvatar(
            //                   backgroundColor: const Color(0xFF958CFA),
            //                   child: Image.asset("images/video icon.png"),
            //                 ),
            //                 const SizedBox(width: 10),
            //                 const Expanded(
            //                   // Use Expanded to make the text flexible
            //                   child: Text(
            //                     "Your free credits are just a quick video away!",
            //                     style: TextStyle(
            //                       fontSize: 13,
            //                       fontWeight: FontWeight.w400,
            //                     ),
            //                     overflow:
            //                         TextOverflow.ellipsis, // Handle overflow
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //           const SizedBox(
            //               height: 10), // Add some space between text and button
            //           SizedBox(
            //             width: MediaQuery.of(context)
            //                 .size
            //                 .width, // Make button take full width
            //             height: MediaQuery.of(context).size.height * 0.05,
            //             child: Padding(
            //               padding: const EdgeInsets.symmetric(horizontal: 80.0),
            //               child: ElevatedButton(
            //                 onPressed: () {
            //                   _showDialog('Free Credit',
            //                       '10 free credits added successfully');
            //                 },
            //                 style: ElevatedButton.styleFrom(
            //                   backgroundColor: blue,
            //                   padding:
            //                       const EdgeInsets.symmetric(vertical: 15.0),
            //                   textStyle: const TextStyle(fontSize: 18),
            //                 ),
            //                 child: const Text(
            //                   'Get 10 free credits',
            //                   style: TextStyle(
            //                     color: Color(0xFFFFFFFF),
            //                     fontSize: 11,
            //                     fontWeight: FontWeight.w500,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(12.0),
            //   child: SizedBox(
            //     width: MediaQuery.of(context).size.width,
            //     height: 120,
            //     child: DecoratedBox(
            //       decoration: BoxDecoration(
            //         color: Colors.transparent,
            //         border: Border.all(
            //           color: blue, // Border color
            //           width: 2.0, // Border width
            //         ),
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //       child: Column(
            //         children: [
            //           const SizedBox(height: 20),
            //           Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 15.0),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 CircleAvatar(
            //                   backgroundColor: const Color(0xFF958CFA),
            //                   child: Image.asset("images/activity image.png"),
            //                 ),
            //                 const SizedBox(width: 10),
            //                 const Expanded(
            //                   // Use Expanded to make the text flexible
            //                   child: Text(
            //                     "Move to the top and get seen by more people!",
            //                     style: TextStyle(
            //                       fontSize: 13,
            //                       fontWeight: FontWeight.w400,
            //                     ),
            //                     overflow:
            //                         TextOverflow.ellipsis, // Handle overflow
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //           const SizedBox(
            //               height: 10), // Add some space between text and button
            //           SizedBox(
            //             width: MediaQuery.of(context)
            //                 .size
            //                 .width, // Make button take full width
            //             height: MediaQuery.of(context).size.height * 0.05,
            //             child: Padding(
            //               padding: const EdgeInsets.symmetric(horizontal: 80.0),
            //               child: ElevatedButton(
            //                 onPressed: () {},
            //                 style: ElevatedButton.styleFrom(
            //                   backgroundColor: blue,
            //                   padding:
            //                       const EdgeInsets.symmetric(vertical: 15.0),
            //                   textStyle: const TextStyle(fontSize: 18),
            //                 ),
            //                 child: const Text(
            //                   'Move up',
            //                   style: TextStyle(
            //                     color: Color(0xFFFFFFFF),
            //                     fontSize: 11,
            //                     fontWeight: FontWeight.w500,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(12.0),
            //   child: SizedBox(
            //     width: MediaQuery.of(context).size.width,
            //     height: 120,
            //     child: DecoratedBox(
            //       decoration: BoxDecoration(
            //         color: Colors.transparent,
            //         border: Border.all(
            //           color: blue, // Border color
            //           width: 2.0, // Border width
            //         ),
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //       child: Column(
            //         children: [
            //           const SizedBox(height: 20),
            //           Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 15.0),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 CircleAvatar(
            //                   backgroundColor: const Color(0xFF958CFA),
            //                   child: Image.asset("images/activity image.png"),
            //                 ),
            //                 const SizedBox(width: 10),
            //                 const Expanded(
            //                   // Use Expanded to make the text flexible
            //                   child: Text(
            //                     "Appear more when people are swiping!",
            //                     style: TextStyle(
            //                       fontSize: 13,
            //                       fontWeight: FontWeight.w400,
            //                     ),
            //                     overflow:
            //                         TextOverflow.ellipsis, // Handle overflow
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //           const SizedBox(
            //               height: 10), // Add some space between text and button
            //           SizedBox(
            //             width: MediaQuery.of(context)
            //                 .size
            //                 .width, // Make button take full width
            //             height: MediaQuery.of(context).size.height * 0.05,
            //             child: Padding(
            //               padding: const EdgeInsets.symmetric(horizontal: 80.0),
            //               child: ElevatedButton(
            //                 onPressed: () {},
            //                 style: ElevatedButton.styleFrom(
            //                   backgroundColor: blue,
            //                   padding:
            //                       const EdgeInsets.symmetric(vertical: 15.0),
            //                   textStyle: const TextStyle(fontSize: 18),
            //                 ),
            //                 child: const Text(
            //                   'Add extra shows',
            //                   style: TextStyle(
            //                     color: Color(0xFFFFFFFF),
            //                     fontSize: 11,
            //                     fontWeight: FontWeight.w500,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(12.0),
            //   child: SizedBox(
            //     width: MediaQuery.of(context).size.width,
            //     height: 120,
            //     child: DecoratedBox(
            //       decoration: BoxDecoration(
            //         color: Colors.transparent,
            //         border: Border.all(
            //           color: blue, // Border color
            //           width: 2.0, // Border width
            //         ),
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //       child: Column(
            //         children: [
            //           const SizedBox(height: 20),
            //           Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 15.0),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 CircleAvatar(
            //                   backgroundColor: const Color(0xFF958CFA),
            //                   child: Image.asset("images/activity image.png"),
            //                 ),
            //                 const SizedBox(width: 10),
            //                 const Expanded(
            //                   // Use Expanded to make the text flexible
            //                   child: Text(
            //                     "Tell everyone you’re online and ready to chat!",
            //                     style: TextStyle(
            //                       fontSize: 13,
            //                       fontWeight: FontWeight.w400,
            //                     ),
            //                     overflow:
            //                         TextOverflow.ellipsis, // Handle overflow
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //           const SizedBox(
            //               height: 10), // Add some space between text and button
            //           SizedBox(
            //             width: MediaQuery.of(context)
            //                 .size
            //                 .width, // Make button take full width
            //             height: MediaQuery.of(context).size.height * 0.05,
            //             child: Padding(
            //               padding: const EdgeInsets.symmetric(horizontal: 80.0),
            //               child: ElevatedButton(
            //                 onPressed: () {},
            //                 style: ElevatedButton.styleFrom(
            //                   backgroundColor: blue,
            //                   padding:
            //                       const EdgeInsets.symmetric(vertical: 15.0),
            //                   textStyle: const TextStyle(fontSize: 18),
            //                 ),
            //                 child: const Text(
            //                   'Show i’m online',
            //                   style: TextStyle(
            //                     color: Color(0xFFFFFFFF),
            //                     fontSize: 11,
            //                     fontWeight: FontWeight.w500,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
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
