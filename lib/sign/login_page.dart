import 'package:flutter/material.dart';
import 'package:love_bird/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:love_bird/config/routes.dart';
import 'package:love_bird/providers/login_provider.dart';
import 'package:love_bird/config/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final loginProvider = Provider.of<LoginProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/login.jpg',
              fit: BoxFit.cover,
              color: loginProvider.dimBackground
                  ? Colors.black.withOpacity(0.5)
                  : Colors.black.withOpacity(0.3),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 150),
                            child: Text(
                              'Welcome back 👋',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: screenSize.width * 0.05,
                              right: screenSize.width * 0.05,
                              top: screenSize.height * 0.02,
                            ),
                            child: const Text(
                              'Please Enter your email and password to Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenSize.width * 0.065,
                          ),

                          // Email and Password Inputs (Form)
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                _buildTextField('Email', emailController,
                                    Icons.email, false, true),
                                _buildTextField('Password', passwordController,
                                    Icons.lock, true),
                              ],
                            ),
                          ),

                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: GestureDetector(
                                  onTap: () => loginProvider.toggleRememberMe(),
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: const Color.fromRGBO(
                                            54, 40, 221, 1),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: loginProvider.isChecked
                                        ? const Icon(
                                            Icons.check,
                                            size: 18,
                                            color:
                                                Color.fromRGBO(54, 40, 221, 1),
                                          )
                                        : null,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 3),
                              const Text(
                                'Remember me',
                                style: TextStyle(color: Colors.white),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 14),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, forgotPassword);
                                  },
                                  child: const Text(
                                    'Forgot Password',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: screenSize.width * 0.05,
                          ),

                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "Don't have an account?",
                                  style: TextStyle(color: blue),
                                ),
                                const SizedBox(width: 5),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, createAccountRoute);
                                  },
                                  child: const Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Login Button at the Bottom
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: screenSize.width * 0.03,
                  right: screenSize.width * 0.03,
                  bottom: screenSize.height * 0.01,
                ),
                child: GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      loginProvider.handleLogin(
                          context,
                          _formKey,
                          emailController.text,
                          passwordController.text,
                          authProvider,
                          false);
                    }
                  },
                  child: Container(
                    width: screenSize.width * 0.9,
                    height: screenSize.height * 0.05,
                    decoration: BoxDecoration(
                      color: blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (loginProvider.showLoading)
            const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, [
    IconData? icon,
    bool isPassword = false,
    bool isEmail = false, // Add flag for email validation
  ]) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        bottom: screenSize.height * 0.03,
        right: screenSize.width * 0.04,
        left: screenSize.width * 0.04,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          TextFormField(
            controller: controller,
            obscureText: isPassword && !showPassword,
            decoration: InputDecoration(
              hintText: label,
              fillColor: Colors.white,
              prefixIcon: icon != null
                  ? Icon(icon, color: Colors.black, size: 20)
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
                borderSide: const BorderSide(
                    color: blue, width: 2), // Set the border color here
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                    color: blue,
                    width: 2), // Set the color for the enabled state
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                    color: blue,
                    width: 2), // Set the color for the focused state
              ),
              filled: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 16.0,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '$label cannot be empty';
              }
              if (isEmail &&
                  !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                return 'Enter a valid email';
              }
              if (isPassword && value.length < 8) {
                return 'Enter valid password';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  void _showSubmissionDialog(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/icons/loginIcon.png'),
                const SizedBox(height: 20),
                const Text(
                  'Login Successful!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: blue,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Please wait....\nYou will be redirected to the homepage",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );
  }
}
