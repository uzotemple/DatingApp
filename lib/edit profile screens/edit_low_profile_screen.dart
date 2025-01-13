import 'package:love_bird/config/routes.dart';
// import 'package:love_bird/edit%20profile%20screens/edit_active_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:love_bird/config/constants.dart';
import 'package:love_bird/edit%20profile%20screens/image_upload/image_grid.dart';

import 'package:love_bird/edit%20profile%20screens/more_about_you_screen.dart';
// import 'package:love_bird/edit%20profile%20screens/upload_screen.dart';
import 'package:love_bird/edit%20profile%20screens/your_activity_screen.dart';

import 'image_upload/image_picker.dart';

class EditLowProfileScreen extends StatefulWidget {
  const EditLowProfileScreen({super.key});

  @override
  State<EditLowProfileScreen> createState() => _EditLowProfileScreenState();
}

class _EditLowProfileScreenState extends State<EditLowProfileScreen> {
  File? _image; // To hold the selected image
  bool _isUploading = false; // To track the upload state
  int _currentIndex = 4;

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

  final List<File?> _images = [];
  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();

  Future<void> _addImage(ImageSource source) async {
    File? image = await _imagePickerHelper.pickImage(source);
    if (image != null) {
      setState(() {
        _images.add(image);
      });
    }
  }

  void _deleteImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  void _setAsProfile(int index) {
    // Logic to set the image as profile picture
    print('Image at $index set as profile picture');
  }

  String? _selectedLocation;
  String? _selectedGender;
  String? _selectedReason;
  final TextEditingController _bioController = TextEditingController();
  int _bioLength = 0;

  final List<String> _locations = ['Location 1', 'Location 2', 'Location 3'];
  final List<String> _genders = ['Male', 'Female'];
  final List<String> _reasons = [
    'Open to chat',
    'Casual',
    'Here to date',
    'Ready for a relationship'
  ];

  @override
  void initState() {
    super.initState();
    _bioController.addListener(() {
      setState(() {
        _bioLength = _bioController.text.length;
      });
    });
  }

  @override
  void dispose() {
    _bioController.dispose(); // Dispose of the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
                                  _pickImage();
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
              Text(
                "Hailey, 25",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
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
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const YourActivityScreen()),
                            );
                          },
                          child: SizedBox(
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
                                        Image.asset("images/edit profile.png"),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                padding: const EdgeInsets.only(
                    top: 40.0, left: 40.0, right: 40.0, bottom: 10.0),
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

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ImageGrid(
                    images: _images,
                    onDelete: _deleteImage,
                    onSetAsProfile: _setAsProfile),
              ),
              ElevatedButton(
                onPressed: () => _addImage(ImageSource.gallery),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: blue, // Text color
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                  elevation: 5, // Shadow effect
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.camera_alt,
                        size: 20, color: Colors.white), // Icon before text
                    SizedBox(width: 8), // Spacing between icon and text
                    Text(
                      'Click to Upload',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),
              _buildTextField("Email", Icons.email),
              _buildTextField("Password", Icons.lock, isPassword: true),
              _buildTextField("Username", null),
              _buildTextField("Height", null),
              const SizedBox(height: 15),
              // Form Fields
              _buildTextField2("Weight (kg)"),
              _buildTextField2("Profession", isPassword2: true),
              _buildDropdownField("Location", _locations, _selectedLocation,
                  (newValue) {
                setState(() {
                  _selectedLocation = newValue;
                });
              }),
              _buildTextField2(
                "University",
              ),
              _buildDropdownField("Gender", _genders, _selectedGender,
                  (newValue) {
                setState(() {
                  _selectedGender = newValue;
                });
              }),
              _buildTextField2(
                "Birthday",
              ),
              _buildTextField2(
                "Phone Number",
              ),
              _buildDropdownField("Why you’re here", _reasons, _selectedReason,
                  (newValue) {
                setState(() {
                  _selectedReason = newValue;
                });
              }),
              _buildBioField(), // Updated bio field

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle the button press
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MoreAboutYouScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text(
                      'Save and Continue',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
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
          left: screenWidth * 0.03, // 3% of screen width
          right: screenWidth * 0.03,
          top: screenHeight * 0.01, // 1% of screen height
          bottom: screenHeight * 0.03, // 3% of screen height
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
              currentIndex: _currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, size: screenWidth * 0.08),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.location_on, size: screenWidth * 0.08),
                  label: 'People Nearby',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat, size: screenWidth * 0.08),
                  label: 'Chats',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite, size: screenWidth * 0.08),
                  label: 'Matches',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person, size: screenWidth * 0.08),
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
                  blue, // Make selected item icon and label black
              unselectedItemColor:
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.white // Dark mode, use white
                      : Colors.black, // Make unselected item icon black
              onTap: (index) {
                setState(() {
                  _currentIndex = index; // Update the current index.
                });
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

  Widget _buildTextField(String label, IconData? icon,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon != null ? Icon(icon) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: blue.withOpacity(0.19),
        ),
      ),
    );
  }

  Widget _buildTextField2(String label, {bool isPassword2 = false}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 35,
        child: TextField(
          textCapitalization: TextCapitalization.sentences,
          // obscureText: isPassword,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: blue.withOpacity(0.19),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> items,
      String? selectedValue, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: blue.withOpacity(0.19),
        ),
        value: selectedValue,
        onChanged: onChanged,
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        isExpanded: true,
      ),
    );
  }

  //Bio data

  Widget _buildBioField() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _bioController,
            maxLength: 400,
            maxLines: 3,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: "Bio",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: blue.withOpacity(0.19),
            ),
          ),
          const SizedBox(height: 8.0),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '$_bioLength/400',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
