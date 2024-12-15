import 'package:flutter/material.dart';
import 'package:love_bird/chatBot/chatbot_config_provider.dart';
import 'package:love_bird/chatBot/font_size_provider.dart';

import 'package:love_bird/config/routes.dart';
import 'package:love_bird/config/theme.dart';
import 'package:love_bird/providers/birthday_provider.dart';
import 'package:love_bird/providers/chat_provider.dart';
import 'package:love_bird/providers/create_account_provider.dart';
import 'package:love_bird/providers/distance_preference_provider.dart';
import 'package:love_bird/providers/gender_provider.dart';
import 'package:love_bird/providers/image_provider.dart';
import 'package:love_bird/providers/interest_provider.dart';
import 'package:love_bird/providers/ip_address.dart';
import 'package:love_bird/providers/login_provider.dart';
import 'package:love_bird/providers/nickname_provider.dart';
import 'package:love_bird/providers/otp_provider.dart';
import 'package:love_bird/providers/relationship_goal_provider.dart';
import 'package:love_bird/providers/resend_provider.dart';
import 'package:love_bird/providers/theme_provider.dart';
import 'package:love_bird/providers/user_bio_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CreateAccountProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => UserBioProvider()),
        ChangeNotifierProvider(create: (_) => ChatBotConfigProvider()),
        ChangeNotifierProvider(create: (_) => FontSizeProvider()),
        ChangeNotifierProvider(create: (_) => NicknameProvider()),
        ChangeNotifierProvider(create: (_) => CelebrateYouProvider()),
        ChangeNotifierProvider(create: (_) => GenderProvider()),
        ChangeNotifierProvider(create: (_) => GoalProvider()),
        ChangeNotifierProvider(create: (_) => DistanceProvider()),
        ChangeNotifierProvider(create: (_) => InterestsProvider()),
        ChangeNotifierProvider(create: (_) => ImageProviderModel()),
        ChangeNotifierProvider(create: (_) => Chatprovider()),
        ChangeNotifierProvider(create: (_) => OtpVerificationProvider()),
        ChangeNotifierProvider(create: (_) => ResendProvider()),
        ChangeNotifierProvider(create: (_) => IpAddressProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

//qwewe@gmail.com  123qweQWE@
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FontSizeProvider>(context, listen: false).updateFontSize(20);
    });
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zenkonect',
      initialRoute: createNickname,
      routes: routes,
      // themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.themeMode,
      // theme: ThemeData(
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
      // ),
      // darkTheme: ThemeData(
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
      // ),

      //123qweQWE%,
    );
  }
}
