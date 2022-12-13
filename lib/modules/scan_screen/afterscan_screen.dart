import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/shared/compoents/components.dart';

class AfterScan extends StatefulWidget {
  final String userId;
  const AfterScan({Key? key, required this.userId}) : super(key: key);

  @override
  _AfterScanState createState() => _AfterScanState();
}

class _AfterScanState extends State<AfterScan> {
  double numberPoint=0.4;
  int point = 0;
  List pointList = [];
  var pointController = TextEditingController();
  TextEditingController phoneController =
      TextEditingController(text: "enter num");
  TextEditingController otpController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool otpVisibility = false;
  String verificationID = "";
  String phone = 'phone';
  bool isVerified = false ;


  getUserDate() {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.userId)
        .get()
        .then((value) {
      setState(() {
        point = value.get('point');
        //pointList = value.get('listPoint');
        phone = value.get('phone');
      });
    });
  }
  getNumberPoint(){
    // 13 -- 15  14
    FirebaseFirestore.instance.collection('Point').doc('MVtK6JdpjkQNo2zdoN8e').get().then((value){
      if(DateTime.now().compareTo(value.get('Form'))>0 &&DateTime.now().compareTo(value.get('To'))<0){
        setState(() {
          numberPoint=value.get('Point');
        });
      }
    });
  }


  @override
  void initState() {
    super.initState();
    getUserDate();
    getNumberPoint();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Point'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Point",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 10,
            ),
            Text("$point",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 10,
            ),
            defaultTextInput(
              controller_: pointController,
              type: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "point must not be empty";
                }
                return null;
              },
              label: ':Price',
              prefix: Icons.password_outlined,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          //5 =>> 40*0.4 --- 10+5=15 end

                          double totalPoints =
                              (point + ((int.parse(pointController.text))*numberPoint));//con *0.4
                          FirebaseFirestore.instance
                              .collection('Users')
                              .doc(widget.userId)
                              .update({
                            'point': totalPoints,
                            'listPoint':FieldValue.arrayUnion([{
                              'points':pointController.text,
                              'price':pointController.text,
                              'time':Timestamp.now(),
                            }])
                              }).then((value) {
                            setState(() {
                              point = totalPoints.toInt();
                            });
                          });
                        },
                        child: const Text(('increase'))),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          loginWithPhone();
                          if (isVerified){
                            // 10 =>>> 5*4 =20<=10? true:false
                            if(point>=((int.parse(pointController.text))*4)){
    int totalPoints =
    (point - (int.parse(pointController.text)));
    if (point <= int.parse(pointController.text)) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.userId)
        .update({'point': totalPoints}).then((value) {
    //Navigator.pop(context);
    setState(() {
    point = totalPoints.toInt();
    });
    });
    } else {
    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
    content: Text('this point less to ')));
    }
    }else{
    return;
    }
                            }



                          },
                        child: const Text(('minus'))),
                  ),
                ),
              ],
            ),
/*            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: phone),
              keyboardType: TextInputType.phone,
            ),*/
            Visibility(
              visible: otpVisibility,
              child: TextField(
                controller: otpController,
                decoration: const InputDecoration(),
                keyboardType: TextInputType.phone,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  if (otpVisibility) {
                    verifyOTP();
                  } else {
                    loginWithPhone();
                  }
                },
                child: Text(otpVisibility ? "Verify" : "Login")),
          ],
        ),
      ),
    );
  }

  void loginWithPhone() async {
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) {
          print("You are logged in successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then((value) {
      print("You are logged in successfully");
      setState(() {
        isVerified = true;
      });
      Fluttertoast.showToast(
          msg: "You are logged in successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }
}
