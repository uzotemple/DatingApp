import 'package:flutter/material.dart';
import 'package:love_bird/config/routes.dart';
import 'package:love_bird/providers/birthday_provider.dart';
import 'package:love_bird/providers/nickname_provider.dart';
import 'package:provider/provider.dart';
import 'package:love_bird/config/constants.dart';

class CreateNickname extends StatelessWidget {
  const CreateNickname({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            right: MediaQuery.of(context).size.width * 0.05,
            left:
                MediaQuery.of(context).size.width * 0.05, // 5% of screen width
            top: MediaQuery.of(context).size.height * 0.03,
            bottom: MediaQuery.of(context).size.height *
                0.05, // 5% of screen height
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Progress bar at the top
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.02,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Outer rounded corners
                              child: Container(
                                color:
                                    blue.withOpacity(0.19), // Background color
                              ),
                            ),
                            // Inner progress bar
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Inner rounded corners
                              child: Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.2, // Set width to represent progress
                                  color: blue // Progress color
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Title
                      Row(children: [
                        const Text(
                          'Your Zenkonect Identity',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Image.asset('assets/images/icons/smile.png', width: 30),
                      ]),
                      const SizedBox(height: 10),
                      // Subtitle
                      const Text(
                        'Create a unique nickname that represents you, it’s how others will know and remember you.',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.045,
                      ),
                      // Nickname Text Field

                      Consumer<NicknameProvider>(
                          builder: (context, nicknameProvider, child) {
                        return Container(
                          width: screenSize.width * 0.9,
                          height: screenSize.width * 0.3,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(54, 40, 221, 0.19),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: blue, width: 1),
                          ),
                          child: Center(
                            child: TextField(
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color,
                                  fontSize: 25,
                                ),
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  hintText: 'Nickname',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    fontSize: 25,
                                    color: Color.fromRGBO(23, 14, 121, 0.173),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onChanged: (value) {
                                  nicknameProvider.setNickname(value);
                                }),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, celebrateYouScreen);
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
}

class CelebrateYouScreen extends StatelessWidget {
  const CelebrateYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            right: MediaQuery.of(context).size.width * 0.05,
            left:
                MediaQuery.of(context).size.width * 0.05, // 5% of screen width
            top: MediaQuery.of(context).size.height * 0.02,
            // 5% of screen width
            bottom: MediaQuery.of(context).size.height *
                0.05, // 5% of screen height
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Progress bar at the top
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.02,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Outer rounded corners
                              child: Container(
                                color:
                                    blue.withOpacity(0.19), // Background color
                              ),
                            ),
                            // Inner progress bar
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Inner rounded corners
                              child: Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.25, // Set width to represent progress
                                  color: blue // Progress color
                                  ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: screenSize.height * 0.04),
                      // Title
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Let\'s celebrate you',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.cake,
                            color: Colors.redAccent,
                            size: 28,
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.035),
                      // Birthday Cake Image
                      Image.asset(
                        'assets/images/cake.png',
                        height: screenSize.height * 0.25,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      // Date Fields
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildDateField(
                              context,
                              'MM',
                              (value) => context
                                  .read<CelebrateYouProvider>()
                                  .setMonth(value)),
                          _buildDateField(
                              context,
                              'DD',
                              (value) => context
                                  .read<CelebrateYouProvider>()
                                  .setDay(value)),
                          _buildDateField(
                              context,
                              'YYYY',
                              (value) => context
                                  .read<CelebrateYouProvider>()
                                  .setYear(value)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, gender);
                },
                child: Container(
                  width: screenSize.width * 0.8,
                  height: screenSize.height * 0.06,
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      'Continue',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateField(
      BuildContext context, String hint, Function(String) onChanged) {
    return Container(
      width: 80,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: blue,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: TextField(
          style:
              TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
            hintStyle: TextStyle(
              fontSize: 18,
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color.fromARGB(
                      255, 185, 182, 182) // Dark mode, use white
                  : const Color.fromRGBO(56, 53, 53, 1),
            ),
          ),
          keyboardType: TextInputType.number,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
