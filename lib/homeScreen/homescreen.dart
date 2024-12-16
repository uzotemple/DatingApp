import 'package:flutter/material.dart';
import 'package:love_bird/chat/chat_screen.dart';

import 'package:love_bird/config/routes.dart';
import 'package:love_bird/creditPages/purchase_credits_page.dart';
import 'package:love_bird/config/constants.dart';
import 'package:love_bird/homeScreen/notification.dart';
import 'package:love_bird/homeScreen/preference.dart';

import 'dart:async';

import 'package:love_bird/profile/users_profile.dart';
import 'package:love_bird/subscription%20plan/standard_plan.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> messages = [
    "You've got this! The right person will appreciate everything you bring to the table.",
    "You are more than enough. The right person will see and cherish that.",
    "It’s all about the journey, not just the destination. Enjoy meeting new people along the way!",
    "Keep your heart open—you never know when a new connection will surprise you!",
    "A positive attitude is contagious—let your optimism shine through!",
    "The right person will love you for who you are, flaws and all. Keep the faith!",
    "Every great love story starts with a little courage. Keep putting yourself out there!",
    "Trust the process and enjoy the ourney—your perfect match could be just around the corner.",
    "Every experience is a step closer to finding the right person. Learn from each one and keep moving forward!",
    "Take a deep breath and relax—dating should be fun and exciting, not stressful!",
    "Sometimes love finds you when you least expect it. Stay hopeful!",
    "Stay confident and trust in them process. Good things are coming your way!",
    "Every date is an opportunity to learn more about yourself and what you truly want.",
    "Your perfect match is out there, and they’re probably searching for you too. Keep going!",
    "Be yourself—authenticity is the most attractive quality you can have.",
    "Don’t forget to smile—it’s the best way to attract positive energy and people!",
    "Remember, you deserve someone who appreciates and respects you. Don’t settle for anything less!",
    "Every great connection starts with a simple 'hello.' Don’t be afraid to make the first move!",
    "You are worthy of love and happiness. Don’t settle for anything less than you deserve!",
    "Don’t be afraid to take the initiative. You never know what amazing connection might start with a simple message!",
    "Remember, each ‘no’ is one step closer to the ‘yes’ that really matters.",
    "It’s okay if it takes time. The best things in life are worth waiting for.",
    "Dating can be a journey, but every interaction brings you closer to what you’re looking for.",
    "You’re one step closer to finding someone special. Stay patient and hopeful!",
    "It only takes one special connection to make all the effort worthwhile. Stay positive, and keep exploring!",
    "It’s okay to take a break if you need one—self-care is just as important as finding love.",
    "Remember, the right person is out there—sometimes it just takes a little time to find them. Keep being yourself!",
  ];

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
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      //   backgroundColor: Colors.white,
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
                width: screenSize.width * 0.08,
              ),
            ),
            SizedBox(width: screenSize.width * 0.07),
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
          // InkWell(
          //   onTap: () {
          //     showExtraViewsPopup(context); // Show extra views popup
          //   },
          //   child: Image.asset(
          //     'assets/images/message.png',
          //     width: screenSize.width * 0.08,
          //   ),
          // ),
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
          // SizedBox(width: screenSize.width * 0.007),
          IconButton(
            icon: const Icon(Icons.filter_list, size: 30),
            onPressed: () {
              showFilterOptions(context, (int startAge, int endAge) {});
            },
          ),
          // InkWell(
          //   onTap: () {
          //     showFilterOptions(context, (int startAge, int endAge) {});
          //   },
          //   child: Image.asset(
          //     'assets/images/Vector.png',
          //     width: 30,
          //   ),
          // ),
          SizedBox(width: screenSize.width * 0.007),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.02,
          vertical: MediaQuery.of(context).size.height * 0.01,
        ),
        child: const Column(
          children: [
            // Row(
            //   children: [
            //     IconButton(
            //       icon: const Icon(Icons.arrow_back_outlined, size: 30),
            //       onPressed: () {
            //         Navigator.pop(context);
            //       },
            //     ),
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.pushNamed(context, chatbotWelcomeScreen);
            //       },
            //       child: Image.asset('assets/images/robot.png',
            //           width: screenSize.width * 0.08),
            //     ),
            //     const Expanded(
            //       child: Center(
            //           child: Text(
            //         'Zenkonect',
            //         style:
            //             TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            //         textAlign: TextAlign.center,
            //       )),
            //     ),
            //     InkWell(
            //       onTap: () {
            //         showExtraViewsPopup(context); // Show extra views popup
            //       },
            //       child: Image.asset('assets/images/message.png',
            //           width: screenSize.width * 0.08),
            //     ),
            //     const SizedBox(width: 5),
            //     IconButton(
            //       icon: const Icon(Icons.notifications,
            //           color: Colors.black, size: 30),
            //       onPressed: () {
            //         Navigator.pushNamed(context, notificationsPage);
            //       },
            //     ),
            //     SizedBox(width: screenSize.width * 0.007),
            //     InkWell(
            //       onTap: () {
            //         showFilterOptions(context, (int startAge, int endAge) {});
            //       },
            //       child: Image.asset('assets/images/Vector.png', width: 30),
            //     ),
            //   ],
            // ),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      ProfileInfo(
                        profiles: [
                          {
                            'imageUrl': 'assets/images/homeImage.png',
                            'name': 'John Doe, 25',
                            'location': 'New York, USA',
                          },
                          {
                            'imageUrl': 'assets/images/homeImage.png',
                            'name': 'Jane Smith, 22',
                            'location': 'Los Angeles, USA',
                          },
                          {
                            'imageUrl': 'assets/images/homeImage.png',
                            'name': 'Chris Johnson, 30',
                            'location': 'Chicago, USA',
                          },
                        ],
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
                    Theme.of(context).brightness == Brightness.dark
                        ? 'assets/images/icons/home.png'
                        : 'assets/images/icons/home.png',
                    width: MediaQuery.of(context).size.width * 0.08,
                    height: MediaQuery.of(context).size.width * 0.08,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    Theme.of(context).brightness == Brightness.dark
                        ? 'assets/images/icons/locationWhite.png'
                        : 'assets/images/icons/localcon.png',
                    width: MediaQuery.of(context).size.width * 0.08,
                    height: MediaQuery.of(context).size.width * 0.08,
                  ),
                  label: 'People Nearby',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    Theme.of(context).brightness == Brightness.dark
                        ? 'assets/images/icons/chatWhite.png'
                        : 'assets/images/icons/chatIcon.png',
                    width: MediaQuery.of(context).size.width * 0.08,
                    height: MediaQuery.of(context).size.width * 0.08,
                  ),
                  label: 'Chats',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    Theme.of(context).brightness == Brightness.dark
                        ? 'assets/images/icons/matchWhite.png'
                        : 'assets/images/icons/matches.png',
                    width: MediaQuery.of(context).size.width * 0.08,
                    height: MediaQuery.of(context).size.width * 0.08,
                  ),
                  label: 'Matches',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    Theme.of(context).brightness == Brightness.dark
                        ? 'assets/images/icons/profileWhite.png'
                        : 'assets/images/icons/personIcon.png',
                    width: MediaQuery.of(context).size.width * 0.07,
                    height: MediaQuery.of(context).size.width * 0.07,
                  ),
                  label: 'Profile',
                ),
              ],
              selectedLabelStyle: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.03,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.03,
              ),
              selectedItemColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
              unselectedItemColor:
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
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
}

void showExtraViewsPopup(BuildContext context) {
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  'assets/images/credit.png',
                  width: screenWidth * 0.15, // 15% of screen width
                  height: screenHeight * 0.06, // 6% of screen height
                ),
              ),
              SizedBox(height: screenHeight * 0.01), // 1% of screen height
              Text(
                'Extra Views',
                style: TextStyle(
                  fontSize: screenHeight * 0.025, // 2.5% of screen height
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Be seen by more people and get up to 6x more likes.',
                style: TextStyle(
                  fontSize: screenHeight * 0.022, // 2.2% of screen height
                ),
              ),
              SizedBox(height: screenHeight * 0.03), // 3% of screen height
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04), // 4% of screen width
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PurchaseCreditsPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blue,
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02, // 2% of screen height
                    ),
                  ),
                  child: Text(
                    'Get Extra Views For 150 Credits',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenHeight * 0.02, // 2% of screen height
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.015), // 1.5% of screen height
              Text(
                'OR',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenHeight * 0.02, // 2.5% of screen height
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.01), // 1% of screen height
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04), // 4% of screen width
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoveBirdPlanPage()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02, // 2% of screen height
                    ),
                    side: const BorderSide(color: blue, width: 2),
                  ),
                  child: Text(
                    'Get Zenkonect Standard Plan',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      fontSize: screenHeight * 0.02, // 2% of screen height
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03), // 3% of screen height
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Maybe Later',
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: screenHeight * 0.018, // 1.8% of screen height
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

class ProfileInfo extends StatefulWidget {
  final List<Map<String, String>> profiles;

  const ProfileInfo({super.key, required this.profiles});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  int _currentIndex = 0;
  bool _showSuperLike = false;
  bool _showLike = false;
  bool _showNo = false;
  bool _showCancel = false;
  double _rotationAngle = 0.0;

  void _onStarPressed() {
    setState(() {
      _showSuperLike = true;
      _rotationAngle = -0.2;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _showSuperLike = false;
        _rotationAngle = 0.0;
      });
    });
  }

  void _onLovePressed() {
    setState(() {
      _showLike = true;
      _rotationAngle = 0.3;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _showLike = false;
        _rotationAngle = 0.0;
      });
    });
  }

  void _onNoPressed() {
    setState(() {
      _showNo = true;
      _rotationAngle = -0.3;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _showNo = false;
        _rotationAngle = 0.0;
      });
    });
  }

  void _onCancelPressed() {
    setState(() {
      _showCancel = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _showCancel = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.9,
          child: PageView.builder(
            itemCount: widget.profiles.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
                //  To Show SnackBar when swiped to the last image
                if (index == widget.profiles.length - 1) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('This is the last image'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              });
            },
            itemBuilder: (context, index) {
              final profile = widget.profiles[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserProfilePage(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(profile['imageUrl']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Action indicators and buttons
        if (_showLike)
          Positioned.fill(
            child: Transform.rotate(
              angle: _rotationAngle,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(
                      widget.profiles[_currentIndex]['imageUrl']!,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Opacity(
                    opacity: _showLike ? 1.0 : 0.0,
                    child: const Text(
                      ' Like',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white, // Set your desired color
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

        if (_showNo)
          Positioned.fill(
            child: Transform.rotate(
              angle: _rotationAngle,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.74,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(
                      widget.profiles[_currentIndex]['imageUrl']!,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Opacity(
                    opacity: _showNo ? 1.0 : 0.0,
                    child: const Text(
                      ' No',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white, // Set your desired color
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

        if (_showSuperLike)
          Positioned(
            // top: MediaQuery.of(context).size.height * 0.1,
            left: MediaQuery.of(context).size.width * 0.1,
            child: Transform.rotate(
              angle: _rotationAngle,
              child: Container(
                width: MediaQuery.of(context).size.width *
                    0.6, // Small image width
                height: MediaQuery.of(context).size.height *
                    0.4, // Small image height
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(
                      widget.profiles[_currentIndex]['imageUrl']!,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Opacity(
                    opacity: _showSuperLike ? 1.0 : 0.0,
                    child: const Text(
                      'Super  Like',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white, // Set your desired color
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

        Positioned(
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            color: Colors.black.withOpacity(0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.profiles[_currentIndex]['name']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.005,
                      ),
                      Text(
                        widget.profiles[_currentIndex]['location']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: _onCancelPressed,
                          child: Image.asset('assets/images/left.png')),
                      const Spacer(),
                      InkWell(
                        onTap: _onLovePressed,
                        child: Image.asset('assets/images/love2.png'),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: _onStarPressed,
                        child: Image.asset('assets/images/star2.png'),
                      ),
                      const Spacer(),
                      GestureDetector(
                          onTap: _onNoPressed,
                          child: Image.asset('assets/images/cancel.png')),
                      //const Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_showCancel)
          Positioned.fill(
            child: Center(
              child: Opacity(
                opacity: _showCancel ? 1.0 : 0.0,
                child: const Text(
                  'Recent Action Reversed',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white, // Set your desired color
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

        Positioned(
          top: 10,
          right: 10,
          child: IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.white, size: 30),
            onPressed: () {
              _showSmallPopup(context);
            },
          ),
        ),
        Positioned(
          bottom: 170,
          right: 10,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChatDetailScreen(
                    name: 'Daniel',
                    profileImage: 'assets/images/homeImage.png',
                    isOnline: true,
                    lastMessage: 'Hello',
                  ),
                ),
              );
            },
            child: Image.asset('assets/images/icons/messageicon.png'),
          ),
        ),
      ],
    );
  }
}

void _showSmallPopup(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true, // Dismiss when tapped outside
    barrierLabel: 'Dismiss',
    barrierColor: Colors.transparent, // Add a background overlay
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation1, animation2) {
      return Align(
        alignment: Alignment.topRight, // Align the dialog to the right
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.13,
              horizontal: MediaQuery.of(context).size.width * .07,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width *
                  0.4, // Set the width of your popup

              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black
                    : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                        onPressed: () {
                          showBlockPopup(context);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.block,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            const SizedBox(width: 5),
                            Text('Block',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                ))
                          ],
                        )),
                    Divider(
                        thickness: 2,
                        color: Theme.of(context).textTheme.bodyMedium?.color),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/reportPage');
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.report,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            const SizedBox(width: 5),
                            Text('Report',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                ))
                          ],
                        )),
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
          begin: const Offset(1, 0),
          end: const Offset(0, 0),
        ).animate(animation1),
        child: child,
      );
    },
  );
}
