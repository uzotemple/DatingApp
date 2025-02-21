import 'package:flutter/material.dart';
import 'package:love_bird/onboarding/onboarding_screen_two.dart';
import 'package:love_bird/sign/sign.dart';
import 'package:love_bird/config/constants.dart';

class OnboardingScreenOne extends StatefulWidget {
  const OnboardingScreenOne({super.key});

  @override
  State<OnboardingScreenOne> createState() => _OnboardingScreenOneState();
}

class _OnboardingScreenOneState extends State<OnboardingScreenOne> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Onboarding One'),
      // ),
      body: SafeArea(
        child: Stack(
          children: [
            // Positioned background container to avoid covering the second container
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              // bottom: MediaQuery.of(context).size.height / 2.5, // Prevent overlap
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Content for the first container
                    SizedBox(
                        // width: 300,
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: screenSize.height * 0.8,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: blue, // Border color
                              width:
                                  10.0, // Border width (increase this to make it thicker)
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: screenSize.height * 0.02),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: screenSize.height * 0.02,
                                    bottom: screenSize.height * 0.01,
                                  ),
                                  child: SizedBox(
                                      child: Image.asset(
                                          "images/Rectangle 2.png")),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset("images/onboarding.png"),
                                    const Text(
                                      "Matches",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black, // Text color
                                      ),
                                    ),
                                    const Icon(Icons.search),
                                    Image.asset("images/filter.png"),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: screenSize.height * 0.009,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: screenSize.width * 0.3,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor: const Color(
                                                0xFF3628DD), // Text color
                                            elevation: 3,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          child: const Text(
                                            'Likes',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: screenSize.height * 0.009,
                                        ),
                                        child: SizedBox(
                                          // width: screenSize.width * 0.3,
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor: const Color(
                                                  0xFFD2CFFB), // Text color
                                              elevation: 3,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            child: const Text(
                                              'SuperLikes',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.32,
                                        child:
                                            Image.asset("images/Group 2.png"),
                                      ),
                                      SizedBox(width: screenSize.width * 0.02),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.32,
                                        child:
                                            Image.asset("images/Group 2.png"),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: screenSize.height * 0.01),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.32,
                                            child: Image.asset(
                                                "images/Group 3.png")),
                                        SizedBox(
                                            width: screenSize.width * 0.02),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.32,
                                            child: Image.asset(
                                                "images/Group 4.png")),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
            // Curved container positioned lower in the stack
            Positioned(
              bottom: 0, // Align to the bottom of the screen
              left: 0,
              right: 0,
              child: ClipPath(
                clipper: CurvedTopContainerClipper(),
                child: Container(
                  decoration: const BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  height: MediaQuery.of(context).size.height *
                      0.5, // Half of the screen height
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Center content vertically
                      children: [
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Discover Meaningful Connections',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // Text color
                            ),
                            textAlign: TextAlign.center, // Center align text
                          ),
                        ),
                        //  const SizedBox(height: 10), // Space between text
                        const Text(
                          'Join Zenkonect today and explore a world of meaningful connections. Swipe, match and meet like-minded people. ',
                          style: TextStyle(
                              fontSize: 18, color: Colors.white), // Text color
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset("images/Rectangle 10.png"),
                            ),
                            Image.asset("images/Rectangle 12.png"),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset("images/Rectangle 12.png"),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: screenSize.width *
                                  0.35, // Adjust width based on screen size
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    vertical: screenSize.height *
                                        0.02, // Responsive vertical padding
                                  ),
                                  foregroundColor: Colors.black,
                                  backgroundColor: const Color(
                                      0xFFD2CFFB), // Background color
                                  elevation: 3,
                                ),
                                child: Text(
                                  'Skip',
                                  style: TextStyle(
                                    fontSize: screenSize.width *
                                        0.045, // Responsive font size
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenSize.width *
                                  0.35, // Adjust width based on screen size
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const OnboardingScreenTwo(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    vertical: screenSize.height *
                                        0.02, // Responsive vertical padding
                                  ),
                                  foregroundColor: Colors.black,
                                  backgroundColor: const Color(
                                      0xFFFFFFFF), // Background color
                                  elevation: 3,
                                ),
                                child: Text(
                                  'Continue',
                                  style: TextStyle(
                                    fontSize: screenSize.width *
                                        0.045, // Responsive font size
                                    fontWeight: FontWeight.w400,
                                    color: Colors
                                        .blue, // Replace `blue` with your variable if defined
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom clipper for curved top border with rounded left and right edges
class CurvedTopContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height); // Start from bottom left
    path.lineTo(size.width, size.height); // Bottom right
    path.lineTo(size.width, -20); // Top right
    path.quadraticBezierTo(size.width / 2, 100, 0, -20); // Curved top left
    path.lineTo(0, 0); // Close to the starting point
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) =>
      true; // Reclip when necessary
}
