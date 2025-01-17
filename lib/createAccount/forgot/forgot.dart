import 'package:flutter/material.dart';

import 'package:love_bird/config/constants.dart';
import 'package:love_bird/providers/forgot_password_provider.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final retrieveProvider = Provider.of<RetrieveProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      resizeToAvoidBottomInset: false, // This line helps prevent overflow
      body: Padding(
        padding: EdgeInsets.only(
            top: screenSize.height * 0.03,
            bottom: screenSize.height * 0.03,
            left: screenSize.width * 0.07,
            right: screenSize.width * 0.06),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Reset Your Password',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: screenSize.width * 0.02),
                        const Icon(Icons.key_sharp)
                      ],
                    ),
                    SizedBox(height: screenSize.height * 0.012),
                    const Text(
                      "Please enter your email and we will send an OTP code in the next step to reset your password",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.042),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildTextField(
                              'Email', emailController, Icons.email),
                          // _buildTextField('Password', passwordController, Icons.lock, true),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.02,
                  horizontal: screenSize.width * 0.03),
              child: GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    retrieveProvider.retrieveEmail(
                        context, emailController.text);
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
                    child: Text(
                      'Continiue',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, [
    IconData? icon,
  ]) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: screenSize.height * 0.023),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenSize.height * 0.009),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '$label cannot be empty';
              }
              if (label.toLowerCase() == 'email' &&
                  !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                      .hasMatch(value)) {
                return 'Enter a valid email';
              }
              return null;
            },
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
            controller: controller,
            decoration: InputDecoration(
              fillColor: const Color.fromRGBO(54, 40, 221, 0.1),
              prefixIcon: Icon(icon,
                  color: Theme.of(context).iconTheme.color, size: 20),
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
