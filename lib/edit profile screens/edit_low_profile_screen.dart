// import 'package:love_bird/config/routes.dart';
// // import 'package:love_bird/edit%20profile%20screens/edit_active_profile_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:love_bird/config/constants.dart';
// import 'package:love_bird/edit%20profile%20screens/image_upload/image_grid.dart';

// import 'package:love_bird/edit%20profile%20screens/more_about_you_screen.dart';
// // import 'package:love_bird/edit%20profile%20screens/upload_screen.dart';
// import 'package:love_bird/edit%20profile%20screens/your_activity_screen.dart';

// import 'image_upload/image_picker.dart';

// class EditLowProfileScreen extends StatefulWidget {
//   const EditLowProfileScreen({super.key});

//   @override
//   State<EditLowProfileScreen> createState() => _EditLowProfileScreenState();
// }

// class _EditLowProfileScreenState extends State<EditLowProfileScreen> {
//   File? _image; // To hold the selected image
//   bool _isUploading = false; // To track the upload state
//   int _currentIndex = 4;

//   final ImagePicker _picker = ImagePicker();

//   // Method to pick an image
//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path); // Store the selected image
//       });

//       // Simulate an upload process
//       await _uploadImage(_image!);
//     }
//   }

//   // Simulated upload method
//   Future<void> _uploadImage(File image) async {
//     setState(() {
//       _isUploading = true; // Start the upload
//     });

//     // Simulate a network request delay
//     await Future.delayed(const Duration(seconds: 2));

//     if (mounted) {
//       setState(() {
//         _isUploading = false; // End the upload
//       });

//       // Show a snackbar or dialog after the upload is complete
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Image uploaded successfully!')),
//       );
//     }
//   }

//   final List<File?> _images = [];
//   final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();

//   Future<void> _addImage(ImageSource source) async {
//     File? image = await _imagePickerHelper.pickImage(source);
//     if (image != null) {
//       setState(() {
//         _images.add(image);
//       });
//     }
//   }

//   void _deleteImage(int index) {
//     setState(() {
//       _images.removeAt(index);
//     });
//   }

//   void _setAsProfile(int index) {
//     // Logic to set the image as profile picture
//     print('Image at $index set as profile picture');
//   }

//   String? _selectedLocation;
//   String? _selectedGender;
//   String? _selectedReason;
//   final TextEditingController _bioController = TextEditingController();
//   int _bioLength = 0;

//   final List<String> _locations = ['Location 1', 'Location 2', 'Location 3'];
//   final List<String> _genders = ['Male', 'Female'];
//   final List<String> _reasons = [
//     'Open to chat',
//     'Casual',
//     'Here to date',
//     'Ready for a relationship'
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _bioController.addListener(() {
//       setState(() {
//         _bioLength = _bioController.text.length;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _bioController.dispose(); // Dispose of the controller
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               GestureDetector(
//                   onTap: _pickImage, // Trigger image picker on tap
//                   child:

//               appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Row(
//           children: [
//             InkWell(
//               onTap: () {
//                 Navigator.pushNamed(context, geminiBot);
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(right: 10.0),
//                 child: Image.asset(
//                   "images/ai.png",
//                 ),
//               ),
//             ),
//             const SizedBox(width: 45),
//             const Text(
//               "Edit Profile",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
//             ),
//           ],
//         ),
//       ),        // Stack(
//                       //   children: [
//                       //     CircleAvatar(
//                       //       radius: 60,
//                       //       backgroundColor: Colors.grey[200],
//                       //       backgroundImage: _image != null ? FileImage(_image!) : null,
//                       //       child: _image == null
//                       //           ? const Icon(
//                       //               Icons.camera_alt,
//                       //               size: 40,
//                       //               color: Colors.grey,
//                       //             )
//                       //           : null,
//                       //     ),
//                       //     if (_image !=
//                       //         null) // Show the camera icon on the bottom right
//                       //       Positioned(
//                       //         bottom: 0,
//                       //         right: 0,
//                       //         child: GestureDetector(
//                       //           onTap: _pickImage,
//                       //           child: Container(
//                       //             decoration: BoxDecoration(
//                       //               shape: BoxShape.circle,
//                       //               color: Colors.white,
//                       //               border: Border.all(color: Colors.grey),
//                       //             ),
//                       //             child: const Padding(
//                       //               padding: EdgeInsets.all(8.0),
//                       //               child: Icon(
//                       //                 Icons.camera_alt,
//                       //                 color: Colors.grey,
//                       //               ),
//                       //             ),
//                       //           ),
//                       //         ),
//                       //       ),
//                       //     if (_isUploading) // Show progress indicator while uploading
//                       //       Positioned.fill(
//                       //         child: Container(
//                       //           decoration: const BoxDecoration(
//                       //             shape: BoxShape.circle,
//                       //             color: Colors.black54,
//                       //           ),
//                       //           child: const Center(
//                       //             child: CircularProgressIndicator(
//                       //               color: Colors.white,
//                       //             ),
//                       //           ),
//                       //         ),
//                       //       ),
//                       //   ],
//                       // ),
//                       Stack(
//                     children: [
//                       CircleAvatar(
//                         radius: 60,
//                         backgroundColor: Colors.grey[200],
//                         backgroundImage:
//                             _image != null ? FileImage(_image!) : null,
//                         child: _image == null
//                             ? const Icon(
//                                 Icons.camera_alt,
//                                 size: 40,
//                                 color: Colors.grey,
//                               )
//                             : null,
//                       ),
//                       if (_image !=
//                           null) // Show the camera icon on the bottom right
//                         Positioned(
//                           bottom: 0,
//                           right: 0,
//                           child: PopupMenuButton<int>(
//                             onSelected: (value) {
//                               switch (value) {
//                                 case 1:
//                                   // Take Photo logic here
//                                   break;
//                                 case 2:
//                                   // Add Photo logic here
//                                   _pickImage();
//                                   break;
//                                 case 3:
//                                   // Add Video logic here
//                                   break;
//                                 case 4:
//                                   // Add Avatar logic here
//                                   break;
//                                 case 5:
//                                   // Delete logic here
//                                   break;
//                               }
//                             },
//                             itemBuilder: (context) => [
//                               const PopupMenuItem<int>(
//                                 value: 1,
//                                 child: ListTile(
//                                   leading: Icon(Icons.camera_alt),
//                                   title: Text("Take Photo"),
//                                 ),
//                               ),
//                               const PopupMenuItem<int>(
//                                 value: 2,
//                                 child: ListTile(
//                                   leading: Icon(Icons.photo),
//                                   title: Text("Add Photo"),
//                                 ),
//                               ),
//                               const PopupMenuItem<int>(
//                                 value: 3,
//                                 child: ListTile(
//                                   leading: Icon(Icons.videocam),
//                                   title: Text("Add Video"),
//                                 ),
//                               ),
//                               const PopupMenuItem<int>(
//                                 value: 4,
//                                 child: ListTile(
//                                   leading: Icon(Icons.person),
//                                   title: Text("Add Avatar"),
//                                 ),
//                               ),
//                               const PopupMenuItem<int>(
//                                 value: 5,
//                                 child: ListTile(
//                                   leading:
//                                       Icon(Icons.delete, color: Colors.red),
//                                   title: Text("Delete"),
//                                 ),
//                               ),
//                             ],
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: Colors.white,
//                                 border: Border.all(color: Colors.grey),
//                               ),
//                               child: const Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Icon(
//                                   Icons.camera_alt,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       if (_isUploading) // Show a loading spinner when uploading
//                         Positioned.fill(
//                           child: Container(
//                             decoration: const BoxDecoration(
//                               shape: BoxShape.circle,
//                               color:
//                                   Colors.black54, // A semi-transparent overlay
//                             ),
//                             child: const Center(
//                               child: CircularProgressIndicator(
//                                 color: Colors.white, // Spinner color
//                               ),
//                             ),
//                           ),
//                         ),
//                     ],
//                   )),
//               const SizedBox(height: 10),
//               Text(
//                 "Hailey, 25",
//                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//               ),
//               // const SizedBox(height: 20),
//               // Additional fields for editing profile (e.g., name, email) can go here
//               SizedBox(
//                 width: 100,
//                 height: 30,
//                 child: DecoratedBox(
//                   decoration: BoxDecoration(
//                     color: blue,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: const Center(
//                     child: Text(
//                       "52% Complete",
//                       style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                     child: Row(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) =>
//                                       const YourActivityScreen()),
//                             );
//                           },
//                           child: SizedBox(
//                             width: 120,
//                             height: 35,
//                             child: DecoratedBox(
//                               decoration: BoxDecoration(
//                                 color: blue.withOpacity(0.19),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: Row(
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.all(15.0),
//                                     child:
//                                         Image.asset("images/edit profile.png"),
//                                   ),
//                                   Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Your activity",
//                                         style: TextStyle(
//                                           fontSize: 10,
//                                           fontWeight: FontWeight.w700,
//                                           color: Colors.black.withOpacity(0.5),
//                                         ),
//                                       ),
//                                       const Text(
//                                         "Low",
//                                         style: TextStyle(
//                                             fontSize: 10,
//                                             fontWeight: FontWeight.w700,
//                                             color: Colors.red),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: 120,
//                           height: 35,
//                           child: DecoratedBox(
//                             decoration: BoxDecoration(
//                               color: blue.withOpacity(0.19),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Row(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(15.0),
//                                   child:
//                                       Image.asset("images/edit profile 2.png"),
//                                 ),
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "Credits",
//                                       style: TextStyle(
//                                         fontSize: 10,
//                                         fontWeight: FontWeight.w700,
//                                         color: Colors.black.withOpacity(0.5),
//                                       ),
//                                     ),
//                                     const Text(
//                                       "Add",
//                                       style: TextStyle(
//                                           fontSize: 10,
//                                           fontWeight: FontWeight.w700,
//                                           color: Color(0xFF3628DD)),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               // Big Rectangle at the center of the screen
//               Padding(
//                 padding: const EdgeInsets.only(
//                     top: 40.0, left: 40.0, right: 40.0, bottom: 10.0),
//                 child: SizedBox(
//                   width: MediaQuery.of(context).size.width,
//                   height: 150,
//                   child: DecoratedBox(
//                     decoration: BoxDecoration(
//                       color: Colors.transparent,
//                       border: Border.all(
//                         color: blue, // Border color
//                         width: 2.0, // Border width
//                       ),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Column(
//                       children: [
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Spacer(),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 10.0),
//                               child: SizedBox(
//                                 width: 80,
//                                 height: 25,
//                                 child: DecoratedBox(
//                                   decoration: BoxDecoration(
//                                     color: blue,
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   child: const Center(
//                                     child: Text(
//                                       "150 credits ",
//                                       style: TextStyle(
//                                           fontSize: 10,
//                                           fontWeight: FontWeight.w400,
//                                           color: Colors.white),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Column(
//                           children: [
//                             Image.asset("images/edit profile3.png"),
//                             const Text(
//                               "Get matches faster ",
//                               style: TextStyle(
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w400,
//                                   color: Colors.black),
//                             ),
//                             const Text(
//                               "Use credits to boost your profile to get more likes ",
//                               style: TextStyle(
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.w400,
//                                   color: Colors.black),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               // images

//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: ImageGrid(
//                     images: _images,
//                     onDelete: _deleteImage,
//                     onSetAsProfile: _setAsProfile),
//               ),
//               ElevatedButton(
//                 onPressed: () => _addImage(ImageSource.gallery),
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.white,
//                   backgroundColor: blue, // Text color
//                   padding: const EdgeInsets.symmetric(
//                       vertical: 12.0, horizontal: 20.0),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20), // Rounded corners
//                   ),
//                   elevation: 5, // Shadow effect
//                 ),
//                 child: const Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(Icons.camera_alt,
//                         size: 20, color: Colors.white), // Icon before text
//                     SizedBox(width: 8), // Spacing between icon and text
//                     Text(
//                       'Click to Upload',
//                       style:
//                           TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 15),
//               _buildTextField("Email", Icons.email),
//               _buildTextField("Password", Icons.lock, isPassword: true),
//               _buildTextField("Username", null),
//               _buildTextField("Height", null),
//               const SizedBox(height: 15),
//               // Form Fields
//               _buildTextField2("Weight (kg)"),
//               _buildTextField2("Profession", isPassword2: true),
//               _buildDropdownField("Location", _locations, _selectedLocation,
//                   (newValue) {
//                 setState(() {
//                   _selectedLocation = newValue;
//                 });
//               }),
//               _buildTextField2(
//                 "University",
//               ),
//               _buildDropdownField("Gender", _genders, _selectedGender,
//                   (newValue) {
//                 setState(() {
//                   _selectedGender = newValue;
//                 });
//               }),
//               _buildTextField2(
//                 "Birthday",
//               ),
//               _buildTextField2(
//                 "Phone Number",
//               ),
//               _buildDropdownField("Why you’re here", _reasons, _selectedReason,
//                   (newValue) {
//                 setState(() {
//                   _selectedReason = newValue;
//                 });
//               }),
//               _buildBioField(), // Updated bio field

//               Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: SizedBox(
//                   width: MediaQuery.of(context).size.width,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Handle the button press
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const MoreAboutYouScreen(),
//                         ),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: blue,
//                       padding: const EdgeInsets.symmetric(vertical: 15.0),
//                       textStyle: const TextStyle(fontSize: 18),
//                     ),
//                     child: const Text(
//                       'Save and Continue',
//                       style: TextStyle(
//                         color: Color(0xFFFFFFFF),
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: EdgeInsets.only(
//           left: screenWidth * 0.03, // 3% of screen width
//           right: screenWidth * 0.03,
//           top: screenHeight * 0.01, // 1% of screen height
//           bottom: screenHeight * 0.03, // 3% of screen height
//         ),
//         child: Container(
//           decoration: BoxDecoration(
//             color: const Color.fromRGBO(97, 86, 234, 0.19),
//             borderRadius: BorderRadius.circular(50),
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(50),
//             child: BottomNavigationBar(
//               type: BottomNavigationBarType.fixed,
//               backgroundColor: Colors.transparent,
//               elevation: 0,
//               currentIndex: _currentIndex,
//               items: [
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.home, size: screenWidth * 0.08),
//                   label: 'Home',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.location_on, size: screenWidth * 0.08),
//                   label: 'People Nearby',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.chat, size: screenWidth * 0.08),
//                   label: 'Chats',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.favorite, size: screenWidth * 0.08),
//                   label: 'Matches',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.person, size: screenWidth * 0.08),
//                   label: 'Profile',
//                 ),
//               ],
//               selectedLabelStyle: TextStyle(
//                 color: Colors.black, // Ensure selected text is black
//                 fontSize: MediaQuery.of(context).size.width * 0.03,
//               ),
//               unselectedLabelStyle: TextStyle(
//                 color: Colors.black, // Ensure unselected text is black
//                 fontSize: MediaQuery.of(context).size.width * 0.03,
//               ),
//               selectedItemColor:
//                   blue, // Make selected item icon and label black
//               unselectedItemColor:
//                   Theme.of(context).brightness == Brightness.dark
//                       ? Colors.white // Dark mode, use white
//                       : Colors.black, // Make unselected item icon black
//               onTap: (index) {
//                 setState(() {
//                   _currentIndex = index; // Update the current index.
//                 });
//                 switch (index) {
//                   case 0:
//                     Navigator.pushNamed(context, homeScreen);

//                     break;
//                   case 1:
//                     Navigator.pushNamed(context, peopleNearbyPage);
//                     break;
//                   case 2:
//                     Navigator.pushNamed(context, mainchat);
//                     break;
//                   case 3:
//                     Navigator.pushNamed(context, likes);
//                     break;
//                   case 4:
//                     Navigator.pushNamed(context, profile);
//                     break;
//                 }
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(String label, IconData? icon,
//       {bool isPassword = false}) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: TextField(
//         obscureText: isPassword,
//         decoration: InputDecoration(
//           labelText: label,
//           prefixIcon: icon != null ? Icon(icon) : null,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide.none,
//           ),
//           filled: true,
//           fillColor: blue.withOpacity(0.19),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField2(String label, {bool isPassword2 = false}) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: SizedBox(
//         height: 35,
//         child: TextField(
//           textCapitalization: TextCapitalization.sentences,
//           // obscureText: isPassword,
//           decoration: InputDecoration(
//             labelText: label,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide.none,
//             ),
//             filled: true,
//             fillColor: blue.withOpacity(0.19),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDropdownField(String label, List<String> items,
//       String? selectedValue, Function(String?) onChanged) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: DropdownButtonFormField<String>(
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide.none,
//           ),
//           filled: true,
//           fillColor: blue.withOpacity(0.19),
//         ),
//         value: selectedValue,
//         onChanged: onChanged,
//         items: items.map((String value) {
//           return DropdownMenuItem<String>(
//             value: value,
//             child: Text(value),
//           );
//         }).toList(),
//         isExpanded: true,
//       ),
//     );
//   }

//   //Bio data

//   Widget _buildBioField() {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TextField(
//             controller: _bioController,
//             maxLength: 400,
//             maxLines: 3,
//             textCapitalization: TextCapitalization.sentences,
//             decoration: InputDecoration(
//               labelText: "Bio",
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: BorderSide.none,
//               ),
//               filled: true,
//               fillColor: blue.withOpacity(0.19),
//             ),
//           ),
//           const SizedBox(height: 8.0),
//           Align(
//             alignment: Alignment.centerRight,
//             child: Text(
//               '$_bioLength/400',
//               style: const TextStyle(color: Colors.grey),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:love_bird/api/profile_api.dart';
// import 'package:provider/provider.dart';
// import 'package:love_bird/providers/auth_provider.dart';

// class EditLowProfileScreen extends StatefulWidget {
//   const EditLowProfileScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _EditLowProfileScreenState createState() => _EditLowProfileScreenState();
// }

// class _EditLowProfileScreenState extends State<EditLowProfileScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final Map<String, TextEditingController> _controllers = {};

//   @override
//   void initState() {
//     super.initState();
//     final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
//     final profileData = profileProvider.getProfileData ?? {};

//     _controllers['nickname'] = TextEditingController(text: profileData['nickname'] ?? "");
//     _controllers['age'] = TextEditingController(text: profileData['age']?.toString() ?? "");
//     _controllers['location'] = TextEditingController(text: profileData['location'] ?? "");
//     _controllers['gender'] = TextEditingController(text: profileData['gender'] ?? "");
//     _controllers['relationshipGoals'] = TextEditingController(text: profileData['relationshipGoals'] ?? "");
//     _controllers['weight'] = TextEditingController(text: profileData['weight']?.toString() ?? "");
//     _controllers['height'] = TextEditingController(text: profileData['height']?.toString() ?? "");
//     _controllers['country'] = TextEditingController(text: profileData['country'] ?? "");
//     _controllers['city'] = TextEditingController(text: profileData['city'] ?? "");
//     _controllers['bio'] = TextEditingController(text: profileData['bio'] ?? "");
//     _controllers['interest'] = TextEditingController(text: profileData['interest'] ?? "");
//     _controllers['educationLevel'] = TextEditingController(text: profileData['educationLevel'] ?? "");
//     _controllers['profession'] = TextEditingController(text: profileData['profession'] ?? "");
//   }

//   @override
//   Widget build(BuildContext context) {
//     final profileProvider = Provider.of<ProfileProvider>(context);
//     final authProvider = Provider.of<AuthProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Edit Profile", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//         centerTitle: true,
//         backgroundColor: Colors.purple,
//         foregroundColor: Colors.white,
//       ),
//       body: profileProvider.getProfileData == null
//           ? const Center(child: CircularProgressIndicator())
//           : Container(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Colors.purple.shade200, Colors.purple.shade700],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//               child: Form(
//                 key: _formKey,
//                 child: ListView(
//                   children: [
//                     const SizedBox(height: 20),
//                     buildTextField("Nickname", "nickname"),
//                     buildTextField("Age", "age", isNumber: true),
//                     buildTextField("Location", "location"),
//                     buildTextField("Gender", "gender"),
//                     buildTextField("Relationship Goals", "relationshipGoals"),
//                     buildTextField("Weight", "weight", isNumber: true),
//                     buildTextField("Height", "height", isNumber: true),
//                     buildTextField("Country", "country"),
//                     buildTextField("City", "city"),
//                     buildTextField("Bio", "bio"),
//                     buildTextField("Interest", "interest"),
//                     buildTextField("Education Level", "educationLevel"),
//                     buildTextField("Profession", "profession"),
//                     const SizedBox(height: 30),
//                     ElevatedButton(
//                       onPressed: () async {
//                         if (_formKey.currentState!.validate()) {
//                           Map<String, dynamic> updatedData = {
//                             "nickname": _controllers["nickname"]!.text,
//                             "age": _controllers["age"]!.text,
//                             "location": _controllers["location"]!.text,
//                             "gender": _controllers["gender"]!.text,
//                             "relationshipGoals": _controllers["relationshipGoals"]!.text,
//                             "weight": _controllers["weight"]!.text,
//                             "height": _controllers["height"]!.text,
//                             "country": _controllers["country"]!.text,
//                             "city": _controllers["city"]!.text,
//                             "bio": _controllers["bio"]!.text,
//                             "interest": _controllers["interest"]!.text,
//                             "educationLevel": _controllers["educationLevel"]!.text,
//                             "profession": _controllers["profession"]!.text,
//                           };

//                           bool success = await profileProvider.updateProfile(context, authProvider, updatedData);

//                           if (success) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(content: Text("Profile updated successfully")),
//                             );
//                             Navigator.pop(context);
//                           }
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//                         backgroundColor: Colors.purple.shade800,
//                       ),
//                       child: const Text(
//                         "Save Changes",
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }

//   Widget buildTextField(String label, String key, {bool isNumber = false}) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.9),
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: const [
//           BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2)),
//         ],
//       ),
//       child: TextFormField(
//         controller: _controllers[key],
//         keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//         decoration: InputDecoration(
//           labelText: label,
//           border: InputBorder.none,
//           labelStyle: TextStyle(color: Colors.purple.shade700, fontWeight: FontWeight.w500),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:love_bird/api/profile_api.dart';
// import 'package:provider/provider.dart';
// import 'dart:io';
// import 'package:love_bird/providers/auth_provider.dart';

// class EditLowProfileScreen extends StatefulWidget {
//   const EditLowProfileScreen({super.key});

//   @override
//   State<EditLowProfileScreen> createState() => _EditLowProfileScreenState();
// }

// class _EditLowProfileScreenState extends State<EditLowProfileScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final Map<String, TextEditingController> _controllers = {};
//   File? _selectedImage;

//   @override
//   void initState() {
//     super.initState();
//     final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
//     final profileData = profileProvider.getProfileData ?? {};

//     _controllers['nickname'] = TextEditingController(text: profileData['nickname'] ?? "");
//     _controllers['age'] = TextEditingController(text: profileData['age']?.toString() ?? "");
//     _controllers['location'] = TextEditingController(text: profileData['location'] ?? "");
//     _controllers['gender'] = TextEditingController(text: profileData['gender'] ?? "");
//     _controllers['relationshipGoals'] = TextEditingController(text: profileData['relationshipGoals'] ?? "");
//     _controllers['weight'] = TextEditingController(text: profileData['weight']?.toString() ?? "");
//     _controllers['height'] = TextEditingController(text: profileData['height']?.toString() ?? "");
//     _controllers['country'] = TextEditingController(text: profileData['country'] ?? "");
//     _controllers['city'] = TextEditingController(text: profileData['city'] ?? "");
//     _controllers['bio'] = TextEditingController(text: profileData['bio'] ?? "");
//     _controllers['interest'] = TextEditingController(text: profileData['interest'] ?? "");
//     _controllers['educationLevel'] = TextEditingController(text: profileData['educationLevel'] ?? "");
//     _controllers['profession'] = TextEditingController(text: profileData['profession'] ?? "");
//   }

//   Future<void> _pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);

//     if (image != null) {
//       setState(() {
//         _selectedImage = File(image.path);
//       });
//     }
//   }

//   Future<void> _uploadProfilePicture(ProfileProvider profileProvider, AuthProvider authProvider) async {
//     if (_selectedImage != null) {
//       bool success = await profileProvider.uploadProfilePicture(context, authProvider, _selectedImage!);
//       if (success) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Profile picture updated successfully")),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final profileProvider = Provider.of<ProfileProvider>(context);
//     final authProvider = Provider.of<AuthProvider>(context);
//     final profileData = profileProvider.getProfileData ?? {};
//     String? currentImageUrl = profileData['imageUrl']; // Assuming backend provides an image URL

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Edit Profile", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//         centerTitle: true,
//         backgroundColor: Colors.purple,
//         foregroundColor: Colors.white,
//       ),
//       body: profileProvider.getProfileData == null
//           ? const Center(child: CircularProgressIndicator())
//           : Container(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: Form(
//                 key: _formKey,
//                 child: ListView(
//                   children: [
//                     const SizedBox(height: 20),

//                     // Profile Picture Section
//                     Center(
//                       child: Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           CircleAvatar(
//                             radius: 60,
//                             backgroundColor: Colors.grey[300],
//                             backgroundImage: _selectedImage != null
//                                 ? FileImage(_selectedImage!) as ImageProvider
//                                 : (currentImageUrl != null && currentImageUrl.isNotEmpty
//                                     ? NetworkImage(currentImageUrl)
//                                     : const AssetImage("assets/default_profile.png")) as ImageProvider,
//                           ),
//                           Positioned(
//                             bottom: 0,
//                             right: 0,
//                             child: GestureDetector(
//                               onTap: _pickImage,
//                               child: Container(
//                                 padding: const EdgeInsets.all(6),
//                                 decoration: const BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Colors.purple,
//                                 ),
//                                 child: const Icon(Icons.camera_alt, color: Colors.white),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     // Upload Button (Only shows when an image is selected)
//                     if (_selectedImage != null)
//                       ElevatedButton(
//                         onPressed: () => _uploadProfilePicture(profileProvider, authProvider),
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(vertical: 12),
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//                           backgroundColor: Colors.purple.shade800,
//                         ),
//                         child: const Text(
//                           "Upload Profile Picture",
//                           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
//                         ),
//                       ),

//                     const SizedBox(height: 20),

//                     ..._controllers.keys.map((key) => buildTextField(key)),

//                     const SizedBox(height: 30),
//                     ElevatedButton(
//                       onPressed: () async {
//                         if (_formKey.currentState!.validate()) {
//                           Map<String, dynamic> updatedData =
//                               _controllers.map((key, controller) => MapEntry(key, controller.text));
//                           bool success = await profileProvider.updateProfile(context, authProvider, updatedData);

//                           if (success) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(content: Text("Profile updated successfully")),
//                             );
//                             Navigator.pop(context);
//                           }
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//                         backgroundColor: Colors.purple.shade800,
//                       ),
//                       child: const Text(
//                         "Save Changes",
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }

//   Widget buildTextField(String key) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             key[0].toUpperCase() + key.substring(1),
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.purple.shade700),
//           ),
//           const SizedBox(height: 4),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: const [
//                 BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2)),
//               ],
//             ),
//             child: TextFormField(
//               controller: _controllers[key],
//               keyboardType: key == "age" || key == "weight" || key == "height" ? TextInputType.number : TextInputType.text,
//               decoration: const InputDecoration(
//                 border: InputBorder.none,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:love_bird/api/profile_api.dart';
import 'package:love_bird/config/routes.dart';
import 'package:love_bird/edit%20profile%20screens/more_about_you_screen.dart';
import 'package:love_bird/edit%20profile%20screens/your_activity_screen.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:love_bird/providers/auth_provider.dart';

class EditLowProfileScreen extends StatefulWidget {
  const EditLowProfileScreen({super.key});

  @override
  State<EditLowProfileScreen> createState() => _EditLowProfileScreenState();
}

class _EditLowProfileScreenState extends State<EditLowProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};
  File? _selectedImage;
  String? _selectedAvatar; // Placeholder for avatar selection
  @override
  void initState() {
    super.initState();
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Fetch profile data first
    profileProvider.retieveProfile(context, authProvider).then((_) {
      final profileData = profileProvider.getProfileData ?? {};

      setState(() {
        _controllers['nickname'] =
            TextEditingController(text: profileData['nickname'] ?? "");
        _controllers['age'] =
            TextEditingController(text: profileData['age']?.toString() ?? "");
        _controllers['location'] =
            TextEditingController(text: profileData['location'] ?? "");
        _controllers['gender'] =
            TextEditingController(text: profileData['gender'] ?? "");
        _controllers['relationshipGoals'] =
            TextEditingController(text: profileData['relationshipGoals'] ?? "");
        _controllers['weight'] = TextEditingController(
            text: profileData['weight']?.toString() ?? "");
        _controllers['height'] = TextEditingController(
            text: profileData['height']?.toString() ?? "");
        _controllers['country'] =
            TextEditingController(text: profileData['country'] ?? "");
        _controllers['city'] =
            TextEditingController(text: profileData['city'] ?? "");
        _controllers['bio'] =
            TextEditingController(text: profileData['bio'] ?? "");
        _controllers['interest'] =
            TextEditingController(text: profileData['interest'] ?? "");
        _controllers['educationLevel'] =
            TextEditingController(text: profileData['educationLevel'] ?? "");
        _controllers['profession'] =
            TextEditingController(text: profileData['profession'] ?? "");
        // _controllers['religion'] =
        //     TextEditingController(text: profileData['religion'] ?? "");
        // _controllers['sexuality'] =
        //     TextEditingController(text: profileData['sexuality'] ?? "");
        // _controllers['smoking'] =
        //     TextEditingController(text: profileData['smoking'] ?? ""); 
        // _controllers['drinking'] =
        //     TextEditingController(text: profileData['drinking'] ?? "");
        // _controllers['pets'] =
        //     TextEditingController(text: profileData['pets'] ?? "");
        // _controllers['children'] =
        //     TextEditingController(text: profileData['children'] ?? "");
        // _controllers['personality'] =
        //     TextEditingController(text: profileData['personalty'] ?? "");
        // _controllers['relationshipStatus'] =
        //     TextEditingController(text: profileData['RelationshipStatus'] ?? "");
        // _controllers['starSign'] =
        //     TextEditingController(text: profileData['startSign'] ?? "");
        // _controllers['language'] =
        //     TextEditingController(text: profileData['language'] ?? "");
      });
    });
  }

  /// Function to update profile
  Future<void> _updateProfile(ProfileProvider profileProvider, AuthProvider authProvider) async {
  if (_formKey.currentState!.validate()) {
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final updatedData = {
      "nickname": _controllers['nickname']!.text,
      "age": int.tryParse(_controllers['age']!.text) ?? profileProvider.profileData?['age'],
      "location": _controllers['location']!.text,
      "gender": _controllers['gender']!.text,
      "relationshipGoals": _controllers['relationshipGoals']!.text,
      "weight": double.tryParse(_controllers['weight']!.text) ?? profileProvider.profileData?['weight'],
      "height": double.tryParse(_controllers['height']!.text) ?? profileProvider.profileData?['height'],
      "country": _controllers['country']!.text,
      "city": _controllers['city']!.text,
      "bio": _controllers['bio']!.text,
      "interest": _controllers['interest']!.text,
      "educationLevel": _controllers['educationLevel']!.text,
      "profession": _controllers['profession']!.text,
    };

    bool success = await profileProvider.updateProfile(context, authProvider, updatedData);

    if (success && mounted) {
      Navigator.pop(context); // Go back only if update was successful
    }
  }
}

  // Future<void> _updateProfile(
  //     ProfileProvider profileProvider, AuthProvider authProvider) async {
  //   if (_formKey.currentState!.validate()) {
  //     Map<String, dynamic> updatedData = {
  //       "nickname": _controllers['nickname']!.text,
  //       "age": int.tryParse(_controllers['age']!.text) ?? 0,
  //       "location": _controllers['location']!.text,
  //       "gender": _controllers['gender']!.text,
  //       "relationshipGoals": _controllers['relationshipGoals']!.text,
  //       "weight": int.tryParse(_controllers['weight']!.text) ?? 0,
  //       "height": int.tryParse(_controllers['height']!.text) ?? 0,
  //       "country": _controllers['country']!.text,
  //       "city": _controllers['city']!.text,
  //       "bio": _controllers['bio']!.text,
  //       "interest": _controllers['interest']!.text,
  //       "educationLevel": _controllers['educationLevel']!.text,
  //       "profession": _controllers['profession']!.text,
  //       "religion": _controllers['religion']!.text,
  //       "sexuality": _controllers['sexuality']!.text,
  //       "smoking": _controllers['smoking']!.text,
  //       "drinking": _controllers['drinking']!.text,
  //       "pets": _controllers['pets']!.text,
  //       "children": _controllers['children']!.text,
  //       "personality": _controllers['personality']!.text,
  //       "relationshipStatus": _controllers['relationshipStatus']!.text,
  //       "starSign": _controllers['starSign']!.text,
  //       "language": _controllers['language']!.text,
  //     };

  //     bool success = await profileProvider.updateProfile(
  //         context, authProvider, updatedData);
  //     if (success) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text("Profile updated successfully")),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text("Failed to update profile")),
  //       );
  //     }
  //   }
  // }

  void _navigateToMoreAboutYouscreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MoreAboutYouScreen()),
    );
  }

  // Show full-screen preview
  void _showPreview() {
    if (_selectedImage == null) return;
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(_selectedImage!, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
        _selectedAvatar = null; // Reset avatar if user selects an image
      });
    }
  }

  Future<void> _pickVideo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);

    if (video != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Video selected: ${video.name}")),
      );
    }
  }

  void _deleteProfilePicture() {
    setState(() {
      _selectedImage = null;
      _selectedAvatar = null;
    });
  }

  void _selectAvatar() {
    setState(() {
      _selectedAvatar =
          "assets/avatar.png"; // Replace with avatar selection logic
      _selectedImage = null;
    });
  }

  void _showImageOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.purple),
                title: const Text("Take Photo"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.purple),
                title: const Text("Add Photo"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.video_library, color: Colors.purple),
                title: const Text("Add Video"),
                onTap: () {
                  Navigator.pop(context);
                  _pickVideo();
                },
              ),
              ListTile(
                leading: const Icon(Icons.person, color: Colors.purple),
                title: const Text("Add Avatar"),
                onTap: () {
                  Navigator.pop(context);
                  _selectAvatar();
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text("Delete"),
                onTap: () {
                  Navigator.pop(context);
                  _deleteProfilePicture();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _uploadProfilePicture(
      ProfileProvider profileProvider, AuthProvider authProvider) async {
    if (_selectedImage != null) {
      bool success = await profileProvider.uploadProfilePicture(
          context, authProvider, _selectedImage!);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile picture updated successfully")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final profileData = profileProvider.getProfileData ?? {};
    String? currentImageUrl =
        profileData['imageUrl']; // Assuming backend provides an image URL

    return Scaffold(
      appBar: AppBar(
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
        centerTitle: true,
        // backgroundColor: Colors.purple,
        // foregroundColor: Colors.white,
      ),
      body: profileProvider.getProfileData == null
          ? const Center(child: CircularProgressIndicator())
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const SizedBox(height: 20),

                    // Profile Picture Section
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _selectedImage != null
                                  ? _showPreview()
                                  : _pickImage(ImageSource.gallery);
                            },
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.grey[300],
                              backgroundImage: _selectedImage != null
                                  ? FileImage(_selectedImage!) as ImageProvider
                                  : _selectedAvatar != null
                                      ? AssetImage(_selectedAvatar!)
                                          as ImageProvider
                                      : (currentImageUrl != null &&
                                              currentImageUrl.isNotEmpty
                                          ? NetworkImage(currentImageUrl)
                                              as ImageProvider
                                          : const AssetImage(
                                                  "assets/images/homeImage.png")
                                              as ImageProvider),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: _showImageOptions,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.purple,
                                ),
                                child: const Icon(Icons.camera_alt,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 5),

                    // Display Nickname and Age
                    Center(
                      child: Text(
                        "${_controllers['nickname']?.text ?? 'Unknown'}, ${_controllers['age']?.text ?? 'N/A'}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    // Upload Button (Only shows when an image is selected)
                    if (_selectedImage != null)
                      ElevatedButton(
                        onPressed: () => _uploadProfilePicture(
                            profileProvider, authProvider),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          backgroundColor: Colors.purple.shade800,
                        ),
                        child: const Text(
                          "Upload Profile Picture",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),

                    const SizedBox(height: 20),

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
                                          const YourActivityScreen(),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  width: 120,
                                  height: 35,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(
                                          0.19), // Assuming 'blue' is Colors.blue
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(
                                              8.0), // Adjusted padding
                                          child: Image.asset(
                                            "images/edit profile.png",
                                            width: 20, // Set image size
                                            height: 20,
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Your activity",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                            const Text(
                                              "Low",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.red,
                                              ),
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
                      ],
                    ),

                    const SizedBox(height: 20),

                    ..._controllers.keys.map((key) => buildTextField(key)),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () {
                        _updateProfile(profileProvider, authProvider);
                        _navigateToMoreAboutYouscreen();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        backgroundColor: Colors.purple.shade800,
                      ),
                      child: const Text(
                        "Save & Continue",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget buildTextField(String key) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            key[0].toUpperCase() + key.substring(1),
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.purple.shade700),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2)),
              ],
            ),
            child: TextFormField(
              controller: _controllers[key],
              keyboardType: key == "age" || key == "weight" || key == "height"
                  ? TextInputType.number
                  : TextInputType.text,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
