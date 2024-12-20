import 'package:flutter/material.dart';
import 'package:love_bird/config/constants.dart';
import 'package:love_bird/config/routes.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:love_bird/providers/user_bio_provider.dart';
import 'package:provider/provider.dart';

class UserBio extends StatefulWidget {
  const UserBio({super.key});

  @override
  State<UserBio> createState() => _UserBioState();
}

class _UserBioState extends State<UserBio> {
  String? selectedLevel;

  final List<String> educationLevels = [
    'None',
    'Primary Education',
    'Secondary Education',
    'Higher Education',
    'Vocational Training',
    'Postgraduate Education',
  ];

  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  bool agreeToPolicy = false;
  bool showPassword = false; // For toggling password visibility

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final userProvider = Provider.of<UserBioProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal:
                MediaQuery.of(context).size.width * 0.05, // 5% of screen width
            vertical: MediaQuery.of(context).size.height *
                0.02, // 5% of screen height
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.02,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            10.0), // Outer rounded corners
                        child: Container(
                          color: blue.withOpacity(0.19), // Background color
                        ),
                      ),
                      // Inner progress bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            10.0), // Inner rounded corners
                        child: Container(
                            width: MediaQuery.of(context).size.width *
                                0.1, // Set width to represent progress
                            color: blue // Progress color
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                const Row(
                  children: [
                    Text(
                      'Bio Data',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(width: 5),
                    Icon(Icons.person, size: 40, color: blue),
                    // Image.asset('assets/images/woman.png'),
                  ],
                ),
                SizedBox(height: screenSize.height * 0.02),

                const Text(
                  "Enter your Bio Data And Find Your Perfect Match",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: screenSize.height * 0.02),
                Form(
                  key: _formKey,
                  child: Column(children: [
                    _buildTextField(
                      'Profession',
                      (value) => userProvider.updateProfession(value),
                    ),
                    _buildTextField(
                      'Linkedln Profile link',
                      (value) => userProvider.updateLinkdln(value),
                    ),
                    _buildTextField(
                      'Weight(kg)',
                      (value) => userProvider.updateWeight(value),
                    ),
                    _buildTextField(
                      'Height(cm)',
                      (value) => userProvider.updateHeight(value),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Country',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.01),
                        Container(
                          width: double.infinity,
                          padding:
                              EdgeInsets.only(bottom: screenSize.height * 0.02),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromRGBO(54, 40, 221, 0.1),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Text(
                                'Select Item',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: userProvider.countries
                                  .map((item) => DropdownMenuItem(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.color, // Text color based on theme
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              value: userProvider.country,
                              onChanged: (value) {
                                userProvider.updateCountry(value);
                              },
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 200,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor, // Background color based on theme
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 40,
                                width: 200,
                              ),

                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),
                              dropdownSearchData: DropdownSearchData(
                                searchController: textEditingController,
                                searchInnerWidgetHeight: 50,
                                searchInnerWidget: Container(
                                  height: 50,
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                    bottom: 4,
                                    right: 8,
                                    left: 8,
                                  ),
                                  child: TextFormField(
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.color),
                                    expands: true,
                                    maxLines: null,
                                    controller: textEditingController,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText: 'Search for an item...',
                                      hintStyle: TextStyle(
                                          color: Theme.of(context).hintColor,
                                          fontSize: 12),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 8,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                                searchMatchFn: (item, searchValue) {
                                  return item.value
                                      .toString()
                                      .toLowerCase()
                                      .contains(searchValue.toLowerCase());
                                },
                              ),
                              // This clears the search value when you close the menu
                              onMenuStateChange: (isOpen) {
                                if (!isOpen) {
                                  textEditingController.clear();
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                      ],
                    ),
                    _buildTextField(
                      'City',
                      (value) => userProvider.updateCity(value),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: screenSize.height * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Education Level',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.02),
                          Container(
                            width: double.infinity,
                            height: screenSize.height *
                                0.065, // Set a suitable height
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(54, 40, 221, 0.1),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: DropdownButton<String>(
                              value: selectedLevel,

                              // hint: Text('Select Education Level'),
                              isExpanded:
                                  true, // Makes the dropdown take full width
                              items: educationLevels.map((String level) {
                                return DropdownMenuItem<String>(
                                  value: level,
                                  child: Text(
                                    level,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.color),
                                  ),
                                );
                              }).toList(),

                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedLevel = newValue;
                                });
                              },
                              underline: Container(),
                              dropdownColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildTextField(
                      'Bio',
                      (value) => userProvider.updateBio(value),
                    ),
                  ]),
                ),
                SizedBox(height: screenSize.height * 0.05),
                // Sign Up Button
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, createNickname);
                    },
                    child: Container(
                      width: screenSize.width * 0.8,
                      height: screenSize.height * 0.05,
                      decoration: BoxDecoration(
                        color: blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text('Continue',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Login Link
                // Inside CreateAcc1 class
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    Function(String) onChanged, [
    IconData? icon,
    bool isPassword = false,
  ]) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: screenSize.height * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenSize.height * 0.01),
          TextField(
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
            onChanged: onChanged,
            obscureText: isPassword && !showPassword,
            decoration: InputDecoration(
              fillColor: const Color.fromRGBO(54, 40, 221, 0.1),
              prefixIcon: icon != null
                  ? Icon(icon,
                      color: Colors.black, size: screenSize.height * 0.02)
                  : null,
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              filled: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 16.0,
              ),
              hintText: label == 'Bio' ? 'Eg: Fun and Interesing' : null,
              hintStyle: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium?.color),
            ),
          ),
        ],
      ),
    );
  }
}
