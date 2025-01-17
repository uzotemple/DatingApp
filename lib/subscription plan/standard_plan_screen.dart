import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:love_bird/config/routes.dart';
import 'package:love_bird/config/constants.dart';
import 'package:love_bird/payment/flutter_wave.dart';
import 'package:love_bird/subscription%20plan/plan_card.dart';

class StandardPlan extends StatefulWidget {
  const StandardPlan({super.key});

  @override
  State<StandardPlan> createState() => _StandardPlanState();
}

class _StandardPlanState extends State<StandardPlan> {
  String _appBarTitle = 'Standard'; // Default title
  int _currentIndex = 4;
  void _onTabChanged(int index) {
    setState(() {
      _appBarTitle = index == 0
          ? 'Standard'
          : 'Premium'; // Update title based on selected tab
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2, // Number of tabs (Standard and Premium)
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            _appBarTitle,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, geminiBot);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Image.asset("images/ai.png"),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            // TabBar for Standard and Premium
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.transparent,
              child: TabBar(
                onTap: _onTabChanged, // Listen for tab changes
                labelColor: Colors.white, // Text color for the active tab
                unselectedLabelColor:
                    Colors.white, // Text color for the inactive tab
                indicator: BoxDecoration(
                  color: const Color(
                      0xFF3628DD), // Background color for the active tab
                  borderRadius:
                      BorderRadius.circular(10), // Shape for active tab
                ),
                indicatorWeight: 0.0,
                tabs: [
                  Tab(
                    child: Container(
                      width: 150, // Ensures consistent width
                      height: 35, // Ensures consistent height
                      alignment: Alignment.center, // Centers the text
                      decoration: BoxDecoration(
                        color: blue.withOpacity(0.6), // Inactive tab background
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text('Standard'),
                    ),
                  ),
                  Tab(
                    child: Container(
                      width: 150, // Ensures consistent width
                      height: 35, // Ensures consistent height
                      alignment: Alignment.center, // Centers the text
                      decoration: BoxDecoration(
                        color: blue.withOpacity(0.6), // Inactive tab background
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text('Premium'),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  StandardTab(), // Make sure this widget is defined and imported
                  PremiumTab(), // Make sure this widget is defined and imported
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            left:
                MediaQuery.of(context).size.width * 0.03, // 3% of screen width
            right: MediaQuery.of(context).size.width * 0.03,
            top: MediaQuery.of(context).size.height *
                0.01, // 1% of screen height
            bottom: MediaQuery.of(context).size.height *
                0.03, // 3% of screen height
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
      ),
    );
  }
}

class StandardTab extends StatelessWidget {
  const StandardTab({super.key});

  @override
  Widget build(BuildContext context) {
    final paymentService = PaymentService();
    final List<Widget> containers = [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // Curved edges
          color: Colors.transparent, // Background color (optional)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'images/message.png',
                ), // First image
                const SizedBox(height: 5),
                Text(
                  'Match and Connect',
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // Dark mode text color
                        : Colors.black, // Light mode text color
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Connect and chat with mutual matches',
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white.withOpacity(0.6) // Dark mode text color
                        : Colors.black
                            .withOpacity(0.6), // Light mode text color
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // Curved edges
          color: Colors.transparent, // Background color (optional)
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'images/goodbye.png',
              ), // Second image
              const SizedBox(height: 5),
              Text(
                'Send Unlimited Likes',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white // Dark mode text color
                      : Colors.black, // Light mode text color
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Like as many profiles as you want.',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.6) // Dark mode text color
                      : Colors.black.withOpacity(0.6), // Light mode text color
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // Curved edges
          color: Colors.transparent, // Background color (optional)
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'images/threetimes.png',
              ), // Third image
              const SizedBox(height: 5),
              Text(
                'See Who Liked You',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white // Dark mode text color
                      : Colors.black, // Light mode text color
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'View users who liked your profile.',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.6) // Dark mode text color
                      : Colors.black.withOpacity(0.6), // Light mode text color
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // Curved edges
          color: Colors.transparent, // Background color (optional)
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'images/undo.png',
              ), // Fourth image
              const SizedBox(height: 5),
              Text(
                'See Super Likes',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white // Dark mode text color
                      : Colors.black, // Light mode text color
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Check who super liked you',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.6) // Dark mode text color
                      : Colors.black.withOpacity(0.6), // Light mode text color
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // Curved edges
          color: Colors.transparent, // Background color (optional)
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'images/bonus.png',
              ), // Fifth image
              const SizedBox(height: 5),
              Text(
                'Add Notes to Super Likes',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white // Dark mode text color
                      : Colors.black, // Light mode text color
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Send a personal message with super likes.',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.6) // Dark mode text color
                      : Colors.black.withOpacity(0.6), // Light mode text color
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // Curved edges
          color: Colors.transparent, // Background color (optional)
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'images/pushmessage.png',
              ), // Sixth image
              const SizedBox(height: 5),
              Text(
                'Start Conversations',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white // Dark mode text color
                      : Colors.black, // Light mode text color
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Chat with your matches.',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.6) // Dark mode text color
                      : Colors.black.withOpacity(0.6), // Light mode text color
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // Curved edges
          color: Colors.transparent, // Background color (optional)
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'images/visibility.png',
              ), // Seventh image
              const SizedBox(height: 5),
              Text(
                'Undo Left Swipes',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white // Dark mode text color
                      : Colors.black, // Light mode text color
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Rewind accidental swipes',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.6) // Dark mode text color
                      : Colors.black.withOpacity(0.6), // Light mode text color
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // Curved edges
          color: Colors.transparent, // Background color (optional)
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'images/language.png',
              ), // Eighth image
              const SizedBox(height: 5),
              Text(
                'Boost Your Profile',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white // Dark mode text color
                      : Colors.black, // Light mode text color
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Increase visibility to get more matches.',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.6) // Dark mode text color
                      : Colors.black.withOpacity(0.6), // Light mode text color
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // Curved edges
          color: Colors.transparent, // Background color (optional)
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'images/language.png',
              ), // Eighth image
              const SizedBox(height: 5),
              Text(
                'Location-Based Swiping',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white // Dark mode text color
                      : Colors.black, // Light mode text color
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Connect with people near you.',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.6) // Dark mode text color
                      : Colors.black.withOpacity(0.6), // Light mode text color
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // Curved edges
          color: Colors.transparent, // Background color (optional)
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'images/language.png',
              ), // Eighth image
              const SizedBox(height: 5),
              Text(
                'Voice Call',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white // Dark mode text color
                      : Colors.black, // Light mode text color
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Talk directly with your matches.',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.6) // Dark mode text color
                      : Colors.black.withOpacity(0.6), // Light mode text color
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // Curved edges
          color: Colors.transparent, // Background color (optional)
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'images/language.png',
              ), // Eighth image
              const SizedBox(height: 5),
              Text(
                'Video Call',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white // Dark mode text color
                      : Colors.black, // Light mode text color
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Video chat in real-time.',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.6) // Dark mode text color
                      : Colors.black.withOpacity(0.6), // Light mode text color
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // Curved edges
          color: Colors.transparent, // Background color (optional)
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'images/language.png',
              ), // Eighth image
              const SizedBox(height: 5),
              Text(
                'Virtual Dates',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white // Dark mode text color
                      : Colors.black, // Light mode text color
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Enjoy virtual date experiences.',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.6) // Dark mode text color
                      : Colors.black.withOpacity(0.6), // Light mode text color
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // Curved edges
          color: Colors.transparent, // Background color (optional)
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'images/language.png',
              ), // Eighth image
              const SizedBox(height: 5),
              Text(
                'Libby, Virtual Assistant',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white // Dark mode text color
                      : Colors.black, // Light mode text color
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Get help with conversations and profile tips.',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.6) // Dark mode text color
                      : Colors.black.withOpacity(0.6), // Light mode text color
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // Curved edges
          color: Colors.transparent, // Background color (optional)
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'images/language.png',
              ), // Eighth image
              const SizedBox(height: 5),
              Text(
                'Incognito Mode',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white // Dark mode text color
                      : Colors.black, // Light mode text color
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Browse profiles anonymously.',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.6) // Dark mode text color
                      : Colors.black.withOpacity(0.6), // Light mode text color
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // Curved edges
          color: Colors.transparent, // Background color (optional)
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'images/language.png',
              ), // Eighth image
              const SizedBox(height: 5),
              Text(
                'Unlimited Passport',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white // Dark mode text color
                      : Colors.black, // Light mode text color
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Swipe anywhere globally.',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.6) // Dark mode text color
                      : Colors.black.withOpacity(0.6), // Light mode text color
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 110, // Adjust the height as needed
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
            ),
            items: containers.map((item) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0), // Curved edges
                  child: item, // Use the container directly
                ),
              );
            }).toList(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PlanCard(
                      price: 15.00,
                      duration: '2 weeks',
                      description: 'This plan expires in 14 days',
                      borderColor: blue,
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      onTap: () {
                        paymentService.makePayment(context, 15.0, "USD",
                            'Purchase for zenkonnect 2 weeks plan');
                      },
                    ),
                    const SizedBox(width: 20), // Space between containers
                    PlanCard(
                      price: 24.00,
                      duration: '1 month',
                      description: 'This plan expires in 30 days',
                      borderColor: blue,
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      onTap: () {
                        paymentService.makePayment(context, 24.0, "USD",
                            'Purchase for Zenkonnect 1 month plan');
                      },
                    ),
                    // Second Container with another container on top
                  ]),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PlanCard(
                    price: 124.00,
                    duration: '6 month',
                    description: 'This plan expires in 180 days',
                    borderColor: blue,
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    onTap: () {
                      paymentService.makePayment(context, 124.0, "USD",
                          'Purchase for Zenkonnect 6 month plan');
                    },
                  ),
                  const SizedBox(width: 20), // Space between containers
                  PlanCard(
                    price: 240.00,
                    duration: '1 year',
                    description: 'This plan expires in 365 days',
                    borderColor: blue,
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    onTap: () {
                      paymentService.makePayment(context, 240.0, "USD",
                          'Purchase for Zenkonnect standard 1 year plan');
                    },
                  ),

                  // Second Container with another container on top
                ],
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text(
                      'Get Now',
                      style: TextStyle(color: Color(0xFFFFFFFF)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildPremiumPlans() {
    return const Center(
      child: Text('Premium plan coming soon'),
    );
  }

  Widget buildSubscriptionCard(String duration, String price) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              duration,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              price,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

// Premium Tab Section

class PremiumTab extends StatelessWidget {
  const PremiumTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> containers = [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // Curved edges
          color: Colors.transparent, // Background color (optional)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'images/message.png',
                ), // First image
                const SizedBox(height: 5),
                Text(
                  'Send unlimited messages ',
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // Dark mode text color
                        : Colors.black, // Light mode text color
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Send messages to everyone on your list\nwithout restrictions',
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white.withOpacity(0.6) // Dark mode text color
                        : Colors.black
                            .withOpacity(0.6), // Light mode text color
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // Curved edges
          color: Colors.transparent, // Background color (optional)
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'images/goodbye.png',
              ), // Second image
              const SizedBox(height: 5),
              Text(
                'Say goodbye to ads',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white // Dark mode text color
                      : Colors.black, // Light mode text color
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Turn off all ads shown on the app.',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.6) // Dark mode text color
                      : Colors.black.withOpacity(0.6), // Light mode text color
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // Curved edges
          color: Colors.transparent, // Background color (optional)
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'images/threetimes.png',
              ), // Third image
              const SizedBox(height: 5),
              Text(
                'Get 3 times more matches',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white // Dark mode text color
                      : Colors.black, // Light mode text color
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Get more chances to be matched with your favourite people.',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.6) // Dark mode text color
                      : Colors.black.withOpacity(0.6), // Light mode text color
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // Curved edges
          color: Colors.transparent, // Background color (optional)
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'images/undo.png',
              ), // Fourth image
              const SizedBox(height: 5),
              Text(
                'Undo accidental left swipes',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white // Dark mode text color
                      : Colors.black, // Light mode text color
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'You can undo a left swipe.',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.6) // Dark mode text color
                      : Colors.black.withOpacity(0.6), // Light mode text color
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // Curved edges
          color: Colors.transparent, // Background color (optional)
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'images/bonus.png',
              ), // Fifth image
              const SizedBox(height: 5),
              Text(
                'Bonus credit on credit purchases in app',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white // Dark mode text color
                      : Colors.black, // Light mode text color
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Get up to 25% more credit on all credit purchases',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.6) // Dark mode text color
                      : Colors.black.withOpacity(0.6), // Light mode text color
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // Curved edges
          color: Colors.transparent, // Background color (optional)
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'images/pushmessage.png',
              ), // Sixth image
              const SizedBox(height: 5),
              Text(
                'Push your messages to the top of the recipient’s inbox',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white // Dark mode text color
                      : Colors.black, // Light mode text color
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Be the first on their list when you send a message',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.6) // Dark mode text color
                      : Colors.black.withOpacity(0.6), // Light mode text color
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // Curved edges
          color: Colors.transparent, // Background color (optional)
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'images/visibility.png',
              ), // Seventh image
              const SizedBox(height: 5),
              Text(
                'Get more visibility',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white // Dark mode text color
                      : Colors.black, // Light mode text color
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Get 3 times more visibility when you subscribe to premium',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.6) // Dark mode text color
                      : Colors.black.withOpacity(0.6), // Light mode text color
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // Curved edges
          color: Colors.transparent, // Background color (optional)
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'images/language.png',
              ), // Eighth image
              const SizedBox(height: 5),
              Text(
                'Instantly translate other languages to English',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white // Dark mode text color
                      : Colors.black, // Light mode text color
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Chat with anyone in their native language, instantly.',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.6) // Dark mode text color
                      : Colors.black.withOpacity(0.6), // Light mode text color
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 110, // Adjust the height as needed
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
            ),
            items: containers.map((item) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0), // Curved edges
                  child: item, // Use the container directly
                ),
              );
            }).toList(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Main container
                      Container(
                        width: 135,
                        height: 130,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: blue,
                            width: 3,
                          ),
                        ),
                        child: const Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '\$19.00',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'This plan expires in 14 days',
                                style: TextStyle(
                                    color: Color(0xFF958CFA), fontSize: 9),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Smaller container on top border
                      Positioned(
                        top: -15, // Position it above the main container
                        left: 25, // Adjust left position if needed
                        child: Container(
                          width: 90,
                          height: 30,
                          decoration: BoxDecoration(
                            color: blue,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: blue,
                              width: 2,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              '2 weeks',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20), // Space between containers

                  // Second Container with another container on top
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Main container
                      Container(
                        width: 135,
                        height: 130,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: blue,
                            width: 3,
                          ),
                        ),
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '\$34.00',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'This plan expires in 30 days',
                                style: TextStyle(
                                    color: Color(0xFF958CFA), fontSize: 9),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Smaller container on top border
                      Positioned(
                        top: -15, // Position it above the main container
                        left: 25, // Adjust left position if needed
                        child: Container(
                          width: 90,
                          height: 30,
                          decoration: BoxDecoration(
                            color: blue,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: blue,
                              width: 2,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              '1 month',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Main container
                      Container(
                        width: 135,
                        height: 130,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: blue,
                            width: 3,
                          ),
                        ),
                        child: const Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '\$210.00',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'This plan expires in 180 days',
                                style: TextStyle(
                                    color: Color(0xFF958CFA), fontSize: 9),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Smaller container on top border
                      Positioned(
                        top: -15, // Position it above the main container
                        left: 25, // Adjust left position if needed
                        child: Container(
                          width: 90,
                          height: 30,
                          decoration: BoxDecoration(
                            color: blue,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: blue,
                              width: 2,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              '6 months',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20), // Space between containers

                  // Second Container with another container on top
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Main container
                      Container(
                        width: 135,
                        height: 130,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: blue,
                            width: 3,
                          ),
                        ),
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '\$410.00',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'This plan expires in 365 days',
                                style: TextStyle(
                                    color: Color(0xFF958CFA), fontSize: 9),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Smaller container on top border
                      Positioned(
                        top: -15, // Position it above the main container
                        left: 25, // Adjust left position if needed
                        child: Container(
                          width: 90,
                          height: 30,
                          decoration: BoxDecoration(
                            color: blue,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: blue,
                              width: 2,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              '1 year',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text(
                      'Get Now',
                      style: TextStyle(color: Color(0xFFFFFFFF)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
