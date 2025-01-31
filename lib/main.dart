import 'package:flutter/material.dart';
import 'package:love_bird/api/profile_api.dart';
// import 'package:love_bird/chat/chat_screen.dart';
import 'package:love_bird/chatBot/chatbot_config_provider.dart';
import 'package:love_bird/chatBot/font_size_provider.dart';
import 'package:love_bird/config/routes.dart';
import 'package:love_bird/providers/auth_provider.dart';
import 'package:love_bird/providers/birthday_provider.dart';
import 'package:love_bird/providers/likes_provider.dart';

import 'package:love_bird/providers/log_out_provider.dart';
import 'package:love_bird/providers/payment_provider.dart';
import 'package:love_bird/providers/profile_data_provider.dart';
import 'package:love_bird/providers/status_provider.dart';
import 'package:love_bird/providers/update_password_provider.dart';
import 'package:love_bird/providers/chat_provider.dart';
import 'package:love_bird/providers/create_account_provider.dart';
import 'package:love_bird/providers/distance_preference_provider.dart';
import 'package:love_bird/providers/forgot_password_provider.dart';
import 'package:love_bird/providers/gender_provider.dart';
import 'package:love_bird/providers/image_provider.dart';
import 'package:love_bird/providers/interest_provider.dart';
import 'package:love_bird/providers/ip_address.dart';
//import 'package:love_bird/providers/login_create_provider.dart';
import 'package:love_bird/providers/login_provider.dart';
import 'package:love_bird/providers/nickname_provider.dart';
import 'package:love_bird/providers/otp_provider.dart';
import 'package:love_bird/providers/relationship_goal_provider.dart';
import 'package:love_bird/providers/resend_provider.dart';
import 'package:love_bird/providers/theme_provider.dart';
import 'package:love_bird/providers/user_bio_provider.dart';
import 'package:love_bird/providers/visit_provider.dart';

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
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UpdatePasswordProvider()),
        ChangeNotifierProvider(create: (_) => RetrieveProvider()),
        ChangeNotifierProvider(create: (_) => LogOutProvider()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => VisitProvider()),
        ChangeNotifierProvider(create: (_) => ProfileDataProvider()),
        ChangeNotifierProvider(create: (_) => StatusProvider()),
        // ChangeNotifierProvider(create: (_) => LikeProvider()),
         ChangeNotifierProxyProvider<AuthProvider, LikeProvider>(
          create: (context) => LikeProvider(Provider.of<AuthProvider>(context, listen: false)),
          update: (context, authProvider, previous) => LikeProvider(authProvider),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

//123qweQWE@
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
      initialRoute: firstScreen,
      routes: routes,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.themeMode,
    );
  }
}
