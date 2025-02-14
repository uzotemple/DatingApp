// import 'package:love_bird/edit%20profile%20screens/religion_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:love_bird/config/constants.dart';

// class PetsScreen extends StatefulWidget {
//   const PetsScreen({super.key});

//   @override
//   State<PetsScreen> createState() => _PetsScreenState();
// }

// class _PetsScreenState extends State<PetsScreen> {
//   // List of items
//   final List<String> items = [
//     'Cat(s)',
//     'Dog(s)',
//     'No pets',
//     'Other animals',
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
//         children: [
//           Image.asset('images/pets.png'),
//           const Text(
//             'Do you have pets?',
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
//               const Text('(8/11)'),
//               InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const ReligionScreen()),
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
import 'package:love_bird/edit%20profile%20screens/religion_screen.dart';

class PetsScreen extends StatefulWidget {
  const PetsScreen({super.key});

  @override
  State<PetsScreen> createState() => _PetsScreenState();
}

class _PetsScreenState extends State<PetsScreen> {
  final List<String> items = [
    'Cat(s)',
    'Dog(s)',
    'No pets', // Default option
    'Other animals',
    'I’d rather not say',
  ];

  List<bool> selectedItems = [];

  @override
  void initState() {
    super.initState();

    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    // Fetch saved pet preferences from the profile
    List<String>? currentPets = profileProvider.getProfileData?['pets']?.cast<String>();

    selectedItems = List<bool>.filled(items.length, false);

    if (currentPets != null && currentPets.isNotEmpty) {
      for (String pet in currentPets) {
        int index = items.indexOf(pet);
        if (index != -1) {
          selectedItems[index] = true;
        }
      }
    } else {
      // If no selection exists, default to "No pets"
      selectedItems[2] = true;
    }
  }

  void _updateProfile() {
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Collect selected pets (excluding "No pets" if others are selected)
    List<String> selectedPets = [];
    for (int i = 0; i < items.length; i++) {
      if (selectedItems[i]) {
        selectedPets.add(items[i]);
      }
    }

    // Ensure "No pets" is saved if nothing else is selected
    if (selectedPets.isEmpty) {
      selectedPets.add('No pets');
    } else {
      // Remove "No pets" if other options are selected
      selectedPets.remove('No pets');
    }

    // Update profile data
    profileProvider.updateProfile(
      context,
      authProvider,
      {"pets": selectedPets},
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
          Image.asset('images/pets.png'),
          const Text(
            'Do you have pets?',
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
                        if (index == 2 && value) {
                          // If "No pets" is selected, unselect all others
                          selectedItems = List<bool>.filled(items.length, false);
                          selectedItems[2] = true;
                        } else {
                          // If any other option is selected, unselect "No pets"
                          selectedItems[2] = false;
                        }
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
              const Text('(8/11)'), // Placeholder for step number
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReligionScreen(),
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
