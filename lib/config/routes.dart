import 'package:flutter/material.dart';
import 'package:love_bird/chat/main_chat.dart';
import 'package:love_bird/chat/story_viewer.dart';
import 'package:love_bird/chat/story_viewer2.dart';
import 'package:love_bird/chatBot/chatbot_screen.dart';

import 'package:love_bird/chatBot/chatbot_welcome.dart';
import 'package:love_bird/chatBott/lib/main_bot.dart';
import 'package:love_bird/createAccount/create_account1.dart';
import 'package:love_bird/createAccount/enable_location.dart';
import 'package:love_bird/createAccount/finding_people_nearby.dart';
import 'package:love_bird/createAccount/forgot/forgot.dart';
import 'package:love_bird/createAccount/forgot/newPassword.dart';
import 'package:love_bird/createAccount/forgot/otp.dart';
import 'package:love_bird/createAccount/interest.dart';
import 'package:love_bird/createAccount/distance_preference.dart';
import 'package:love_bird/createAccount/nickname.dart';
import 'package:love_bird/createAccount/choose_gender.dart';
import 'package:love_bird/createAccount/photoVerification/photo_verification_scan.dart';
import 'package:love_bird/createAccount/photoVerification/image_scanner.dart';
import 'package:love_bird/createAccount/photoVerification/photo_verification_one.dart';
import 'package:love_bird/createAccount/relationship.dart';
import 'package:love_bird/createAccount/upload_six_photo.dart';
import 'package:love_bird/createAccount/user_bio.dart';
import 'package:love_bird/createAccount/verify.dart';
import 'package:love_bird/homeScreen/dating_tips.dart';
import 'package:love_bird/homeScreen/homeScreen.dart';
import 'package:love_bird/homeScreen/notification.dart';
import 'package:love_bird/profile/users_profile.dart';
import 'package:love_bird/report/personalized_report.dart';
import 'package:love_bird/report/report.dart';
import 'package:love_bird/ip.dart';
import 'package:love_bird/matches/likes.dart';
import 'package:love_bird/matches/people_nearby.dart';
import 'package:love_bird/matches/profile_visits.dart';
import 'package:love_bird/matches/super_likes.dart';
import 'package:love_bird/onboarding/firstScreen.dart';
import 'package:love_bird/onboarding/slidable.dart';
import 'package:love_bird/payment/paypal.dart';
import 'package:love_bird/profile/profile.dart';
import 'package:love_bird/providers/ip_address.dart';
import 'package:love_bird/sign/login_page.dart';
import 'package:love_bird/sign/sign.dart';
import 'package:love_bird/createAccount/captcha.dart';

// Define route names as constants
const createAccountRoute = "/createAccount";
const verifyEmailRoute = "/verifyEmail";
const signUpRoute = "/signUp";
const firstScreen = "/firstScreen";
const slideableOnboardingScreen = "/slideableOnboardingScreen";
const loginPage = "/loginPage";
const homeScreen = "/homeScreen";
const forgotPassword = "/ForgotPassword";
const oTPVerificationPage = "/oTPVerificationPage";
const newPassword = "/newPassword";
const captchaVerificationPage = "/captchaVerificationPage";
const createNickname = "/createNickname";
const celebrateYouScreen = '/celebrateYouScreen';
const gender = "/gender";
const relationshipGoalsScreen = "/relationshipGoalsScreen";
const distancePreferenceScreen = "/distancePreferenceScreen";
const interestsSelectionScreen = "/interestsSelectionScreen";
const findingPeople = "/findingPeople";
const uploadPicturesScreen = "/uploadPicturesScreen";
const photoVerificationOne = "/PhotoVerificationOne";
const chatbotWelcomeScreen = "/chatbotWelcomeScreen";
const gestureVerificationScreen = "/gestureVerificationScreen";
const photoScreen3 = "/photoScreen3";
const imageScanner = "/imageScanner";
const enableLocationScreen = "/enableLocationScreen";
const findingPeopleNearBy = "/findingPeopleNearBy";
const userBio = "/userBio";
const notificationsPage = "/notificationsPage";
const mainchat = "/mainchat";
const peopleNearbyPage = "/PeopleNearbyPage";
const likes = "/likes";
const profilevisits = "/profilevisits";
const profile = "/profile";
const superLikes = "/superLikes";
const ipAddressScreen = "/ipAddressScreen";
const payPal = "/payPal";
const reportPage = "/reportPage";
const datingPicture = "/datingPicture";
const personalizedReport = "/personalizedReport";
const geminiBot = "/geminiBot";
const storyPage = "/storyPage";
const storyExamplePage = "/storyExamplePage";
const userProfilePage = "/userProfilePage";
const chatBotScreen = "/chatBotScreen";

// Map each route to the respective widget
final routes = <String, Widget Function(BuildContext)>{
  createAccountRoute: (_) => const CreateAcc1(),
  verifyEmailRoute: (_) => const EmailVerificationPage(),
  signUpRoute: (_) => const SignUpScreen(),
  firstScreen: (_) => const FirstScreen(),
  slideableOnboardingScreen: (_) => const SlideableOnboardingScreen(),
  loginPage: (_) => const LoginPage(),
  homeScreen: (_) => const HomeScreen(),
  forgotPassword: (_) => const ForgotPassword(),
  oTPVerificationPage: (_) => const OTPVerificationPage(),
  newPassword: (_) => const NewPassword(),
  captchaVerificationPage: (_) => const Captcha(),
  createNickname: (_) => const CreateNickname(),
  celebrateYouScreen: (_) => const CelebrateYouScreen(),
  gender: (_) => const Gender(),
  relationshipGoalsScreen: (_) => const RelationshipGoalsScreen(),
  distancePreferenceScreen: (_) => const DistancePreferenceScreen(),
  interestsSelectionScreen: (_) => const InterestsSelectionScreen(),
  uploadPicturesScreen: (_) => const UploadPicturesScreen(),
  photoVerificationOne: (_) => const PhotoVerificationOne(),
  chatbotWelcomeScreen: (_) => const ChatbotWelcomeScreen(),
  gestureVerificationScreen: (_) => const GestureVerificationScreen(),
  photoScreen3: (_) => const PhotoScreen3(),
  imageScanner: (_) => const ImageScanner(),
  enableLocationScreen: (_) => const EnableLocationScreen(),
  findingPeopleNearBy: (_) => const FindingPeopleNearBy(),
  userBio: (_) => const UserBio(),
  notificationsPage: (_) => const NotificationsPage(),
  mainchat: (_) => const Mainchat(),
  peopleNearbyPage: (_) => const PeopleNearbyPage(),
  likes: (_) => const Likes(),
  profilevisits: (_) => const Profilevisits(),
  profile: (_) => const ProfilePage(),
  superLikes: (_) => const SuperLikes(),
  ipAddressScreen: (_) => IpAddressScreen(provider: IpAddressProvider()),
  payPal: (_) => const Paypal(),
  reportPage: (_) => const ReportPage(),
  datingPicture: (_) => const DatingPicture(),
  personalizedReport: (_) => const PersonalizedReport(),
  geminiBot: (_) => const GeminiBot(),
  storyPage: (_) => const StoryPage(),
  storyExamplePage: (_) => const StoryExamplePage(),
  userProfilePage: (_) => const UserProfilePage(),
  chatBotScreen: (_) => const ChatBotScreen(),
};
