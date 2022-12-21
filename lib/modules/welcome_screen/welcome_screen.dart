import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:GHASLAH/shared/colors.dart';

import '../../shared/compoents/components.dart';
import '../../signin_client.dart';
import '../login_screen/login_screen.dart';
import '../signup_screen/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('#1d3666') ,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      "Welcome \n مرحبا",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 28,
                          color: defaultColor),
                    ),
                    const SizedBox(
                      height: 35.0,
                    ),
                    Image.asset(
                      "assets/images/w4.jpeg",
                      width: 280,
                      height: 400,
                    ),
                    const SizedBox(
                      height: 3.0,
                    ),
                    defaultTextButton(
                        function: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        background: HexColor("#d0c7dc"),
                        text: "Staff",
                        backgroundText: Colors.black),
                    const SizedBox(
                      height: 15.0,
                    ),
                    defaultTextButton(
                      function: () {Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>   LoginScreen_client()));},
                      background: HexColor("#d0c7dc"),
                      text: "Client",
                      backgroundText: Colors.black,
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
                left: 0,
                child: Image.asset(
                  "assets/images/main_bottom.png",
                  width: 75.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
