import 'package:barcode_widget/barcode_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:untitled/modules/scan_screen/afterscan_screen.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  String typeAccount='Client';
  var qrStar = "let's Scan it";
  String userName='name';
  double price = 0 ;
  int points = 0;
  getUserDate(){
    FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid)
        .get().then((value){
          setState(() {
            typeAccount=value.get('typeUser');
            userName = value.get('name');
            points = value.get('point');
            price = points *0.4 ;
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
    Future <void>scanQr()async{
      try{
        FlutterBarcodeScanner.scanBarcode('#2A99CF', 'cancel', true, ScanMode.QR).then((value){
          setState(() {
            qrStar=value;
          });
          FirebaseFirestore.instance.collection('Users')
              .get().then((valu){
            for (var element in valu.docs) {
              if(element.id==qrStar){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AfterScan(userId: qrStar,)));
              }
            }});
        });
      }catch(e){
        setState(() {
          qrStar='unable to read this';
        });
      }
    }
    return Scaffold(
      appBar: AppBar(
        leading:  Container(),
        title: Row(
          children: [
             Text("${price.toStringAsFixed(2)}"),
            const SizedBox(
              width: 15.0,
            ),
            Icon(
              Icons.mode_standby,
              size: 35,
              color: HexColor('#d2a049'),
            ),
            const SizedBox(
              width: 110.0,
            ),
            Text(userName),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45.0,
                    width: double.maxFinite,
                    color: HexColor('#1d3666'),
                    child: const Center(
                      child: Text(
                        "         Scan",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 250.0,
              height: 400.0,
              child: Image.asset(
                'assets/images/w5.jpeg',
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            (typeAccount=='Client')?
            Container(
              alignment: Alignment.topCenter,
              //height: 200.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: HexColor('#f7f7f7')),
              height: 600,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: 300.0,
                  height: 550.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text(
                          "Scan to Collect Points",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(15.0),
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue)),
                          child: const Text(
                            'Collect 4 points per 10 SAR',
                            style: TextStyle(fontSize: 11.0),
                          ),
                        ),
                        BarcodeWidget(
                          data:FirebaseAuth.instance.currentUser!.uid,
                          barcode: Barcode.qrCode(),
                          color: Colors.black,
                          height: 170,
                          width: 170,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ):
            Center(
               child: ElevatedButton(
                   onPressed: scanQr, child:
               const Text(('Scanner'))),

            ),
          ],
        ),
      ),
    );
  }
}
