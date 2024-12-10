import 'package:flutter/material.dart';
import 'package:love_bird/config/routes.dart';
import 'package:love_bird/config/constants.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HelpCenterScreenState createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  bool marketingPermission = false;

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
              'Help Center',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(color: Color(0xFF3628DD)),
          const SizedBox(height: 5.0), // Space after the divider
          _buildSearchBar(), // Search bar
          const SizedBox(height: 10.0), // Space after the search bar
          // const SizedBox(height: 8.0), // Space before the list
          Expanded(
            child: ListView(
              children: [
                ListTile(
                    title: Text(
                  'Popular questions',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                )),
                ListTile(
                    title: Text(
                  'About Zenkonect',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                )),
                ListTile(
                    title: Text(
                  'Profile',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                )),
                ListTile(
                    title: Text(
                  'Profile verification',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                )),
                ListTile(
                    title: Text(
                  'People nearby and search',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                )),
                ListTile(
                    title: Text(
                  'Home',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                )),
                ListTile(
                    title: Text(
                  'Messages',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                )),
                ListTile(
                    title: Text(
                  'Zenkonect premium',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                )),
                ListTile(
                    title: Text(
                  'Credits',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                )),
                ListTile(
                    title: Text(
                  'Photos',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                )),
                ListTile(
                    title: Text(
                  'Settings and privacy',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.05,
        child: TextField(
          style:
              TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
          decoration: InputDecoration(
            filled: true,

            fillColor: blue.withOpacity(0.19), // Background color
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0), // Rounded corners
              borderSide: BorderSide.none, // No border
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0), // Rounded corners
              borderSide: BorderSide.none, // No border when enabled
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0), // Rounded corners
              borderSide: BorderSide.none, // No border when focused
            ),
            hintText: 'Search',
            hintStyle: TextStyle(
              color: Theme.of(context).hintColor,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Theme.of(context).iconTheme.color,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 30.0, // Padding inside the search bar
            ),
          ),
        ),
      ),
    );
  }
}
