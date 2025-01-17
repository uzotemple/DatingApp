import 'package:flutter/material.dart';

import 'package:love_bird/config/constants.dart';
import 'package:love_bird/providers/auth_provider.dart';

import 'package:love_bird/providers/update_password_provider.dart';
import 'package:provider/provider.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool showPassword = false;
  void _submitOtp() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final updatePasswordProvider =
        Provider.of<UpdatePasswordProvider>(context, listen: false);

    updatePasswordProvider.updatePassword(context, authProvider,
        oldPasswordController.text, newPasswordController.text);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_outlined, size: 30),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Update Password',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: screenSize.width * 0.01),
                      const Icon(
                        Icons.lock,
                      )
                    ],
                  ),
                  SizedBox(height: screenSize.height * 0.01),
                  const Text(
                    "Update password and save",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.047),
                  Form(
                    key: _formKey,
                    child: Column(children: [
                      _buildTextField('Old Password', oldPasswordController,
                          Icons.lock, false),
                      _buildTextField('New Password', newPasswordController,
                          Icons.lock, true),
                    ]),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  _submitOtp();
                }
              },
              child: Container(
                width: screenSize.width * 0.8,
                height: screenSize.height * 0.05,
                decoration: BoxDecoration(
                  color: blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text('Save',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
            ),
          )
        ]));
  }

  Widget _buildTextField(String label, TextEditingController controller,
      [IconData? icon, bool isPassword = false]) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: screenSize.height * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
            controller: controller,
            obscureText: isPassword && !showPassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '$label cannot be empty';
              }

              if (isPassword) {
                // if (label == 'Confirm New Password' &&
                //     value != passwordController.text) {
                //   return 'Passwords do not match';
                // }
                if (value.length < 9) {
                  return 'Password must be at least 9 characters long';
                }
                if (!RegExp(r'[a-z]').hasMatch(value)) {
                  return 'Password must contain at least one lowercase letter';
                }
                if (!RegExp(r'[A-Z]').hasMatch(value)) {
                  return 'Password must contain at least one uppercase letter';
                }
                if (!RegExp(r'\d').hasMatch(value)) {
                  return 'Password must contain at least one number';
                }
                if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                  return 'Password must contain at least one special character';
                }
                if (value.contains(' ')) {
                  return 'Password must not contain spaces';
                }
              }

              return null;
            },
            decoration: InputDecoration(
              fillColor: const Color.fromRGBO(54, 40, 221, 0.1),
              prefixIcon: icon != null
                  ? Icon(
                      icon,
                      color: Theme.of(context).iconTheme.color,
                      size: 20,
                    )
                  : null,
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off,
                        color: Theme.of(context).iconTheme.color,
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
            ),
          ),
        ],
      ),
    );
  }
}
