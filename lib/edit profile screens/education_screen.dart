// import 'package:flutter/material.dart';
// import 'package:love_bird/config/constants.dart';

// class EducationScreen extends StatefulWidget {
//   const EducationScreen({super.key});

//   @override
//   State<EducationScreen> createState() => _EducationScreenState();
// }

// class _EducationScreenState extends State<EducationScreen> {
//   // List of items
//   final List<String> items = [
//     'Primary Education',
//     'Secondry Education',
//     'Higher Education',
//     'Vocational Training',
//     'Postgraduate Education',
//   ];

//   // List to keep track of selected items
//   List<bool> selectedItems = [false, false, false, false, false];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.close),
//           onPressed: () {
//             // Pop the screen when close icon is pressed
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Column(
//         children: [
//           Image.asset('images/education.png'),
//           const Padding(
//             padding: EdgeInsets.all(10.0),
//             child: Text(
//               'What level of education do you have?',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
//             ),
//           ),
//           const SizedBox(height: 16),
//           Expanded(
//             child: ListView.builder(
//               itemCount: items.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(items[index],
//                       style: TextStyle(
//                           color:
//                               Theme.of(context).textTheme.bodyMedium?.color)),
//                   trailing: Checkbox(
//                     value: selectedItems[index],
//                     onChanged: (bool? value) {
//                       setState(() {
//                         selectedItems[index] = value!;
//                       });
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//           const SizedBox(
//             height: 100,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               const Text('(11/11)'),
//               InkWell(
//                 onTap: () {
//                   //  Navigator.push(
//                   //         context,
//                   //         MaterialPageRoute(builder: (context) => const LanguageYouSpeakScreen()),
//                   //       );
//                 },
//                 child: CircleAvatar(
//                   backgroundColor: blue.withOpacity(0.19),
//                   child: const Icon(Icons.arrow_forward_ios),
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:love_bird/api/profile_api.dart';
// import 'package:provider/provider.dart';
// import 'package:love_bird/config/constants.dart';
// import 'package:love_bird/providers/auth_provider.dart';

// class EducationScreen extends StatefulWidget {
//   const EducationScreen({super.key});

//   @override
//   State<EducationScreen> createState() => _EducationScreenState();
// }

// class _EducationScreenState extends State<EducationScreen> {
//   final List<String> items = [
//     'None', // Default option
//     'Primary Education',
//     'Secondary Education',
//     'Higher Education',
//     'Vocational Training',
//     'Postgraduate Education',
//   ];

//   int? selectedIndex = 0; // Default to 'None'

//   @override
//   void initState() {
//     super.initState();

//     final profileProvider = Provider.of<ProfileProvider>(context, listen: false);

//     // Fetch current education level from profile data
//     String? currentEducation = profileProvider.getProfileData?['educationLevel'];

//     if (currentEducation != null) {
//       int index = items.indexOf(currentEducation);
//       if (index != -1) {
//         selectedIndex = index;
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final profileProvider = Provider.of<ProfileProvider>(context);
//     final authProvider = Provider.of<AuthProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.close),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Column(
//         children: [
//           Image.asset('images/education.png'),
//           const Padding(
//             padding: EdgeInsets.all(10.0),
//             child: Text(
//               'What level of education do you have?',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
//             ),
//           ),
//           const SizedBox(height: 16),
//           Expanded(
//             child: ListView.builder(
//               itemCount: items.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(
//                     items[index],
//                     style: TextStyle(
//                       color: Theme.of(context).textTheme.bodyMedium?.color,
//                     ),
//                   ),
//                   trailing: Radio<int>(
//                     value: index,
//                     groupValue: selectedIndex,
//                     onChanged: (int? value) {
//                       setState(() {
//                         selectedIndex = value;
//                       });

//                       // Update profile with new education level
//                       profileProvider.updateProfile(
//                         context,
//                         authProvider,
//                         {"educationLevel": items[value!]},
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//           const SizedBox(height: 100),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               const Text('(11/11)'),
//               InkWell(
//                 onTap: () {
//                   // Handle navigation if needed
//                 },
//                 child: CircleAvatar(
//                   backgroundColor: blue.withOpacity(0.19),
//                   child: const Icon(Icons.arrow_forward_ios),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:love_bird/api/profile_api.dart';
import 'package:love_bird/edit%20profile%20screens/more_about_you_screen.dart';
import 'package:provider/provider.dart';
import 'package:love_bird/config/constants.dart';
import 'package:love_bird/providers/auth_provider.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({super.key});

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

// class _EducationScreenState extends State<EducationScreen> {
//   final List<String> items = [
//     'None', // Default option
//     'Primary Education',
//     'Secondry Education',
//     'Higher Education',
//     'Vocational Training',
//     'Postgraduate Education',
//   ];

//   int? selectedIndex;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();

//     final profileProvider = Provider.of<ProfileProvider>(context, listen: false);

//     // Ensure profile data is available before accessing it
//     if (profileProvider.getProfileData != null) {
//       String? currentEducation = profileProvider.getProfileData?['educationLevel'];

//       if (currentEducation != null) {
//         int index = items.indexOf(currentEducation);
//         if (index != -1) {
//           setState(() {
//             selectedIndex = index;
//           });
//         }
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final profileProvider = Provider.of<ProfileProvider>(context);
//     final authProvider = Provider.of<AuthProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.close),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Column(
//         children: [
//           Image.asset('images/education.png'),
//           const Padding(
//             padding: EdgeInsets.all(10.0),
//             child: Text(
//               'What level of education do you have?',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
//             ),
//           ),
//           const SizedBox(height: 16),
//           Expanded(
//             child: ListView.builder(
//               itemCount: items.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(
//                     items[index],
//                     style: TextStyle(
//                       color: Theme.of(context).textTheme.bodyMedium?.color,
//                     ),
//                   ),
//                   trailing: Radio<int>(
//                     value: index,
//                     groupValue: selectedIndex,
//                     onChanged: (int? value) {
//                       if (value != null) {
//                         setState(() {
//                           selectedIndex = value;
//                         });

//                         // Update profile with new education level
//                         profileProvider.updateProfile(
//                           context,
//                           authProvider,
//                           {"educationLevel": items[value]},
//                         );
//                       }
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//           const SizedBox(height: 100),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               const Text('(11/11)'),
//               InkWell(
//                 onTap: () {
//                   // Handle navigation if needed
//                 },
//                 child: CircleAvatar(
//                   backgroundColor: blue.withOpacity(0.19),
//                   child: const Icon(Icons.arrow_forward_ios),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class _EducationScreenState extends State<EducationScreen> {
  final List<String> items = [
    'NONE',
    'PRIMARY_EDUCATION',
    'SECONDRY_EDUCATION',
    'HIGHER_EDUCATION',
    'VOCATIONAL_TRAINING',
    'POSTGRADUATE_EDUCATION',
  ];

  int? selectedIndex;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    String? currentEducation = profileProvider.getEducationLevel; // Fetch only educationLevel

    if (currentEducation != null) {
      int index = items.indexOf(currentEducation);
      if (index != -1) {
        setState(() {
          selectedIndex = index;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Image.asset('images/education.png'),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'What level of education do you have?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    items[index],
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                  trailing: Radio<int>(
                    value: index,
                    groupValue: selectedIndex,
                    onChanged: (int? value) {
                      if (value != null) {
                        setState(() {
                          selectedIndex = value;
                        });

                        // Update profile with new education level
                        profileProvider.updateProfile(
                          context,
                          authProvider,
                          {"educationLevel": items[value]},
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('(11/11)'),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MoreAboutYouScreen(),
                    ),
                  );
                },
                child: CircleAvatar(
                  backgroundColor: blue.withOpacity(0.19),
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
