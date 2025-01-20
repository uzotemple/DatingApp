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

import 'package:flutter/material.dart';
import 'package:love_bird/api/home_api.dart';
import 'package:love_bird/chat/chat_screen.dart';
import 'package:love_bird/modals/block_and_report_modal.dart';

import 'package:love_bird/model/profile_model.dart';
import 'package:love_bird/profile/users_profile.dart';

import 'package:provider/provider.dart';

import 'package:love_bird/providers/auth_provider.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  List<Profile> profiles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    fetchProfileData(authProvider);
  }

  bool _showSuperLike = false;
  bool _showLike = false;
  bool _showNo = false;
  bool _showCancel = false;
  double _rotationAngle = 0.0;

  void _onStarPressed() {
    setState(() {
      _showSuperLike = true;
      _rotationAngle = -0.2;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _showSuperLike = false;
        _rotationAngle = 0.0;
      });
    });
  }

  void _onLovePressed() {
    setState(() {
      _showLike = true;
      _rotationAngle = 0.3;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _showLike = false;
        _rotationAngle = 0.0;
      });
    });
  }

  void _onNoPressed() {
    setState(() {
      _showNo = true;
      _rotationAngle = -0.3;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _showNo = false;
        _rotationAngle = 0.0;
      });
    });
  }

  void _onCancelPressed() {
    setState(() {
      _showCancel = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _showCancel = false;
      });
    });
  }

  void fetchProfileData(AuthProvider authProvider) async {
    try {
      List<Profile> fetchedProfiles =
          await ProfileService.fetchProfiles(authProvider);
      setState(() {
        profiles = fetchedProfiles;
        isLoading = false;
      });
    } catch (error) {
      print("Error fetching profiles: $error");
      setState(() => isLoading = false);
    }
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
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserProfilePage(profile: profile)),
                );
              },
              child: Stack(children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/homeImage.png'),
                      //                image: AssetImage(profile.imageUrl!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  // child: Column(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Text(
                  //       profile.nickname ?? "Unknown",
                  //       style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.bold),
                  //     ),
                  //     Text(
                  //       profile.age ?? "N/A",
                  //       style: TextStyle(color: Colors.white, fontSize: 16),
                  //     ),
                  //   ],
                  // ),
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
                          padding: EdgeInsets.all(
                            screenWidth * 0.02,
                          ),
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
                              SizedBox(
                                height: screenHeight * 0.005,
                              ),
                              Text(
                                '20 km away',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.03),
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
                                  onTap: _onCancelPressed,
                                  child: Image.asset('assets/images/left.png')),
                              const Spacer(),
                              InkWell(
                                onTap: _onLovePressed,
                                child: Image.asset('assets/images/love2.png'),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: _onStarPressed,
                                child: Image.asset('assets/images/star2.png'),
                              ),
                              const Spacer(),
                              GestureDetector(
                                  onTap: _onNoPressed,
                                  child:
                                      Image.asset('assets/images/cancel.png')),
                              //const Spacer(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //      Action indicators and buttons
                if (_showCancel)
                  Positioned.fill(
                    child: Center(
                      child: Opacity(
                        opacity: _showCancel ? 1.0 : 0.0,
                        child: Text(
                          'Recent Action Reversed',
                          style: TextStyle(
                            fontSize: screenWidth * 0.06,
                            color: Colors.white, // Set your desired color
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
//           ),
                if (_showLike)
                  Positioned.fill(
                    child: Transform.rotate(
                      angle: _rotationAngle,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/homeImage.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Center(
                          child: Opacity(
                            opacity: _showLike ? 1.0 : 0.0,
                            child: const Text(
                              ' Like',
                              style: TextStyle(
                                fontSize: 32,
                                color: Colors.white, // Set your desired color
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                if (_showNo)
                  Positioned.fill(
                    child: Transform.rotate(
                      angle: _rotationAngle,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.74,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/homeImage.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Center(
                          child: Opacity(
                            opacity: _showNo ? 1.0 : 0.0,
                            child: const Text(
                              ' No',
                              style: TextStyle(
                                fontSize: 32,
                                color: Colors.white, // Set your desired color
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                if (_showSuperLike)
                  Positioned(
                    // top: MediaQuery.of(context).size.height * 0.1,
                    left: MediaQuery.of(context).size.width * 0.1,
                    child: Transform.rotate(
                      angle: _rotationAngle,
                      child: Container(
                        width: MediaQuery.of(context).size.width *
                            0.6, // Small image width
                        height: MediaQuery.of(context).size.height *
                            0.4, // Small image height
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/homeImage.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Center(
                          child: Opacity(
                            opacity: _showSuperLike ? 1.0 : 0.0,
                            child: const Text(
                              'Super  Like',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white, // Set your desired color
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

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
                  // bottom: 170,
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
              ]));
        },
      ),
    );
  }
}
