import 'package:flutter/material.dart';

import 'package:love_bird/config/constants.dart';

import 'package:love_bird/subscription%20plan/standard_plan.dart';

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
                'Extra Features',
                style: TextStyle(
                  fontSize: screenHeight * 0.025, // 2.5% of screen height
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Get Access to amazing features',
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
                        builder: (context) =>
                            const LoveBirdPlanPage(initialTabIndex: 1),
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
                    'Get Zenkonect Standard Plan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenHeight * 0.02, // 2% of screen height
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              //  SizedBox(height: screenHeight * 0.03), // 3% of screen height
              // Padding(
              //   padding: EdgeInsets.symmetric(
              //       horizontal: screenWidth * 0.04), // 4% of screen width
              //   child: ElevatedButton(
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => const PurchaseCreditsPage(),
              //         ),
              //       );
              //     },
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: blue,
              //       padding: EdgeInsets.symmetric(
              //         vertical: screenHeight * 0.02, // 2% of screen height
              //       ),
              //     ),
              //     child: Text(
              //       'Get Extra Views For 150 Credits',
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontSize: screenHeight * 0.02, // 2% of screen height
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ),
              // ),
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
                        builder: (context) =>
                            const LoveBirdPlanPage(initialTabIndex: 2),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02, // 2% of screen height
                    ),
                    side: const BorderSide(color: blue, width: 2),
                  ),
                  child: Text(
                    'Get Zenkonect Premium Plan',
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
