import 'package:flutter/material.dart';
import 'package:love_bird/api/profile_api.dart';
import 'package:love_bird/config/routes.dart';
import 'package:love_bird/homeScreen/notification.dart';
import 'package:love_bird/modals/extra_sheet.dart';
import 'package:love_bird/providers/auth_provider.dart';
import 'package:love_bird/setting_screen/setting_screen.dart';
import 'package:love_bird/safety_privacy_screens/safety_screen.dart';
import 'package:love_bird/subscription%20plan/standard_plan.dart';
import 'package:love_bird/config/constants.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  int _currentIndex = 4;
  // @override
  // void initState() {
  //   super.initState();
  //   _pageController.addListener(() {
  //     setState(() {
  //       _currentPage = _pageController.page!.round();
  //     });
  //   });
  //   // Call the verifyPayment method to load data when the page is loaded
  //   final profileProvider =
  //       Provider.of<ProfileProvider>(context, listen: false);

  //   final authProvider = Provider.of<AuthProvider>(context, listen: false);
  //   profileProvider.retieveProfile(context, authProvider);
  // }

  @override
  void initState() {
    super.initState();

    // Add a small delay to ensure ProfileProvider is ready
    Future.delayed(Duration.zero, () {
      final profileProvider =
          Provider.of<ProfileProvider>(context, listen: false);
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      profileProvider.retieveProfile(context, authProvider);
    });

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _pageController.addListener(() {
  //     setState(() {
  //       _currentPage = _pageController.page!.round();
  //     });
  //   });
  // }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenSize = MediaQuery.of(context).size;
    final profileProvider = Provider.of<ProfileProvider>(context);
    int age = profileProvider.getProfileData?["age"] as int? ?? 0;

    String name = profileProvider.getProfileData?["nickname"] ?? "Unknown";
    String profession =
        profileProvider.getProfileData?["profession"] ?? "Unknown";
    double weight =
        profileProvider.getProfileData?["weight"]?.toDouble() ?? 0.0;
    double height =
        profileProvider.getProfileData?["height"]?.toDouble() ?? 0.0;
    String country = profileProvider.getProfileData?["country"] ?? "Unknown";
    String city = profileProvider.getProfileData?["city"] ?? "Unknown";
    String bio = profileProvider.getProfileData?["bio"] ?? "Unknown";
    String educationLevel =
        profileProvider.getProfileData?["educationLevel"] ?? "Unknown";

    String gender = profileProvider.getProfileData?["gender"] ?? "Unknown";
    String goal =
        profileProvider.getProfileData?["relationshipGoals"] ?? "Unknown";
    String location = profileProvider.getProfileData?["location"] ?? "Unknown";
    String interest = profileProvider.getProfileData?["interest"] ?? "Unknown";
    bool isPicsVerified =
        profileProvider.getProfileData?['isPicsVerified'] ?? false;

    String imagePath = isPicsVerified
        ? 'assets/images/icons/verblue.png'
        : 'assets/images/redCheck.png';

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
                  'Profile',
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
          // IconButton(
          //   icon: Image.asset('assets/images/icons/verblue.png',
          //       width: 30, height: 30),
          //   onPressed: () {
          //     verify(context);
          //   },
          // ),
          IconButton(
              icon: Image.asset(imagePath, width: 30, height: 30),
              onPressed: isPicsVerified
                  ? () => verifyy(context)
                  : () =>
                      Navigator.pushNamed(context, photoVerificationOneAfter)),

          IconButton(
            icon: const Icon(Icons.monetization_on, size: 30),
            onPressed: () {
              showExtraViewsPopup(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, size: 30),
            onPressed: () {
              _showPopup(context);
            },
          ),
          SizedBox(width: screenSize.width * 0.007),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: screenHeight * 0.5,
                  child: PageView(
                    controller: _pageController,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.asset(
                          'assets/images/homeImage.png',
                          width: screenWidth * 0.9,
                          height: screenHeight * 0.4,
                          fit: BoxFit.cover,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.asset(
                          'assets/images/homeImage.png',
                          width: screenWidth * 0.9,
                          height: screenHeight * 0.5,
                          fit: BoxFit.cover,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.asset(
                          'assets/images/homeImage.png',
                          width: screenWidth * 0.9,
                          height: screenHeight * 0.2,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? blue
                              : const Color.fromRGBO(255, 255, 255, 0.54),
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenSize.height * 0.025),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenSize.height * 0.025),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$name, $age',
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),

                          const Text(
                            'Bio',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: screenWidth * 0.00),

                          // ),
                        ],
                      ),

                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProfileDetail(
                                icon: Icons.man,
                                title: gender,
                              ),
                              ProfileDetail(
                                  icon: Icons.rule_sharp,
                                  title: '$weight kg, $height cm'
                                  //  '${paymentProvider.getProfileData!['nickname']},  ${paymentProvider.getProfileData!['age']}',
                                  ),
                              ProfileDetail(
                                icon: Icons.work,
                                title: profession,
                              ),
                              ProfileDetail(
                                icon: Icons.school,
                                title: educationLevel,
                              ),
                              ProfileDetail(
                                icon: Icons.home,
                                title: "Lives $country",
                              ),
                              ProfileDetail(
                                icon: Icons.location_on,
                                title: "$location km away",
                              ),
                            ],
                          ),
                          SizedBox(width: screenWidth * 0.09),
                          Expanded(
                            child: Text(
                              bio, style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.start,
                              // This will ensure the text is truncated if it overflows
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: screenSize.height * 0.025),
                      // Relationship basics
                      const Text(
                        'My relationship Basics',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: screenSize.height * 0.015),
                      RelationshipOption(
                        title: goal,
                        icon: Icons.people,
                        color: Colors.pinkAccent,
                      ),
                      SizedBox(height: screenSize.height * 0.025),
                      // Interests
                      const Text(
                        'Interests',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: screenSize.height * 0.015),
                      Wrap(
                        spacing: 10,
                        children: [
                          InterestOption(
                            title: interest,
                            color: Colors.orange,
                          ),
                          // InterestOption(
                          //   title: 'Hiking',
                          //   icon: Icons.hiking,
                          //   color: Colors.green,
                          // ),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.023),
                      const Text(
                        'Location',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '$city ,$country',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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

  void verifyy(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);

    String name = profileProvider.getProfileData?["nickname"] ?? "Unknown";
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
                  width: screenWidth * 0.6,
                  height: screenHeight * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Image.asset('assets/images/icons/verblue.png',
                          width: 30, height: 30),
                      Text('$name is Photo Verified',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.03,
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
}

class ProfileDetail extends StatelessWidget {
  final IconData icon;
  final String title;

  const ProfileDetail({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(
            icon,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class RelationshipOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const RelationshipOption({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.purple),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          Icon(icon, color: color),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}

class InterestOption extends StatelessWidget {
  final String title;
  // final IconData icon;
  final Color color;

  const InterestOption({
    super.key,
    required this.title,
    //  required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.purple),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          //  Icon(icon, color: color),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}

void _showPopup(BuildContext context) {
  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;
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
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.1, horizontal: screenWidth * 0.03),
            child: Container(
              width: screenWidth * 0.5,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black
                    : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        showSharePopup(context);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.share,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.color),
                          const SizedBox(width: 5),
                          Text('Share your profile',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color)),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/datingPicture');
                      },
                      child: Row(
                        children: [
                          Icon(Icons.tips_and_updates,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.color),
                          const SizedBox(width: 5),
                          Text('Dating Tips',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color)),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/editLowProfileScreen');
                      },
                      child: Row(
                        children: [
                          Icon(Icons.edit,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.color),
                          const SizedBox(width: 5),
                          Text('Edit profile',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color)),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoveBirdPlanPage()),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.money,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.color),
                          const SizedBox(width: 5),
                          Text('Plans',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color)),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SafetyScreen()),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.safety_check,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.color),
                          const SizedBox(width: 5),
                          Text('Safety',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color)),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingsScreen()),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.settings,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.color),
                          const SizedBox(width: 5),
                          Text('Settings',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color)),
                        ],
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
