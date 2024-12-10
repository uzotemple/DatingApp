import 'package:flutter/material.dart';
import 'package:love_bird/config/routes.dart';

class PrivacyNameOnSettingsScreen extends StatefulWidget {
  const PrivacyNameOnSettingsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PrivacyNameOnSettingsScreenState createState() =>
      _PrivacyNameOnSettingsScreenState();
}

class _PrivacyNameOnSettingsScreenState
    extends State<PrivacyNameOnSettingsScreen> {
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
              'Privacy',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Divider(
            color: Color(0xFF3628DD),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Name',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
