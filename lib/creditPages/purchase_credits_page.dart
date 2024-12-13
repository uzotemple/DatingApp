import 'package:flutter/material.dart';
import 'package:love_bird/config/constants.dart';
import 'package:love_bird/config/routes.dart';

import 'package:love_bird/homeScreen/homescreen.dart';

class PurchaseCreditsPage extends StatelessWidget {
  const PurchaseCreditsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_outlined, size: 30)),
        title: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, chatbotWelcomeScreen);
          },
          child: Image.asset(
            'assets/images/robot.png',
            width: screenSize.width * 0.08,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          right: screenSize.width * 0.055,
          left: screenSize.width * 0.055,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: screenSize.height * 0.009,
              ),
              child: const Text(
                "Get more messages, matches, and get to the top at one click!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: blue),
              ),
            ),
            SizedBox(height: screenSize.height * 0.01),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: screenSize.height * 0.04),
                  // First Row (50 credits, N500.00)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CreditOption(
                        onPressed: () {
                          Navigator.pushNamed(context, payPal);
                        },
                        credits: '50 credits',
                        price: 'N500.00',
                        description: 'Send up to 15 messages',
                      ),
                      const Spacer(),
                      CreditOption(
                        onPressed: () {
                          Navigator.pushNamed(context, payPal);
                        },
                        credits: '150 credits',
                        price: 'N1,100',
                        description:
                            'Send up to 25 messages, and get more chances to be matched instantly',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenSize.width * 0.09,
                  ),
                  // Second Row (200 credits, N1600)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CreditOption(
                        onPressed: () {
                          Navigator.pushNamed(context, payPal);
                        },
                        credits: '200 credits',
                        price: 'N1,600',
                        description:
                            'Send up to 30 messages, get more chances to be matched instantly, and appear at the top on people nearby',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Buttons at the bottom
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle continue action
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: blue),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.deepPurple.shade100,
                  ),
                  child: const Text(
                    'Close',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.04,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CreditOption extends StatelessWidget {
  final String credits;
  final String price;
  final String description;
  final VoidCallback onPressed;
  const CreditOption({
    super.key,
    required this.credits,
    required this.price,
    required this.description,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: onPressed,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: screenSize.width * 0.4,
            height: screenSize.height * 0.2,
            padding: const EdgeInsets.only(top: 40, bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: blue,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  price,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: screenSize.width * 0.009),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color.fromRGBO(149, 140, 250, 1),
                    fontSize: 8,
                  ),
                ),
              ],
            ),
          ),

          // Stacked "200 credits" container
          Positioned(
            top: -10, // This aligns the container to sit on the border
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.05,
                  vertical: screenSize.height * 0.005),
              decoration: BoxDecoration(
                color: blue,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                credits,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
