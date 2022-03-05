import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/screens/about_us.dart';
import 'package:flutter_application/screens/test.dart';
import 'screens/add_new_model.dart';
import 'screens/change_pass_screen.dart';
import 'screens/forget_pass_screen.dart';
import 'screens/model_library.dart';
import 'screens/my_models.dart';
import 'screens/register_screen.dart';
import 'screens/result_hist_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/landing_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: GoogleFonts.promptTextTheme(),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      home: const LandingScreen(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/login': (ctx) => const LoginScreen(),
        '/reg': (ctx) => const RegisterScreen(),
        '/forget': (ctx) => const ForgetPassScreen(),
        '/home': (ctx) => const HomeScreen(),
        '/changepass': (ctx) => const ChangePassScreen(),
        '/resulthist': (ctx) => const ResultHistScreen(),
        '/addnewmod': (ctx) => const AddNewModelScreen(),
        '/mymodels': (ctx) => const MyModelsScreen(),
        '/modellib': (ctx) => const ModelLibraryScreen(),
        '/test': (ctx) => const TestScreen(),
        '/aboutus': (ctx) => const AboutUsScreen(),
      },
    );
  }
}
