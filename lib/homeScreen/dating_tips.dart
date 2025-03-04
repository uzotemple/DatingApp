import 'package:flutter/material.dart';

import 'package:love_bird/config/routes.dart';
import 'package:love_bird/config/constants.dart';

class DatingPicture extends StatefulWidget {
  const DatingPicture({super.key});

  @override
  _DatingPictureState createState() => _DatingPictureState();
}

class _DatingPictureState extends State<DatingPicture> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  int _currentIndex = 4;
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                    context, chatbotWelcomeScreen); // Call the popup function
              },
              child: Image.asset('assets/images/robot.png', width: 40),
            ),
            const SizedBox(width: 30), // Add some spacing
            const Text(
              'Dating Tips',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: blue,
              ),
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: [
          // First page (image with Dating Tips)
          Column(
            children: [
              // Middle Image Section
              Expanded(
                child: Stack(
                  children: [
                    // Main image aligned to the left
                    Positioned(
                      left: 0, // Positioning to the left side
                      top: screenHeight * 0.02, // Position from the top
                      child: Image.asset(
                        'assets/images/dateNo.png',
                        height: screenHeight * 0.68, // Adjust height
                        fit: BoxFit.fill,
                      ),
                    ),

                    Positioned(
                      top: screenHeight * 0.13,
                      right: screenHeight * 0.01,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset(
                            'assets/images/textdate.png',
                            fit: BoxFit.contain,
                          ),
                          Image.asset(
                            'assets/images/arrowdate.png',
                            width: 40,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Page indicators
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PageIndicator(isActive: _currentPage == 0),
                    const SizedBox(width: 10),
                    PageIndicator(isActive: _currentPage == 1),
                  ],
                ),
              ),
            ],
          ),

          // Second page
          const DatingTipsPage(),
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

// Custom widget for page indicator
class PageIndicator extends StatelessWidget {
  final bool isActive;

  const PageIndicator({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.08,
      height: screenHeight * 0.017,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? blue : Colors.grey,
      ),
    );
  }
}

class DatingTipsPage extends StatefulWidget {
  const DatingTipsPage({super.key});

  @override
  State<DatingTipsPage> createState() => _DatingTipsPageState();
}

class _DatingTipsPageState extends State<DatingTipsPage> {
  @override
  Widget build(BuildContext context) {
    final List<String> datingBlue = [
      """The questions are:,\n
 1. What side of me did they bring out?\n
 2. How did my body feel during the date? Stiff, relaxed, or somewhere in between?\n
 3. Do I feel more energized or de-energized than I did before the date?\n
 4. Is there something about them that I'm curious about?\n
 5. Did they make me laugh?\n
 6. Did I feel heard?\n
 7. Did I feel attractive in their presence?\n
 8. Did I feel captivated, bored, or something in between?"""
    ];
    final List<String> datingTips2 = [
      "By the third date, be sure to ask about family and deal breakers.",
      "Always give yourself grace.",
    ];
    final List<String> datingTips = [
      "Before you start swiping, get into a playful mood.",
      "Use dates as an opportunity to connect with someone, no strings attached.",
      "Don't rely on only one form of dating to try to meet someone.",
      "Take it slow; plan but not too fast.",
      "Prioritize your dating life as much as your work life.",
      "Expect challenges and have support ready for when things get tough.",
      "Use dates as an opportunity to connect with someone, no strings attached.",
      "Do a chemistry test before meeting someone from an app.",
      "Have only one expectation on a first date: to enjoy yourself.",
      "Don’t allow your phone to become the third wheel on your date.",
      "Focus on quality over quantity",
      "Suggest plans if you want to keep in touch.",
      "When using dating apps, reference a match's profile to keep the cnversation flowing.",
      "To start the conversation, give a compliment or ask for advice.",
      "Always ask a match, 'What keeps you busy?'",
      "Get curious about a match's differences instead of writing them off.",
      "On the first date, ask about your date's career and relationships.",
      "If you're enjoying the date, end it with an 'accidental touch.'",
      "After a first date, ask yourself 8 questions to decide if you could be compatible for the long term.",
    ];

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          const Divider(thickness: 2, color: blue),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ListView.builder(
                      physics:
                          const NeverScrollableScrollPhysics(), // Prevent inner scroll
                      shrinkWrap:
                          true, // Makes ListView take only necessary space
                      itemCount: datingTips.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading:
                              Image.asset('assets/images/icons/loveTips.png'),
                          title: Text(
                            datingTips[index],
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: 16,
                                ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ListView.builder(
                      physics:
                          const NeverScrollableScrollPhysics(), // Prevent inner scroll
                      shrinkWrap:
                          true, // Makes ListView take only necessary space
                      itemCount: datingBlue.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            datingBlue[index],
                            style: const TextStyle(
                                fontSize: 16, color: blue, height: 1),
                          ),
                        );
                      },
                    ),
                  ),
                  ListView.builder(
                    physics:
                        const NeverScrollableScrollPhysics(), // Prevent inner scroll
                    shrinkWrap:
                        true, // Makes ListView take only necessary space
                    itemCount: datingTips2.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.favorite_border_outlined,
                            color: blue),
                        title: Text(
                          datingTips2[index],
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 16,
                                  ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: screenWidth * 0.08,
                height: screenHeight * 0.017,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
              ),
              SizedBox(width: screenWidth * 0.007),
              Container(
                width: screenWidth * 0.08,
                height: screenHeight * 0.017,
                decoration:
                    const BoxDecoration(shape: BoxShape.circle, color: blue),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
