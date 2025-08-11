import 'package:calley_app/features/auth/screen/login_screen.dart';
import 'package:calley_app/features/auth/screen/otp_verification_screen.dart';
import 'package:calley_app/features/auth/screen/signup_screen.dart';
import 'package:calley_app/features/home/about_us_screen.dart';
import 'package:calley_app/features/home/calley_screen.dart';
import 'package:calley_app/features/home/dashboard_screen.dart';
import 'package:calley_app/features/home/home_screen.dart';
import 'package:calley_app/features/lang_selection/screen/language_selection_screen.dart';
import 'package:calley_app/route/route_name.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class RoutePage{
  static final page = [
    GetPage(name: RouteName.language_selection, page: () => LanguageSelectionScreen(),transition: Transition.leftToRight),
    GetPage(name: RouteName.login, page: () => LoginScreen(),transition: Transition.leftToRight),
    GetPage(name: RouteName.signup, page: () => SignupScreen(),transition: Transition.leftToRight),
    GetPage(name: RouteName.otp_verification, page: () => OtpVerificationScreen(),transition: Transition.leftToRight),
    GetPage(name: RouteName.calley, page: () => CalleyUI(),transition: Transition.leftToRight),
    GetPage(name: RouteName.home, page: () => HomeScreen(),transition: Transition.leftToRight),
    GetPage(name: RouteName.dashboard, page: () => DashboardScreen(),transition: Transition.leftToRight),
    GetPage(name: RouteName.about_us, page: () => AboutUsPage(),transition: Transition.leftToRight),
  ];
}