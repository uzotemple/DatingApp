// import 'package:flutter/material.dart';

// import 'package:love_bird/config/routes.dart';
// import 'package:love_bird/config/constants.dart';

// import 'package:love_bird/homeScreen/preference.dart';
// import 'package:love_bird/homeScreen/profiles.dart';

// import 'dart:async';

// import 'package:love_bird/modals/extra_sheet.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _currentIndex = 0;
//   String currentMessage = '';
//   Timer? popupTimer;

//   @override
//   void initState() {
//     super.initState();
//     startPopupTimer();
//   }

//   // Start the timer to show popup every 2 minutes
//   //chnage timer as whaever they say
//   void startPopupTimer() {
//     popupTimer = Timer.periodic(const Duration(hours: 10), (timer) {
//       showPopup();
//     });
//   }

//   void showPopup() {
//     setState(() {
//       currentMessage =
//           messages[(messages.indexOf(currentMessage) + 1) % messages.length];
//     });

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(5),
//           ),
//           child: Container(
//             padding: const EdgeInsets.only(
//               top: 5,
//             ),
//             width: 150,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Center(
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 28.0),
//                           child: SizedBox(
//                             width: 30,
//                             height: 40,
//                             child: Image.asset('assets/images/image1.png',
//                                 fit: BoxFit.cover),
//                           ),
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       icon: const Icon(Icons.close, size: 20),
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding:
//                       const EdgeInsets.only(bottom: 20, left: 20, right: 25),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: const Color(0xff6156EA).withOpacity(0.4),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Color.fromRGBO(0, 0, 0, 0.25),
//                           offset: Offset(10, 10),
//                           blurRadius: 2,
//                         ),
//                       ],
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(10),
//                       child: Text(
//                         '"$currentMessage"',
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                             fontSize: 12, fontWeight: FontWeight.w500),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     popupTimer?.cancel(); // Cancel the timer when the widget is disposed
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_outlined, size: 30),
//           onPressed: () {
//             Navigator.pushNamed(context, signUpRoute);
//           },
//         ),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             GestureDetector(
//               onTap: () {
//                 Navigator.pushNamed(context, chatbotWelcomeScreen);
//               },
//               child: Image.asset(
//                 'assets/images/robot.png',
//                 width: screenWidth * 0.08,
//               ),
//             ),
//             SizedBox(width: screenWidth * 0.07),
//             const Expanded(
//               child: Center(
//                 child: Text(
//                   'Zenkonect',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w700,
//                     fontSize: 20,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.monetization_on, size: 30),
//             onPressed: () {
//               showExtraViewsPopup(context);
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.notifications, size: 30),
//             onPressed: () {
//               Navigator.pushNamed(context, notificationsPage);
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.filter_list, size: 30),
//             onPressed: () {
//               showFilterOptions(context, (int startAge, int endAge) {});
//             },
//           ),
//           SizedBox(width: screenWidth * 0.007),
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: screenWidth * 0.02,
//           vertical: screenHeight * 0.01,
//         ),
//         child: const Center(child: ProfileInfo()),
//       ),
//       bottomNavigationBar: Padding(
//         padding: EdgeInsets.only(
//           left: screenWidth * 0.03, // 3% of screen width
//           right: screenWidth * 0.03,
//           top: screenHeight * 0.01, // 1% of screen height
//           bottom: screenHeight * 0.03, // 3% of screen height
//         ),
//         child: Container(
//           decoration: BoxDecoration(
//             color: const Color.fromRGBO(97, 86, 234, 0.19),
//             borderRadius: BorderRadius.circular(50),
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(50),
//             child: BottomNavigationBar(
//               type: BottomNavigationBarType.fixed,
//               backgroundColor: Colors.transparent,
//               elevation: 0,
//               currentIndex: _currentIndex,
//               items: [
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.home, size: screenWidth * 0.08),
//                   label: 'Home',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.location_on, size: screenWidth * 0.08),
//                   label: 'People Nearby',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.chat, size: screenWidth * 0.08),
//                   label: 'Chats',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.favorite, size: screenWidth * 0.08),
//                   label: 'Matches',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.person, size: screenWidth * 0.08),
//                   label: 'Profile',
//                 ),
//               ],
//               selectedLabelStyle: TextStyle(
//                 color: Colors.black, // Ensure selected text is black
//                 fontSize: MediaQuery.of(context).size.width * 0.03,
//               ),
//               unselectedLabelStyle: TextStyle(
//                 color: Colors.black, // Ensure unselected text is black
//                 fontSize: MediaQuery.of(context).size.width * 0.03,
//               ),
//               selectedItemColor:
//                   blue, // Make selected item icon and label black
//               unselectedItemColor:
//                   Theme.of(context).brightness == Brightness.dark
//                       ? Colors.white // Dark mode, use white
//                       : Colors.black, // Make unselected item icon black
//               onTap: (index) {
//                 setState(() {
//                   _currentIndex = index; // Update the current index.
//                 });
//                 switch (index) {
//                   case 0:
//                     Navigator.pushNamed(context, homeScreen);

//                     break;
//                   case 1:
//                     Navigator.pushNamed(context, peopleNearbyPage);
//                     break;
//                   case 2:
//                     Navigator.pushNamed(context, mainchat);
//                     break;
//                   case 3:
//                     Navigator.pushNamed(context, likes);
//                     break;
//                   case 4:
//                     Navigator.pushNamed(context, profile);
//                     break;
//                 }
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

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

  final List<String> messages = [
    "You’ve got this! The right person will appreciate everything you bring to the table",
    "Take a deep breath and relax—dating should be fun and exciting, not stressful!",
    "You are worthy of love and happiness. Don’t settle for anything less than you deserve!",
    "You are more than enough. The right person will see and cherish that.",
    "Sometimes love finds you when you least expect it. Stay hopeful!",
  ];

  final List<String> routes = [
    homeScreen,
    peopleNearbyPage,
    mainchat,
    likes,
    profile,
  ];

  @override
  void initState() {
    super.initState();
    startPopupTimer();
  }

  // Start the timer to show popup every 2 minutes
  void startPopupTimer() {
    popupTimer = Timer.periodic(const Duration(minutes: 2), (timer) {
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
            width: MediaQuery.of(context).size.width * 0.8, // Responsive width
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
        child: const Center(child: ProfileInfo()),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: screenWidth * 0.03, 
          right: screenWidth * 0.03,
          top: screenHeight * 0.01, 
          bottom: screenHeight * 0.03, 
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
                color: Colors.black,
                fontSize: screenWidth * 0.03,
              ),
              unselectedLabelStyle: TextStyle(
                color: Colors.black,
                fontSize: screenWidth * 0.03,
              ),
              selectedItemColor: blue,
              unselectedItemColor:
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
              onTap: (index) {
                if (_currentIndex != index) {
                  setState(() {
                    _currentIndex = index;
                  });
                  Navigator.pushReplacementNamed(context, routes[index]);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class HomeScreen extends StatefulWidget {
//   final String currentUserId;

//   const HomeScreen({super.key, required this.currentUserId});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   List<Map<String, dynamic>> users = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchUsers();
//   }

//   Future<void> fetchUsers() async {
//     try {
//       const apiUrl = 'http://138.68.150.48:7001/profile/list'; // Replace with your API URL
//       final response = await http.get(Uri.parse(apiUrl));

//       if (response.statusCode == 200) {
//         List<dynamic> data = json.decode(response.body);

//         // Ensure that both user["id"] and widget.currentUserId are treated as strings for comparison
//         final List<Map<String, dynamic>> filteredUsers = data
//             .where((user) => user["id"].toString() != widget.currentUserId)
//             .cast<Map<String, dynamic>>()
//             .toList();

//         setState(() {
//           users = filteredUsers;
//           isLoading = false;
//         });
//       } else {
//         throw Exception('Failed to load users');
//       }
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       print('Error fetching users: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_outlined, size: 30),
//           onPressed: () {
//             Navigator.pushNamed(context, '/signUp');
//           },
//         ),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             GestureDetector(
//               onTap: () {
//                 Navigator.pushNamed(context, '/chatbotWelcome');
//               },
//               child: Image.asset(
//                 'assets/images/robot.png',
//                 width: screenWidth * 0.08,
//               ),
//             ),
//             SizedBox(width: screenWidth * 0.07),
//             const Expanded(
//               child: Center(
//                 child: Text(
//                   'Zenkonect',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w700,
//                     fontSize: 20,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.monetization_on, size: 30),
//             onPressed: () {
//               // Show extra views popup
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.notifications, size: 30),
//             onPressed: () {
//               Navigator.pushNamed(context, '/notifications');
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.filter_list, size: 30),
//             onPressed: () {
//               // Show filter options
//             },
//           ),
//           SizedBox(width: screenWidth * 0.007),
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: screenWidth * 0.02,
//           vertical: screenWidth * 0.02,
//         ),
//         child: isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : users.isEmpty
//                 ? const Center(child: Text('No users available'))
//                 : GridView.builder(
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2, // 2 items per row
//                       crossAxisSpacing: 10.0,
//                       mainAxisSpacing: 10.0,
//                       childAspectRatio: (screenWidth / 2) / 200, // Adjust height
//                     ),
//                     itemCount: users.length,
//                     itemBuilder: (context, index) {
//                       final user = users[index];
//                       return GestureDetector(
//                         onTap: () {
//                           // Handle user tap (e.g., navigate to user profile)
//                           print("Selected: ${user["name"]}");
//                         },
//                         child: Card(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           elevation: 5,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               CircleAvatar(
//                                 radius: 40,
//                                 backgroundImage: NetworkImage(user["image"]),
//                               ),
//                               const SizedBox(height: 10),
//                               Text(
//                                 user["name"],
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'People Nearby'),
//           BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
//           BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Matches'),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//         ],
//         currentIndex: 0,
//         onTap: (index) {
//           // Handle navigation
//         },
//       ),
//     );
//   }
// }
