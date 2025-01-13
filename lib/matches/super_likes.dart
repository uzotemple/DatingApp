import 'package:flutter/material.dart';
import 'package:love_bird/config/constants.dart';

import 'package:love_bird/config/routes.dart';

import 'package:love_bird/matches/Likes.dart';

import 'dart:ui';

import 'package:love_bird/renewal/renewal.dart'; // For image blurring

class SuperLikes extends StatefulWidget {
  const SuperLikes({super.key});

  @override
  _SuperLikesState createState() => _SuperLikesState();
}

class _SuperLikesState extends State<SuperLikes> {
  bool premuimPackage = false;
  bool showSearchBox = false;
  String searchQuery = '';
  int _currentIndex = 3;
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
            SizedBox(width: screenSize.width * 0.07),
            const Expanded(
              child: Center(
                child: Text(
                  'Matches',
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
            icon: const Icon(Icons.search, size: 30),
            onPressed: () {
              setState(() {
                if (showSearchBox) {
                  searchQuery = ''; // Reset the search query
                }
                showSearchBox = !showSearchBox; // Toggle visibility
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.sort_outlined, size: 30),
            onPressed: () {
              showLikeSort(context);
            },
          ),
          //    SizedBox(width: screenSize.height * 0.025),
          SizedBox(width: screenSize.width * 0.05),
        ],
      ),
      body: Column(
        children: [
          if (showSearchBox)
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * 0.08),
              child: SizedBox(
                height: 40,
                child: TextField(
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color),
                  decoration: InputDecoration(
                    hintText: 'Search by name...',
                    hintStyle: TextStyle(
                      color: Theme.of(context).hintColor,
                    ),
                    contentPadding:
                        EdgeInsets.only(top: screenSize.height * 0.02),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).iconTheme.color,
                    ),
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
                        width: 1.5,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
              ),
            ),
          SizedBox(height: screenSize.height * 0.025),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Likes()),
                );
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
                    'Likes(4)', // dynamic number
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SuperLikes()),
                );
              },
              child: Container(
                width: screenSize.width * 0.4,
                height: screenSize.height * 0.06,
                decoration: BoxDecoration(
                  color: blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'SuperLikes(4)', //dynamic number
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ]),
          const SizedBox(height: 20),
          Expanded(
            child: PeopleNearbyGrid(
              premuimPackage: premuimPackage,
              searchQuery: searchQuery, // Pass the search query
            ),
          ),
          const SizedBox(height: 7),
          if (premuimPackage == false)
            SizedBox(
              width: screenSize.width * 0.7,
              height: screenSize.height * 0.07,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UpgradePremium()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  backgroundColor: blue,
                ),
                child: const Text(
                  'Upgrade to Premium To See More',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
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

class PeopleNearbyGrid extends StatelessWidget {
  final bool premuimPackage;
  final String searchQuery;

  PeopleNearbyGrid(
      {super.key, required this.premuimPackage, required this.searchQuery});

  final List<User> users = [
    User(imageUrl: 'assets/images/homeImage.png', name: 'David', age: 31),
    User(imageUrl: 'assets/images/homeImage.png', name: 'James', age: 29),
    User(imageUrl: 'assets/images/homeImage.png', name: 'Tom', age: 32),
    User(imageUrl: 'assets/images/homeImage.png', name: 'Michael', age: 30),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredUsers = searchQuery.isEmpty
        ? users
        : users
            .where((user) =>
                user.name.toLowerCase().contains(searchQuery.toLowerCase()))
            .toList();

    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.7,
      ),
      itemCount: filteredUsers.length,
      itemBuilder: (context, index) {
        bool shouldBlur = !premuimPackage;
        return UserCard(user: users[index], blurImage: shouldBlur);
      },
    );
  }
}

// User Model
class User {
  final String imageUrl;
  final String name;
  final int age;

  User({required this.imageUrl, required this.name, required this.age});
}

// User Card
class UserCard extends StatelessWidget {
  final User user;
  final bool blurImage;

  const UserCard({required this.user, required this.blurImage, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: blurImage
          ? null // Disable tap if blurImage is true
          : () {
              Navigator.pushNamed(context, userProfilePage);
            },
      // behavior: blurImage ? HitTestBehavior.opaque : HitTestBehavior.deferToChild,

      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Image.asset(
              user.imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            // Blurring effect
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10)),
                  color: Colors.black.withOpacity(0.5),
                ),
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${user.age}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (blurImage)
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  color:
                      const Color.fromARGB(255, 151, 145, 145).withOpacity(0),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

void showLikeSort(BuildContext context) {
  final screenSize = MediaQuery.of(context).size;

  // Initial checkbox states
  bool allLikes = false;
  bool newLikes = false;
  bool online = false;
  bool nearYou = false;

  showGeneralDialog(
    context: context,
    barrierDismissible: true, // Dismiss when tapped outside
    barrierLabel: 'Dismiss',
    barrierColor: Colors.black54, // Add a background overlay
    transitionDuration:
        const Duration(milliseconds: 300), // Add transition duration
    pageBuilder: (context, animation1, animation2) {
      return Align(
        alignment: Alignment.bottomCenter, // Align the dialog to the bottom
        child: Dialog(
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Rounded corners
          ),
          child: SizedBox(
            width: screenSize.width * 0.85,
            child: StatefulBuilder(
              builder: (context, setState) {
                return SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Sort By',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      CheckboxListTile(
                        title: Text('All Likes',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color)),
                        value: allLikes,
                        onChanged: (bool? value) {
                          setState(() {
                            allLikes = value ?? false;
                          });
                        },
                        activeColor: blue,
                        checkColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: const BorderSide(
                          color: blue,
                          width: 2,
                        ),
                      ),
                      CheckboxListTile(
                        title: Text('New Likes',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color)),
                        value: newLikes,
                        onChanged: (bool? value) {
                          setState(() {
                            newLikes = value ?? false;
                          });
                        },
                        activeColor: blue,
                        checkColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: const BorderSide(
                          color: blue,
                          width: 2,
                        ),
                      ),
                      CheckboxListTile(
                        title: Text('Online',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color)),
                        value: online,
                        onChanged: (bool? value) {
                          setState(() {
                            online = value ?? false;
                          });
                        },
                        activeColor: blue,
                        checkColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: const BorderSide(
                          color: blue,
                          width: 2,
                        ),
                      ),
                      CheckboxListTile(
                        title: Text('Near You',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color)),
                        value: nearYou,
                        onChanged: (bool? value) {
                          setState(() {
                            nearYou = value ?? false;
                          });
                        },
                        activeColor: blue,
                        checkColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: const BorderSide(
                          color: blue,
                          width: 2,
                        ),
                      ),
                    ],
                  ),
                ));
              },
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, animation1, animation2, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1), // Slide in from the bottom
          end: Offset.zero, // End at original position
        ).animate(animation1),
        child: child,
      );
    },
  );
}
