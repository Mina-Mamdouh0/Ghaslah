import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:untitled/modules/home_screen/home_screen.dart';
import 'package:untitled/modules/manager_screen.dart';
import '../../shared/colors.dart';
import '../../shared/compoents/components.dart';
import '../saller_module/saller_acreen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var loginController = TextEditingController();
  var passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        "   \t \t \t \t Login \n    تسجيل الدخول    ",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 28,
                            color: HexColor("#69319c")),
                      ),
                      const SizedBox(
                        height: 35.0,
                      ),
                  /*    SvgPicture.asset(
                        "assets/icons/login.svg",
                        width: 180,
                        height: 230,
                      ),*/
                      const SizedBox(
                        height: 35.0,
                      ),
                      defaultTextInput(
                          controller_: loginController,
                          type: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "title must not be empty";
                            }
                            return null ;
                          },
                          label: 'User Name',
                          prefix: Icons.login),
                  defaultTextInput(
                    controller_: passwordController,
                    type: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "title must not be empty";
                      }
                      return null ;
                    },
                    label: 'Password',
                    isPassword: true,
                    prefix: Icons.password_outlined,
                  ),
                      const SizedBox(
                        height: 35.0,
                      ),                      defaultTextButton(
                          function: () {
                            FirebaseFirestore.instance.collection('Users').get().then((value) {
                              for (var element in value.docs) {
                                if(element.get('typeUser')=='staff'&&
                                    element.get('email')==loginController.text){
                                  FirebaseAuth.instance.signInWithEmailAndPassword(
                                      email: loginController.text,
                                      password: passwordController.text).then((value) {
                                    Navigator.pushNamed(context, 'Scan');
                                  });
                                }
                              }
                            });
                            FirebaseFirestore.instance.collection('Users').get().then((value) {
                              for (var element in value.docs) {
                                if(element.get('typeUser')=='manager'&&
                                    element.get('email')==loginController.text){
                                  FirebaseAuth.instance.signInWithEmailAndPassword(
                                      email: loginController.text,
                                      password: passwordController.text).then((value) {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>ManagerScreen()));
                                  });
                                }
                              }
                            });
                            /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  HomeScreen()));*/
                           /* Navigator.pushNamed(context, 'HomeLayout');*/
                          },
                          background: defaultColor,
                          text: "Log in",
                          backgroundText: Colors.white),
                    ],
                  ),
                ),
                Positioned(
                    child: Image.asset(
                      "assets/images/main_top.png",
                      width: 140.0,
                    )),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset(
                      "assets/images/login_bottom.png",
                      width: 120.0,
                    ))
              ],
            )),
      ),
    );
  }
}
