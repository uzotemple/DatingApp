import 'package:flutter/material.dart';
import 'package:love_bird/config/routes.dart';
import 'api_helper.dart';
import 'auth_provider.dart';
import 'dart:developer' as developer;
import 'dart:convert';

class UserBioProvider extends ChangeNotifier {
  // Fields for user information

  String profession = '';
  String weight = '';
  String height = '';
  String? linkdln = '';
  String? country;
  String city = '';
  String? educationLevel = '';
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

  String mapEducationLevelToBackend(String selectedLevel) {
    switch (selectedLevel) {
      case 'None':
        return 'None';
      case 'Primary Education':
        return 'Primary Education';
      case 'Secondary Education':
        return 'SECONDRY_EDUCATION';
      case 'Vocational Training':
        return 'VOCATIONAL_TRAINING';
      case 'Postgraduate Education':
        return 'POSTGRADUATE_EDUCATION';
      default:
        return 'NONE'; // Default value, in case of an invalid selection
    }
  }

  Future<void> createProfile(
      BuildContext context, AuthProvider authProvider) async {
    // Map educationLevel to backend value
    String mappedEducationLevel =
        mapEducationLevelToBackend(educationLevel ?? 'None');
    try {
      // Define API request details
      const url = 'http://138.68.150.48:7001/profile/initial-addition';
      const method =
          'POST'; // Consider using a constant or enum for HTTP methods
      final headers = {'Content-Type': 'application/json'};

      // API request body
      final body = {
        "profession": profession,
        "weight": double.tryParse(weight) ?? 0, // Ensure numeric value
        "height": double.tryParse(height) ?? 0, // Ensure numeric value
        "country": country,
        "city": city,
        "bio": bio,
        "educationLevel": mappedEducationLevel
        // "educationLevel": 'None'
      };

      // Send the request using makeApiRequest
      final response = await makeApiRequest(
        url,
        method,
        headers,
        authProvider,
        body: body,
      );

      // Check for successful response
      if (response.statusCode == 200 || response.statusCode == 201) {
        developer.log('Profile created successfully: ${response.body}');
        Navigator.pushNamed(context, createNickname);
      } else {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final errorMessage = responseBody['message'] ?? 'Unknown error';

        //  Print and log the error
        developer.log(
            'Failed to create profile. Status code: ${response.statusCode}, Error: $errorMessage');

        _showErrorDialog(context, "Error: $errorMessage");
        throw Exception(
            'Failed to create profile. Status code: ${response.statusCode}, Response: ${response.body}');

        //  return;
      }
    } catch (e) {
      developer.log('Error creating profile: $e');
      _showErrorDialog(context, "An error occurred. Please try again.");
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

//   Future<void> saveToDatabase() async {
//     const String apiUrl = "http://localhost:7001/profile/initial-addition";

//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         body: jsonEncode({
//           "profession": profession,
//           "weight": double.tryParse(weight) ?? 0, // Ensure numeric value
//           "height": double.tryParse(height) ?? 0, // Ensure numeric value
//           "country": country,
//           "city": city,
//           "bio": bio,
//           "educationLevel": educationLevel,
//         }),
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         print("User bio saved successfully.");
//       } else {
//         print("Failed to save user bio: ${response.statusCode}");
//         print(response.body);
//       }
//     } catch (error) {
//       print("Error saving user bio: $error");
//     }
//   }
// }



// class ProfileProvider with ChangeNotifier {
//   Future<void> createProfile(AuthProvider authProvider) async {
//     try {
//       // Define API request details
//       final url = 'http://localhost:7001/profile/initial-addition';
//       final method =
//           'POST'; // Consider using a constant or enum for HTTP methods
//       final headers = {'Content-Type': 'application/json'};

//       // API request body
//       final body = {
//         "profession": 'Developer',
//         "weight": 75,
//         "height": 180,
//         "country": 'USA',
//         "city": 'New York',
//         "bio": 'I love codes!',
//         "educationLevel": 'None',
//       };

//       // Send the request using makeApiRequest
//       final response = await makeApiRequest(
//         url,
//         method,
//         headers,
//         authProvider,
//         body: body,
//       );

//       // Check for successful response
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         developer.log('Profile created successfully: ${response.body}');
//       } else {
//         throw Exception(
//             'Failed to create profile. Status code: ${response.statusCode}, Response: ${response.body}');
//       }
//     } catch (e) {
//       developer.log('Error creating profile: $e');
//     }
//   }
// }
