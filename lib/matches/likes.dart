// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:love_bird/config/constants.dart';
// import 'package:love_bird/config/routes.dart';
// import 'package:love_bird/matches/super_likes.dart';
// import 'package:love_bird/renewal/renewal.dart';

// class Likes extends StatefulWidget {
//   const Likes({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _LikesState createState() => _LikesState();
// }

// class _LikesState extends State<Likes> {
//   bool premuimPackage = false;
//   bool showSearchBox = false;
//   String searchQuery = '';
//   int _currentIndex = 3;

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_outlined, size: 30),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             GestureDetector(
//               onTap: () {
//                 Navigator.pushNamed(context, chatbotWelcomeScreen);
//               },
//               child: Image.asset(
//                 'assets/images/robot.png',
//                 width: screenSize.width * 0.08,
//               ),
//             ),
//             SizedBox(width: screenSize.width * 0.07),
//             const Expanded(
//               child: Center(
//                 child: Text(
//                   'Matches',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w700,
//                     fontSize: 20,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search, size: 30),
//             onPressed: () {
//               setState(() {
//                 if (showSearchBox) {
//                   searchQuery = '';
//                 }
//                 showSearchBox = !showSearchBox;
//               });
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.sort_outlined, size: 30),
//             onPressed: () {
//               showLikeSort(context);
//             },
//           ),
//           SizedBox(width: screenSize.width * 0.05),
//         ],
//       ),
//       body: Column(
//         children: [
//           if (showSearchBox)
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.08),
//               child: SizedBox(
//                 height: 40,
//                 child: TextField(
//                   style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
//                   decoration: InputDecoration(
//                     hintText: 'Search by name...',
//                     hintStyle: TextStyle(color: Theme.of(context).hintColor),
//                     contentPadding: EdgeInsets.only(top: screenSize.height * 0.02),
//                     prefixIcon: Icon(Icons.search, color: Theme.of(context).iconTheme.color),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       borderSide: const BorderSide(color: blue, width: 1.5),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       borderSide: const BorderSide(color: blue, width: 1.5),
//                     ),
//                   ),
//                   onChanged: (value) {
//                     setState(() {
//                       searchQuery = value;
//                     });
//                   },
//                 ),
//               ),
//             ),
//           SizedBox(height: screenSize.height * 0.025),
//           Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//             InkWell(
//               onTap: () {},
//               child: Container(
//                 width: screenSize.width * 0.4,
//                 height: screenSize.height * 0.06,
//                 decoration: BoxDecoration(
//                   color: blue,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Center(
//                   child: Text(
//                     'Likes(4)',
//                     style: TextStyle(color: Colors.white, fontSize: 18),
//                   ),
//                 ),
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 Navigator.pushNamed(context, superLikes);
//               },
//               child: Container(
//                 width: screenSize.width * 0.4,
//                 height: screenSize.height * 0.06,
//                 decoration: BoxDecoration(
//                   color: const Color.fromRGBO(149, 140, 250, 1),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Center(
//                   child: Text(
//                     'SuperLikes(4)',
//                     style: TextStyle(color: Colors.white, fontSize: 18),
//                   ),
//                 ),
//               ),
//             ),
//           ]),
//           SizedBox(height: screenSize.height * 0.025),
//           const Expanded(
//             child: Center(child: CircularProgressIndicator()),
//           ),
//           const SizedBox(height: 7),
//           if (!premuimPackage)
//             SizedBox(
//               width: screenSize.width * 0.7,
//               height: screenSize.height * 0.06,
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const UpgradePremium()),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   backgroundColor: blue,
//                 ),
//                 child: const Text(
//                   'Upgrade to Premium To See More',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 13,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//       bottomNavigationBar: Padding(
//   padding: EdgeInsets.only(
//     left: screenSize.width * 0.03,
//     right: screenSize.width * 0.03,
//     top: screenSize.height * 0.01,
//     bottom: screenSize.height * 0.03,
//   ),
//   child: Container(
//     decoration: BoxDecoration(
//       color: const Color.fromRGBO(97, 86, 234, 0.19),
//       borderRadius: BorderRadius.circular(50),
//     ),
//     child: ClipRRect(
//       borderRadius: BorderRadius.circular(50),
//       child: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         currentIndex: _currentIndex,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home, size: screenSize.width * 0.08),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.location_on, size: screenSize.width * 0.08),
//             label: 'People Nearby',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.chat, size: screenSize.width * 0.08),
//             label: 'Chats',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite, size: screenSize.width * 0.08),
//             label: 'Matches',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person, size: screenSize.width * 0.08),
//             label: 'Profile',
//           ),
//         ],
//         selectedLabelStyle: TextStyle(
//           color: Colors.black,
//           fontSize: MediaQuery.of(context).size.width * 0.03,
//         ),
//         unselectedLabelStyle: TextStyle(
//           color: Colors.black,
//           fontSize: MediaQuery.of(context).size.width * 0.03,
//         ),
//         selectedItemColor: blue,
//         unselectedItemColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//           switch (index) {
//             case 0:
//               Navigator.pushNamed(context, homeScreen);
//               break;
//             case 1:
//               Navigator.pushNamed(context, peopleNearbyPage);
//               break;
//             case 2:
//               Navigator.pushNamed(context, mainchat);
//               break;
//             case 3:
//               Navigator.pushNamed(context, likes);
//               break;
//             case 4:
//               Navigator.pushNamed(context, profile);
//               break;
//           }
//         },
//       ),
//     ),
//   ),
// ),

//     );
//   }
// }    

// class PeopleNearbyGrid extends StatelessWidget {
//   final bool premuimPackage;
//   final String searchQuery;
  

//   PeopleNearbyGrid(
//       {super.key, required this.premuimPackage, 
//       required this.searchQuery,
//       });

//   final List<User> users = [
//     User(imageUrl: 'assets/images/homeImage.png', name: 'David', age: 31),
//     User(imageUrl: 'assets/images/homeImage.png', name: 'James', age: 29),
//     User(imageUrl: 'assets/images/homeImage.png', name: 'Tom', age: 32),
//     User(imageUrl: 'assets/images/homeImage.png', name: 'Michael', age: 30),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final filteredUsers = searchQuery.isEmpty
//         ? users
//         : users
//             .where((user) =>
//                 user.name.toLowerCase().contains(searchQuery.toLowerCase()))
//             .toList();

//     return GridView.builder(
//       padding: const EdgeInsets.all(8.0),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 8.0,
//         mainAxisSpacing: 8.0,
//         childAspectRatio: 0.7,
//       ),
//       itemCount: filteredUsers.length,
//       itemBuilder: (context, index) {
//         bool shouldBlur = !premuimPackage && index >= 2;
//         return UserCard(user: filteredUsers[index], blurImage: shouldBlur);
//       },
//     );
//   }
// }

// class User {
//   final String imageUrl;
//   final String name;
//   final int age;

//   User({required this.imageUrl, required this.name, required this.age});
// }

// class UserCard extends StatelessWidget {
//   final User user;
//   final bool blurImage;

//   const UserCard({required this.user, required this.blurImage, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: blurImage
//           ? null // Disable tap if blurImage is true
//           : () {
//               Navigator.pushNamed(context, userProfilePage);
//             },
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(10),
//         child: Stack(
//           children: [
//             Image.asset(
//               user.imageUrl,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//             // Blurring effect
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius:
//                       const BorderRadius.vertical(top: Radius.circular(10)),
//                   color: Colors.black.withOpacity(0.5),
//                 ),
//                 padding: const EdgeInsets.all(6.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       user.name,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 5),
//                     Text(
//                       '${user.age}',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             if (blurImage)
//               BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
//                 child: Container(
//                   height: 150,
//                   width: double.infinity,
//                   color:
//                       const Color.fromARGB(255, 151, 145, 145).withOpacity(0),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:love_bird/providers/likes_provider.dart';
import 'package:provider/provider.dart';

class Likes extends StatefulWidget {
  const Likes({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LikesState createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  @override
void initState() {
  super.initState();

  // Use addPostFrameCallback to ensure fetchLikes is called after the build process
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final likeProvider = Provider.of<LikeProvider>(context, listen: false);
    likeProvider.fetchLikes(); // Fetch likes after the build
  });
}


  @override
  Widget build(BuildContext context) {
    return Consumer<LikeProvider>(
      builder: (context, likeProvider, child) {
        if (likeProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: likeProvider.likes.length,
          itemBuilder: (context, index) {
            final like = likeProvider.likes[index];
            return ListTile(
              title: Text('User ID: ${like.userId}, Profile ID: ${like.profileId}'),
            );
          },
        );
      },
    );
  }
}
