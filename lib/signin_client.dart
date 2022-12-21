import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:GHASLAH/modules/home_screen/home_screen.dart';
import 'package:GHASLAH/shared/colors.dart';
import '../../shared/compoents/components.dart';
import 'modules/signup_screen/signup_screen.dart';

class LoginScreen_client extends StatelessWidget {
  LoginScreen_client({Key? key}) : super(key: key);


  final _auth = FirebaseAuth.instance;
  /*late String email;
  late String password;*/
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
                          label: 'Enter Your Email',
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
                      ),
                      defaultTextButton(
                          function: () {
                            FirebaseFirestore.instance.collection('Users').get().then((value) {
                             for (var element in value.docs) {
                               if(element.get('typeUser')=='Client'&&
                                   element.get('email')==loginController.text){
                                 FirebaseAuth.instance.signInWithEmailAndPassword(
                                     email: loginController.text,
                                     password: passwordController.text).then((value) {
                                   Navigator.pushNamed(context, 'HomeLayout');
                                 });
                               }
                             }
                            });

                            /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  HomeScreen()));*/
                          },
                          background: defaultColor,
                          text: "Login",
                          backgroundText: Colors.white),
                      const SizedBox(
                        height: 35.0,
                      ),
                      defaultTextButton(
                        function: () {Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>   const SignUpScreen()));},
                        background: defaultColor,
                        text: "Sign Up",
                        backgroundText: Colors.white,
                      )
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
