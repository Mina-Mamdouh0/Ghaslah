import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:GHASLAH/bloc/app_cubit.dart';
import 'package:GHASLAH/layout/home_layout.dart';
import 'package:GHASLAH/modules/signup_screen/privacy.dart';
import 'package:GHASLAH/utlis/themes.dart';
import 'modules/scan_screen/scan_screen.dart';
import 'modules/scan_screen/scan_staff.dart';
import 'modules/signup_screen/compontens/signup_form.dart';
import 'modules/signup_screen/signup_screen.dart';
import 'modules/welcome_screen/welcome_screen.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
  await Firebase.initializeApp();
  runApp(BlocProvider(
    create: (BuildContext context) => AppCubit(),
  child: const MyApp(),));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  String? typeAccount  ;

  var qrStar = "let's Scan it";

  String userName='name';

  double price = 0.0 ;

  double points = 0;

  getUserDate(){
    if(FirebaseAuth.instance.currentUser!= null){
      FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid)
          .get().then((value){
        setState(() {
          typeAccount=value.get('typeUser');

        });
        print('test method');
        print(typeAccount=='staff');
        print(FirebaseAuth.instance.currentUser!.uid);
      });
    }

  }  @override

  initState(){
    super.initState();
    getUserDate();

  }

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GHASLAH',
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
/*initialRoute: (FirebaseAuth.instance.currentUser==null)?'Welcome' :
(typeAccount=='staff')?'scan staff':'HomeLayout' ,*/
      home: (FirebaseAuth.instance.currentUser==null)?WelcomeScreen() :
      (typeAccount=='staff')?ScanStaffScreen():HomePage() ,
      routes: {
        'Welcome' : (context) => const WelcomeScreen(),
        'HomeLayout' : (context) =>  HomePage(),
        'Scan' : (context) => const ScanScreen(),
        'Privacy': (context) => const Privacy(),
        'Sign up' : (context) =>  const SignUpScreen(),
        'scan staff' : (context) => ScanStaffScreen()
      }
      ,
    );
  }
}
