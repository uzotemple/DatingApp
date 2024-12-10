import 'package:flutter/material.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PrivacyScreenState createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
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
        title: const Text(
          'Privacy',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
            // Handle back button action here
          },
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  'Show locnation',
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
              ListTile(
                title: Text(
                  'Turn off read receipt',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                subtitle: Text(
                  "You can only turn this off if you get Zenkonect Premium",
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
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
