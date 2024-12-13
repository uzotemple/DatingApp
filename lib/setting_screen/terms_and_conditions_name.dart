import 'package:flutter/material.dart';
import 'package:love_bird/config/routes.dart';
import 'package:love_bird/config/constants.dart';

class TermsAndConditionsNameScreen extends StatefulWidget {
  const TermsAndConditionsNameScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TermsAndConditionsNameScreenState createState() =>
      _TermsAndConditionsNameScreenState();
}

class _TermsAndConditionsNameScreenState
    extends State<TermsAndConditionsNameScreen> {
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
        title: const Text(
          'Terms and Conditions',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, geminiBot);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Image.asset(
                "images/ai.png",
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Divider(
            color: blue,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
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
