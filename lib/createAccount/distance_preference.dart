import 'package:flutter/material.dart';
import 'package:love_bird/config/routes.dart';
import 'package:love_bird/config/constants.dart';
import 'package:love_bird/providers/distance_preference_provider.dart';
import 'package:provider/provider.dart';

class DistancePreferenceScreen extends StatelessWidget {
  const DistancePreferenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    // Access the provider using Provider.of or Consumer
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal:
                MediaQuery.of(context).size.width * 0.05, // 5% of screen width
            vertical: MediaQuery.of(context).size.height *
                0.02, // 5% of screen height
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                width: screenSize.width * 0.5,
                                color: blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Find matches nearby ',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Image.asset(
                            'assets/images/icons/compass.png',
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.01),
                      const Text(
                        'Select your preferred distance range to discover matches conveniently. We\'ll help you find love close by.',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      SizedBox(height: screenSize.height * 0.04),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Distance Preference',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Consumer<DistanceProvider>(
                            builder: (context, distanceProvider, child) {
                              return Text(
                                distanceProvider.currentSliderValue == 100
                                    ? 'Unlimited'
                                    : '${distanceProvider.currentSliderValue.toInt()} km',
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.03),
                      // Slider
                      Consumer<DistanceProvider>(
                        builder: (context, distanceProvider, child) {
                          return Slider(
                            value: distanceProvider.currentSliderValue,
                            min: 1,
                            max: 100,
                            divisions: 100,
                            activeColor: const Color.fromRGBO(54, 40, 221, 1),
                            inactiveColor: Colors.grey[300],
                            label: distanceProvider.currentSliderValue == 100
                                ? 'Unlimited'
                                : '${distanceProvider.currentSliderValue.toInt()} km',
                            onChanged: (double value) {
                              distanceProvider.currentSliderValue = value;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.4),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, interestsSelectionScreen);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(54, 40, 221, 1),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Continue',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
