import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:love_bird/config/constants.dart';
import 'package:love_bird/config/routes.dart';

import 'package:love_bird/providers/image_provider.dart';
import 'package:provider/provider.dart';

class PhotoVerificationOneAfter extends StatefulWidget {
  const PhotoVerificationOneAfter({super.key});

  @override
  _PhotoVerificationOneAfterState createState() =>
      _PhotoVerificationOneAfterState();
}

class _PhotoVerificationOneAfterState extends State<PhotoVerificationOneAfter> {
  final ImagePicker _picker = ImagePicker();

  // Image picker logic
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      // Replace the first image in the list with the new image
      Provider.of<ImageProviderModel>(context, listen: false)
          .addImage(0, File(pickedFile.path)); // Replace the first image
    }
  }

  void _showImageSourceMenu(BuildContext context) {
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(2, 300, 0, 100),
      items: [
        const PopupMenuItem<ImageSource>(
          value: ImageSource.gallery,
          child: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.photo_library, size: 16, color: Colors.black),
                SizedBox(width: 8),
                Text('Pick from gallery', style: TextStyle(fontSize: 10)),
              ],
            ),
          ),
        ),
        const PopupMenuItem<ImageSource>(
          value: ImageSource.camera,
          child: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.camera_alt, size: 16, color: Colors.black),
                SizedBox(width: 3),
                Text('Take a photo', style: TextStyle(fontSize: 10)),
              ],
            ),
          ),
        ),
      ],
    ).then((value) {
      if (value != null) {
        _pickImage(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Access the first image from ImageProviderModel
    final firstImage = Provider.of<ImageProviderModel>(context).images[0];
    final screenSize = MediaQuery.of(context).size;
    // bool isTapped = true;
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              MediaQuery.of(context).size.width * 0.05, // 5% of screen width
          vertical:
              MediaQuery.of(context).size.height * 0.03, // 5% of screen height
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: screenSize.width,
                      height: screenSize.height * 0.02,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              color: blue.withOpacity(0.19),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              width: screenSize.width * 0.8,
                              color: blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenSize.width * 0.046,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Photo Verification',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 5),
                        Image.asset('assets/images/verify.png', height: 40),
                      ],
                    ),
                    const SizedBox(height: 15),
                    // Stack(
                    //   children: [
                    //     Center(
                    //       child: CircleAvatar(
                    //         radius: 80,
                    //         backgroundImage: firstImage != null
                    //             ? FileImage(firstImage)
                    //             : const AssetImage('assets/your_image.png')
                    //                 as ImageProvider,
                    //       ),
                    //     ),
                    //     Positioned(
                    //       bottom: 0,
                    //       right: 0,
                    //       child: GestureDetector(
                    //         onTap: () => _showImageSourceMenu(context),
                    //         child: Container(
                    //           decoration: BoxDecoration(
                    //             color: const Color.fromRGBO(197, 202, 227, 1),
                    //             shape: BoxShape.circle,
                    //           ),
                    //           child: const Center(
                    //               child: Icon(Icons.camera_alt,
                    //                   color: Colors.black)),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundImage: firstImage != null
                              ? FileImage(firstImage)
                              : const AssetImage('assets/your_image.png')
                                  as ImageProvider,
                        ),
                        // Show the camera icon on the bottom right
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () => _showImageSourceMenu(context),
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(197, 202, 227, 1),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),
                    const Center(
                      child: Text(
                        'Prove you’re the real you, with selfies. If the pics match your profile, we’ll give you a blue tick to show off your new verified status. And we’ll keep the selfies just between us.',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, gestureVerificationScreenAfter);
                    },
                    child: Container(
                      width: screenSize.width * 0.8,
                      height: screenSize.height * 0.05,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(54, 40, 221, 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text('Continue',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15), // Add spacing between buttons
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, homeScreen);
                      // setState(() {
                      //   // Update the isTapped state to change color
                      //   isTapped = !isTapped;
                      // });

                      // // Delay for a brief moment to let the color change
                      // await Future.delayed(Duration(milliseconds: 200));

                      // // Navigate to the next screen
                      // Navigator.pushNamed(context, enableLocationScreen);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(
                          milliseconds: 200), // Duration of the animation
                      width: screenSize.width * 0.8,
                      height: screenSize.height * 0.05,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          'Maybe Later',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class GestureVerificationScreenAfter extends StatefulWidget {
  const GestureVerificationScreenAfter({
    super.key,
  });

  @override
  State<GestureVerificationScreenAfter> createState() =>
      _GestureVerificationScreenAfterState();
}

class _GestureVerificationScreenAfterState
    extends State<GestureVerificationScreenAfter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal:
                MediaQuery.of(context).size.width * 0.05, // 5% of screen width
            vertical: MediaQuery.of(context).size.height * 0.03,
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Progress bar at the top
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 15,
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
                                      0.8, // Set width to represent progress
                                  color: blue // Progress color
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        "Copy these gestures to verify your photo.",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 25),
                      // Gesture verification images
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(232, 232, 255,
                              1), // Background color for the image area
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Column(
                          children: [
                            // Front-facing image
                            Center(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundImage: AssetImage(
                                        'assets/images/front.png' // Replace with your image URL
                                        ),
                                  ),
                                  SizedBox(height: 8),
                                  Text("Front",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            // Side-facing images (Left & Right)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage: AssetImage(
                                        'assets/images/left2.png', // Replace with your image URL
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text("Left",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage: AssetImage(
                                        'assets/images/right.png', // Replace with your image URL
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text("Right",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Verify button
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, photoScreen3After);
                },
                child: const Text(
                  "Verify",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
