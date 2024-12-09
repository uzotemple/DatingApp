import 'package:love_bird/config/routes.dart';
import 'package:love_bird/subscription%20plan/standard_plan_screen.dart';
import 'package:flutter/material.dart';
import 'package:love_bird/config/constants.dart';

class LoveBirdPlanPage extends StatefulWidget {
  const LoveBirdPlanPage({super.key});

  @override
  State<LoveBirdPlanPage> createState() => _LoveBirdPlanPageState();
}

class _LoveBirdPlanPageState extends State<LoveBirdPlanPage> {
  String _appBarTitle = 'Zenkonect Standard Plan'; // Default title

  void _onTabChanged(int index) {
    setState(() {
      _appBarTitle = index == 0
          ? 'Zenkonect Standard Plan' // Title for Standard Tab
          : 'Zenkonect Premium Plan'; // Title for Premium Tab
    });
  }

  @override
  Widget build(BuildContext context) {
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
                items: [
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/images/icons/homeBlack.png',
                      width: MediaQuery.of(context).size.width *
                          0.08, // 7% of width
                      height: MediaQuery.of(context).size.width * 0.08,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/images/icons/localcon.png',
                      width: MediaQuery.of(context).size.width * 0.08,
                      height: MediaQuery.of(context).size.width * 0.08,
                    ),
                    label: 'People Nearby',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/images/icons/chatIcon.png',
                      width: MediaQuery.of(context).size.width * 0.08,
                      height: MediaQuery.of(context).size.width * 0.08,
                    ),
                    label: 'Chats',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/images/icons/matches.png',
                      width: MediaQuery.of(context).size.width * 0.08,
                      height: MediaQuery.of(context).size.width * 0.08,
                    ),
                    label: 'Matches',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/images/icons/blueProfile.png',
                      width: MediaQuery.of(context).size.width * 0.07,
                      height: MediaQuery.of(context).size.width * 0.07,
                    ),
                    label: 'Profile',
                  ),
                ],
                selectedLabelStyle: TextStyle(
                  fontSize:
                      MediaQuery.of(context).size.width * 0.03, // 3% of width
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                ),
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
      ),
    );
  }
}

class StandardTab extends StatelessWidget {
  const StandardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Messages Section
        const Text(
          'Messages',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        // ListTile with curved angles and color
        Container(
          decoration: BoxDecoration(
            color: blue.withOpacity(0.09), // Background color
            borderRadius: BorderRadius.circular(10.0), // Curved angles
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.all(10.0), // Add padding to the ListTile
            leading: Image.asset("images/message.png"),
            title: const Text('Send unlimited messages'),
            tileColor: Colors
                .transparent, // Make the ListTile's background transparent
          ),
        ),
        const SizedBox(height: 20),

        // Other Features Section
        const Text(
          'Other features',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        // Use the same approach for other ListTiles
        Container(
          decoration: BoxDecoration(
            color: blue.withOpacity(0.09),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              ListTile(
                leading: Image.asset("images/goodbye.png"),
                title: const Stack(
                  children: [
                    // Shadow text
                    Text(
                      'Say goodbye to ads',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white, // Shadow color with opacity
                        // You can adjust the position with the Offset
                        shadows: [
                          Shadow(
                            offset: Offset(
                                5.0, 5.0), // Adjust the offset for the shadow
                            color: Colors.white, // Shadow color
                            blurRadius: 7.0, // Softness of the shadow
                          ),
                        ],
                      ),
                    ),
                    // Main text
                    Text(
                      'Say goodbye to ads',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black, // Main text color
                      ),
                    ),
                  ],
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: Image.asset("images/threetimes.png"),
                title: const Text(
                  'Get 3 times more matches',
                  style: TextStyle(fontSize: 16),
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: Image.asset("images/undo.png"),
                title: const Text(
                  'Undo accidental left swipes',
                  style: TextStyle(fontSize: 16),
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: Image.asset("images/bonus.png"),
                title: const Text(
                  'Bonus credit on credit purchases in app',
                  style: TextStyle(fontSize: 16),
                ),
                tileColor: Colors.transparent,
              ),
            ],
          ),
        ),
        // Bottom Button
        // const Spacer(),
        const SizedBox(height: 100),
        ElevatedButton(
          onPressed: () {
            // Navigate to the Standard Plan page
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
            'Get Now From N1,200',
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
        // Messages Section
        const Text(
          'Messages',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        // ListTile with curved angles and color
        Container(
          decoration: BoxDecoration(
            color: blue.withOpacity(0.09), // Background color
            borderRadius: BorderRadius.circular(10.0), // Curved angles
          ),
          child: Column(
            children: [
              ListTile(
                contentPadding:
                    const EdgeInsets.all(10.0), // Add padding to the ListTile
                leading: Image.asset("images/message.png"),
                title: const Text(
                  'Send unlimited messages',
                  style: TextStyle(fontSize: 16),
                ),
                tileColor: Colors
                    .transparent, // Make the ListTile's background transparent
              ),
              ListTile(
                contentPadding:
                    const EdgeInsets.all(10.0), // Add padding to the ListTile
                leading: Image.asset("images/pushmessage.png"),
                title: const Text(
                  'Push your messages to the top of the recipient’s inbox',
                  style: TextStyle(fontSize: 16),
                ),
                tileColor: Colors
                    .transparent, // Make the ListTile's background transparent
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Other Features Section
        const Text(
          'Other features',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        // Use the same approach for other ListTiles
        Container(
          decoration: BoxDecoration(
            color: blue.withOpacity(0.09),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              ListTile(
                leading: Image.asset("images/visibility.png"),
                title: const Stack(
                  children: [
                    // Shadow text
                    Text(
                      'Get more visibility',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white, // Shadow color with opacity
                        // You can adjust the position with the Offset
                        shadows: [
                          Shadow(
                            offset: Offset(
                                5.0, 5.0), // Adjust the offset for the shadow
                            color: Colors.white, // Shadow color
                            blurRadius: 7.0, // Softness of the shadow
                          ),
                        ],
                      ),
                    ),
                    // Main text
                    Text(
                      'Get more visibility',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black, // Main text color
                      ),
                    ),
                  ],
                ),
                tileColor: Colors.transparent,
              ),

              // say goodbye to ads
              ListTile(
                leading: Image.asset("images/goodbye.png"),
                title: const Stack(
                  children: [
                    // Shadow text
                    Text(
                      'Say goodbye to ads',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white, // Shadow color with opacity
                        // You can adjust the position with the Offset
                        shadows: [
                          Shadow(
                            offset: Offset(
                                5.0, 5.0), // Adjust the offset for the shadow
                            color: Colors.white, // Shadow color
                            blurRadius: 7.0, // Softness of the shadow
                          ),
                        ],
                      ),
                    ),
                    // Main text
                    Text(
                      'Say goodbye to ads',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black, // Main text color
                      ),
                    ),
                  ],
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: Image.asset("images/threetimes.png"),
                title: const Text(
                  'Get 3 times more matches',
                  style: TextStyle(fontSize: 16),
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: Image.asset("images/undo.png"),
                title: const Text(
                  'Undo accidental left swipes',
                  style: TextStyle(fontSize: 16),
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: Image.asset("images/bonus.png"),
                title: const Text(
                  'Bonus credit on credit purchases in app',
                  style: TextStyle(fontSize: 16),
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: Image.asset("images/language.png"),
                title: const Text(
                  'Instantly translate other languages to English',
                  style: TextStyle(fontSize: 16),
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: Image.asset("images/like.png"),
                title: const Text(
                  'Unlock the people who already sent you a like',
                  style: TextStyle(fontSize: 16),
                ),
                tileColor: Colors.transparent,
              ),
              ListTile(
                leading: Image.asset("images/privately.png"),
                title: const Text(
                  'Browse profiles privately, hide your profile for everyone except your existing matches',
                  style: TextStyle(fontSize: 16),
                ),
                tileColor: Colors.transparent,
              ),
            ],
          ),
        ),
        // Bottom Button
        const SizedBox(height: 20),
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
            'Get Now From N1,500',
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
          ),
        ),
      ],
    );
  }
}
