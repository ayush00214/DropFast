import 'pages/Signup_page.dart';
import 'pages/splash_screen.dart';
import 'pages/storage_screen.dart';
import 'pages/welcome_screen.dart';
import 'pages/home_screen.dart';
import 'pages/upload_screen.dart';
import 'pages/login_page.dart';
import 'pages/SettingsScreen.dart';
import 'pages/Profile_Screen.dart';
import 'pages/my_qr_screen.dart';
import 'pages/about_screen.dart';
import 'pages/upload_success_screen.dart';
import 'pages/QRScanner.dart';

class AppRoute{
  AppRoute._();
  static const String initialpage = '/';
  static const String welcomepage = '/welcome';
  static const String loginpage = '/login';
  static const String signuppage = '/signup';
  static const String homepage = '/home';
  static const String uploadpage = '/upload';
  static const String storagepage = '/storage';
  static const String settingspage = '/settings';
  static const String profilepage = '/profile';
  static const String myqrpage = '/myqr';
  static const String aboutpage = '/about';
  static const String uploadsuccesspage = '/uploadsuccess';
  static const String qrscannerpage = '/qrscanner';

  static getAppRoutes()=>{
        initialpage : (context) => const SplashScreen(),
        welcomepage : (context) => const WelcomeScreen(),
        loginpage : (context) => const LoginScreen(),
        signuppage : (context) => const SignupScreen(),
        homepage : (context) => const HomeScreen(),
        uploadpage : (context) => const UploadScreen(),
        storagepage : (context) => const StorageScreen(),
        settingspage : (context) => const SettingsScreen(),
        profilepage : (context) => const ProfileScreen(),
        myqrpage : (context) => const MyQrScreen(),
        aboutpage : (context) => const AboutScreen(),
        uploadsuccesspage : (context) => const UploadSuccessScreen(),
        qrscannerpage : (context) => const QRViewExample(),
  };
}