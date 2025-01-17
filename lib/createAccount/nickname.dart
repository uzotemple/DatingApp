import 'package:flutter/material.dart';

import 'package:love_bird/providers/auth_provider.dart';

import 'package:love_bird/providers/nickname_provider.dart';
import 'package:provider/provider.dart';
import 'package:love_bird/config/constants.dart';

class CreateNickname extends StatefulWidget {
  const CreateNickname({super.key});

  @override
  State<CreateNickname> createState() => _CreateNicknameState();
}

final formKey = GlobalKey<FormState>();

class _CreateNicknameState extends State<CreateNickname> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final nicknameProvider =
        Provider.of<NicknameProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final TextEditingController nicknameController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            right: MediaQuery.of(context).size.width * 0.05,
            left:
                MediaQuery.of(context).size.width * 0.05, // 5% of screen width
            top: MediaQuery.of(context).size.height * 0.03,
            bottom: MediaQuery.of(context).size.height *
                0.05, // 5% of screen height
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Progress bar at the top
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.02,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Outer rounded corners
                              child: Container(
                                color:
                                    blue.withOpacity(0.19), // Background color
                              ),
                            ),
                            // Inner progress bar
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Inner rounded corners
                              child: Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.2, // Set width to represent progress
                                  color: blue // Progress color
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Title
                      Row(children: [
                        const Text(
                          'Your Zenkonect Identity',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Image.asset('assets/images/icons/smile.png', width: 30),
                      ]),
                      const SizedBox(height: 10),
                      // Subtitle
                      const Text(
                        'Create a unique nickname that represents you, it’s how others will know and remember you.',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.045,
                      ),
                      // Nickname Text Field
                      Form(
                          key: formKey,
                          child: Container(
                            width: screenSize.width * 0.9,
                            height: screenSize.width * 0.3,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(54, 40, 221, 0.19),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: blue, width: 1),
                            ),
                            child: Center(
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Nickname cannot be empty';
                                  }
                                  if (value.length < 5) {
                                    return 'Nickname must not be less than 5 characters';
                                  }
                                  if (value.length > 20) {
                                    return 'Nickname must not be more than 20 characters long';
                                  }
                                  if (value.contains(' ')) {
                                    return 'Nickname must not contain spaces';
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color,
                                  fontSize: 25,
                                ),
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  hintText: 'Nickname',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    fontSize: 25,
                                    color: Color.fromRGBO(23, 14, 121, 0.173),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  //  Navigator.pushNamed(context, gender);
                  if (formKey.currentState!.validate()) {
                    nicknameProvider.setNickname(nicknameController.text);
                    nicknameProvider.updateName(context, authProvider);
                  }
                },
                child: Container(
                  width: screenSize.width * 0.8,
                  height: screenSize.height * 0.05,
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text('Continue',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
