import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/layout/home_layout.dart';
import 'package:untitled/modules/signup_screen/privacy.dart';
import 'package:untitled/utlis/themes.dart';
import 'modules/scan_screen/scan_screen.dart';
import 'modules/signup_screen/compontens/signup_form.dart';
import 'modules/signup_screen/signup_screen.dart';
import 'modules/welcome_screen/welcome_screen.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
initialRoute: FirebaseAuth.instance.currentUser==null?'Welcome':'HomeLayout' ,
      routes: {
        'Welcome' : (context) => const WelcomeScreen(),
        'HomeLayout' : (context) =>  HomePage(),
        'Scan' : (context) => const ScanScreen(),
        'Privacy': (context) => const Privacy(),
        'Sign up' : (context) =>  SignUpScreen()
      }
      ,
    );
  }
}
