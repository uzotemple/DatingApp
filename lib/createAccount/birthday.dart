import 'package:flutter/material.dart';

import 'package:love_bird/providers/auth_provider.dart';
import 'package:love_bird/providers/birthday_provider.dart';

import 'package:provider/provider.dart';
import 'package:love_bird/config/constants.dart';

class CelebrateYouScreen extends StatefulWidget {
  const CelebrateYouScreen({super.key});

  @override
  State<CelebrateYouScreen> createState() => _CelebrateYouScreenState();
}

final formKey = GlobalKey<FormState>();

// class _CelebrateYouScreenState extends State<CelebrateYouScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;

//     final birthdayProvider = Provider.of<CelebrateYouProvider>(context);
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     final TextEditingController monthController = TextEditingController();
//     final TextEditingController yearController = TextEditingController();
//     final TextEditingController dayController = TextEditingController();
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.only(
//             right: MediaQuery.of(context).size.width * 0.05,
//             left:
//                 MediaQuery.of(context).size.width * 0.05, // 5% of screen width
//             top: MediaQuery.of(context).size.height * 0.02,
//             // 5% of screen width
//             bottom: MediaQuery.of(context).size.height *
//                 0.05, // 5% of screen height
//           ),
//           child: Column(
//             children: [
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       // Progress bar at the top
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width,
//                         height: MediaQuery.of(context).size.height * 0.02,
//                         child: Stack(
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(
//                                   10.0), // Outer rounded corners
//                               child: Container(
//                                 color:
//                                     blue.withOpacity(0.19), // Background color
//                               ),
//                             ),
//                             // Inner progress bar
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(
//                                   10.0), // Inner rounded corners
//                               child: Container(
//                                   width: MediaQuery.of(context).size.width *
//                                       0.25, // Set width to represent progress
//                                   color: blue // Progress color
//                                   ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       SizedBox(height: screenSize.height * 0.04),
//                       // Title
//                       const Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Let\'s celebrate you',
//                             style: TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(width: 10),
//                           Icon(
//                             Icons.cake,
//                             color: Colors.redAccent,
//                             size: 28,
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: screenSize.height * 0.035),
//                       // Birthday Cake Image
//                       Image.asset(
//                         'assets/images/cake.png',
//                         height: screenSize.height * 0.25,
//                         fit: BoxFit.contain,
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.04,
//                       ),
//                       // Date Fields
//                       Form(
//                         key: formKey,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             _buildDateField(context, 'MM', monthController),
//                             _buildDateField(context, 'DD', dayController),
//                             _buildDateField(context, 'YYYY', yearController),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   if (formKey.currentState!.validate()) {
//                     birthdayProvider.setMonth(monthController.text);
//                     birthdayProvider.setDay(dayController.text);
//                     birthdayProvider.setYear(yearController.text);
//                     birthdayProvider.updateDob(context, authProvider);
//                   }
//                 },
//                 child: Container(
//                   width: screenSize.width * 0.8,
//                   height: screenSize.height * 0.06,
//                   decoration: BoxDecoration(
//                     color: blue,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: const Center(
//                     child: Text(
//                       'Continue',
//                       style: TextStyle(color: Colors.white, fontSize: 18),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Widget _buildDateField(
//   Widget _buildDateField(
//       BuildContext context, String hint, TextEditingController controller) {
//     String? errorMessage;

//     return Tooltip(
//       message: errorMessage ?? '',
//       child: SizedBox(
//         width: MediaQuery.of(context).size.width * 0.2,
//         height: MediaQuery.of(context).size.height * 0.09,
//         child: TextFormField(
//           controller: controller,
//           style: TextStyle(
//             color: Theme.of(context).textTheme.bodyMedium?.color,
//           ),
//           textAlign: TextAlign.center,
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: TextStyle(
//               fontSize: 18,
//               color: Theme.of(context).brightness == Brightness.dark
//                   ? const Color.fromARGB(255, 185, 182, 182)
//                   : const Color.fromRGBO(56, 53, 53, 1),
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderSide: const BorderSide(
//                   color: blue, width: 2), // Blue border when inactive
//               borderRadius: BorderRadius.circular(10),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: const BorderSide(
//                   color: blue, width: 3), // Thicker blue border when active
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           keyboardType: TextInputType.number,
//           validator: (value) {
//             // Validation logic
//             if (hint == 'DD') {
//               if (value == null || value.isEmpty) {
//                 errorMessage = 'Value cannot be empty';
//                 return '';
//               }
//               if (value.length > 2) {
//                 errorMessage = 'Value must not be more than 2 digits';
//                 return '';
//               }
//               final intValue = int.tryParse(value);
//               if (intValue == null) {
//                 errorMessage = 'Value must contain only numbers';
//                 return '';
//               }
//               if (intValue < 1 || intValue > 31) {
//                 errorMessage = 'Value must be between 1 and 31';
//                 return '';
//               }
//             }
//             if (hint == 'MM') {
//               if (value == null || value.isEmpty) {
//                 errorMessage = 'Value cannot be empty';
//                 return '';
//               }
//               if (value.length > 2) {
//                 errorMessage = 'Value must not be more than 2 digits';
//                 return '';
//               }
//               final intValue = int.tryParse(value);
//               if (intValue == null) {
//                 errorMessage = 'Value must contain only numbers';
//                 return '';
//               }
//               if (intValue < 1 || intValue > 12) {
//                 errorMessage = 'Value must be between 1 and 21';
//                 return '';
//               }
//             }
//             if (hint == 'YYYY') {
//               if (value == null || value.isEmpty) {
//                 errorMessage = 'Value cannot be empty';
//                 return '';
//               }
//               if (value.length > 4) {
//                 errorMessage = 'Value must not be more than 2 digits';
//                 return '';
//               }
//               final intValue = int.tryParse(value);
//               if (intValue == null) {
//                 errorMessage = 'Value must contain only numbers';
//                 return '';
//               }
//               final currentYear = DateTime.now().year;

//               if (intValue < 1900 || intValue > currentYear - 18) {
//                 errorMessage =
//                     'Year must be between 1900 and ${currentYear - 18}';
//                 return '';
//               }
//             }
//             errorMessage = null; // No error
//             return null;
//           },
//         ),
//       ),
//     );
//   }
// }
class _CelebrateYouScreenState extends State<CelebrateYouScreen> {
  late TextEditingController monthController;
  late TextEditingController dayController;
  late TextEditingController yearController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers in initState to persist their values
    monthController = TextEditingController();
    dayController = TextEditingController();
    yearController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final birthdayProvider = Provider.of<CelebrateYouProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            right: MediaQuery.of(context).size.width * 0.05,
            left: MediaQuery.of(context).size.width * 0.05,
            top: MediaQuery.of(context).size.height * 0.02,
            bottom: MediaQuery.of(context).size.height * 0.05,
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Progress bar at the top
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.02,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                color: blue.withOpacity(0.19),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  color: blue),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.04),
                      // Title
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Let\'s celebrate you',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.cake,
                            color: Colors.redAccent,
                            size: 28,
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.035),
                      // Birthday Cake Image
                      Image.asset(
                        'assets/images/cake.png',
                        height: screenSize.height * 0.25,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      // Date Fields
                      Form(
                        key: formKey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildDateField(context, 'MM', monthController),
                            _buildDateField(context, 'DD', dayController),
                            _buildDateField(context, 'YYYY', yearController),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    birthdayProvider.setMonth(monthController.text);
                    birthdayProvider.setDay(dayController.text);
                    birthdayProvider.setYear(yearController.text);
                    birthdayProvider.updateDob(context, authProvider);
                  }
                },
                child: Container(
                  width: screenSize.width * 0.8,
                  height: screenSize.height * 0.06,
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      'Continue',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateField(
      BuildContext context, String hint, TextEditingController controller) {
    String? errorMessage;

    return Tooltip(
      message: errorMessage ?? '',
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.09,
        child: TextFormField(
          controller: controller,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 18,
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color.fromARGB(255, 185, 182, 182)
                  : const Color.fromRGBO(56, 53, 53, 1),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: blue, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: blue, width: 3),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            // Validation logic
            if (hint == 'DD') {
              if (value == null || value.isEmpty) {
                errorMessage = 'Value cannot be empty';
                return '';
              }
              if (value.length > 2) {
                errorMessage = 'Value must not be more than 2 digits';
                return '';
              }
              final intValue = int.tryParse(value);
              if (intValue == null) {
                errorMessage = 'Value must contain only numbers';
                return '';
              }
              if (intValue < 1 || intValue > 31) {
                errorMessage = 'Value must be between 1 and 31';
                return '';
              }
            }
            if (hint == 'MM') {
              if (value == null || value.isEmpty) {
                errorMessage = 'Value cannot be empty';
                return '';
              }
              if (value.length > 2) {
                errorMessage = 'Value must not be more than 2 digits';
                return '';
              }
              final intValue = int.tryParse(value);
              if (intValue == null) {
                errorMessage = 'Value must contain only numbers';
                return '';
              }
              if (intValue < 1 || intValue > 12) {
                errorMessage = 'Value must be between 1 and 12';
                return '';
              }
            }
            if (hint == 'YYYY') {
              if (value == null || value.isEmpty) {
                errorMessage = 'Value cannot be empty';
                return '';
              }
              if (value.length > 4) {
                errorMessage = 'Value must not be more than 2 digits';
                return '';
              }
              final intValue = int.tryParse(value);
              if (intValue == null) {
                errorMessage = 'Value must contain only numbers';
                return '';
              }
              final currentYear = DateTime.now().year;

              if (intValue < 1900 || intValue > currentYear - 18) {
                errorMessage =
                    'Year must be between 1900 and ${currentYear - 18}';
                return '';
              }
            }
            errorMessage = null; // No error
            return null;
          },
        ),
      ),
    );
  }
}
