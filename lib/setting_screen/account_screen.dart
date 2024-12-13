import 'package:love_bird/config/routes.dart';
import 'package:love_bird/setting_screen/delete_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:love_bird/config/constants.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isChecked = false;
  final TextEditingController _controller = TextEditingController();

  Future<void> handleLogout() async {
    const String url = 'http://localhost:7001/auth/logout';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          // Optionally add Authorization header if required (e.g., using Bearer token)
          // 'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        // On success, clear any stored tokens and navigate the user to the login screen
        // You can use shared_preferences or secure_storage to clear the tokens
        // For example:
        // await SecureStorage.delete('accessToken');
        // await SecureStorage.delete('refreshToken');

        Navigator.pushReplacementNamed(context, loginPage);
      } else {
        _showErrorDialog(context, "Failed to log out. Please try again.");
      }
    } catch (e) {
      _showErrorDialog(context, "An error occurred. Please try again.");
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

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
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, geminiBot);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Image.asset(
                  "images/ai.png",
                ),
              ),
            ),
            Container(width: 45),
            const Text(
              'Account',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Divider(
              color: blue,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Hide account',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? newValue) {
                          setState(() {
                            isChecked = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  const Text(
                    'Hide your account like you deleted it,\n you can come back anytime.',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: const Text(
                'Make sure you can remember your password, as you’ll need it to sign back in.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextField(
                controller: _controller,
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color),
                decoration: const InputDecoration(
                  labelText: 'hailey1@ymail.com',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: blue,
                        width: 2.0), // Purple color for the underline
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: blue, width: 2.0), // Same color when focused
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    handleLogout();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blue,
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  child: const Text(
                    'Sign Out',
                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Forgot Password?',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DeleteAccountScreen()),
                );
              },
              child: const Text(
                'Delete account',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
