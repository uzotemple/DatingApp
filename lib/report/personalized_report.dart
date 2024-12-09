// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:love_bird/config/routes.dart';
// import 'package:image_picker/image_picker.dart';

// class PersonalizedReport extends StatefulWidget {
//   const PersonalizedReport({super.key});

//   @override
//   State<PersonalizedReport> createState() => _PersonalizedReportState();
// }

// class _PersonalizedReportState extends State<PersonalizedReport> {
//   File? _selectedImage; // To store the selected image
//   String? _imageName; // To store the name of the selected image

//   // Function to pick an image from the gallery
//   Future<void> _pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? pickedImage =
//         await picker.pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage = File(pickedImage.path);
//         _imageName = pickedImage.name; // Get the name of the image
//       });
//     }
//   }

//   final TextEditingController _emailController = TextEditingController();
//   final FocusNode _emailFocusNode = FocusNode();
//   final FocusNode _messageFocusNode = FocusNode();

//   @override
//   void dispose() {
//     _emailFocusNode.dispose();
//     _messageFocusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     const Color blue = Color.fromRGBO(54, 40, 221, 1.0);
//     final String? selectedReason =
//         ModalRoute.of(context)!.settings.arguments as String?;
//     final TextEditingController reasonController = TextEditingController(
//       text: selectedReason != null ? 'You reported: $selectedReason' : '',
//     );
//     final formKey = GlobalKey<FormState>();
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back, color: Colors.black),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           title: Row(
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   Navigator.pushNamed(context, chatbotWelcomeScreen);
//                 },
//                 child: Image.asset(
//                   'assets/images/robot.png',
//                   width: screenSize.width * 0.08,
//                 ),
//               ),
//               // SizedBox(width: screenSize.width * 0.07),
//               const Spacer(),
//               const Text(
//                 'Report',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w700,
//                   fontSize: 20,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const Spacer(), const Spacer(),
//             ],
//           ),
//           centerTitle: true,
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       const CircleAvatar(
//                         radius: 70,
//                         backgroundImage: AssetImage(
//                           'assets/images/homeImage.png',
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       Form(
//                         key: formKey,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               "Email",
//                               style: TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.w800),
//                             ),
//                             TextFormField(
//                               focusNode: _emailFocusNode,
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Email cannot be empty';
//                                 }
//                                 if (!RegExp(
//                                         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                                     .hasMatch(value)) {
//                                   return 'Enter a valid email';
//                                 }
//                                 return null;
//                               },
//                               controller: _emailController,
//                               decoration: InputDecoration(
//                                 labelStyle: const TextStyle(color: blue),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide: const BorderSide(color: blue),
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide: const BorderSide(color: blue),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                             const Text(
//                               "Message",
//                               style: TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.w800),
//                             ),
//                             TextFormField(
//                               controller: reasonController,
//                               maxLines: 6,
//                               readOnly: false,
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Message cannot be empty';
//                                 }
//                                 return null;
//                               },
//                               decoration: InputDecoration(
//                                 labelStyle: const TextStyle(color: blue),
//                                 hintStyle: const TextStyle(color: Colors.grey),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide: const BorderSide(color: blue),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide: const BorderSide(color: blue),
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide: const BorderSide(color: blue),
//                                 ),
//                               ),
//                             ),
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       const Text(
//                                         'Attach a screenshot',
//                                         style: TextStyle(color: blue),
//                                       ),
//                                       const SizedBox(width: 5),
//                                       IconButton(
//                                         onPressed:
//                                             _pickImage, // Call the function to pick an image
//                                         icon: const Icon(Icons.attach_file,
//                                             color: blue),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 20),
//                                   if (_selectedImage != null) ...[
//                                     Image.file(
//                                       _selectedImage!,
//                                       height: 150,
//                                       fit: BoxFit.cover,
//                                     ),
//                                     const SizedBox(height: 10),
//                                     Text(
//                                       'Selected Image: $_imageName',
//                                       style: const TextStyle(
//                                           color: Colors.black, fontSize: 16),
//                                     ),
//                                   ] else
//                                     const Text(
//                                       'No image selected.',
//                                       style: TextStyle(
//                                           color: Colors.grey, fontSize: 16),
//                                     ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: screenSize.width * 0.8,
//               height: screenSize.height * 0.07,
//               child: ElevatedButton(
//                 onPressed: () {
//                   if (formKey.currentState!.validate()) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                           content: Text('Your report has been sent')),
//                     );
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: blue,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                 ),
//                 child: const Text(
//                   'Send',
//                   style: TextStyle(fontSize: 16, color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:love_bird/config/routes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:love_bird/config/constants.dart';

class PersonalizedReport extends StatefulWidget {
  const PersonalizedReport({super.key});

  @override
  State<PersonalizedReport> createState() => _PersonalizedReportState();
}

class _PersonalizedReportState extends State<PersonalizedReport> {
  // State Variables
  File? _selectedImage;
  String? _imageName;
  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _messageFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  // Pick an image from the gallery
  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedImage =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        setState(() {
          _selectedImage = File(pickedImage.path);
          _imageName = pickedImage.name;
        });
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _messageFocusNode.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // Text Field Decoration Helper
  InputDecoration _buildInputDecoration({String? hintText}) {
    return InputDecoration(
      labelStyle: const TextStyle(color: blue),
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: blue),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: blue),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final String? selectedReason =
        ModalRoute.of(context)?.settings.arguments as String?;
    final reasonController = TextEditingController(
      text: selectedReason != null ? 'You reported: $selectedReason' : '',
    );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, chatbotWelcomeScreen),
                child: Image.asset(
                  'assets/images/robot.png',
                  width: screenSize.width * 0.08,
                ),
              ),
              const Spacer(),
              const Text(
                'Report',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 70,
                      backgroundImage:
                          AssetImage('assets/images/homeImage.png'),
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color),
                            focusNode: _emailFocusNode,
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email cannot be empty';
                              }
                              if (!RegExp(
                                      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                                  .hasMatch(value)) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                            decoration: _buildInputDecoration(),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Message",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color),
                            controller: reasonController,
                            maxLines: 6,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Message cannot be empty';
                              }
                              return null;
                            },
                            decoration: _buildInputDecoration(),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Text(
                                'Attach a screenshot',
                                style: TextStyle(color: blue),
                              ),
                              const SizedBox(width: 5),
                              IconButton(
                                onPressed: _pickImage,
                                icon:
                                    const Icon(Icons.attach_file, color: blue),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          if (_selectedImage != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.file(
                                  _selectedImage!,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Selected Image: $_imageName',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            )
                          else
                            const Text(
                              'No image selected.',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: screenSize.width * 0.7,
              height: screenSize.height * 0.07,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Your report has been sent')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Send',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
