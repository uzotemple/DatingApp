import 'package:flutter/material.dart';
import 'package:love_bird/config/routes.dart';

class PrivacyOnSettingsScreen extends StatefulWidget {
  const PrivacyOnSettingsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PrivacyOnSettingsScreenState createState() =>
      _PrivacyOnSettingsScreenState();
}

class _PrivacyOnSettingsScreenState extends State<PrivacyOnSettingsScreen> {
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
            const SizedBox(width: 45), // Use SizedBox for spacing
            const Text(
              'Privacy',
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
                'Show location',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              subtitle: Text(
                "Must be on if you want to see how near other users are. No one will know your actual location without your permission.",
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
            const Divider(),
            ListTile(
              title: Text(
                'Show online status',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              subtitle: Text(
                "Must be on if you want to see if other users are currently online.",
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
            const Divider(),
            ListTile(
              title: Text(
                'Allow public search',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              subtitle: Text(
                "People will be able to find your profile when searching the internet.",
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
            const Divider(),
            ListTile(
              title: Text(
                'Limit profile views',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              subtitle: Text(
                "Only the people you like and visit can see your profile",
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
            const Divider(),
            // This is the 5th item with no subtitle and an arrow forward icon
            ListTile(
              title: Text(
                'Ad and tracker preferences',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).iconTheme.color,
              ), // Change to icon
              onTap: () {
                // Handle tap action here
              },
            ),
            const Divider(),
            ListTile(
              title: Text(
                'Show ads',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              subtitle: Text(
                "You can remove ads if you get Zenkonect Premium",
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
            const Divider(),
          ],
        ),
      ),
    );
  }
}
