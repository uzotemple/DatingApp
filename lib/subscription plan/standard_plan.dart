import 'package:love_bird/config/routes.dart';
import 'package:love_bird/subscription%20plan/standard_plan_screen.dart';
import 'package:flutter/material.dart';
import 'package:love_bird/config/constants.dart';

class LoveBirdPlanPage extends StatefulWidget {
  final int initialTabIndex;

  const LoveBirdPlanPage({super.key, this.initialTabIndex = 0});

  @override
  State<LoveBirdPlanPage> createState() => _LoveBirdPlanPageState();
}

class _LoveBirdPlanPageState extends State<LoveBirdPlanPage> {
  //String _appBarTitle = 'Zenkonect Standard Plan'; // Default title
  late String _appBarTitle;
  late int _currentTabIndex;
  int _currentIndex = 4;

  @override
  void initState() {
    super.initState();
    _currentTabIndex = widget.initialTabIndex; // Set the initial tab index
    _updateAppBarTitle(_currentTabIndex);
  }

  void _updateAppBarTitle(int index) {
    setState(() {
      if (index == 0) {
        _appBarTitle = 'Zenkonect Free Plan';
      } else if (index == 1) {
        _appBarTitle = 'Zenkonect Standard Plan';
      } else if (index == 2) {
        _appBarTitle = 'Zenkonect Premium Plan';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      initialIndex: _currentTabIndex,
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              color: Colors.transparent,
              child: TabBar(
                onTap: (index) {
                  _updateAppBarTitle(index);
                  _currentTabIndex = index; // Update the current tab index
                },
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
                indicator: BoxDecoration(
                  color: const Color(0xFF3628DD),
                  borderRadius: BorderRadius.circular(10),
                ),
                indicatorWeight: 0.0,
                tabs: [
                  Tab(child: _buildTab('Free')),
                  Tab(child: _buildTab('Standard')),
                  Tab(child: _buildTab('Premium')),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  FreeTab(), // Widget for Free tab
                  StandardTab(), // Widget for Standard tab
                  PremiumTab(), // Widget for Premium tab
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

  Widget _buildTab(String title) {
    return Container(
      width: 150,
      height: 35,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: blue.withOpacity(0.6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(title),
    );
  }
}

// Free Tab

class FreeTab extends StatelessWidget {
  const FreeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const SizedBox(height: 10),

        // Features Section
        const Text(
          'Features',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        Container(
          decoration: BoxDecoration(
            color: blue.withOpacity(0.09),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF958CFA),
                  child: Icon(Icons.check),
                ),
                title: Stack(
                  children: [
                    // Shadow text
                    Text(
                      'Match and connect',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                                .withOpacity(0.6) // Light shadow in dark mode
                            : Colors.black
                                .withOpacity(0.6), // Light shadow in light mode
                      ),
                    ),
                    // Main text
                    Text(
                      'Match and connect',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white // White text in dark mode
                            : Colors.black, // Black text in light mode
                      ),
                    ),
                  ],
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF958CFA),
                  child: Icon(Icons.check),
                ),
                title: Text(
                  'Start conversations with matches.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // White text in dark mode
                        : Colors.black, // Black text in light mode
                  ),
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF958CFA),
                  child: Icon(Icons.check),
                ),
                title: Text(
                  'location-based swiping',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // White text in dark mode
                        : Colors.black, // Black text in light mode
                  ),
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF958CFA),
                  child: Icon(Icons.check),
                ),
                title: Text(
                  'Voice Call',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // White text in dark mode
                        : Colors.black, // Black text in light mode
                  ),
                ),
                tileColor: Colors.transparent,
              ),
            ],
          ),
        ),

        SizedBox(
          height:
              MediaQuery.of(context).size.height * 0.2, // 10% of screen height
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: blue,
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            textStyle: const TextStyle(fontSize: 18),
          ),
          child: const Text(
            '\$0.00',
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
          ),
        ),
      ],
    );
  }
}

// Standard Tab

class StandardTab extends StatelessWidget {
  const StandardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const SizedBox(height: 10),

        // Other Features Section
        const Text(
          'Features',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: blue.withOpacity(0.09),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF958CFA),
                  child: Icon(Icons.check),
                ),
                title: Stack(
                  children: [
                    // Shadow text
                    Text(
                      'Match and connect',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                                .withOpacity(0.6) // Light shadow in dark mode
                            : Colors.black
                                .withOpacity(0.6), // Light shadow in light mode
                      ),
                    ),
                    // Main text
                    Text(
                      'Match and connect',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white // White text in dark mode
                            : Colors.black, // Black text in light mode
                      ),
                    ),
                  ],
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF958CFA),
                  child: Icon(Icons.check),
                ),
                title: Text(
                  'Start conversations with matches.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // White text in dark mode
                        : Colors.black, // Black text in light mode
                  ),
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF958CFA),
                  child: Icon(Icons.check),
                ),
                title: Text(
                  'location-based swiping',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // White text in dark mode
                        : Colors.black, // Black text in light mode
                  ),
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF958CFA),
                  child: Icon(Icons.check),
                ),
                title: Text(
                  'Voice Call',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // White text in dark mode
                        : Colors.black, // Black text in light mode
                  ),
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF958CFA),
                  child: Icon(Icons.check),
                ),
                title: Text(
                  'Video call',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // White text in dark mode
                        : Colors.black, // Black text in light mode
                  ),
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF958CFA),
                  child: Icon(Icons.check),
                ),
                title: Text(
                  'Boost Your Profile',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // White text in dark mode
                        : Colors.black, // Black text in light mode
                  ),
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF958CFA),
                  child: Icon(Icons.check),
                ),
                title: Text(
                  'Send Unlimited likes',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // White text in dark mode
                        : Colors.black, // Black text in light mode
                  ),
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF958CFA),
                  child: Icon(Icons.check),
                ),
                title: Text(
                  'See all users who liked you',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // White text in dark mode
                        : Colors.black, // Black text in light mode
                  ),
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF958CFA),
                  child: Icon(Icons.check),
                ),
                title: Text(
                  'Undo accidental left swipes',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // White text in dark mode
                        : Colors.black, // Black text in light mode
                  ),
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF958CFA),
                  child: Icon(Icons.check),
                ),
                title: Text(
                  'Unlimited Passport Mode',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // White text in dark mode
                        : Colors.black, // Black text in light mode
                  ),
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF958CFA),
                  child: Icon(Icons.check),
                ),
                title: Text(
                  'Access to Libby, virtual assistant',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // White text in dark mode
                        : Colors.black, // Black text in light mode
                  ),
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF958CFA),
                  child: Icon(Icons.check),
                ),
                title: Text(
                  'Virtual dates',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // White text in dark mode
                        : Colors.black, // Black text in light mode
                  ),
                ),
                tileColor: Colors.transparent,
              ),
            ],
          ),
        ),

        // Bottom Button
        SizedBox(
          height:
              MediaQuery.of(context).size.height * 0.05, // 10% of screen height
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StandardPlan()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: blue,
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            textStyle: const TextStyle(fontSize: 18),
          ),
          child: const Text(
            'Get Now From \$15.00',
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class PremiumTab extends StatelessWidget {
  const PremiumTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const SizedBox(height: 10),

        // Other Features Section
        const Text(
          'Features',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: blue.withOpacity(0.09),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF958CFA),
                  child: Icon(Icons.check),
                ),
                title: Stack(
                  children: [
                    // Shadow text
                    Text(
                      'Match and connect',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                                .withOpacity(0.6) // Light shadow in dark mode
                            : Colors.black
                                .withOpacity(0.6), // Light shadow in light mode
                      ),
                    ),
                    // Main text
                    Text(
                      'Match and connect',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white // White text in dark mode
                            : Colors.black, // Black text in light mode
                      ),
                    ),
                  ],
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF958CFA),
                  child: Icon(Icons.check),
                ),
                title: Text(
                  'Start conversations with matches.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // White text in dark mode
                        : Colors.black, // Black text in light mode
                  ),
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF958CFA),
                  child: Icon(Icons.check),
                ),
                title: Text(
                  'location-based swiping',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // White text in dark mode
                        : Colors.black, // Black text in light mode
                  ),
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF958CFA),
                  child: Icon(Icons.check),
                ),
                title: Text(
                  'Voice Call',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // White text in dark mode
                        : Colors.black, // Black text in light mode
                  ),
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF958CFA),
                  child: Icon(Icons.check),
                ),
                title: Text(
                  'Video call',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // White text in dark mode
                        : Colors.black, // Black text in light mode
                  ),
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF958CFA),
                  child: Icon(Icons.check),
                ),
                title: Text(
                  'Boost Your Profile',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // White text in dark mode
                        : Colors.black, // Black text in light mode
                  ),
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF958CFA),
                  child: Icon(Icons.check),
                ),
                title: Text(
                  'Send Unlimited likes',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // White text in dark mode
                        : Colors.black, // Black text in light mode
                  ),
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF958CFA),
                  child: Icon(Icons.check),
                ),
                title: Text(
                  'See all users who liked you',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // White text in dark mode
                        : Colors.black, // Black text in light mode
                  ),
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF958CFA),
                  child: Icon(Icons.check),
                ),
                title: Text(
                  'Undo accidental left swipes',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // White text in dark mode
                        : Colors.black, // Black text in light mode
                  ),
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF958CFA),
                  child: Icon(Icons.check),
                ),
                title: Text(
                  'Unlimited Passport Mode',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // White text in dark mode
                        : Colors.black, // Black text in light mode
                  ),
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF958CFA),
                  child: Icon(Icons.check),
                ),
                title: Text(
                  'Access to Libby, virtual assistant',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // White text in dark mode
                        : Colors.black, // Black text in light mode
                  ),
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF958CFA),
                  child: Icon(Icons.check),
                ),
                title: Text(
                  'Virtual dates',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // White text in dark mode
                        : Colors.black, // Black text in light mode
                  ),
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF958CFA),
                  child: Icon(Icons.check),
                ),
                title: Text(
                  'See all users who super liked you',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // White text in dark mode
                        : Colors.black, // Black text in light mode
                  ),
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF958CFA),
                  child: Icon(Icons.check),
                ),
                title: Text(
                  'Add a personal note to super likes',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // White text in dark mode
                        : Colors.black, // Black text in light mode
                  ),
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF958CFA),
                  child: Icon(Icons.check),
                ),
                title: Text(
                  'Incognito Mode',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white // White text in dark mode
                        : Colors.black, // Black text in light mode
                  ),
                ),
                tileColor: Colors.transparent,
              ),
            ],
          ),
        ),

        // Bottom Button
        SizedBox(
          height:
              MediaQuery.of(context).size.height * 0.05, // 10% of screen height
        ),

        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StandardPlan()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: blue,
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            textStyle: const TextStyle(fontSize: 18),
          ),
          child: const Text(
            'Get Now From \$19.00',
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
          ),
        ),
      ],
    );
  }
}
