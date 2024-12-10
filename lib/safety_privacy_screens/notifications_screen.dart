import 'package:flutter/material.dart';
import 'package:love_bird/config/routes.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int _selectedOption = -1; // Start with no selection

  void _onOptionSelected(int? value) {
    setState(() {
      _selectedOption = value!;
    });
  }

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
              child: Image.asset(
                "images/ai.png",
              ),
            ),
            const SizedBox(width: 25), // Use SizedBox for spacing
            const Text(
              'Notifications',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                'Messages',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              subtitle: Text(
                "Get updates about new messages",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              trailing: Radio(
                value: 0,
                groupValue: _selectedOption,
                onChanged: _onOptionSelected,
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFF3628DD),
            ), // Reduced height
            ListTile(
              title: Text(
                'Show online status',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              subtitle: Text(
                "Get updates about new matches",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              trailing: Radio(
                value: 1,
                groupValue: _selectedOption,
                onChanged: _onOptionSelected,
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFF3628DD),
            ), // Reduced height
            ListTile(
              title: Text(
                'Allow public search',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              subtitle: Text(
                "Liked you",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              trailing: Radio(
                value: 2,
                groupValue: _selectedOption,
                onChanged: _onOptionSelected,
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFF3628DD),
            ), // Reduced height
            ListTile(
              title: Text(
                'Profile visitors',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              subtitle: Text(
                "Get notified when people visit your profile",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              trailing: Radio(
                value: 3,
                groupValue: _selectedOption,
                onChanged: _onOptionSelected,
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFF3628DD),
            ), // Reduced height
            ListTile(
              title: Text(
                'Profile tips & freebies',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              subtitle: Text(
                "Get updates on profile tips & freebies",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              trailing: Radio(
                value: 4,
                groupValue: _selectedOption,
                onChanged: _onOptionSelected,
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFF3628DD),
            ), // Reduced height
            ListTile(
              title: Text(
                'Show ads',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              subtitle: Text(
                "Get updates on profile tips & freebies",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              trailing: Radio(
                value: 5,
                groupValue: _selectedOption,
                onChanged: _onOptionSelected,
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFF3628DD),
            ), // Reduced height
            ListTile(
              title: Text(
                'Get notified if your match is using incognito mode ',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              subtitle: Text(
                "You must use incognito mode for this feature to work",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              trailing: Radio(
                value: 6,
                groupValue: _selectedOption,
                onChanged: _onOptionSelected,
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFF3628DD),
            ), // Reduced height
            ListTile(
              title: Text(
                'Left Swipes',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              subtitle: Text(
                "Get notified when you get a left swipe",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              trailing: Radio(
                value: 7,
                groupValue: _selectedOption,
                onChanged: _onOptionSelected,
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFF3628DD),
            ), // Reduced height
          ],
        ),
      ),
    );
  }
}
