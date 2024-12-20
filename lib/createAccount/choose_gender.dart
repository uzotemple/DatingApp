import 'package:flutter/material.dart';
import 'package:love_bird/config/routes.dart';
import 'package:love_bird/providers/gender_provider.dart';
import 'package:provider/provider.dart';
import 'package:love_bird/config/constants.dart';

class Gender extends StatelessWidget {
  const Gender({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final genderProvider =
        Provider.of<GenderProvider>(context); // Access the provider

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            right: MediaQuery.of(context).size.width * 0.05,
            left:
                MediaQuery.of(context).size.width * 0.05, // 5% of screen width
            top: MediaQuery.of(context).size.height * 0.03,
            bottom: MediaQuery.of(context).size.height * 0.05,
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: screenSize.width,
                        height: screenSize.height * 0.02,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                color: blue.withOpacity(0.19),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: screenSize.width * 0.3,
                                color: blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenSize.width * 0.046,
                      ),
                      Row(children: [
                        const Text(
                          'Be True To Yourself',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Image.asset('assets/images/star.png', width: 30),
                      ]),
                      SizedBox(
                        height: screenSize.height * 0.03,
                      ),
                      const Text(
                        'Choose the gender that best represents you.',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const Text(
                        ' Authenticity is the key to meaningful connections.',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.06,
                      ),
                      buildGenderOption('Man', 1, screenSize, genderProvider),
                      SizedBox(
                        height: screenSize.height * 0.04,
                      ),
                      buildGenderOption('Woman', 2, screenSize, genderProvider),
                      SizedBox(
                        height: screenSize.height * 0.04,
                      ),
                      buildGenderOption("I'd Prefer Not to Say", 3, screenSize,
                          genderProvider),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, relationshipGoalsScreen);
                },
                child: Container(
                  width: screenSize.width * 0.8,
                  height: screenSize.height * 0.05,
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text('Continue',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build the gender options dynamically
  Widget buildGenderOption(
      String label, int value, Size screenSize, GenderProvider genderProvider) {
    return InkWell(
      onTap: () {
        genderProvider
            .setGender(value); // Update the selected gender through provider
      },
      child: Container(
        width: screenSize.width * 0.8,
        height: screenSize.height * 0.05,
        decoration: BoxDecoration(
          color: genderProvider.selectedGender == value ? blue : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: blue,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: genderProvider.selectedGender == value
                  ? Colors.white
                  : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
