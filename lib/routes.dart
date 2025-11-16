import 'package:drop_fast/pages/Signup_page.dart';
import 'pages/splash_screen.dart';
import 'pages/welcome_screen.dart';
import 'pages/home_screen.dart';
import 'pages/upload_screen.dart';
import 'pages/login_page.dart';
class AppRoute{
  AppRoute._();
  static const String initialpage = '/';
  static const String welcomepage = '/welcome';
  static const String loginpage = '/login';
  static const String signuppage = '/signup';
  static const String homepage = '/home';
  static const String uploadpage = '/upload';

  static getAppRoutes()=>{
        initialpage : (context) => const SplashScreen(),
        welcomepage : (context) => const WelcomeScreen(),
        loginpage : (context) => const LoginScreen(),
        signuppage : (context) => const SignupScreen(),
        homepage : (context) => const HomeScreen(),
        uploadpage : (context) => const UploadScreen(),
  };
}