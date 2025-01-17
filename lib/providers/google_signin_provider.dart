// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:google_sign_in/google_sign_in.dart';
// import 'dart:developer' as developer;

// final GoogleSignIn _googleSignIn = GoogleSignIn();

// Future<void> handleGoogleSignIn() async {
//   try {
//     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//     if (googleUser != null) {
//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       final idToken = googleAuth.idToken;

//       //To  Send idToken to backend
//       if (idToken != null) {
//         await sendTokenToBackend(idToken);
//       }
//     }
//   } catch (error) {
//     developer.log('Error signing in: $error', name: 'UserAction');
//   }
// }

// Future<void> sendTokenToBackend(String idToken) async {
//   final response = await http.post(
//     Uri.parse('http://138.68.150.48:7001/auth/google-sso'),
//     headers: {'Content-Type': 'application/json'},
//     body: jsonEncode({'token': idToken, 'secret': 'optional_secret'}),
//   );

//   if (response.statusCode == 200) {
//     developer.log('Successfully authenticated with backend',
//         name: 'UserAction');
//   } else {
//     developer.log('Failed to authenticate: ${response.body}',
//         name: 'UserAction');
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer' as developer;

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email', 'profile'],
);

Future<void> handleGoogleSignIn() async {
  try {
    // Sign in with Google
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser != null) {
      developer.log('User signed in: ${googleUser.email}', name: 'UserAction');

      // Get authentication details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final idToken = googleAuth.idToken;

      // Send idToken to the backend
      if (idToken != null) {
        await sendTokenToBackend(idToken);
      } else {
        developer.log('Failed to retrieve idToken', name: 'UserAction');
      }
    } else {
      developer.log('User canceled the sign-in process', name: 'UserAction');
    }
  } catch (error) {
    developer.log('Error during Google Sign-In: $error', name: 'UserAction');
  }
}

Future<void> sendTokenToBackend(String idToken) async {
  try {
    // Replace with your backend's actual URL
    final response = await http.post(
      Uri.parse('https://localhost/auth/google-sso'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': idToken}),
    );

    if (response.statusCode == 200) {
      developer.log('Successfully authenticated with backend',
          name: 'UserAction');
    } else {
      developer.log('Failed to authenticate with backend: ${response.body}',
          name: 'UserAction');
    }
  } catch (error) {
    developer.log('Error communicating with backend: $error',
        name: 'UserAction');
  }
}

// class GoogleSignInApi {
//   static final _googleSignIn = GoogleSignIn();

//   static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
// }
