import 'package:flutter/material.dart';

import 'package:love_bird/providers/auth_provider.dart';

import 'package:love_bird/providers/interest_provider.dart';
import 'package:provider/provider.dart';
import 'package:love_bird/config/constants.dart';

class InterestsSelectionScreen extends StatelessWidget {
  const InterestsSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final interestsProvider = Provider.of<InterestsProvider>(context);
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal:
                MediaQuery.of(context).size.width * 0.05, // 5% of screen width
            vertical: MediaQuery.of(context).size.height *
                0.03, // 5% of screen height
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Your existing UI components
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 15,
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
                        width: MediaQuery.of(context).size.width * 0.6,
                        color: blue,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.03,
              ),
              Row(
                children: [
                  const Text(
                    'Discover Like-Minded People',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 2),
                  Image.asset('assets/images/icons/smile.png', width: 30),
                ],
              ),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              const Text(
                "Share your interests, passions, hobbies. We'll connect you with people who share your enthusiasm.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              TextField(
                onChanged: interestsProvider.onSearchQueryChanged,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromRGBO(149, 140, 250, 0.48),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Search Interest",
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                ),
                style: const TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: screenSize.height * 0.03,
              ),
              Wrap(
                spacing: 15.0,
                runSpacing: 15.0,
                children: interestsProvider.filteredInterests.map((interest) {
                  bool isSelected =
                      interestsProvider.selectedInterests.contains(interest);
                  return ChoiceChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          interest,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: screenSize.width * 0.02,
                        ),
                        Image.asset(
                          interestsProvider.interestIcons[interest]!,
                          width: screenSize.height * 0.026,
                          height: screenSize.height * 0.026,
                        ),
                      ],
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      interestsProvider.toggleInterest(interest);
                    },
                    selectedColor: blue,
                    backgroundColor: Colors.white,
                    shape: const StadiumBorder(
                      side: BorderSide(
                        color: blue,
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: screenSize.height * 0.08,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: interestsProvider.selectedInterests.isNotEmpty
                    ? () async {
                        final interestProvider = Provider.of<InterestsProvider>(
                            context,
                            listen: false);
                        final authProvider =
                            Provider.of<AuthProvider>(context, listen: false);
                        await interestProvider.updateInterest(
                            context, authProvider);
                      }
                    : null,
                child: Text(
                  "Continue (${interestsProvider.selectedInterests.length}/6)",
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
