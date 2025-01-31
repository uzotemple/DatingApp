// import 'package:flutter/material.dart';
// import 'package:love_bird/api/home_api.dart';
// import 'package:love_bird/chat/chat_screen.dart';
// import 'package:love_bird/modals/modal_sheet.dart';

// import 'dart:async';

// import 'package:love_bird/profile/users_profile.dart';
// import 'package:love_bird/providers/auth_provider.dart';

// import 'package:provider/provider.dart';

// class ProfileInfo extends StatefulWidget {
//   final List<Map<String, String>> profiles;

//   const ProfileInfo({super.key, required this.profiles});

//   @override
//   State<ProfileInfo> createState() => _ProfileInfoState();
// }

// class _ProfileInfoState extends State<ProfileInfo> {
//   void initState() {
//     super.initState();
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     getRequest(authProvider);
//   }

//   int _currentIndex = 0;
//   bool _showSuperLike = false;
//   bool _showLike = false;
//   bool _showNo = false;
//   bool _showCancel = false;
//   double _rotationAngle = 0.0;

//   void _onStarPressed() {
//     setState(() {
//       _showSuperLike = true;
//       _rotationAngle = -0.2;
//     });

//     Future.delayed(const Duration(seconds: 1), () {
//       setState(() {
//         _showSuperLike = false;
//         _rotationAngle = 0.0;
//       });
//     });
//   }

//   void _onLovePressed() {
//     setState(() {
//       _showLike = true;
//       _rotationAngle = 0.3;
//     });

//     Future.delayed(const Duration(seconds: 1), () {
//       setState(() {
//         _showLike = false;
//         _rotationAngle = 0.0;
//       });
//     });
//   }

//   void _onNoPressed() {
//     setState(() {
//       _showNo = true;
//       _rotationAngle = -0.3;
//     });

//     Future.delayed(const Duration(seconds: 1), () {
//       setState(() {
//         _showNo = false;
//         _rotationAngle = 0.0;
//       });
//     });
//   }

//   void _onCancelPressed() {
//     setState(() {
//       _showCancel = true;
//     });

//     Future.delayed(const Duration(seconds: 1), () {
//       setState(() {
//         _showCancel = false;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Stack(
//       children: [
//         SizedBox(
//           height: MediaQuery.of(context).size.height * 0.7,
//           width: MediaQuery.of(context).size.width * 0.9,
//           child: PageView.builder(
//             itemCount: widget.profiles.length,
//             onPageChanged: (index) {
//               setState(() {
//                 _currentIndex = index;

//                 if (index == widget.profiles.length - 1) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text('This is the last image'),
//                       duration: Duration(seconds: 2),
//                     ),
//                   );
//                 }
//               });
//             },
//             itemBuilder: (context, index) {
//               final profile = widget.profiles[index];
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const UserProfilePage(),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     image: DecorationImage(
//                       image: AssetImage(profile['imageUrl']!),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),

//         // Action indicators and buttons
//         if (_showLike)
//           Positioned.fill(
//             child: Transform.rotate(
//               angle: _rotationAngle,
//               child: Container(
//                 width: MediaQuery.of(context).size.width * 0.5,
//                 height: MediaQuery.of(context).size.height * 0.4,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   image: DecorationImage(
//                     image: AssetImage(
//                       widget.profiles[_currentIndex]['imageUrl']!,
//                     ),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 child: Center(
//                   child: Opacity(
//                     opacity: _showLike ? 1.0 : 0.0,
//                     child: const Text(
//                       ' Like',
//                       style: TextStyle(
//                         fontSize: 32,
//                         color: Colors.white, // Set your desired color
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//         if (_showNo)
//           Positioned.fill(
//             child: Transform.rotate(
//               angle: _rotationAngle,
//               child: Container(
//                 width: MediaQuery.of(context).size.width * 0.9,
//                 height: MediaQuery.of(context).size.height * 0.74,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   image: DecorationImage(
//                     image: AssetImage(
//                       widget.profiles[_currentIndex]['imageUrl']!,
//                     ),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 child: Center(
//                   child: Opacity(
//                     opacity: _showNo ? 1.0 : 0.0,
//                     child: const Text(
//                       ' No',
//                       style: TextStyle(
//                         fontSize: 32,
//                         color: Colors.white, // Set your desired color
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//         if (_showSuperLike)
//           Positioned(
//             // top: MediaQuery.of(context).size.height * 0.1,
//             left: MediaQuery.of(context).size.width * 0.1,
//             child: Transform.rotate(
//               angle: _rotationAngle,
//               child: Container(
//                 width: MediaQuery.of(context).size.width *
//                     0.6, // Small image width
//                 height: MediaQuery.of(context).size.height *
//                     0.4, // Small image height
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   image: DecorationImage(
//                     image: AssetImage(
//                       widget.profiles[_currentIndex]['imageUrl']!,
//                     ),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 child: Center(
//                   child: Opacity(
//                     opacity: _showSuperLike ? 1.0 : 0.0,
//                     child: const Text(
//                       'Super  Like',
//                       style: TextStyle(
//                         fontSize: 30,
//                         color: Colors.white, // Set your desired color
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//         Positioned(
//           bottom: 0,
//           child: Container(
//             width: MediaQuery.of(context).size.width * 0.9,
//             padding: EdgeInsets.symmetric(
//                 vertical: MediaQuery.of(context).size.height * 0.01),
//             color: Colors.black.withOpacity(0.5),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.profiles[_currentIndex]['name']!,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: screenWidth * 0.04,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(
//                         height: screenHeight * 0.005,
//                       ),
//                       Text(
//                         widget.profiles[_currentIndex]['location']!,
//                         style: TextStyle(
//                             color: Colors.white, fontSize: screenWidth * 0.03),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       GestureDetector(
//                           onTap: _onCancelPressed,
//                           child: Image.asset('assets/images/left.png')),
//                       const Spacer(),
//                       InkWell(
//                         onTap: _onLovePressed,
//                         child: Image.asset('assets/images/love2.png'),
//                       ),
//                       const Spacer(),
//                       GestureDetector(
//                         onTap: _onStarPressed,
//                         child: Image.asset('assets/images/star2.png'),
//                       ),
//                       const Spacer(),
//                       GestureDetector(
//                           onTap: _onNoPressed,
//                           child: Image.asset('assets/images/cancel.png')),
//                       //const Spacer(),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         if (_showCancel)
//           Positioned.fill(
//             child: Center(
//               child: Opacity(
//                 opacity: _showCancel ? 1.0 : 0.0,
//                 child: const Text(
//                   'Recent Action Reversed',
//                   style: TextStyle(
//                     fontSize: 28,
//                     color: Colors.white, // Set your desired color
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),

//         Positioned(
//           top: 10,
//           right: 10,
//           child: IconButton(
//             icon: const Icon(Icons.more_horiz, color: Colors.white, size: 30),
//             onPressed: () {
//               showSmallPopup(context);
//             },
//           ),
//         ),
//         Positioned(
//           bottom: screenHeight * 0.2,
//           // bottom: 170,
//           right: 10,
//           child: InkWell(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const ChatDetailScreen(
//                     name: 'Daniel',
//                     profileImage: 'assets/images/homeImage.png',
//                     isOnline: true,
//                     lastMessage: 'Hello',
//                   ),
//                 ),
//               );
//             },
//             child: Image.asset('assets/images/icons/messageicon.png'),
//           ),
//         ),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:love_bird/api/home_api.dart';
// import 'package:love_bird/chat/chat_screen.dart';
// import 'package:love_bird/modals/block_and_report_modal.dart';

// import 'package:love_bird/model/profile_model.dart';
// import 'package:love_bird/profile/users_profile.dart';

// import 'package:provider/provider.dart';

// import 'package:love_bird/providers/auth_provider.dart';

// class ProfileInfo extends StatefulWidget {
//   const ProfileInfo({super.key});

//   @override
//   _ProfileInfoState createState() => _ProfileInfoState();
// }

// class _ProfileInfoState extends State<ProfileInfo> {
//   List<Profile> profiles = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     fetchProfileData(authProvider);
//   }

//   bool _showSuperLike = false;
//   bool _showLike = false;
//   bool _showNo = false;
//   bool _showCancel = false;
//   double _rotationAngle = 0.0;

//   void _onStarPressed() {
//     setState(() {
//       _showSuperLike = true;
//       _rotationAngle = -0.2;
//     });

//     Future.delayed(const Duration(seconds: 1), () {
//       setState(() {
//         _showSuperLike = false;
//         _rotationAngle = 0.0;
//       });
//     });
//   }

//   void _onLovePressed() {
//     setState(() {
//       _showLike = true;
//       _rotationAngle = 0.3;
//     });

//     Future.delayed(const Duration(seconds: 1), () {
//       setState(() {
//         _showLike = false;
//         _rotationAngle = 0.0;
//       });
//     });
//   }

//   void _onNoPressed() {
//     setState(() {
//       _showNo = true;
//       _rotationAngle = -0.3;
//     });

//     Future.delayed(const Duration(seconds: 1), () {
//       setState(() {
//         _showNo = false;
//         _rotationAngle = 0.0;
//       });
//     });
//   }

//   void _onCancelPressed() {
//     setState(() {
//       _showCancel = true;
//     });

//     Future.delayed(const Duration(seconds: 1), () {
//       setState(() {
//         _showCancel = false;
//       });
//     });
//   }

//   void fetchProfileData(AuthProvider authProvider) async {
//     try {
//       List<Profile> fetchedProfiles =
//           await ProfileService.fetchProfiles(authProvider);
//       setState(() {
//         profiles = fetchedProfiles;
//         isLoading = false;
//       });
//     } catch (error) {
//       print("Error fetching profiles: $error");
//       setState(() => isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     if (isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     return SizedBox(
//       height: screenHeight * 0.7,
//       width: screenWidth * 0.9,
//       child: PageView.builder(
//         itemCount: profiles.length,
//         itemBuilder: (context, index) {
//           final profile = profiles[index];
//           final name = profile.nickname ?? "Unknown";
//           final age = profile.age ?? "N/A";
//           return GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => UserProfilePage(profile: profile)),
//                 );
//               },
//               child: Stack(children: [
//                 Container(
//                   height: double.infinity,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     image: const DecorationImage(
//                       image: AssetImage('assets/images/homeImage.png'),
//                       //                image: AssetImage(profile.imageUrl!),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   // child: Column(
//                   //   mainAxisAlignment: MainAxisAlignment.end,
//                   //   children: [
//                   //     Text(
//                   //       profile.nickname ?? "Unknown",
//                   //       style: TextStyle(
//                   //           color: Colors.white,
//                   //           fontSize: 18,
//                   //           fontWeight: FontWeight.bold),
//                   //     ),
//                   //     Text(
//                   //       profile.age ?? "N/A",
//                   //       style: TextStyle(color: Colors.white, fontSize: 16),
//                   //     ),
//                   //   ],
//                   // ),
//                 ),
//                 Positioned(
//                   bottom: 0,
//                   child: Container(
//                     width: screenWidth * 0.9,
//                     padding:
//                         EdgeInsets.symmetric(vertical: screenHeight * 0.01),
//                     color: Colors.black.withOpacity(0.5),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.all(
//                             screenWidth * 0.02,
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 '$name, $age',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: screenWidth * 0.04,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: screenHeight * 0.005,
//                               ),
//                               Text(
//                                 '20 km away',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: screenWidth * 0.03),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: screenWidth * 0.02),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               GestureDetector(
//                                   onTap: _onCancelPressed,
//                                   child: Image.asset('assets/images/left.png')),
//                               const Spacer(),
//                               InkWell(
//                                 onTap: _onLovePressed,
//                                 child: Image.asset('assets/images/love2.png'),
//                               ),
//                               const Spacer(),
//                               GestureDetector(
//                                 onTap: _onStarPressed,
//                                 child: Image.asset('assets/images/star2.png'),
//                               ),
//                               const Spacer(),
//                               GestureDetector(
//                                   onTap: _onNoPressed,
//                                   child:
//                                       Image.asset('assets/images/cancel.png')),
//                               //const Spacer(),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 //      Action indicators and buttons
//                 if (_showCancel)
//                   Positioned.fill(
//                     child: Center(
//                       child: Opacity(
//                         opacity: _showCancel ? 1.0 : 0.0,
//                         child: Text(
//                           'Recent Action Reversed',
//                           style: TextStyle(
//                             fontSize: screenWidth * 0.06,
//                             color: Colors.white, // Set your desired color
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
// //           ),
//                 if (_showLike)
//                   Positioned.fill(
//                     child: Transform.rotate(
//                       angle: _rotationAngle,
//                       child: Container(
//                         width: MediaQuery.of(context).size.width * 0.5,
//                         height: MediaQuery.of(context).size.height * 0.4,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           image: const DecorationImage(
//                             image: AssetImage('assets/images/homeImage.png'),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         child: Center(
//                           child: Opacity(
//                             opacity: _showLike ? 1.0 : 0.0,
//                             child: const Text(
//                               ' Like',
//                               style: TextStyle(
//                                 fontSize: 32,
//                                 color: Colors.white, // Set your desired color
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),

//                 if (_showNo)
//                   Positioned.fill(
//                     child: Transform.rotate(
//                       angle: _rotationAngle,
//                       child: Container(
//                         width: MediaQuery.of(context).size.width * 0.9,
//                         height: MediaQuery.of(context).size.height * 0.74,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           image: const DecorationImage(
//                             image: AssetImage('assets/images/homeImage.png'),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         child: Center(
//                           child: Opacity(
//                             opacity: _showNo ? 1.0 : 0.0,
//                             child: const Text(
//                               ' No',
//                               style: TextStyle(
//                                 fontSize: 32,
//                                 color: Colors.white, // Set your desired color
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),

//                 if (_showSuperLike)
//                   Positioned(
//                     // top: MediaQuery.of(context).size.height * 0.1,
//                     left: MediaQuery.of(context).size.width * 0.1,
//                     child: Transform.rotate(
//                       angle: _rotationAngle,
//                       child: Container(
//                         width: MediaQuery.of(context).size.width *
//                             0.6, // Small image width
//                         height: MediaQuery.of(context).size.height *
//                             0.4, // Small image height
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           image: const DecorationImage(
//                             image: AssetImage('assets/images/homeImage.png'),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         child: Center(
//                           child: Opacity(
//                             opacity: _showSuperLike ? 1.0 : 0.0,
//                             child: const Text(
//                               'Super  Like',
//                               style: TextStyle(
//                                 fontSize: 30,
//                                 color: Colors.white, // Set your desired color
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),

//                 Positioned(
//                   top: 10,
//                   right: 10,
//                   child: IconButton(
//                     icon: const Icon(Icons.more_horiz,
//                         color: Colors.white, size: 30),
//                     onPressed: () {
//                       showSmallPopup(context);
//                     },
//                   ),
//                 ),
//                 Positioned(
//                   bottom: screenHeight * 0.2,
//                   // bottom: 170,
//                   right: 10,
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const ChatDetailScreen(
//                             name: 'Daniel',
//                             profileImage: 'assets/images/homeImage.png',
//                             isOnline: true,
//                             lastMessage: 'Hello',
//                           ),
//                         ),
//                       );
//                     },
//                     child: Image.asset('assets/images/icons/messageicon.png'),
//                   ),
//                 ),
//               ]));
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:love_bird/api/home_api.dart';
// import 'package:love_bird/api/profile_api.dart';
// import 'package:love_bird/chat/chat_screen.dart';
// import 'package:love_bird/modals/block_and_report_modal.dart';
// import 'package:love_bird/model/profile_model.dart';
// import 'package:love_bird/profile/users_profile.dart';
// import 'package:love_bird/providers/visit_provider.dart';
// // import 'package:love_bird/providers/visit_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:love_bird/providers/auth_provider.dart';

// class ProfileInfo extends StatefulWidget {
//   const ProfileInfo({super.key});

//   @override
//   _ProfileInfoState createState() => _ProfileInfoState();
// }

// class _ProfileInfoState extends State<ProfileInfo> {
//   List<Profile> profiles = [];
//   bool isLoading = true;
//   bool _isDisposed = false;

//   bool _showSuperLike = false;
//   bool _showLike = false;
//   bool _showNo = false;
//   bool _showCancel = false;
//   double _rotationAngle = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     final profileProvider =
//         Provider.of<ProfileProvider>(context, listen: false);
//     profileProvider.retieveProfile(context, authProvider); // Fetch profile data
//   }

//   @override
//   void dispose() {
//     _isDisposed = true;
//     super.dispose();
//   }

//   void fetchProfileData(AuthProvider authProvider) async {
//     try {
//       List<Profile> fetchedProfiles =
//           await ProfileService.fetchProfiles(authProvider);
//       if (!_isDisposed) {
//         setState(() {
//           profiles = fetchedProfiles;
//           isLoading = false;
//         });
//       }
//     } catch (error) {
//       if (!_isDisposed) {
//         setState(() => isLoading = false);
//       }
//       print("Error fetching profiles: $error");
//     }
//   }

//   void _triggerAction(
//       {required void Function() setFlag, double rotationAngle = 0.0}) {
//     setState(() {
//       setFlag();
//       _rotationAngle = rotationAngle;
//     });

//     Future.delayed(const Duration(seconds: 1), () {
//       if (mounted) {
//         setState(() {
//           setFlag();
//           _rotationAngle = 0.0;
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     if (isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     return SizedBox(
//       height: screenHeight * 0.7,
//       width: screenWidth * 0.9,
//       child: PageView.builder(
//         itemCount: profiles.length,
//         itemBuilder: (context, index) {
//           final profile = profiles[index];
//           final name = profile.nickname ?? "Unknown";
//           final age = profile.age ?? "N/A";
//           final imageUrl = profile.imageUrl != null
//               ? NetworkImage(profile.imageUrl!)
//               : const AssetImage('assets/images/homeImage.png');

//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => UserProfilePage(profile: profile),
//                 ),
//               );
//             },
//             child: Stack(
//               children: [
//                 Container(
//                   height: double.infinity,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     image: DecorationImage(
//                       image: imageUrl as ImageProvider,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 0,
//                   child: Container(
//                     width: screenWidth * 0.9,
//                     padding:
//                         EdgeInsets.symmetric(vertical: screenHeight * 0.01),
//                     color: Colors.black.withOpacity(0.5),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.all(screenWidth * 0.02),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 '$name, $age',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: screenWidth * 0.04,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               SizedBox(height: screenHeight * 0.005),
//                               Text(
//                                 '20 km away',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: screenWidth * 0.03,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: screenWidth * 0.02),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               GestureDetector(
//                                 onTap: () => _triggerAction(
//                                     setFlag: () => _showCancel = !_showCancel),
//                                 child: Image.asset('assets/images/left.png'),
//                               ),
//                               const Spacer(),
//                               GestureDetector(
//                                 onTap: () async {
//                                   _triggerAction(
//                                     setFlag: () => _showLike = !_showLike,
//                                     rotationAngle: 0.3,
//                                   );

//                                   final authToken = Provider.of<AuthProvider>(
//                                           context,
//                                           listen: false)
//                                       .accessToken;

//                                   // Ensure the profile data is retrieved before using it
//                                   final profileProvider =
//                                       Provider.of<ProfileProvider>(context,
//                                           listen: false);
//                                   if (profileProvider.getProfileData != null) {
//                                     final profileId = profileProvider
//                                             .getProfileData?[
//                                         'profileId']; // Access profileId here

//                                     if (profileId != null) {
//                                       // Use the fetched profileId for the visitorId in addVisit
//                                       Provider.of<VisitProvider>(context,
//                                               listen: false)
//                                           .addVisit(
//                                         visitorId: profileId,
//                                         action: 'LIKE',
//                                         authToken: authToken,
//                                       );
//                                     } else {
//                                       print('Profile ID is missing');
//                                     }
//                                   } else {
//                                     print('Profile data is not available');
//                                   }
//                                 },
//                                 child: Image.asset('assets/images/love2.png'),
//                               ),
//                               const Spacer(),
//                               GestureDetector(
//                                 onTap: () => _triggerAction(
//                                     setFlag: () =>
//                                         _showSuperLike = !_showSuperLike,
//                                     rotationAngle: -0.2),
//                                 child: Image.asset('assets/images/star2.png'),
//                               ),
//                               const Spacer(),
//                               GestureDetector(
//                                 onTap: () => _triggerAction(
//                                     setFlag: () => _showNo = !_showNo,
//                                     rotationAngle: -0.3),
//                                 child: Image.asset('assets/images/cancel.png'),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 if (_showCancel)
//                   Positioned.fill(
//                     child: Center(
//                       child: Text(
//                         'Recent Action Reversed',
//                         style: TextStyle(
//                           fontSize: screenWidth * 0.06,
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 if (_showLike)
//                   _buildActionOverlay(screenWidth, screenHeight, 'LIKE', 0.3),
//                 if (_showNo)
//                   _buildActionOverlay(
//                       screenWidth, screenHeight, 'DISLIKE', -0.3),
//                 if (_showSuperLike)
//                   _buildActionOverlay(
//                       screenWidth, screenHeight, 'SUPERLIKE', -0.2),
//                 Positioned(
//                   top: 10,
//                   right: 10,
//                   child: IconButton(
//                     icon: const Icon(Icons.more_horiz,
//                         color: Colors.white, size: 30),
//                     onPressed: () {
//                       showSmallPopup(context);
//                     },
//                   ),
//                 ),
//                 Positioned(
//                   bottom: screenHeight * 0.2,
//                   right: 10,
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const ChatDetailScreen(
//                             name: 'Daniel',
//                             profileImage: 'assets/images/homeImage.png',
//                             isOnline: true,
//                             lastMessage: 'Hello',
//                           ),
//                         ),
//                       );
//                     },
//                     child: Image.asset('assets/images/icons/messageicon.png'),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildActionOverlay(
//       double width, double height, String label, double angle) {
//     return Positioned.fill(
//       child: Transform.rotate(
//         angle: angle,
//         child: Center(
//           child: Text(
//             label,
//             style: TextStyle(
//               fontSize: width * 0.06,
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:love_bird/api/home_api.dart';
// import 'package:provider/provider.dart';
// // import 'package:love_bird/api/profile_api.dart';
// // import 'package:love_bird/chat/chat_screen.dart';
// // import 'package:love_bird/modals/block_and_report_modal.dart';
// import 'package:love_bird/model/profile_model.dart';
// import 'package:love_bird/profile/users_profile.dart';
// // import 'package:love_bird/providers/visit_provider.dart';
// import 'package:love_bird/providers/auth_provider.dart';

// class ProfileInfo extends StatefulWidget {
//   const ProfileInfo({Key? key}) : super(key: key);

//   @override
//   State<ProfileInfo> createState() => _ProfileInfoState();
// }

// class _ProfileInfoState extends State<ProfileInfo> {
//   List<Profile> profiles = [];
//   bool isLoading = true;
//   bool _isDisposed = false;

//   bool _showSuperLike = false;
//   bool _showLike = false;
//   bool _showNo = false;
//   bool _showCancel = false;
//   double _rotationAngle = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final authProvider = Provider.of<AuthProvider>(context, listen: false);
//       fetchProfileData(authProvider);
//     });
//   }

//   @override
//   void dispose() {
//     _isDisposed = true;
//     super.dispose();
//   }

//   void fetchProfileData(AuthProvider authProvider) async {
//     try {
//       List<Profile> fetchedProfiles =
//           await ProfileService.fetchProfiles(authProvider);
//       if (!_isDisposed) {
//         setState(() {
//           profiles = fetchedProfiles;
//           isLoading = false;
//         });
//       }
//     } catch (error) {
//       if (!_isDisposed) {
//         setState(() => isLoading = false);
//       }
//       print("Error fetching profiles: $error");
//     }
//   }

//   void _triggerAction(
//       {required void Function() setFlag, double rotationAngle = 0.0}) {
//     setState(() {
//       setFlag();
//       _rotationAngle = rotationAngle;
//     });

//     Future.delayed(const Duration(seconds: 1), () {
//       if (mounted) {
//         setState(() {
//           setFlag();
//           _rotationAngle = 0.0;
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     if (isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     return SizedBox(
//       height: screenHeight * 0.7,
//       width: screenWidth * 0.9,
//       child: PageView.builder(
//         itemCount: profiles.length,
//         itemBuilder: (context, index) {
//           final profile = profiles[index];
//           final name = profile.nickname ?? "Unknown";
//           final age = profile.age?.toString() ?? "N/A";
//           final imageUrl = profile.imageUrl != null
//               ? NetworkImage(profile.imageUrl!)
//               : const AssetImage('assets/images/homeImage.png');

//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => UserProfilePage(profile: profile),
//                 ),
//               );
//             },
//             child: Stack(
//               children: [
//                 Container(
//                   height: double.infinity,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     image: DecorationImage(
//                       image: imageUrl as ImageProvider,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 0,
//                   child: Container(
//                     width: screenWidth * 0.9,
//                     padding:
//                         EdgeInsets.symmetric(vertical: screenHeight * 0.01),
//                     color: Colors.black.withOpacity(0.5),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.all(screenWidth * 0.02),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 '$name, $age',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: screenWidth * 0.04,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               SizedBox(height: screenHeight * 0.005),
//                               Text(
//                                 '20 km away',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: screenWidth * 0.03,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: screenWidth * 0.02),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               GestureDetector(
//                                 onTap: () => _triggerAction(
//                                     setFlag: () => _showCancel = !_showCancel),
//                                 child: Image.asset('assets/images/left.png'),
//                               ),
//                               const Spacer(),
//                               GestureDetector(
//                                 onTap: () {
//                                   _triggerAction(
//                                     setFlag: () => _showLike = !_showLike,
//                                     rotationAngle: 0.3,
//                                   );
//                                 },
//                                 child: Image.asset('assets/images/love2.png'),
//                               ),
//                               const Spacer(),
//                               GestureDetector(
//                                 onTap: () => _triggerAction(
//                                     setFlag: () =>
//                                         _showSuperLike = !_showSuperLike,
//                                     rotationAngle: -0.2),
//                                 child: Image.asset('assets/images/star2.png'),
//                               ),
//                               const Spacer(),
//                               GestureDetector(
//                                 onTap: () => _triggerAction(
//                                     setFlag: () => _showNo = !_showNo,
//                                     rotationAngle: -0.3),
//                                 child: Image.asset('assets/images/cancel.png'),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 // Add overlays for actions (e.g., LIKE, DISLIKE, etc.)
//                 if (_showLike)
//                   _buildActionOverlay(screenWidth, screenHeight, 'LIKE', 0.3),
//                 if (_showNo)
//                   _buildActionOverlay(
//                       screenWidth, screenHeight, 'DISLIKE', -0.3),
//                 if (_showSuperLike)
//                   _buildActionOverlay(
//                       screenWidth, screenHeight, 'SUPERLIKE', -0.2),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildActionOverlay(
//       double width, double height, String label, double angle) {
//     return Positioned.fill(
//       child: Transform.rotate(
//         angle: angle,
//         child: Center(
//           child: Text(
//             label,
//             style: TextStyle(
//               fontSize: width * 0.06,
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:love_bird/providers/profile_data_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:love_bird/providers/auth_provider.dart';
// import 'package:love_bird/providers/visit_provider.dart';

// class ProfileInfo extends StatelessWidget {
//   const ProfileInfo({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Fetch the `profileId` (visitorId) dynamically or display a default value
//     final profileId = Provider.of<ProfileDataProvider>(context, listen: false).profileId;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile Actions'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (profileId == null)
//               const Center(
//                 child: Text(
//                   'Profile not found. Please select a valid profile.',
//                   style: TextStyle(fontSize: 18, color: Colors.red),
//                   textAlign: TextAlign.center,
//                 ),
//               )
//             else ...[
//               // Action buttons for LIKE, SUPERLIKE, DISLIKE
//               _buildActionButton(context, 'LIKE', profileId),
//               const SizedBox(height: 20),
//               _buildActionButton(context, 'SUPERLIKE', profileId),
//               const SizedBox(height: 20),
//               _buildActionButton(context, 'DISLIKE', profileId),
//               const SizedBox(height: 20),
//               Consumer<VisitProvider>(
//                 builder: (context, visitProvider, child) {
//                   // Display loading indicator if the request is in progress
//                   if (visitProvider.isLoading) {
//                     return const CircularProgressIndicator();
//                   }

//                   // Display message after the action is completed
//                   if (visitProvider.message != null) {
//                     return Text(
//                       visitProvider.message!,
//                       style: const TextStyle(
//                         fontSize: 18,
//                         color: Colors.green,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     );
//                   }

//                   return const SizedBox(); // No message to show if there's nothing.
//                 },
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }

//   // Helper method to build each action button (LIKE, SUPERLIKE, DISLIKE)
//   Widget _buildActionButton(BuildContext context, String action, String profileId) {
//     return ElevatedButton(
//       onPressed: () async {
//         // Get the authToken from the AuthProvider
//         final authToken = Provider.of<AuthProvider>(context, listen: false).accessToken;

//         // Ensure the authToken is valid and not null
//         if (authToken == null || authToken.isEmpty) {
//           // Handle missing authToken (show error or notify user)
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Please login first!')),
//           );
//           return;
//         }

//         try {
//           // Call the addVisit method from VisitProvider
//           await Provider.of<VisitProvider>(context, listen: false).addVisit(
//             visitorId: profileId,
//             action: action, // 'LIKE', 'SUPERLIKE', or 'DISLIKE'
//             authToken: authToken,
//           );
//         } catch (error) {
//           // Handle errors gracefully
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Error: $error')),
//           );
//         }
//       },
//       style: ElevatedButton.styleFrom(
//         padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//         backgroundColor: _getButtonColor(action), // Change button color based on action
//       ),
//       child: Text(action, style: const TextStyle(fontSize: 18)),
//     );
//   }

//   // Helper method to set the button color based on the action type
//   Color _getButtonColor(String action) {
//     switch (action) {
//       case 'LIKE':
//         return Colors.blue;
//       case 'SUPERLIKE':
//         return Colors.purple;
//       case 'DISLIKE':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:love_bird/api/home_api.dart';
import 'package:love_bird/chat/chat_screen.dart';
import 'package:love_bird/modals/block_and_report_modal.dart';
import 'package:love_bird/model/profile_model.dart';
import 'package:love_bird/profile/users_profile.dart';
import 'package:love_bird/providers/visit_provider.dart';
import 'package:provider/provider.dart';
import 'package:love_bird/providers/auth_provider.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  List<Profile> profiles = [];
  bool isLoading = true;
  bool _isDisposed = false;

  bool _showSuperLike = false;
  bool _showLike = false;
  bool _showNo = false;
  double _rotationAngle = 0.0;

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    fetchProfileData(authProvider); // Fetch profiles on initialization
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  void fetchProfileData(AuthProvider authProvider) async {
    try {
      List<Profile> fetchedProfiles =
          await ProfileService.fetchProfiles(authProvider);
      if (!_isDisposed) {
        setState(() {
          profiles = fetchedProfiles;
          isLoading = false;
        });
      }
    } catch (error) {
      if (!_isDisposed) {
        setState(() => isLoading = false);
      }
      print("Error fetching profiles: $error");
    }
  }

  void _triggerAction({
    required void Function() setFlag,
    required String action,
    required String? visitorId,
    double rotationAngle = 0.0,
  }) {
    setState(() {
      setFlag();
      _rotationAngle = rotationAngle;
    });

    // Trigger the action (LIKE, SUPERLIKE, or DISLIKE)
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final authToken = authProvider.accessToken;

    if (visitorId == null || visitorId.isEmpty) {
      print("Error: visitorId is missing");
      return;
    }

    if (authToken != null && authToken.isNotEmpty) {
      Provider.of<VisitProvider>(context, listen: false).addVisit(
        visitorId: visitorId,
        action: action,
        authToken: authToken,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please login first!')),
      );
    }

    // Reset the UI effect after a delay
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          setFlag();
          _rotationAngle;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SizedBox(
      height: screenHeight * 0.7,
      width: screenWidth * 0.9,
      child: PageView.builder(
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          final profile = profiles[index];
          final name = profile.nickname ?? "Unknown";
          final age = profile.age ?? "N/A";
          final visitorId = profile.profileId;

          // Commenting out the network image to use only the asset image
          // final ImageProvider<Object> imageUrl =
          //     (profile.imageUrl != null && profile.imageUrl!.isNotEmpty)
          //         ? NetworkImage(profile.imageUrl!)
          //         : const AssetImage('assets/images/homeImage.png');

          const ImageProvider<Object> imageUrl =
              AssetImage('assets/images/homeImage.png');

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfilePage(profile: profile),
                ),
              );
            },
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: screenWidth * 0.9,
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                    color: Colors.black.withOpacity(0.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(screenWidth * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$name, $age',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.005),
                              Text(
                                '20 km away',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.03,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () => _triggerAction(
                                  setFlag: () => _showNo = !_showNo,
                                  action: 'DISLIKE',
                                  visitorId: visitorId,
                                  rotationAngle: -0.3,
                                ),
                                child: Image.asset('assets/images/left.png'),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () => _triggerAction(
                                  setFlag: () => _showLike = !_showLike,
                                  action: 'LIKE',
                                  visitorId: visitorId,
                                  rotationAngle: 0.3,
                                ),
                                child: Image.asset('assets/images/love2.png'),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () => _triggerAction(
                                  setFlag: () =>
                                      _showSuperLike = !_showSuperLike,
                                  action: 'SUPERLIKE',
                                  visitorId: visitorId,
                                  rotationAngle: -0.2,
                                ),
                                child: Image.asset('assets/images/star2.png'),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () => _triggerAction(
                                  setFlag: () => _showNo = !_showNo,
                                  action: 'DISLIKE',
                                  visitorId: visitorId,
                                  rotationAngle: -0.3,
                                ),
                                child: Image.asset('assets/images/cancel.png'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_showNo)
                  _buildActionOverlay(
                      screenWidth, screenHeight, 'DISLIKE', -0.3),
                if (_showLike)
                  _buildActionOverlay(screenWidth, screenHeight, 'LIKE', 0.3),
                if (_showSuperLike)
                  _buildActionOverlay(
                      screenWidth, screenHeight, 'SUPERLIKE', -0.2),
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(Icons.more_horiz,
                        color: Colors.white, size: 30),
                    onPressed: () {
                      showSmallPopup(context);
                    },
                  ),
                ),
                Positioned(
                  bottom: screenHeight * 0.2,
                  right: 10,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChatDetailScreen(
                            name: 'Daniel',
                            profileImage: 'assets/images/homeImage.png',
                            isOnline: true,
                            lastMessage: 'Hello',
                          ),
                        ),
                      );
                    },
                    child: Image.asset('assets/images/icons/messageicon.png'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    // return SizedBox(
    //   height: screenHeight * 0.7,
    //   width: screenWidth * 0.9,
    //   child: PageView.builder(
    //     itemCount: profiles.length,
    //     itemBuilder: (context, index) {
    //       final profile = profiles[index];
    //       final name = profile.nickname ?? "Unknown";
    //       final age = profile.age ?? "N/A";
    //       final visitorId = profile.profileId;
    //       // final imageUrl = profile.imageUrl != null
    //       //     ? NetworkImage(profile.imageUrl!)
    //       //     : const AssetImage('assets/images/homeImage.png') as ImageProvider;

    //       final ImageProvider<Object> imageUrl =
    //           (profile.imageUrl != null && profile.imageUrl!.isNotEmpty)
    //               ? NetworkImage(profile.imageUrl!)
    //               : const AssetImage('assets/images/homeImage.png');

    //               print("Profile Image URL: ${profile.imageUrl}, Using Image: $imageUrl");

    //       return GestureDetector(
    //         onTap: () {
    //           Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => UserProfilePage(profile: profile),
    //             ),
    //           );
    //         },
    //         child: Stack(
    //           children: [
    //             Container(
    //               height: double.infinity,
    //               width: double.infinity,
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(10),
    //                 image: DecorationImage(
    //                   // image: imageUrl as ImageProvider,
    //                   image: imageUrl,
    //                   fit: BoxFit.cover,
    //                 ),
    //               ),
    //             ),
    //             Positioned(
    //               bottom: 0,
    //               child: Container(
    //                 width: screenWidth * 0.9,
    //                 padding:
    //                     EdgeInsets.symmetric(vertical: screenHeight * 0.01),
    //                 color: Colors.black.withOpacity(0.5),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Padding(
    //                       padding: EdgeInsets.all(screenWidth * 0.02),
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Text(
    //                             '$name, $age',
    //                             style: TextStyle(
    //                               color: Colors.white,
    //                               fontSize: screenWidth * 0.04,
    //                               fontWeight: FontWeight.bold,
    //                             ),
    //                           ),
    //                           SizedBox(height: screenHeight * 0.005),
    //                           Text(
    //                             '20 km away',
    //                             style: TextStyle(
    //                               color: Colors.white,
    //                               fontSize: screenWidth * 0.03,
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                     Padding(
    //                       padding: EdgeInsets.symmetric(
    //                           horizontal: screenWidth * 0.02),
    //                       child: Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                         children: [
    //                           GestureDetector(
    //                             onTap: () => _triggerAction(
    //                               setFlag: () => _showNo = !_showNo,
    //                               action: 'DISLIKE',
    //                               visitorId: visitorId,
    //                               rotationAngle: -0.3,
    //                             ),
    //                             child: Image.asset('assets/images/left.png'),
    //                           ),
    //                           const Spacer(),
    //                           GestureDetector(
    //                             onTap: () => _triggerAction(
    //                               setFlag: () => _showLike = !_showLike,
    //                               action: 'LIKE',
    //                               visitorId: visitorId,
    //                               rotationAngle: 0.3,
    //                             ),
    //                             child: Image.asset('assets/images/love2.png'),
    //                           ),
    //                           const Spacer(),
    //                           GestureDetector(
    //                             onTap: () => _triggerAction(
    //                               setFlag: () =>
    //                                   _showSuperLike = !_showSuperLike,
    //                               action: 'SUPERLIKE',
    //                               visitorId: visitorId,
    //                               rotationAngle: -0.2,
    //                             ),
    //                             child: Image.asset('assets/images/star2.png'),
    //                           ),
    //                           const Spacer(),
    //                           GestureDetector(
    //                             onTap: () => _triggerAction(
    //                               setFlag: () => _showNo = !_showNo,
    //                               action: 'DISLIKE',
    //                               visitorId: visitorId,
    //                               rotationAngle: -0.3,
    //                             ),
    //                             child: Image.asset('assets/images/cancel.png'),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //             if (_showNo)
    //               _buildActionOverlay(
    //                   screenWidth, screenHeight, 'DISLIKE', -0.3),
    //             if (_showLike)
    //               _buildActionOverlay(screenWidth, screenHeight, 'LIKE', 0.3),
    //             if (_showSuperLike)
    //               _buildActionOverlay(
    //                   screenWidth, screenHeight, 'SUPERLIKE', -0.2),
    //             Positioned(
    //               top: 10,
    //               right: 10,
    //               child: IconButton(
    //                 icon: const Icon(Icons.more_horiz,
    //                     color: Colors.white, size: 30),
    //                 onPressed: () {
    //                   showSmallPopup(context);
    //                 },
    //               ),
    //             ),
    //             Positioned(
    //               bottom: screenHeight * 0.2,
    //               right: 10,
    //               child: InkWell(
    //                 onTap: () {
    //                   Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                       builder: (context) => const ChatDetailScreen(
    //                         name: 'Daniel',
    //                         profileImage: 'assets/images/homeImage.png',
    //                         isOnline: true,
    //                         lastMessage: 'Hello',
    //                       ),
    //                     ),
    //                   );
    //                 },
    //                 child: Image.asset('assets/images/icons/messageicon.png'),
    //               ),
    //             ),
    //           ],
    //         ),
    //       );
    //     },
    //   ),
    // );
  }

  Widget _buildActionOverlay(
      double width, double height, String label, double angle) {
    return Positioned.fill(
      child: Transform.rotate(
        angle: angle,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: width * 0.06,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:love_bird/api/home_api.dart';
// import 'package:love_bird/model/profile_model.dart';
// import 'package:love_bird/providers/visit_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:love_bird/providers/auth_provider.dart';

// class ProfileInfo extends StatefulWidget {
//   const ProfileInfo({super.key});

//   @override
//   _ProfileInfoState createState() => _ProfileInfoState();
// }

// class _ProfileInfoState extends State<ProfileInfo> {
//   List<Profile> profiles = [];
//   bool isLoading = true;
//   bool _isDisposed = false;

//   @override
//   void initState() {
//     super.initState();
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     fetchProfileData(authProvider);
//   }

//   @override
//   void dispose() {
//     _isDisposed = true;
//     super.dispose();
//   }

//   void fetchProfileData(AuthProvider authProvider) async {
//     try {
//       List<Profile> fetchedProfiles =
//           await ProfileService.fetchProfiles(authProvider);
//       if (!_isDisposed) {
//         setState(() {
//           profiles = fetchedProfiles;
//           isLoading = false;
//         });
//       }
//     } catch (error) {
//       if (!_isDisposed) {
//         setState(() => isLoading = false);
//       }
//       print("Error fetching profiles: $error");
//     }
//   }

//   void _triggerAction({
//     required String action,
//     required String? visitorId,
//   }) {
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     final authToken = authProvider.accessToken;

//     if (visitorId == null || visitorId.isEmpty) {
//       print("Error: visitorId is missing");
//       return;
//     }

//     if (authToken != null && authToken.isNotEmpty) {
//       Provider.of<VisitProvider>(context, listen: false).addVisit(
//         visitorId: visitorId,
//         action: action,
//         authToken: authToken,
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please login first!')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     return ListView.builder(
//       itemCount: profiles.length,
//       itemBuilder: (context, index) {
//         final profile = profiles[index];
//         final visitorId = profile.profileId; 
//         final name = profile.nickname ?? "Unknown";
//         final age = profile.age ?? "N/A";
//         final imageUrl = profile.imageUrl != null
//             ? NetworkImage(profile.imageUrl!)
//             : const AssetImage('assets/images/homeImage.png') as ImageProvider;

//         return Card(
//           child: ListTile(
//             leading: CircleAvatar(backgroundImage: imageUrl),
//             title: Text('$name, $age'),
//             subtitle: const Text('20 km away'),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.close, color: Colors.red),
//                   onPressed: () => _triggerAction(action: 'DISLIKE', visitorId: visitorId),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.favorite, color: Colors.green),
//                   onPressed: () => _triggerAction(action: 'LIKE', visitorId: visitorId),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.star, color: Colors.blue),
//                   onPressed: () => _triggerAction(action: 'SUPERLIKE', visitorId: visitorId),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:love_bird/api/home_api.dart';
// import 'package:love_bird/chat/chat_screen.dart';
// import 'package:love_bird/modals/block_and_report_modal.dart';
// import 'package:love_bird/model/profile_model.dart';
// import 'package:love_bird/profile/users_profile.dart';
// import 'package:love_bird/providers/visit_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:love_bird/providers/auth_provider.dart';

// class ProfileInfo extends StatefulWidget {
//   const ProfileInfo({super.key});

//   @override
//   _ProfileInfoState createState() => _ProfileInfoState();
// }

// class _ProfileInfoState extends State<ProfileInfo> {
//   List<Profile> profiles = [];
//   bool isLoading = true;
//   bool _isDisposed = false;

//   bool _showSuperLike = false;
//   bool _showLike = false;
//   bool _showNo = false;
//   double _rotationAngle = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     fetchProfileData(authProvider); // Fetch profiles on initialization
//   }

//   @override
//   void dispose() {
//     _isDisposed = true;
//     super.dispose();
//   }

//   void fetchProfileData(AuthProvider authProvider) async {
//     try {
//       List<Profile> fetchedProfiles = await ProfileService.fetchProfiles(authProvider);
//       if (!_isDisposed) {
//         setState(() {
//           profiles = fetchedProfiles;
//           isLoading = false;
//         });
//       }
//     } catch (error) {
//       if (!_isDisposed) {
//         setState(() => isLoading = false);
//       }
//       print("Error fetching profiles: $error");
//     }
//   }

//   void _triggerAction({
//     required void Function() setFlag,
//     required String action,
//     required String? visitorId,
//     double rotationAngle = 0.0,
//   }) {
//     setState(() {
//       setFlag();
//       _rotationAngle = rotationAngle;
//     });

//     // Trigger the action (LIKE, SUPERLIKE, or DISLIKE)
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     final authToken = authProvider.accessToken;

//     if (visitorId == null || visitorId.isEmpty) {
//       print("Error: visitorId is missing");
//       return;
//     }

//     if (authToken != null && authToken.isNotEmpty) {
//       Provider.of<VisitProvider>(context, listen: false).addVisit(
//         visitorId: visitorId,
//         action: action,
//         authToken: authToken,
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please login first!')),
//       );
//     }

//     // Reset the UI effect after a delay
//     Future.delayed(const Duration(seconds: 1), () {
//       if (mounted) {
//         setState(() {
//           setFlag();
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     if (isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     return SizedBox(
//       height: screenHeight * 0.7,
//       width: screenWidth * 0.9,
//       child: PageView.builder(
//         itemCount: profiles.length,
//         itemBuilder: (context, index) {
//           final profile = profiles[index];
//           final name = profile.nickname ?? "Unknown";
//           final age = profile.age ?? "N/A";
//           final visitorId = profile.profileId;
//           final imageUrl = _getProfileImage(profile);

//           return GestureDetector(
//             onTap: () => _navigateToUserProfile(context, profile),
//             child: Stack(
//               children: [
//                 _buildProfileImage(imageUrl),
//                 _buildUserInfo(name, age),
//                 _buildActionButtons(visitorId, screenWidth, screenHeight), // Removed Flexible from here
//                 if (_showNo) _buildActionOverlay(screenWidth, screenHeight, 'DISLIKE', -0.3),
//                 if (_showLike) _buildActionOverlay(screenWidth, screenHeight, 'LIKE', 0.3),
//                 if (_showSuperLike) _buildActionOverlay(screenWidth, screenHeight, 'SUPERLIKE', -0.2),
//                 _buildMoreOptionsButton(context),
//                 _buildMessageButton(),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // Helper function to determine profile image
//   ImageProvider<Object> _getProfileImage(profile) {
//     return (profile.imageUrl != null && profile.imageUrl!.isNotEmpty)
//         ? NetworkImage(profile.imageUrl!)
//         : const AssetImage('assets/images/homeImage.png');
//   }

//   // Navigation to user profile page
//   void _navigateToUserProfile(BuildContext context, profile) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => UserProfilePage(profile: profile),
//       ),
//     );
//   }

//   // Build the profile image widget
//   Widget _buildProfileImage(ImageProvider<Object> imageUrl) {
//     return Container(
//       height: double.infinity,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         image: DecorationImage(
//           image: imageUrl,
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }

//   // Build the user info section (name, age, distance)
//   Widget _buildUserInfo(String name, String age) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     return Positioned(
//       bottom: 0,
//       child: Container(
//         width: screenWidth * 0.9,
//         padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
//         color: Colors.black.withOpacity(0.5),
//         child: Padding(
//           padding: EdgeInsets.all(screenWidth * 0.02),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 '$name, $age',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: screenWidth * 0.04,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: screenHeight * 0.005),
//               Text(
//                 '20 km away',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: screenWidth * 0.03,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Build the action buttons (Like, Dislike, Superlike, etc.)
//   Widget _buildActionButtons(visitorId, screenWidth, screenHeight) {
//     return Positioned(
//       bottom: screenHeight * 0.1,
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             _buildActionButton('assets/images/left.png', 'DISLIKE', visitorId, -0.3, () => _toggleActionFlag('DISLIKE')),
//             _buildActionButton('assets/images/love2.png', 'LIKE', visitorId, 0.3, () => _toggleActionFlag('LIKE')),
//             _buildActionButton('assets/images/star2.png', 'SUPERLIKE', visitorId, -0.2, () => _toggleActionFlag('SUPERLIKE')),
//             _buildActionButton('assets/images/cancel.png', 'DISLIKE', visitorId, -0.3, () => _toggleActionFlag('DISLIKE')),
//           ],
//         ),
//       ),
//     );
//   }

//   // Helper function for action button widget
//   Widget _buildActionButton(String asset, String action, String visitorId, double rotationAngle, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Image.asset(asset),
//     );
//   }

//   // Toggle action flags based on the action type
//   void _toggleActionFlag(String action) {
//     setState(() {
//       if (action == 'DISLIKE') {
//         _showNo = !_showNo;
//       } else if (action == 'LIKE') {
//         _showLike = !_showLike;
//       } else if (action == 'SUPERLIKE') {
//         _showSuperLike = !_showSuperLike;
//       }
//     });
//   }

//   // Build the action overlay widget
//   Widget _buildActionOverlay(double screenWidth, double screenHeight, String label, double rotationAngle) {
//     return Positioned.fill(
//       child: Transform.rotate(
//         angle: rotationAngle,
//         child: Center(
//           child: Text(
//             label,
//             style: TextStyle(
//               fontSize: screenWidth * 0.06,
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Build the more options button (3 dots)
//   Widget _buildMoreOptionsButton(BuildContext context) {
//     return Positioned(
//       top: 10,
//       right: 10,
//       child: IconButton(
//         icon: const Icon(Icons.more_horiz, color: Colors.white, size: 30),
//         onPressed: () => showSmallPopup(context),
//       ),
//     );
//   }

//   // Build the message icon button
//   Widget _buildMessageButton() {
//     final screenHeight = MediaQuery.of(context).size.height;
//     return Positioned(
//       bottom: screenHeight * 0.2,
//       right: 10,
//       child: InkWell(
//         onTap: () => _navigateToChatDetail(context),
//         child: Image.asset('assets/images/icons/messageicon.png'),
//       ),
//     );
//   }

//   // Navigate to ChatDetailScreen
//   void _navigateToChatDetail(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const ChatDetailScreen(
//           name: 'Daniel',
//           profileImage: 'assets/images/homeImage.png',
//           isOnline: true,
//           lastMessage: 'Hello',
//         ),
//       ),
//     );
//   }
// }
