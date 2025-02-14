// import 'package:love_bird/edit%20profile%20screens/extrovert_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:love_bird/config/constants.dart';

// class ReligionScreen extends StatefulWidget {
//   const ReligionScreen({super.key});

//   @override
//   State<ReligionScreen> createState() => _ReligionScreenState();
// }

// class _ReligionScreenState extends State<ReligionScreen> {
//   // List of items
//   final List<String> items = [
//     'Atheist',
//     'Christian',
//     'Muslim',
//     'Hindu',
//     'Other',
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
//           Image.asset('images/religion.png'),
//           const Text(
//             'Whats your religion?',
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
//               const Text('(9/11)'),
//               InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const ExtrovertScreen()),
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
import 'package:love_bird/providers/auth_provider.dart';
import 'package:love_bird/edit%20profile%20screens/extrovert_screen.dart';

class ReligionScreen extends StatefulWidget {
  const ReligionScreen({super.key});

  @override
  State<ReligionScreen> createState() => _ReligionScreenState();
}

class _ReligionScreenState extends State<ReligionScreen> {
  final List<String> items = [
    'Atheist',
    'Christianity',
    'Islam',
    'Hinduism',
    'Other',
  ];

  int selectedIndex = 4; // Default to 'Atheist'

  @override
  void initState() {
    super.initState();

    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    // Fetch the saved religion from profile data
    String? currentReligion = profileProvider.getProfileData?['religion'];

    if (currentReligion != null && items.contains(currentReligion)) {
      selectedIndex = items.indexOf(currentReligion);
    }
  }

  void _updateProfile() {
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Update profile with selected religion
    profileProvider.updateProfile(
      context,
      authProvider,
      {"religion": items[selectedIndex]},
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
      body: Column(
        children: [
          Image.asset('images/religion.png'),
          const Text(
            'What’s your religion?',
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
                        selectedIndex = value!;
                      });

                      _updateProfile();
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
              const Text('(9/11)'), // Step number
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ExtrovertScreen(),
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
