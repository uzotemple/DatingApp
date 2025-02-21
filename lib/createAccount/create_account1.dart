import 'package:flutter/material.dart';
import 'package:love_bird/config/constants.dart';
import 'package:love_bird/config/routes.dart';
import 'package:love_bird/providers/create_account_provider.dart';

import 'package:provider/provider.dart';
import 'dart:developer' as developer;

class CreateAcc1 extends StatefulWidget {
  const CreateAcc1({super.key});

  @override
  State<CreateAcc1> createState() => _CreateAcc1State();
}

class _CreateAcc1State extends State<CreateAcc1> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool agreeToPolicy = false;
  bool showPassword = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<CreateAccountProvider>(context);
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.05,
            vertical: screenSize.height * 0.05,
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Create an account',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(width: screenSize.width * 0.01),
                          const Icon(
                            Icons.person,
                            size: 40,
                            color: blue,
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.01),
                      const Text(
                        "Create your account in seconds, we'll help you find your perfect match",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: screenSize.height * 0.03),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _buildTextField(
                              'Email',
                              _emailController,
                              Icons.email,
                              isEmail: true,
                            ),
                            _buildTextField(
                              'Password',
                              _passwordController,
                              Icons.lock,
                              isPassword: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: userProvider.agreeToPolicy,
                    onChanged: userProvider.toggleAgreeToPolicy,
                    side: const BorderSide(color: blue, width: 2),
                  ),
                  const Text("I agree to Zenkonect "),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      'Privacy Policy',
                      style: TextStyle(
                        color: blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: GestureDetector(
                  onTap: userProvider.agreeToPolicy
                      ? () {
                          if (_formKey.currentState!.validate()) {
                            developer.log(
                                'Email: ${_emailController.text}, Password: ${_passwordController.text}',
                                name: 'UserInput');
                            developer.log('');

                            userProvider
                                .updateEmail(_emailController.text.trim());
                            userProvider.updatePassword(
                                _passwordController.text.trim());
                            userProvider.saveToDatabase(context);

                            // Navigator.pushNamed(context, verifyEmailRoute);
                          }
                        }
                      : null,
                  child: Container(
                    width: screenSize.width * 0.8,
                    height: screenSize.height * 0.05,
                    decoration: BoxDecoration(
                      color: userProvider.agreeToPolicy ? blue : Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.04),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, loginPage);
                  },
                  child: const Text.rich(
                    TextSpan(
                      text: "Already have an account? ",
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            color: blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    IconData icon, {
    bool isPassword = false,
    bool isEmail = false,
  }) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: screenSize.height * 0.03),
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
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
            obscureText: isPassword && !showPassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '$label cannot be empty';
              }
              if (isEmail &&
                  !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                return 'Enter a valid email';
              }
              // if (isPassword) {
              //   if (value.length < 9) {
              //     return 'Password must be at least 9 characters long';
              //   }
              //   if (!RegExp(r'[a-z]').hasMatch(value)) {
              //     return 'Password must contain at least one lowercase letter';
              //   }
              //   if (!RegExp(r'[A-Z]').hasMatch(value)) {
              //     return 'Password must contain at least one uppercase letter';
              //   }
              //   if (!RegExp(r'\d').hasMatch(value)) {
              //     return 'Password must contain at least one number';
              //   }
              //   if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
              //     return 'Password must contain at least one special character';
              //   }
              // }
              //   if (isPassword) {
              //     if (value.length < 9) {
              //       return 'Password must be at least 9 characters long';
              //     }
              //     if (!RegExp(r'[a-z]').hasMatch(value)) {
              //       return 'Password must contain at least one lowercase letter';
              //     }
              //     if (!RegExp(r'[A-Z]').hasMatch(value)) {
              //       return 'Password must contain at least one uppercase letter';
              //     }
              //     if (!RegExp(r'\d').hasMatch(value)) {
              //       return 'Password must contain at least one number';
              //     }
              //     if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
              //       return 'Password must contain at least one special character';
              //     }
              //     if (value.contains(' ')) {
              //       return 'Password must not contain spaces';
              //     }
              //   }

              //   return null;
              // },
              if (isPassword) {
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
                if (!RegExp(r'[!@#$%^&*(),.":{}|<>]').hasMatch(value)) {
                  return 'Password must contain at least one special character';
                }
                if (value.contains(' ')) {
                  return 'Password must not contain spaces';
                }
                if (value.contains('?')) {
                  return 'Password must not contain a question mark (?)';
                }
              }

              return null;
            },
            decoration: InputDecoration(
              fillColor: const Color.fromRGBO(54, 40, 221, 0.1),
              prefixIcon: Icon(icon,
                  color: Theme.of(context).iconTheme.color, size: 20),
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
