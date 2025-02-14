// import 'package:love_bird/edit%20profile%20screens/relationship_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:love_bird/config/constants.dart';

// class LanguageYouSpeakScreen extends StatefulWidget {
//   const LanguageYouSpeakScreen({super.key});

//   @override
//   State<LanguageYouSpeakScreen> createState() => _LanguageYouSpeakScreenState();
// }

// class _LanguageYouSpeakScreenState extends State<LanguageYouSpeakScreen> {
//   // List of items
//   final List<String> items = [
//     'English',
//     'German',
//     'French',
//     'Spanish',
//     'Italian',
//     'Portuguese',
//     'Russian',
//     'Chinese',
//   ];

//   // List to keep track of selected items
//   List<bool> selectedItems = [
//     false,
//     false,
//     false,
//     false,
//     false,
//     false,
//     false,
//     false
//   ];

//   @override
//   void initState() {
//     super.initState();
//     // Initialize selectedItems with the same length as items
//     selectedItems = List<bool>.filled(items.length, false);
//   }

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
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Image.asset('images/lang.png'),
//             const SizedBox(height: 16),
//             const Text(
//               'What language(s) do you speak?',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: items.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(items[index],
//                         style: TextStyle(
//                             color:
//                                 Theme.of(context).textTheme.bodyMedium?.color)),
//                     trailing: Checkbox(
//                       value: selectedItems[index],
//                       onChanged: (bool? value) {
//                         setState(() {
//                           selectedItems[index] = value!;
//                         });
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 const Text('(3/11)'), // Placeholder for your count logic
//                 InkWell(
//                   onTap: () {
//                     // Navigate to the next screen
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             const RelationshipScreen(), // Replace with your next screen
//                       ),
//                     );
//                   },
//                   child: CircleAvatar(
//                     backgroundColor: blue.withOpacity(0.19),
//                     child: const Icon(Icons.arrow_forward_ios),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:love_bird/api/profile_api.dart';
import 'package:provider/provider.dart';
import 'package:love_bird/config/constants.dart';
import 'package:love_bird/providers/auth_provider.dart';
import 'package:love_bird/edit%20profile%20screens/relationship_screen.dart';

class LanguageYouSpeakScreen extends StatefulWidget {
  const LanguageYouSpeakScreen({super.key});

  @override
  State<LanguageYouSpeakScreen> createState() => _LanguageYouSpeakScreenState();
}

class _LanguageYouSpeakScreenState extends State<LanguageYouSpeakScreen> {
  final List<String> items = [
    'None', // Default option
    'English',
    'German',
    'French',
    'Spanish',
    'Italian',
    'Portuguese',
    'Russian',
    'Chinese',
  ];

  List<bool> selectedItems = [];

  @override
  void initState() {
    super.initState();

    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    // Fetch current languages from profile data (expecting a list)
    List<String>? currentLanguages = profileProvider.getProfileData?['languages']?.cast<String>();

    selectedItems = List<bool>.filled(items.length, false);

    if (currentLanguages != null && currentLanguages.isNotEmpty) {
      for (String lang in currentLanguages) {
        int index = items.indexOf(lang);
        if (index != -1) {
          selectedItems[index] = true;
        }
      }
    } else {
      // If no languages are found, set "None" as selected
      selectedItems[0] = true;
    }
  }

  void _updateProfile() {
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Collect selected languages (excluding "None" if others are selected)
    List<String> selectedLanguages = [];
    for (int i = 0; i < items.length; i++) {
      if (selectedItems[i]) {
        selectedLanguages.add(items[i]);
      }
    }

    // Ensure at least "None" is saved if nothing is selected
    if (selectedLanguages.isEmpty) {
      selectedLanguages.add('None');
    } else {
      // Remove "None" if other languages are selected
      selectedLanguages.remove('None');
    }

    // Update the profile
    profileProvider.updateProfile(
      context,
      authProvider,
      {"languages": selectedLanguages},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('images/lang.png'),
            const SizedBox(height: 16),
            const Text(
              'What language(s) do you speak?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
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
                    trailing: Checkbox(
                      value: selectedItems[index],
                      onChanged: (bool? value) {
                        setState(() {
                          selectedItems[index] = value!;
                          if (index == 0 && value) {
                            // If "None" is selected, unselect all others
                            selectedItems = List<bool>.filled(items.length, false);
                            selectedItems[0] = true;
                          } else {
                            // If any other language is selected, unselect "None"
                            selectedItems[0] = false;
                          }
                        });

                        _updateProfile();
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text('(3/11)'),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RelationshipScreen(),
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
      ),
    );
  }
}
