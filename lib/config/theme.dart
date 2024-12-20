// import 'package:flutter/material.dart';
// import 'package:love_bird/config/constants.dart';

// ThemeData lightTheme = ThemeData(
//   primaryColor: Colors.white,
//   scaffoldBackgroundColor: Colors.white,
//   appBarTheme: const AppBarTheme(
//     backgroundColor: Colors.white,
//     iconTheme: IconThemeData(color: Colors.black),
//     titleTextStyle: TextStyle(
//       color: Colors.black,
//     ),
//   ),
//   textTheme: const TextTheme(
//     bodyMedium: TextStyle(color: Colors.black),
//   ),
//   colorScheme: ColorScheme.fromSwatch().copyWith(
//     secondary: blue,
//     brightness: Brightness.light,
//   ),
// );

// ThemeData darkTheme = ThemeData(
//   primaryColor: Colors.black,
//   scaffoldBackgroundColor: Colors.black,
//   appBarTheme: const AppBarTheme(
//     backgroundColor: Colors.black,
//     iconTheme: IconThemeData(color: Colors.white),
//     titleTextStyle: TextStyle(
//       color: Colors.white,
//     ),
//   ),
//   textTheme: const TextTheme(
//     bodyMedium: TextStyle(color: Colors.white),
//   ),
//   colorScheme: ColorScheme.fromSwatch().copyWith(
//     secondary: blue,
//     brightness: Brightness.dark,
//   ),
//   bottomSheetTheme: const BottomSheetThemeData(
//     backgroundColor: Colors.black, // Modal sheet background color
//     modalBackgroundColor: Colors.black, // Dark background for modal sheets
//     elevation: 10, // Optional, to give the modal some shadow
//   ),
// );


// // After the routes on the main.dart
// // themeMode: ThemeMode.system, 
// // theme: lightTheme, 
// // darkTheme: darkTheme,

// // import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart'; // For saving user preferences

// // class ThemeProvider extends ChangeNotifier {
// //   ThemeMode _themeMode = ThemeMode.system;

// //   ThemeMode get themeMode => _themeMode;

// //   ThemeProvider() {
// //     _loadThemePreference();
// //   }

// //   // Toggle between light and dark themes
// //   void toggleTheme() async {
// //     _themeMode =
// //         _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
// //     notifyListeners();
// //     _saveThemePreference();
// //   }

// //   // Save user's theme preference
// //   Future<void> _saveThemePreference() async {
// //     final prefs = await SharedPreferences.getInstance();
// //     prefs.setString('themeMode', _themeMode == ThemeMode.light ? 'light' : 'dark');
// //   }

// //   // Load the saved theme preference or default to system theme
// //   Future<void> _loadThemePreference() async {
// //     final prefs = await SharedPreferences.getInstance();
// //     final theme = prefs.getString('themeMode') ?? 'system';
// //     if (theme == 'light') {
// //       _themeMode = ThemeMode.light;
// //     } else if (theme == 'dark') {
// //       _themeMode = ThemeMode.dark;
// //     } else {
// //       _themeMode = ThemeMode.system;
// //     }
// //     notifyListeners();
// //   }
// // }

// // ThemeData lightTheme = ThemeData(
// //   primaryColor: Colors.white,
// //   scaffoldBackgroundColor: Colors.white,
// //   appBarTheme: const AppBarTheme(
// //     backgroundColor: Colors.white,
// //     iconTheme: IconThemeData(color: Colors.black),
// //     titleTextStyle: TextStyle(
// //       color: Colors.black,
// //     ),
// //   ),
// //   textTheme: const TextTheme(
// //     bodyMedium: TextStyle(color: Colors.black),
// //   ),
// //   colorScheme: ColorScheme.fromSwatch().copyWith(
// //     secondary: blue,
// //     brightness: Brightness.light,
// //   ),
// // );

// // ThemeData darkTheme = ThemeData(
// //   primaryColor: Colors.black,
// //   scaffoldBackgroundColor: Colors.black,
// //   appBarTheme: const AppBarTheme(
// //     backgroundColor: Colors.black,
// //     iconTheme: IconThemeData(color: Colors.white),
// //     titleTextStyle: TextStyle(
// //       color: Colors.white,
// //     ),
// //   ),
// //   textTheme: const TextTheme(
// //     bodyMedium: TextStyle(color: Colors.white),
// //   ),
// //   colorScheme: ColorScheme.fromSwatch().copyWith(
// //     secondary: blue,
// //     brightness: Brightness.dark,
// //   ),
// //   bottomSheetTheme: const BottomSheetThemeData(
// //     backgroundColor: Colors.black, // Modal sheet background color
// //     modalBackgroundColor: Colors.black, // Dark background for modal sheets
// //     elevation: 10, // Optional, to give the modal some shadow
// //   ),
// // );
