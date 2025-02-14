// import 'package:love_bird/edit%20profile%20screens/language_you_speak_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:love_bird/config/constants.dart';

// class DrinksScreen extends StatefulWidget {
//   const DrinksScreen({super.key});

//   @override
//   State<DrinksScreen> createState() => _DrinksScreenState();
// }

// class _DrinksScreenState extends State<DrinksScreen> {
//   // List of items
//   final List<String> items = [
//     'Socially',
//     'Never',
//     'Often',
//     'No, i’m sober',
//     'I’d rather not say',
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
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Image.asset('images/drinks.png'),
//           const Text(
//             'Do you drink?',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
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
//               const Text('(2/11)'),
//               InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const LanguageYouSpeakScreen()),
//                   );
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


import 'package:flutter/material.dart';
import 'package:love_bird/api/profile_api.dart';
import 'package:provider/provider.dart';
import 'package:love_bird/config/constants.dart';
import 'package:love_bird/edit%20profile%20screens/language_you_speak_screen.dart';
import 'package:love_bird/providers/auth_provider.dart';

class DrinksScreen extends StatefulWidget {
  const DrinksScreen({super.key});

  @override
  State<DrinksScreen> createState() => _DrinksScreenState();
}

class _DrinksScreenState extends State<DrinksScreen> {
  final List<String> items = [
    'None', // Default option
    'Socially',
    'Never',
    'Often',
    'No, I’m sober',
    'I’d rather not say',
  ];

  int? selectedIndex = 0; // Default to 'None'

  @override
  void initState() {
    super.initState();

    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    
    // Fetch current drinking status from profile data
    String? currentDrinking = profileProvider.getProfileData?['drinking'];

    if (currentDrinking != null) {
      int index = items.indexOf(currentDrinking);
      if (index != -1) {
        selectedIndex = index;
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('images/drinks.png'),
          const Text(
            'Do you drink?',
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
                  trailing: Radio<int>(
                    value: index,
                    groupValue: selectedIndex,
                    onChanged: (int? value) {
                      setState(() {
                        selectedIndex = value;
                      });

                      // Update profile with new drinking status
                      profileProvider.updateProfile(
                        context,
                        authProvider,
                        {"drinking": items[value!]},
                      );
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
              const Text('(2/11)'),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LanguageYouSpeakScreen(),
                    ),
                  );
                },
                child: CircleAvatar(
                  backgroundColor: blue.withOpacity(0.19),
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
