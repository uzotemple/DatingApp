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
  TextEditingController nicknameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nicknameController = TextEditingController(); // Initialize the controller
  }

  @override
  void dispose() {
    nicknameController.dispose(); // Dispose of the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final nicknameProvider =
        Provider.of<NicknameProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            right: screenSize.width * 0.05,
            left: screenSize.width * 0.05, // 5% of screen width
            top: screenSize.height * 0.03,
            bottom: screenSize.height * 0.05, // 5% of screen height
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Progress bar at the top
                      SizedBox(
                        width: screenSize.width,
                        height: screenSize.height * 0.02,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(color: blue.withOpacity(0.19)),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                  width: screenSize.width * 0.2, color: blue),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
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
                      const Text(
                        'Create a unique nickname that represents you, it’s how others will know and remember you.',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: screenSize.height * 0.045),
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
                                controller: nicknameController,
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
                  if (formKey.currentState!.validate()) {
                    nicknameProvider.updateName(
                        context,
                        authProvider,
                        nicknameController
                            .text // Make sure this value is passed
                        );
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
