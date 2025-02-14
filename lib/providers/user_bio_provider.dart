import 'package:flutter/material.dart';
import 'package:love_bird/config/routes.dart';
import 'api_helper.dart';
import 'auth_provider.dart';
import 'dart:developer' as developer;

class UserBioProvider extends ChangeNotifier {
  // Fields for user information
  String profession = '';
  String weight = '';
  String height = '';
  String? linkdln;
  String? country;
  String city = '';
  String educationLevel = '';
  String bio = '';
  bool agreeToPolicy = false;

  List<String> countries = [
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

  bool isLoading = false;

  // Update methods for the fields
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

  void updateEducationLevel(String newEducationLevel) {
    educationLevel = newEducationLevel;
    notifyListeners();
  }

  void updateBio(String newBio) {
    bio = newBio;
    notifyListeners();
  }

  void toggleAgreeToPolicy(bool? newValue) {
    agreeToPolicy = newValue ?? false;
    notifyListeners();
  }

  // String mapEducationLevelToBackend(String selectedLevel) {
  //   switch (selectedLevel) {
  //     case 'None':
  //       return 'NONE';
  //     case 'Primary Education':
  //       return 'PRIMARY_EDUCATION';
  //     case 'Secondary Education':
  //       return 'SECONDRY_EDUCATION';
  //     case 'Higher Education':
  //       return 'HIGHER_EDUCATION';
  //     case 'Vocational Training':
  //       return 'VOCATIONAL_TRAINING';
  //     case 'Postgraduate Education':
  //       return 'POSTGRADUATE_EDUCATION';
  //     default:
  //       return 'NONE';
  //   }
  // }

  Future<void> createProfile(
      BuildContext context, AuthProvider authProvider) async {
    try {
      isLoading = true;
      notifyListeners();

      const url = 'http://138.68.150.48:7001/profile/initial-addition';
      const method = 'POST';
      final headers = {'Content-Type': 'application/json'};

      //final mappedEducationLevel = mapEducationLevelToBackend(educationLevel);

      final body = {
        "profession": profession,
        "linkedin": profession,
        "weight": double.tryParse(weight) ?? 0,
        "height": double.tryParse(height) ?? 0,
        "country": country,
        "city": city,
        "bio": bio,
        "educationLevel":educationLevel,
      };

      final response = await makeApiRequest(
        url,
        method,
        headers,
        authProvider,
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        developer.log('Profile created successfully: ${response.data}');
        Navigator.pushNamed(context, createNickname);
      } else {
        final Map<String, dynamic> responseBody = (response.data);
        final errorMessage = responseBody['message'] ?? 'Unknown error';

        developer.log(
            'Failed to create profile. Status code: ${response.statusCode}, Error: $errorMessage');
        _showErrorDialog(context, "Error: $errorMessage");
        throw Exception(
            'Failed to create profile. Status code: ${response.statusCode}, Response: ${response.data}');
      }
    } catch (e) {
      developer.log('Error creating profile: $e');
      _showErrorDialog(context, "An error occurred. Please try again.");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error', style: TextStyle(color: Colors.black)),
          content: Text(message, style: const TextStyle(color: Colors.black)),
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
}
