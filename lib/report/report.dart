// import 'package:flutter/material.dart';
// import 'package:love_bird/config/routes.dart';

// class ReportPage extends StatefulWidget {
//   const ReportPage({super.key});

//   @override
//   _ReportPageState createState() => _ReportPageState();
// }

// class _ReportPageState extends State<ReportPage> {
//   String? _selectedReason;

//   @override
//   Widget build(BuildContext context) {
//     const Color blue = Color.fromRGBO(54, 40, 221, 1.0);
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
//         title: const Text(
//           'Report Mark',
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//         ),
//         centerTitle: true, // Center the title text
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(right: 16.0, left: 16, bottom: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Row(
//                 children: [],
//               ),

//               const Divider(thickness: 1, color: Colors.black),
//               const Text(
//                 'Why did you report this user?',
//                 style: TextStyle(fontSize: 18),
//               ),
//               const SizedBox(height: 20),
//               // List of report reasons
//               _buildRadioButton('Harassment'),
//               _buildRadioButton('Inappropriate Content'),
//               _buildRadioButton('Violation of Terms'),
//               _buildRadioButton('Offensive Language'),
//               _buildRadioButton('Disrespectful Behaviour'),
//               _buildRadioButton('Threats'),
//               _buildRadioButton('Catfishing'),
//               _buildRadioButton('Unwanted Advances'),
//               _buildRadioButton('Unsolicited Explicit Content'),
//               _buildRadioButton('Privacy Concerns'),
//               _buildRadioButton('Other'),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.purple[100],
//                     ),
//                     onPressed: () {},
//                     child: const Padding(
//                         padding: EdgeInsets.all(10),
//                         child: Text('Cancel',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16))),
//                   ),
//                   ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: blue,
//                       ),
//                       onPressed: () {
//                         //                    ScaffoldMessenger.of(context).showSnackBar(
//                         //   const SnackBar(content: Text("Your report  has been sent.")),
//                         // );
//                         Navigator.pushNamed(context, personalizedReport);
//                       },
//                       child: const Padding(
//                         padding: EdgeInsets.all(10),
//                         child: Text('Send Report',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16)),
//                       )),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Function to build each radio button option
//   Widget _buildRadioButton(String reason) {
//     const Color blue = Color.fromRGBO(54, 40, 221, 1.0);
//     return RadioListTile<String>(
//       title: Text(reason),
//       value: reason,
//       groupValue: _selectedReason,
//       activeColor: blue,
//       onChanged: (String? value) {
//         setState(() {
//           _selectedReason = value;
//         });
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:love_bird/config/constants.dart';
import 'package:love_bird/config/routes.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  String? _selectedReason;

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
        title: const Text(
          'Report Mark',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 16, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(thickness: 1, color: Colors.black),
              const Text(
                'Why did you report this user?',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              // List of report reasons
              _buildRadioButton('Harassment'),
              _buildRadioButton('Inappropriate Content'),
              _buildRadioButton('Violation of Terms'),
              _buildRadioButton('Offensive Language'),
              _buildRadioButton('Disrespectful Behaviour'),
              _buildRadioButton('Threats'),
              _buildRadioButton('Catfishing'),
              _buildRadioButton('Unwanted Advances'),
              _buildRadioButton('Unsolicited Explicit Content'),
              _buildRadioButton('Privacy Concerns'),
              _buildRadioButton('Other'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[100],
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('Cancel',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16))),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,
                    ),
                    onPressed: () {
                      // Navigate to the next page and pass the selected reason
                      Navigator.pushNamed(
                        context,
                        personalizedReport,
                        arguments: _selectedReason,
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('Send Report',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build each radio button option
  Widget _buildRadioButton(String reason) {
    return ListTile(
      title: Text(
        reason,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
      ),
      trailing: GestureDetector(
        onTap: () {
          setState(() {
            _selectedReason = reason;
          });
        },
        child: Container(
          width: 24.0,
          height: 24.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: _selectedReason == reason ? Colors.blue : Colors.grey,
              width: 2.0,
            ),
            color: _selectedReason == reason
                ? const Color(0xFF3628DD)
                : Colors.transparent,
          ),
          child: _selectedReason == reason
              ? const Icon(
                  Icons.circle,
                  size: 16.0,
                  color: Colors.white,
                )
              : null,
        ),
      ),
    );
  }
}
