import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:love_bird/config/routes.dart';
import 'dart:developer' as developer;
import 'package:love_bird/config/constants.dart';
import 'package:love_bird/providers/auth_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginCreateProvider with ChangeNotifier {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  String profession = '';
  String weight = '';
  String height = '';
  String? linkdln = '';
  String? country;
  String city = '';
  String? educationLevel = '';
  String bio = '';
  bool agreeToPolicy = false;

  final List<String> educationLevels = [
    'NONE',
    'Primary Education',
    'Secondary Education',
    'Vocational Training',
    'A level',
    'Undergraduate Education',
    'Postgraduate Education',
  ];

  List<String> countries = [
    'People nearby',
    'Afghanistan',
    'Albania',
    'Algeria',
    'Andorra',
    'Angola',
    'Antigua and Barbuda',
    'Argentina',
    'Armenia',
    'Australia',
    'Austria',
    'Azerbaijan',
    'Bahamas',
    'Bahrain',
    'Bangladesh',
    'Barbados',
    'Belarus',
    'Belgium',
    'Belize',
    'Benin',
    'Bhutan',
    'Bolivia',
    'Bosnia and Herzegovina',
    'Botswana',
    'Brazil',
    'Brunei',
    'Bulgaria',
    'Burkina Faso',
    'Burundi',
    'Cabo Verde',
    'Cambodia',
    'Cameroon',
    'Canada',
    'Central African Republic',
    'Chad',
    'Chile',
    'China',
    'Colombia',
    'Comoros',
    'Congo, Democratic Republic of the',
    'Congo, Republic of the',
    'Costa Rica',
    'Croatia',
    'Cuba',
    'Cyprus',
    'Czech Republic',
    'Denmark',
    'Djibouti',
    'Dominica',
    'Dominican Republic',
    'Ecuador',
    'Egypt',
    'El Salvador',
    'Equatorial Guinea',
    'Eritrea',
    'Estonia',
    'Eswatini',
    'Ethiopia',
    'Fiji',
    'Finland',
    'France',
    'Gabon',
    'Gambia',
    'Georgia',
    'Germany',
    'Ghana',
    'Greece',
    'Grenada',
    'Guatemala',
    'Guinea',
    'Guinea-Bissau',
    'Guyana',
    'Haiti',
    'Honduras',
    'Hungary',
    'Iceland',
    'India',
    'Indonesia',
    'Iran',
    'Iraq',
    'Ireland',
    'Israel',
    'Italy',
    'Jamaica',
    'Japan',
    'Jordan',
    'Kazakhstan',
    'Kenya',
    'Kiribati',
    'Korea, North',
    'Korea, South',
    'Kuwait',
    'Kyrgyzstan',
    'Laos',
    'Latvia',
    'Lebanon',
    'Lesotho',
    'Liberia',
    'Libya',
    'Liechtenstein',
    'Lithuania',
    'Luxembourg',
    'Madagascar',
    'Malawi',
    'Malaysia',
    'Maldives',
    'Mali',
    'Malta',
    'Marshall Islands',
    'Mauritania',
    'Mauritius',
    'Mexico',
    'Micronesia',
    'Moldova',
    'Monaco',
    'Mongolia',
    'Montenegro',
    'Morocco',
    'Mozambique',
    'Myanmar',
    'Namibia',
    'Nauru',
    'Nepal',
    'Netherlands',
    'New Zealand',
    'Nicaragua',
    'Niger',
    'Nigeria',
    'North Macedonia',
    'Norway',
    'Oman',
    'Pakistan',
    'Palau',
    'Palestine',
    'Panama',
    'Papua New Guinea',
    'Paraguay',
    'Peru',
    'Philippines',
    'Poland',
    'Portugal',
    'Qatar',
    'Romania',
    'Russia',
    'Rwanda',
    'Saint Kitts and Nevis',
    'Saint Lucia',
    'Saint Vincent and the Grenadines',
    'Samoa',
    'San Marino',
    'Sao Tome and Principe',
    'Saudi Arabia',
    'Senegal',
    'Serbia',
    'Seychelles',
    'Sierra Leone',
    'Singapore',
    'Slovakia',
    'Slovenia',
    'Solomon Islands',
    'Somalia',
    'South Africa',
    'South Sudan',
    'Spain',
    'Sri Lanka',
    'Sudan',
    'Suriname',
    'Sweden',
    'Switzerland',
    'Syria',
    'Taiwan',
    'Tajikistan',
    'Tanzania',
    'Thailand',
    'Togo',
    'Tonga',
    'Trinidad and Tobago',
    'Tunisia',
    'Turkey',
    'Turkmenistan',
    'Tuvalu',
    'Uganda',
    'Ukraine',
    'United Arab Emirates',
    'United Kingdom',
    'United States',
    'Uruguay',
    'Uzbekistan',
    'Vanuatu',
    'Vatican City',
    'Venezuela',
    'Vietnam',
    'Yemen',
    'Zambia',
    'Zimbabwe',
    'Vatican City',
    'Palestine'
  ];

  void updateProfession(String newProfession) {
    profession = newProfession;
    notifyListeners();
  }

  void updateWeight(String newWeight) {
    weight = newWeight;
    notifyListeners();
  }

  void updateHeight(String newHeight) {
    height = newHeight;
    notifyListeners();
  }

  void updateLinkdln(String? newLinkdln) {
    linkdln = newLinkdln;
    notifyListeners();
  }

  void updateCountry(String? newCountry) {
    country = newCountry;
    notifyListeners();
  }

  void updateCity(String newCity) {
    city = newCity;
    notifyListeners();
  }

  void updateEducationlevel(String newEducationlevel) {
    educationLevel = newEducationlevel;
    notifyListeners();
  }

  void updateBio(String newBio) {
    bio = newBio;
    notifyListeners();
  }
  // Additional update methods for other fields...

  void toggleAgreeToPolicy(bool? newValue) {
    agreeToPolicy = newValue ?? false;
    notifyListeners();
  }

  // Method to reset fields after form submission
  void resetFields() {
    profession = '';
    weight = '';
    height = '';
    country = '';
    linkdln = '';
    city = '';
    educationLevel = '';
    bio = '';
    agreeToPolicy = false;
    notifyListeners();
  }

  bool _showLoading = false;
  bool _dimBackground = false;
  bool _isChecked = false;

  bool get showLoading => _showLoading;
  bool get dimBackground => _dimBackground;
  bool get isChecked => _isChecked;

  void toggleLoading(bool value) {
    _showLoading = value;
    notifyListeners();
  }

  void toggleDimBackground(bool value) {
    _dimBackground = value;
    notifyListeners();
  }

  void toggleRememberMe() {
    _isChecked = !_isChecked;
    notifyListeners();
  }

  Future<void> handleLogin(BuildContext context, GlobalKey<FormState> formKey,
      String email, String password, AuthProvider authProvider) async {
    if (formKey.currentState!.validate()) {
      toggleDimBackground(true);

      try {
        final response = await _loginUser(email, password);

        developer.log('Response status: ${response.statusCode}');
        developer.log('Response body: ${response.body}');

        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        final String message =
            responseBody['message']?.toString() ?? 'Unknown error occurred';

        if (response.statusCode == 202 ||
            response.statusCode == 201 ||
            response.statusCode == 200) {
          // Extract access token from response body
          final accessToken = responseBody['accessToken'];
          // final userId = responseBody['userId'];

          // Extract refresh token from cookies
          final cookies = response.headers['set-cookie'];
          developer.log('Set-Cookie Header: $cookies');

          final refreshToken = _extractRefreshToken(response.headers);

          if (accessToken != null && refreshToken != null) {
            // Securely store tokens
            await _storeTokens(accessToken, refreshToken);

            // Notify AuthProvider of token updates
            await authProvider.loadTokens();

            _showSubmissionDialog(context);
          } else {
            _showErrorDialog(context, "Failed to retrieve tokens");
          }
        } else if (message == 'User Inactive') {
          _showErrorDialogForOtp(context, 'Please verify your mail');
        } else if (message == 'User not found by given Email') {
          _showErrorDialog(context, 'No user with this mail');
        } else if (message == 'Incorrect Password') {
          _showErrorDialog(context, 'Incorrect Password');
        } else {
          _showErrorDialog(context, "Error: $message");
        }
      } catch (e) {
        developer.log('Error: $e');
        _showErrorDialog(context, "An error occurred. Please try again.");
      } finally {
        toggleLoading(false);
        toggleDimBackground(false);
      }
    }
  }

  Future<http.Response> _loginUser(String email, String password) async {
    const String url = 'http://localhost:7001/auth/login';
    return await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'entrypoint': email,
        'password': password,
      }),
    );
  }

  String? _extractRefreshToken(Map<String, String> headers) {
    final cookies = headers['set-cookie'];
    if (cookies != null) {
      // Update regex to match the new cookie name
      final refreshToken =
          RegExp(r'local.bg-refresh-mgmt=([^;]+)').firstMatch(cookies);
      return refreshToken?.group(1);
    }
    return null;
  }

  Future<void> _storeTokens(String accessToken, String refreshToken) async {
    // Store tokens securely
    await _secureStorage.write(key: 'accessToken', value: accessToken);
    await _secureStorage.write(key: 'refreshToken', value: refreshToken);
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

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
      Navigator.pushNamed(context, userBio);
    });
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

  void _showErrorDialogForOtp(BuildContext context, String messages) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(messages),
          actions: [
            TextButton(
              onPressed: () => Navigator.pushNamed(context, verifyEmailRoute),
              //  () => Navigator.pushNamed(context, oTPVerificationPage),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
