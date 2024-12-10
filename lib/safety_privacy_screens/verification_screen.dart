import 'package:flutter/material.dart';
import 'package:love_bird/config/routes.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
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
              'Verifications',
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
                'Get verified',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              // subtitle: Text(
              //   "Get updates about new messages",
              //   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              //   fontSize: 12,
              //   fontWeight: FontWeight.w400,
              //   ),
              // ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFF3628DD),
            ), // Reduced height
            ListTile(
              title: Text(
                'Limit messages',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              subtitle: Text(
                "Turn on to only receive messages from verified users",
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
                'Hide verification details',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              subtitle: Text(
                "Turn on to hide verification details on your profile",
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
          ],
        ),
      ),
    );
  }
}
