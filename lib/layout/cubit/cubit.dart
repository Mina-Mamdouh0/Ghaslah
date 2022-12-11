import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled/layout/cubit/states.dart';
import 'package:untitled/modules/scan_screen/scan_screen.dart';
import 'package:untitled/modules/store_screen/store_screen.dart';

import '../../modules/home_screen/home_screen.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit(): super(AppInitialState()) ;
  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0 ;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    const BottomNavigationBarItem(icon: Icon(Icons.document_scanner_outlined), label: "Scan"),
    const BottomNavigationBarItem(icon: Icon(Icons.store), label: "Store"),

  ];
  List<Widget> screens = [ HomeScreen() ,  ScanScreen(),  StoreScreen()];

  void BottomNav (int index){
    currentIndex =  index;
    if (index == 1) const ScanScreen();
    if (index == 2)   StoreScreen();
    emit(ChangeBottomNav());
  }
  final _auth = FirebaseAuth.instance;
  late User signedInUser;



  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }


}