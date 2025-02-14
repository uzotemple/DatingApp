// import 'package:love_bird/edit%20profile%20screens/pets_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:love_bird/config/constants.dart';

// class StarSignScreen extends StatefulWidget {
//   const StarSignScreen({super.key});

//   @override
//   State<StarSignScreen> createState() => _StarSignScreenState();
// }

// class _StarSignScreenState extends State<StarSignScreen> {
//   // List of items
//   final List<String> items = [
//     'Aries',
//     'Taurus',
//     'Gemini',
//     'Cancer',
//     'Leo',
//     'Virgo',
//     'Libra',
//     'Scorpio',
//     'Sagittarius',
//     'Capricorn',
//     'Aquarius',
//     'Pisces',
//   ];

//   // List to keep track of selected items
//   List<bool> selectedItems = [false, false, false, false, false, false, false];

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
//           Image.asset('images/star sign.png'),
//           const Text(
//             'What’s your star sign??',
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
//               const Text('(7/11)'),
//               InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const PetsScreen()),
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
import 'package:love_bird/edit%20profile%20screens/pets_screen.dart';

class StarSignScreen extends StatefulWidget {
  const StarSignScreen({super.key});

  @override
  State<StarSignScreen> createState() => _StarSignScreenState();
}

class _StarSignScreenState extends State<StarSignScreen> {
  final List<String> items = [
    'Aries',
    'Taurus',
    'Gemini',
    'Cancer',
    'Leo',
    'Virgo',
    'Libra',
    'Scorpio',
    'Sagittarius',
    'Capricorn',
    'Aquarius',
    'Pisces',
  ];

  int selectedIndex = 0; // Default no selection

  @override
  void initState() {
    super.initState();
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    // Fetch saved star sign from profile data
    String? currentStarSign = profileProvider.getProfileData?['starSign'];

    if (currentStarSign != null && items.contains(currentStarSign)) {
      selectedIndex = items.indexOf(currentStarSign);
    }
  }

  void _updateProfile() {
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Update profile with selected star sign
    profileProvider.updateProfile(
      context,
      authProvider,
      {"starSign": items[selectedIndex]},
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
          Image.asset('images/star sign.png'),
          const Text(
            'What’s your star sign?',
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
              const Text('(7/11)'), // Step number
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PetsScreen(),
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
