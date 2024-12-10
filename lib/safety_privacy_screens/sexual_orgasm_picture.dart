import 'package:flutter/material.dart';
import 'package:love_bird/config/routes.dart';

class SexualOrgasmPicturesScreen extends StatefulWidget {
  const SexualOrgasmPicturesScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SexualOrgasmPicturesScreenState createState() =>
      _SexualOrgasmPicturesScreenState();
}

class _SexualOrgasmPicturesScreenState
    extends State<SexualOrgasmPicturesScreen> {
  bool marketingPermission = false;

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Sexual organ picture recognition and censoring',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            )),
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, geminiBot);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                "images/ai.png",
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                'Block all pictures with sexual organ contents before it is sent',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              subtitle: Text(
                "Turn on if you don’t want to see pictures with sexual organ content before it is sent",
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
                'Block but get notified when pictures with sexual organ contents has been sent',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              subtitle: Text(
                "Turn on if you want to get notified when a picture with sexual organ content has been sent",
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
                'Don’t block pictures with sexual organ contents',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              subtitle: Text(
                "I want to receive pictures with sexual organ contents",
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
