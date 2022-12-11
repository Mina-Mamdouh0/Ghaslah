
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:untitled/modules/welcome_screen/welcome_screen.dart';


class HomeScreen extends StatefulWidget {
    HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String userName='Name';
  int point=0;
  List pointList=[];
  double price = 0 ;



  getUserDate(){
    FirebaseFirestore.instance.collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get().then((value){
      setState(() {
        point=value.get('point');
        userName=value.get('name');
        pointList=value.get('listPoint');
        price = point *0.4 ;
      });
    });
  }

  @override
  void initState() {

    super.initState();
    getUserDate();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: HexColor('#1d3666'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 35.0, horizontal: 20.0),
                      child: Text(
                        "Hello $userName",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.mail_sharp,
                              color: Colors.white,
                            )),
                        IconButton(
                          onPressed: () {

                          },
                          icon: const Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut().then((value){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const WelcomeScreen()));
                              });
                            },
                            icon: const Icon(
                              Icons.logout,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 120,
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "REWARDS Points",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: HexColor('#d2a049')),
                      ),
                      Row(
                        children: [
                           Text(
                            "${price..toStringAsExponential(3)}",
                            style: const TextStyle(fontSize: 50),
                          ),
                          Icon(
                            Icons.mode_standby,
                            size: 35,
                            color: HexColor('#d2a049'),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  //width: 200.0,
                  //height: 200.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: HexColor('#f7f7f7')),
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: pointList.isEmpty?
                    Container(
                      width: 400,
                      height: 390,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const Text(
                              "Make the most of GHASLAH",
                              style: TextStyle(fontSize: 18),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 45.0,
                                  child: Image.asset('assets/images/w1.png',
                                      width: 150, height: 200),
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Column(
                                  children: const [
                                    Text(
                                      "Collect Stars\n when ordering our service",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      softWrap: false,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "Collect 4 Stars per 10 SAR",
                                      style: TextStyle(color: Colors.grey),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      softWrap: false,
                                    )
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 45.0,
                                  child: Image.asset('assets/images/w2.png',
                                      width: 150, height: 200),
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Column(
                                  children: const [
                                    Text("Redeem Stars for free service",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "Every 250 Stars get you a free wish",
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 45.0,
                                  child: Image.asset('assets/images/w3.png',
                                      width: 150, height: 200),
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Column(
                                  children: const [
                                    Text("Get to Gold",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "750 Stars gets you to Gold level.\n Enjoy a free\n  service on your birthday ",
                                      style: TextStyle(color: Colors.grey),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      softWrap: false,
                                    )
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ):
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: pointList.length,
                      itemBuilder: (context,index){

                        return Container(
                          child: Column(
                            children: [
/*                              Row(
                                children: [
                                  const Text('Point : '),
                                  Text(pointList[index]['points']),
                                ],
                              ),*/
                              Row(
                                children: [
                                  const Text('Price : '),
                                  Text(pointList[index]['price']),
                                ],
                              ),
                              Row(

                                children: [
                                  const Text('Points : '),
                                  Text(
                                  "${price.toStringAsFixed(2)}",

                                ),],
                              ),
                              Row(
                                children: [
                                  const Text('Time : '),
                                  Text(DateFormat.yMMMd().format(pointList[index]['time'].toDate())),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),//Edit Container
                  ),
                )
              ],
            ),
          ),
        ),
      ),

    );

  }

}

