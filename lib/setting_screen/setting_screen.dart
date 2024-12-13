// import 'package:love_bird/config/routes.dart';
// import 'package:love_bird/setting_screen/about_screen.dart';
// import 'package:love_bird/setting_screen/account_preference_screen.dart';
// import 'package:love_bird/setting_screen/account_screen.dart';
// import 'package:love_bird/setting_screen/basic_info_screen.dart';
// import 'package:love_bird/setting_screen/blocked_users_screen.dart';
// import 'package:love_bird/setting_screen/help_center_screen.dart';
// import 'package:love_bird/setting_screen/reviews_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:love_bird/config/constants.dart';

// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({super.key});

//   void _showGetStartedModal(BuildContext context, int modalIndex) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) => _GetStartedModal(modalIndex: modalIndex),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
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
//                 padding: const EdgeInsets.only(right: 5.0),
//                 child: Image.asset("images/ai.png"),
//               ),
//             ),
//             Container(width: 40),
//             const Text(
//               'Settings',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//             ),
//           ],
//         ),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(10.0),
//         children: [
//           const Divider(color: blue),
//           ListTile(
//             title: Text(
//               'Basic info',
//               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//             ),
//             trailing: Icon(
//               Icons.arrow_forward_ios,
//               color: Theme.of(context).iconTheme.color,
//             ),
//             onTap: () {
//               // Handle Basic info tap
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const BasicInfoScreen()),
//               );
//             },
//           ),
//           const Divider(color: blue),
//           ListTile(
//             title: Text(
//               'Account',
//               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//             ),
//             subtitle: Text(
//               'hailey1@ymail.com',
//               style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
//             ),
//             trailing: Icon(
//               Icons.arrow_forward_ios,
//               color: Theme.of(context).iconTheme.color,
//             ),
//             onTap: () {
//               // Handle Account tap
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const AccountScreen()),
//               );
//             },
//           ),
//           const Divider(color: blue),
//           ListTile(
//             title: Text(
//               'Account Preferences',
//               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//             ),
//             trailing: Icon(
//               Icons.arrow_forward_ios,
//               color: Theme.of(context).iconTheme.color,
//             ),
//             onTap: () {
//               // Handle Account Preferences tap
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const AccountPreferenceScreen()),
//               );
//             },
//           ),
//           const Divider(color: blue),
//           ListTile(
//             title: Text(
//               'Personalize your experience',
//               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//             ),
//             trailing: Icon(
//               Icons.arrow_forward_ios,
//               color: Theme.of(context).iconTheme.color,
//             ),
//             onTap: () {
//               // Show personalize modal sheet
//               _showGetStartedModal(context, 0);
//             },
//           ),
//           const Divider(color: blue),
//           ListTile(
//             title: Text(
//               'Help Center',
//               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//             ),
//             trailing: Icon(
//               Icons.arrow_forward_ios,
//               color: Theme.of(context).iconTheme.color,
//             ),
//             onTap: () {
//               // Handle Help Center tap
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const HelpCenterScreen()),
//               );
//             },
//           ),
//           const Divider(color: blue),
//           ListTile(
//             title: Text(
//               'About',
//               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//             ),
//             trailing: Icon(
//               Icons.arrow_forward_ios,
//               color: Theme.of(context).iconTheme.color,
//             ),
//             onTap: () {
//               // Handle About tap
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const AboutScreen()),
//               );
//             },
//           ),
//           const Divider(color: blue),
//           ListTile(
//             title: Text(
//               'Blocked Users',
//               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//             ),
//             trailing: Icon(
//               Icons.arrow_forward_ios,
//               color: Theme.of(context).iconTheme.color,
//             ),
//             onTap: () {
//               // Handle Blocked Users tap
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const BlockedUsersScreen()),
//               );
//             },
//           ),
//           const Divider(color: blue),
//           ListTile(
//             title: Text(
//               'Reviews',
//               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//             ),
//             trailing: Icon(
//               Icons.arrow_forward_ios,
//               color: Theme.of(context).iconTheme.color,
//             ),
//             onTap: () {
//               // Handle Reviews tap
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const ReviewsScreen()),
//               );
//             },
//           ),
//           const Divider(color: blue),
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.0),
//             child: Text(
//               'Follow us on social media',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 16.0),
//                 child: Image.asset("images/skill-icons_instagram.png"),
//               ),
//               const SizedBox(
//                 width: 25,
//               ),
//               Image.asset("images/logos_facebook.png"),
//             ],
//           ),
//           const Divider(color: blue),
//         ],
//       ),
//     );
//   }
// }

// class _GetStartedModal extends StatefulWidget {
//   final int modalIndex;

//   const _GetStartedModal({required this.modalIndex});

//   @override
//   State<_GetStartedModal> createState() => _GetStartedModalState();
// }

// class _GetStartedModalState extends State<_GetStartedModal> {
//   // Checkbox state for each modal
//   late bool checkbox1;
//   late bool checkbox2;

//   // List of different image paths for each modal
//   final List<String> modalImages = [
//     'images/control your experience.png',
//     'images/who can see your message.png',
//     'images/who do you want to chat with.png',
//     'images/When should we notify you.png',
//     'images/Want to show when you’re online.png',
//     'images/You’re all done!.png', // New image for the last modal
//   ];

//   // List of checkbox options for each modal
//   final List<List<String>> checkboxOptions = [
//     ['Everyone', 'People I’ve liked'],
//     ['Everyone', 'People I’ve liked'],
//     [
//       'Everyone',
//       'Verified People',
//     ],
//     [
//       'Only Me',
//       'My Connections',
//     ],
//     ['Yes', 'No'],
//     [
//       'Only Important Notifications',
//       'All Notifications'
//     ], // New options for the last modal
//   ];

//   @override
//   void initState() {
//     super.initState();
//     checkbox1 = false;
//     checkbox2 = false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         bottom: MediaQuery.of(context).viewInsets.bottom,
//       ),
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const SizedBox(height: 20),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Always show the back button but disable it for the first modal
//                   GestureDetector(
//                     onTap: widget.modalIndex > 0
//                         ? () {
//                             Navigator.pop(context);
//                           }
//                         : null, // Disable tap on the first modal
//                     child: Icon(
//                       Icons.arrow_back_ios,
//                       size: 20,
//                       color: widget.modalIndex > 0
//                           ? Colors.black
//                           : Colors.grey, // Change color based on state
//                     ),
//                   ),
//                   Image.asset(
//                     modalImages[widget.modalIndex],
//                     height: 150,
//                   ),
//                   GestureDetector(
//                     onTap: () => Navigator.pop(context),
//                     child:
//                         const Icon(Icons.close, size: 20, color: Colors.black),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 15),
//               Text(
//                 widget.modalIndex == 0
//                     ? 'Control your experience' // First modal specific text
//                     : (widget.modalIndex < 5
//                         ? 'Who can message you? ${widget.modalIndex}/4' // Display as (n/4) for modals 2 to 4
//                         : 'You’re all done!'), // Last modal specific text
//                 style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.black),
//               ),
//               const SizedBox(height: 15),
//               if (widget.modalIndex == 0)
//                 // Display the "Get started" button on the first modal sheet
//                 ElevatedButton(
//                   onPressed: () {
//                     // Show the next modal (modalIndex 1)
//                     Navigator.pop(context); // Close current modal
//                     _showGetStartedModal(context, 1); // Show second modal
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: blue,
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 12.0, horizontal: 30),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(
//                           30), // Adjust radius for curved edges
//                     ),
//                   ),
//                   child: const Text(
//                     'Get started',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 )
//               else if (widget.modalIndex < 5) // Modal from 2 to 4
//                 Column(
//                   children: [
//                     CheckboxListTile(
//                       title: Text(checkboxOptions[widget.modalIndex][0]),
//                       value: checkbox1,
//                       onChanged: (bool? value) {
//                         setState(() {
//                           checkbox1 = value ?? false;
//                         });
//                       },
//                     ),
//                     CheckboxListTile(
//                       title: Text(checkboxOptions[widget.modalIndex][1]),
//                       value: checkbox2,
//                       onChanged: (bool? value) {
//                         setState(() {
//                           checkbox2 = value ?? false;
//                         });
//                       },
//                     ),
//                     const Text(
//                       'If everyone can message you, you’re more likely to get more matches.',
//                       style: TextStyle(
//                           fontSize: 11,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.black),
//                     ),
//                     const SizedBox(height: 15),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('(${widget.modalIndex}/4)',
//                             style: const TextStyle(
//                                 color: Colors
//                                     .black)), // Show progress for modals 2 to 4
//                         InkWell(
//                           onTap: () {
//                             // Show the next modal
//                             _showGetStartedModal(
//                                 context, widget.modalIndex + 1);
//                           },
//                           child: const Icon(Icons.arrow_forward_ios,
//                               color: Colors.black),
//                         ),
//                       ],
//                     ),
//                   ],
//                 )
//               else // Modal after (4/4)
//                 Column(
//                   children: [
//                     const SizedBox(height: 20),
//                     const Text(
//                       'You’re all done with setup!',
//                       style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.black),
//                     ),
//                     const SizedBox(height: 15),
//                     ElevatedButton(
//                       onPressed: () {
//                         // Add action for last modal
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: blue,
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 12.0, horizontal: 30),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(
//                               30), // Adjust radius for curved edges
//                         ),
//                       ),
//                       child: const Text(
//                         'Start Swiping',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showGetStartedModal(BuildContext context, int modalIndex) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) => _GetStartedModal(modalIndex: modalIndex),
//     );
//   }
// }
import 'package:love_bird/config/routes.dart';
import 'package:love_bird/setting_screen/about_screen.dart';
import 'package:love_bird/setting_screen/account_preference_screen.dart';
import 'package:love_bird/setting_screen/account_screen.dart';
import 'package:love_bird/setting_screen/basic_info_screen.dart';
import 'package:love_bird/setting_screen/blocked_users_screen.dart';
import 'package:love_bird/setting_screen/help_center_screen.dart';
import 'package:love_bird/setting_screen/reviews_screen.dart';
import 'package:flutter/material.dart';
import 'package:love_bird/config/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showGetStartedModal(BuildContext context, int modalIndex) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _GetStartedModal(modalIndex: modalIndex),
    );
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
                padding: const EdgeInsets.only(right: 5.0),
                child: Image.asset("images/ai.png"),
              ),
            ),
            Container(width: 40),
            const Text(
              'Settings',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          const Divider(color: Color(0xFF3628DD)),
          ListTile(
            title: Text(
              'Basic info',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).iconTheme.color,
            ),
            onTap: () {
              // Handle Basic info tap
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BasicInfoScreen()),
              );
            },
          ),
          const Divider(color: Color(0xFF3628DD)),
          ListTile(
            title: Text(
              'Account',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            subtitle: Text(
              'hailey1@ymail.com',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).iconTheme.color,
            ),
            onTap: () {
              // Handle Account tap
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AccountScreen()),
              );
            },
          ),
          const Divider(color: Color(0xFF3628DD)),
          ListTile(
            title: Text(
              'Account Preferences',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).iconTheme.color,
            ),
            onTap: () {
              // Handle Account Preferences tap
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AccountPreferenceScreen()),
              );
            },
          ),
          const Divider(color: Color(0xFF3628DD)),
          ListTile(
            title: Text(
              'Personalize your experience',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).iconTheme.color,
            ),
            onTap: () {
              // Show personalize modal sheet
              _showGetStartedModal(context, 0);
            },
          ),
          const Divider(color: Color(0xFF3628DD)),
          ListTile(
            title: Text(
              'Help Center',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).iconTheme.color,
            ),
            onTap: () {
              // Handle Help Center tap
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HelpCenterScreen()),
              );
            },
          ),
          const Divider(color: Color(0xFF3628DD)),
          ListTile(
            title: Text(
              'About',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).iconTheme.color,
            ),
            onTap: () {
              // Handle About tap
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutScreen()),
              );
            },
          ),
          const Divider(color: Color(0xFF3628DD)),
          ListTile(
            title: Text(
              'Blocked Users',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).iconTheme.color,
            ),
            onTap: () {
              // Handle Blocked Users tap
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BlockedUsersScreen()),
              );
            },
          ),
          const Divider(color: Color(0xFF3628DD)),
          ListTile(
            title: Text(
              'Reviews',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).iconTheme.color,
            ),
            onTap: () {
              // Handle Reviews tap
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReviewsScreen()),
              );
            },
          ),
          const Divider(color: Color(0xFF3628DD)),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Follow us on social media',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Image.asset("images/skill-icons_instagram.png"),
              ),
              const SizedBox(
                width: 25,
              ),
              Image.asset("images/logos_facebook.png"),
            ],
          ),
          const Divider(color: Color(0xFF3628DD)),
        ],
      ),
    );
  }
}

class _GetStartedModal extends StatefulWidget {
  final int modalIndex;

  const _GetStartedModal({required this.modalIndex});

  @override
  State<_GetStartedModal> createState() => _GetStartedModalState();
}

class _GetStartedModalState extends State<_GetStartedModal> {
  // Checkbox state for each modal
  late bool checkbox1;
  late bool checkbox2;
  late bool checkbox3;

  // List of different image paths for each modal
  final List<String> modalImages = [
    'images/control your experience.png',
    'images/who can see your message.png',
    'images/who do you want to chat with.png',
    'images/When should we notify you.png',
    'images/Want to show when you’re online.png',
    'images/You’re all done!.png', // New image for the last modal
  ];

  // List of checkbox options for each modal
  final List<List<String>> checkboxOptions = [
    ['Everyone', 'People I’ve liked'],
    ['Everyone', 'People I’ve liked'],
    ['Everyone', 'Verified People'],
    [
      'When I get a message',
      'When I make a match',
      'When someone likes me'
    ], // 3 options for modal 3
    ['Yes', 'No'],
    ['Only Important Notifications', 'All Notifications'],
  ];

  // List of different text messages for each modal
  final List<String> modalMessages = [
    '', // No message for the first modal
    'If everyone can message you, you’re more likely to get more matches.',
    'When people are verified, it means we’re sure they’re real. This helps us keep Love Bird safe.',
    '',
    'If you hide when you’re online, you won’t see when other people are online.',
  ];

  // List of modal titles for each modal
  final List<String> modalTitles = [
    'Control your experience',
    'Who can message you?',
    'Who do you want to chat with?',
    'When should we notify you?',
    'Want to show when you’re online?',
    'You’re all done!'
  ];

  @override
  void initState() {
    super.initState();
    checkbox1 = false;
    checkbox2 = false;
    checkbox3 = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back button logic
                  GestureDetector(
                    onTap: widget.modalIndex > 0
                        ? () {
                            Navigator.pop(context);
                          }
                        : null,
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: widget.modalIndex > 0 ? Colors.black : Colors.grey,
                    ),
                  ),
                  Image.asset(
                    modalImages[widget.modalIndex],
                    height: 150,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child:
                        const Icon(Icons.close, size: 20, color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              // Modal title
              Text(
                modalTitles[widget.modalIndex],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 10),
              if (widget.modalIndex == 0)
                const Text(
                  "Manage who can message you, let people know when you’re online and more.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),

              const SizedBox(height: 15),
              if (widget.modalIndex == 0)
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Show the next modal (modalIndex 1)
                        Navigator.pop(context);
                        _showGetStartedModal(context, 1);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blue,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Get started',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the modal sheet
                      },
                      child: const Text(
                        'Maybe Later',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                )
              else if (widget.modalIndex < 5) // Modals from 2 to 4
                Column(
                  children: [
                    CheckboxListTile(
                      title: Text(checkboxOptions[widget.modalIndex][0]),
                      value: checkbox1,
                      onChanged: (bool? value) {
                        setState(() {
                          checkbox1 = value ?? false;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(checkboxOptions[widget.modalIndex][1]),
                      value: checkbox2,
                      onChanged: (bool? value) {
                        setState(() {
                          checkbox2 = value ?? false;
                        });
                      },
                    ),

                    // Third checkbox (only for modal index 3)
                    if (widget.modalIndex == 3)
                      CheckboxListTile(
                        title: Text(checkboxOptions[3][2]),
                        value: checkbox3,
                        onChanged: (bool? value) {
                          setState(() {
                            checkbox3 = value ?? false;
                          });
                        },
                      ),

                    if (modalMessages[widget.modalIndex].isNotEmpty)
                      Text(
                        modalMessages[widget.modalIndex],
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),

                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('(${widget.modalIndex}/4)',
                            style: const TextStyle(color: Colors.black)),
                        InkWell(
                          onTap: () {
                            _showGetStartedModal(
                                context, widget.modalIndex + 1);
                          },
                          child: const CircleAvatar(
                            child: Icon(Icons.arrow_forward_ios,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              else // Modal after (4/4)
                Column(
                  children: [
                    const Text(
                      'Great - you’re all set for a better experience. Time to make some meaningful and amazing connections.',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/homeScreen');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blue,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Start Swiping',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the modal sheet
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingsScreen()),
                        );
                      },
                      child: const Text(
                        'Go to Settings',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showGetStartedModal(BuildContext context, int modalIndex) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _GetStartedModal(modalIndex: modalIndex),
    );
  }
}
