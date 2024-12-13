import 'package:love_bird/config/routes.dart';
import 'package:love_bird/providers/theme_provider.dart';
import 'package:love_bird/safety_privacy_screens/instantly_translate_languages_to_english_screen.dart';
import 'package:love_bird/safety_privacy_screens/notifications_screen.dart';
import 'package:love_bird/safety_privacy_screens/payment_settings_screen.dart';
import 'package:love_bird/safety_privacy_screens/sexual_orgasm_picture.dart';
import 'package:love_bird/setting_screen/incognito_mode_onsetting_screen.dart';
import 'package:love_bird/setting_screen/privacy_onsetting_screen.dart';
import 'package:love_bird/setting_screen/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:love_bird/config/constants.dart';

class AccountPreferenceScreen extends StatefulWidget {
  const AccountPreferenceScreen({super.key});

  @override
  State<AccountPreferenceScreen> createState() =>
      _AccountPreferenceScreenState();
}

class _AccountPreferenceScreenState extends State<AccountPreferenceScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider =
        Provider.of<ThemeProvider>(context); // Access the theme provider

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
              child: Image.asset(
                "images/ai.png",
              ),
            ),
            Container(width: 20),
            const Text(
              'Account Preference',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          const Divider(color: blue),
          ListTile(
            title: Text(
              'Privacy',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).iconTheme.color,
            ),
            onTap: () {
              // Navigate to Basic Info Screen
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PrivacyOnSettingsScreen()),
              );
            },
          ),
          const Divider(color: blue),
          ListTile(
            title: Text(
              'Notifications',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).iconTheme.color,
            ),
            onTap: () {
              // Navigate to Basic Info Screen
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationsScreen()),
              );
            },
          ),
          const Divider(color: blue),
          ListTile(
            title: Text(
              'Verifications',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).iconTheme.color,
            ),
            onTap: () {
              // Navigate to Account Preferences Screen
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const VerificationScreen()),
              );
            },
          ),
          const Divider(color: blue),
          ListTile(
            title: Text(
              'Payment settings',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).iconTheme.color,
            ),
            onTap: () {
              // Navigate to Personalize Experience Screen
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PaymentSettingScreen()),
              );
            },
          ),
          const Divider(color: blue),
          ListTile(
            title: Text(
              'Incognito mode',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).iconTheme.color,
            ),
            onTap: () {
              // Navigate to Help Center Screen
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const IncognitoModeOnSettingScreen()),
              );
            },
          ),
          const Divider(color: blue),
          ListTile(
            title: Text(
              'Sexual organ picture recognition and censoring',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).iconTheme.color,
            ),
            onTap: () {
              // Navigate to About Screen
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SexualOrgasmPicturesScreen()),
              );
            },
          ),
          const Divider(color: blue),
          ListTile(
            title: Text(
              'Instantly translate other languages to English',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).iconTheme.color,
            ),
            onTap: () {
              // Navigate to Blocked Users Screen
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const InstantlyTranslateOtherLanguageToEnglishScreen()),
              );
            },
          ),
          const Divider(color: blue),
          // ListTile(
          //   title: const Text(
          //     'Dark mode',
          //     style: TextStyle(
          //       fontSize: 16,
          //       fontWeight: FontWeight.w600,
          //     ),
          //   ),
          //   trailing: Transform.scale(
          //     scale: 0.75,
          //     child: Switch(
          //       value: isDarkMode,
          //       onChanged: (value) {
          //         setState(() {
          //           isDarkMode = value; // Update the dark mode state
          //         });
          //       },
          //       activeColor: const Color(
          //           0xFF3628DD), // Color of the switch when it is ON
          //       activeTrackColor:
          //           Colors.white, // Color of the track when switch is ON
          //       inactiveThumbColor: const Color(
          //           0xFF3628DD), // Color of the thumb when switch is OFF
          //       inactiveTrackColor:
          //           Colors.grey[200], // Color of the track when switch is OFF
          //     ),
          //   ),
          //   onTap: () {
          //     // Optionally, you can also toggle dark mode on tap
          //     setState(() {
          //       isDarkMode = !isDarkMode; // Toggle dark mode on tap
          //     });
          //   },
          // ),
          ListTile(
            title: Text(
              'Dark mode',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            trailing: Transform.scale(
              scale: 0.75,
              child: Switch(
                value: themeProvider.themeMode ==
                    ThemeMode.dark, // Link to themeMode
                onChanged: (value) {
                  themeProvider.toggleTheme(); // Toggle the theme
                },
                activeColor: blue,
                activeTrackColor: Colors.white,
                inactiveThumbColor: blue,
                inactiveTrackColor: Colors.grey[200],
              ),
            ),
            onTap: () {
              themeProvider.toggleTheme(); // Toggle theme on tap
            },
          ),

          const Divider(color: blue),
        ],
      ),
    );
  }
}
