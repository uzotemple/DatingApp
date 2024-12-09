import 'package:love_bird/config/routes.dart';
import 'package:love_bird/edit%20profile%20screens/edit_active_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:love_bird/config/constants.dart';

class EditLowProfileScreen extends StatefulWidget {
  const EditLowProfileScreen({super.key});

  @override
  State<EditLowProfileScreen> createState() => _EditLowProfileScreenState();
}

class _EditLowProfileScreenState extends State<EditLowProfileScreen> {
  File? _image; // To hold the selected image
  bool _isUploading = false; // To track the upload state

  final ImagePicker _picker = ImagePicker();

  // Method to pick an image
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Store the selected image
      });

      // Simulate an upload process
      await _uploadImage(_image!);
    }
  }

  // Simulated upload method
  Future<void> _uploadImage(File image) async {
    setState(() {
      _isUploading = true; // Start the upload
    });

    // Simulate a network request delay
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isUploading = false; // End the upload
      });

      // Show a snackbar or dialog after the upload is complete
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image uploaded successfully!')),
      );
    }
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
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Image.asset(
                  "images/ai.png",
                ),
              ),
            ),
            const SizedBox(width: 45),
            const Text(
              "Edit Profile",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: _pickImage, // Trigger image picker on tap
                  child:

                      // Stack(
                      //   children: [
                      //     CircleAvatar(
                      //       radius: 60,
                      //       backgroundColor: Colors.grey[200],
                      //       backgroundImage: _image != null ? FileImage(_image!) : null,
                      //       child: _image == null
                      //           ? const Icon(
                      //               Icons.camera_alt,
                      //               size: 40,
                      //               color: Colors.grey,
                      //             )
                      //           : null,
                      //     ),
                      //     if (_image !=
                      //         null) // Show the camera icon on the bottom right
                      //       Positioned(
                      //         bottom: 0,
                      //         right: 0,
                      //         child: GestureDetector(
                      //           onTap: _pickImage,
                      //           child: Container(
                      //             decoration: BoxDecoration(
                      //               shape: BoxShape.circle,
                      //               color: Colors.white,
                      //               border: Border.all(color: Colors.grey),
                      //             ),
                      //             child: const Padding(
                      //               padding: EdgeInsets.all(8.0),
                      //               child: Icon(
                      //                 Icons.camera_alt,
                      //                 color: Colors.grey,
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     if (_isUploading) // Show progress indicator while uploading
                      //       Positioned.fill(
                      //         child: Container(
                      //           decoration: const BoxDecoration(
                      //             shape: BoxShape.circle,
                      //             color: Colors.black54,
                      //           ),
                      //           child: const Center(
                      //             child: CircularProgressIndicator(
                      //               color: Colors.white,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //   ],
                      // ),
                      Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey[200],
                        backgroundImage:
                            _image != null ? FileImage(_image!) : null,
                        child: _image == null
                            ? const Icon(
                                Icons.camera_alt,
                                size: 40,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                      if (_image !=
                          null) // Show the camera icon on the bottom right
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: PopupMenuButton<int>(
                            onSelected: (value) {
                              switch (value) {
                                case 1:
                                  // Take Photo logic here
                                  break;
                                case 2:
                                  // Add Photo logic here
                                  break;
                                case 3:
                                  // Add Video logic here
                                  break;
                                case 4:
                                  // Add Avatar logic here
                                  break;
                                case 5:
                                  // Delete logic here
                                  break;
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem<int>(
                                value: 1,
                                child: ListTile(
                                  leading: Icon(Icons.camera_alt),
                                  title: Text("Take Photo"),
                                ),
                              ),
                              const PopupMenuItem<int>(
                                value: 2,
                                child: ListTile(
                                  leading: Icon(Icons.photo),
                                  title: Text("Add Photo"),
                                ),
                              ),
                              const PopupMenuItem<int>(
                                value: 3,
                                child: ListTile(
                                  leading: Icon(Icons.videocam),
                                  title: Text("Add Video"),
                                ),
                              ),
                              const PopupMenuItem<int>(
                                value: 4,
                                child: ListTile(
                                  leading: Icon(Icons.person),
                                  title: Text("Add Avatar"),
                                ),
                              ),
                              const PopupMenuItem<int>(
                                value: 5,
                                child: ListTile(
                                  leading:
                                      Icon(Icons.delete, color: Colors.red),
                                  title: Text("Delete"),
                                ),
                              ),
                            ],
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(color: Colors.grey),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (_isUploading) // Show a loading spinner when uploading
                        Positioned.fill(
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  Colors.black54, // A semi-transparent overlay
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white, // Spinner color
                              ),
                            ),
                          ),
                        ),
                    ],
                  )),
              const SizedBox(height: 10),
              const Text(
                "Hailey, 25",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              // const SizedBox(height: 20),
              // Additional fields for editing profile (e.g., name, email) can go here
              SizedBox(
                width: 100,
                height: 30,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      "52% Complete",
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 35,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: blue.withOpacity(0.19),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Image.asset("images/edit profile.png"),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Your activity",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                    ),
                                    const Text(
                                      "Low",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.red),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 35,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: blue.withOpacity(0.19),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child:
                                      Image.asset("images/edit profile 2.png"),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Credits",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                    ),
                                    const Text(
                                      "Add",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF3628DD)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Big Rectangle at the center of the screen
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: blue, // Border color
                        width: 2.0, // Border width
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: SizedBox(
                                width: 80,
                                height: 25,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: blue,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "150 credits ",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset("images/edit profile3.png"),
                            const Text(
                              "Get matches faster ",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                            const Text(
                              "Use credits to boost your profile to get more likes ",
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // images
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
              //   child: SingleChildScrollView(
              //     scrollDirection: Axis.horizontal,
              //     child: Row(
              //       children: [
              //         Stack(
              //           children: [
              //             Image.asset(
              //               "images/profile picture.png",
              //               // width: 135, // You can adjust the size of the image here
              //               // height: 135,
              //             ),
              //             Positioned(
              //               top: 0,
              //               right: 0,
              //               child: InkWell(
              //                 onTap: () {},
              //                 child: const Icon(
              //                   Icons.more_vert, // The icon you want to place
              //                   size: 30,
              //                   color: Colors
              //                       .white, // You can change the color and size as needed
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //         // Second image
              //         const SizedBox(width: 15),
              //         Stack(
              //           children: [
              //             Image.asset(
              //               "images/profile picture2.png",
              //               // width: 135, // You can adjust the size of the image here
              //               // height: 135,
              //             ),
              //             Positioned(
              //               top: 0,
              //               right: 0,
              //               child: InkWell(
              //                 onTap: () {},
              //                 child: const Icon(
              //                   Icons.more_vert, // The icon you want to place
              //                   size: 30,
              //                   color: Colors
              //                       .white, // You can change the color and size as needed
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //         // Third image
              //         const SizedBox(width: 15),
              //         Stack(
              //           children: [
              //             Image.asset(
              //               "images/profile picture3.png",
              //               // width: 135, // You can adjust the size of the image here
              //               // height: 135,
              //             ),
              //             Positioned(
              //               top: 0,
              //               right: 0,
              //               child: InkWell(
              //                 onTap: () {},
              //                 child: const Icon(
              //                   Icons.more_vert, // The icon you want to place
              //                   size: 30,
              //                   color: Colors
              //                       .white, // You can change the color and size as needed
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

              // images
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            "images/profile picture.png",
                            // width: 135, // You can adjust the size of the image here
                            // height: 135,
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: PopupMenuButton<String>(
                              icon: const Icon(
                                Icons.more_vert, // The icon you want to place
                                size: 30,
                                color: Colors
                                    .white, // You can change the color and size as needed
                              ),
                              onSelected: (value) {
                                if (value == 'setProfile') {
                                  // Handle setting as profile picture
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("Set as Profile Picture")),
                                  );
                                } else if (value == 'delete') {
                                  // Handle delete action
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Deleted")),
                                  );
                                }
                              },
                              itemBuilder: (BuildContext context) {
                                return [
                                  const PopupMenuItem<String>(
                                    value: 'setProfile',
                                    child: Text("Set as Profile Picture"),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'delete',
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete, color: Colors.red),
                                        SizedBox(
                                            width:
                                                8), // Spacing between icon and text
                                        Text("Delete"),
                                      ],
                                    ),
                                  ),
                                ];
                              },
                            ),
                          ),
                        ],
                      ),
                      // Second image
                      const SizedBox(width: 15),
                      Stack(
                        children: [
                          Image.asset(
                            "images/profile picture2.png",
                            // width: 135, // You can adjust the size of the image here
                            // height: 135,
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: PopupMenuButton<String>(
                              icon: const Icon(
                                Icons.more_vert,
                                size: 30,
                                color: Colors.white,
                              ),
                              onSelected: (value) {
                                if (value == 'setProfile') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("Set as Profile Picture")),
                                  );
                                } else if (value == 'delete') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Deleted")),
                                  );
                                }
                              },
                              itemBuilder: (BuildContext context) {
                                return [
                                  const PopupMenuItem<String>(
                                    value: 'setProfile',
                                    child: Text("Set as Profile Picture"),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'delete',
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete, color: Colors.red),
                                        SizedBox(width: 8),
                                        Text("Delete"),
                                      ],
                                    ),
                                  ),
                                ];
                              },
                            ),
                          ),
                        ],
                      ),
                      // Third image
                      const SizedBox(width: 15),
                      Stack(
                        children: [
                          Image.asset(
                            "images/profile picture3.png",
                            // width: 135, // You can adjust the size of the image here
                            // height: 135,
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: PopupMenuButton<String>(
                              icon: const Icon(
                                Icons.more_vert,
                                size: 30,
                                color: Colors.white,
                              ),
                              onSelected: (value) {
                                if (value == 'setProfile') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("Set as Profile Picture")),
                                  );
                                } else if (value == 'delete') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Deleted")),
                                  );
                                }
                              },
                              itemBuilder: (BuildContext context) {
                                return [
                                  const PopupMenuItem<String>(
                                    value: 'setProfile',
                                    child: Text("Set as Profile Picture"),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'delete',
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete, color: Colors.red),
                                        SizedBox(width: 8),
                                        Text("Delete"),
                                      ],
                                    ),
                                  ),
                                ];
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const EditActiveProfileScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.03, // 3% of screen width
          right: MediaQuery.of(context).size.width * 0.03,
          top: MediaQuery.of(context).size.height * 0.01, // 1% of screen height
          bottom:
              MediaQuery.of(context).size.height * 0.03, // 3% of screen height
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(97, 86, 234, 0.19),
            borderRadius: BorderRadius.circular(50),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/icons/homeBlack.png',
                    width:
                        MediaQuery.of(context).size.width * 0.08, // 7% of width
                    height: MediaQuery.of(context).size.width * 0.08,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/icons/localcon.png',
                    width: MediaQuery.of(context).size.width * 0.08,
                    height: MediaQuery.of(context).size.width * 0.08,
                  ),
                  label: 'People Nearby',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/icons/chatIcon.png',
                    width: MediaQuery.of(context).size.width * 0.08,
                    height: MediaQuery.of(context).size.width * 0.08,
                  ),
                  label: 'Chats',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/icons/matches.png',
                    width: MediaQuery.of(context).size.width * 0.08,
                    height: MediaQuery.of(context).size.width * 0.08,
                  ),
                  label: 'Matches',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/icons/blueProfile.png',
                    width: MediaQuery.of(context).size.width * 0.07,
                    height: MediaQuery.of(context).size.width * 0.07,
                  ),
                  label: 'Profile',
                ),
              ],
              selectedLabelStyle: TextStyle(
                color: Colors.black, // Ensure selected text is black
                fontSize: MediaQuery.of(context).size.width * 0.03,
              ),
              unselectedLabelStyle: TextStyle(
                color: Colors.black, // Ensure unselected text is black
                fontSize: MediaQuery.of(context).size.width * 0.03,
              ),
              selectedItemColor:
                  Colors.black, // Make selected item icon and label black
              unselectedItemColor:
                  Colors.black, // Make unselected item icon black
              onTap: (index) {
                // Handle navigation based on the index
                switch (index) {
                  case 0:
                    Navigator.pushNamed(context, homeScreen);

                    break;
                  case 1:
                    Navigator.pushNamed(context, peopleNearbyPage);
                    break;
                  case 2:
                    Navigator.pushNamed(context, mainchat);
                    break;
                  case 3:
                    Navigator.pushNamed(context, likes);
                    break;
                  case 4:
                    Navigator.pushNamed(context, profile);
                    break;
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
