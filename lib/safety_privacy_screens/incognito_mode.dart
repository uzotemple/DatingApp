import 'package:flutter/material.dart';

class IncognitoModeScreen extends StatefulWidget {
  const IncognitoModeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _IncognitoModeScreenState createState() => _IncognitoModeScreenState();
}

class _IncognitoModeScreenState extends State<IncognitoModeScreen> {
  int _selectedOption = 0;

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
          'Incognito Mode',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                'Hide when you’re online',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              subtitle: Text(
                "People won't be able to see when you’re online. Available with Zenkonect Premium.",
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
            ListTile(
              title: Text(
                'Browse profiles privately',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              subtitle: Text(
                "People won't be able to see when you’re online. Available with Zenkonect Premium.",
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
            ListTile(
              title: Text(
                'Hide Zenkonect Premium',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              subtitle: Text(
                "People won’t know that you’ve got Zenkonect Premium. Available with Zenkonect Premium.",
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
          ],
        ),
      ),
    );
  }
}
