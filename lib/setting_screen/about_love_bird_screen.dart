import 'package:flutter/material.dart';
import 'package:love_bird/config/routes.dart';

class AboutLoveBirdScreen extends StatelessWidget {
  const AboutLoveBirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, geminiBot);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Image.asset(
                  "images/ai.png",
                ),
              ),
            ),
            Container(width: 25),
            const Text(
              'About Zenkonect',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Divider(
            thickness: 1.0,
            color: Color(0xFF3628DD),
          ),
          const SizedBox(
            height: 100,
          ),
          Image.asset(
            "images/LoveBird.png",
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'v1.0.43',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.7) // Adjust for dark mode
                      : Colors.black.withOpacity(0.5), // Adjust for light mode
                ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Released on - 12/12/2024',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.7) // Adjust for dark mode
                      : Colors.black.withOpacity(0.5), // Adjust for light mode
                ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'branch: release_android_6.0111',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.7) // Adjust for dark mode
                      : Colors.black.withOpacity(0.5), // Adjust for light mode
                ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
            child: Center(
              child: Text(
                'Copyright 2024 Hans Technology, all rights reserved',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3628DD)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
