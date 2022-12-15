
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:untitled/modules/welcome_screen/welcome_screen.dart';
import 'package:untitled/shared/compoents/components.dart';

class ManagerScreen extends StatefulWidget {
  const ManagerScreen({Key? key}) : super(key: key);

  @override
  _ManagerScreenState createState() => _ManagerScreenState();
}

class _ManagerScreenState extends State<ManagerScreen> {
  double point = 0.4;
  var pointController = TextEditingController();
  var msgController = TextEditingController();
  var titleController = TextEditingController();
  DateTime? dateTo;
  DateTime? dateForm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        backgroundColor: HexColor('#1d3666'),
        foregroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: const Text('Manager'),
        actions: [
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const Text("Number : 0.4",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              pointController.text.isEmpty?Container(): Text(pointController.text,
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
                label: 'Number',
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
                          onPressed: () async{
                             await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100)).then((value){
                                  if(value!=null){
                                    setState(() {
                                      dateForm=value;
                                    });
                                  }

                             });
                          },
                          child: const Text(('Form'))),
                    ),
                  ),
                  dateForm==null?Container():
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () async{
                            await showDatePicker(
                                context: context,
                                initialDate: dateForm!.add(const Duration(days: 1)),
                                firstDate: dateForm!.add(const Duration(days: 1)),
                                lastDate: DateTime(2100)).then((value){
                              setState(() {
                                dateTo =value;
                              });
                            });

                          },
                          child: const Text(('To'))),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              dateForm==null?Container():Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                    child:  Text("Form : ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)),
                  ),
                  dateForm==null?Container():
                  Expanded(
                    child:  Text('$dateForm',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              dateTo==null?Container():Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                    child:  Text("To : ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)),
                  ),
                  dateTo==null?Container():
                  Expanded(
                    child:  Text('$dateTo',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    if(pointController.text.isNotEmpty&&dateForm!=null && dateTo!=null){
                      FirebaseFirestore.instance.collection('Point').doc('MVtK6JdpjkQNo2zdoN8e').update({
                        'To':dateTo,
                        'Form':dateForm,
                        'Point':double.parse(pointController.text),
                      });
                    }
                  },
                  child: const Text(('Submit'))),
              const Divider(height: 10,color: Colors.black,),
              defaultTextInput(
                controller_: titleController,
                type: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "point must not be empty";
                  }
                  return null;
                },
                label: 'Title',
                prefix: Icons.password_outlined,
              ),
              const SizedBox(
                height: 10,
              ),
              defaultTextInput(
                mixLine: 10,
                controller_: msgController,
                type: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "point must not be empty";
                  }
                  return null;
                },
                label: 'Massage',
                prefix: Icons.password_outlined,
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    if(msgController.text.isNotEmpty){
                      FirebaseFirestore.instance.collection('Massage').add({
                        'Msg':msgController.text,
                        'Title':titleController.text,
                      });
                    }
                  },
                  child: const Text(('Submit'))),



            ],
          ),
        ),
      ),

    );
  }
}
