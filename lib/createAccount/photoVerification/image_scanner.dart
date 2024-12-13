import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:love_bird/config/constants.dart';
import 'dart:io';

import 'package:love_bird/config/routes.dart';

class ImageScanner extends StatefulWidget {
  const ImageScanner({
    super.key,
  });

  @override
  PhotoVerificationState createState() => PhotoVerificationState();
}

class PhotoVerificationState extends State<ImageScanner> {
  final List<File> _scannedImages = []; // Stores the three scanned images
  final ImagePicker _picker = ImagePicker(); // Image picker instance

  // Method to scan (capture) an image using the camera
  Future<void> _scanImage() async {
    if (_scannedImages.length < 3) {
      // Limit to three images
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        setState(() {
          _scannedImages
              .add(File(image.path)); // Add captured image to the list
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You have already scanned three images.")),
      );
    }
  }

  // Method to show the submission dialog and navigate after 2 seconds
  void _showSubmissionDialog() {
    showDialog(
      barrierDismissible:
          true, // Prevent dialog from closing by tapping outside
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/password.png'),
                const SizedBox(height: 20),
                const Text(
                  'Submitted Successfully!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: blue,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Your photo will be reviewed within the next 48hrs\nPlease wait...\n You'll be redirected to the next page",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );

    // Wait for 2 seconds and then navigate to the next screen
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pop(context);
        Navigator.pushNamed(context, enableLocationScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 15,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(10.0), // Outer rounded corners
                    child: Container(
                      color: blue.withOpacity(0.19), // Background color
                    ),
                  ),
                  // Inner progress bar
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(10.0), // Inner rounded corners
                    child: Container(
                      width: MediaQuery.of(context).size.width *
                          0.8, // Set width to represent progress
                      color: blue, // Progress color
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Don’t worry, users won’t see these pictures.',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: _scanImage,
                child: Image.asset(
                  'images/scanner.png', // Path to your circular scanner icon image
                  width: 150,
                  height: 150,
                  fit: BoxFit.fill, // Ensures the image covers the circle
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Display scanned images in a similar layout with SizedBox and decoration
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Top center image with decoration
                if (_scannedImages.isNotEmpty)
                  SizedBox(
                    width: screenSize.width * 0.30,
                    height: screenSize.width * 0.33,
                    child: Container(
                      decoration: BoxDecoration(
                        color: blue.withOpacity(
                            0.09), // Background color for the container
                        borderRadius:
                            BorderRadius.circular(20), // Rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 1,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(
                          8.0), // Padding inside the container
                      child: ClipOval(
                        child: Image.file(
                          _scannedImages[0],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 20),

                // Bottom row with two images with decoration
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (_scannedImages.length > 1)
                      SizedBox(
                        width: screenSize.width * 0.30,
                        height: screenSize.width * 0.33,
                        child: Container(
                          decoration: BoxDecoration(
                            color: blue.withOpacity(0.09),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 1,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: ClipOval(
                            child: Image.file(
                              _scannedImages[1],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    if (_scannedImages.length > 2)
                      SizedBox(
                        width: screenSize.width * 0.30,
                        height: screenSize.width * 0.33,
                        child: Container(
                          decoration: BoxDecoration(
                            color: blue.withOpacity(0.09),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 1,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: ClipOval(
                            child: Image.file(
                              _scannedImages[2],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),

            const Spacer(),

            // Submit button
            Padding(
              padding: const EdgeInsets.all(20),
              child: InkWell(
                onTap: () {
                  _showSubmissionDialog(); // Show dialog on submit
                },
                child: Container(
                  width: screenSize.width * 0.8,
                  height: screenSize.height * 0.05,
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
