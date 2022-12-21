import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:GHASLAH/modules/signup_screen/privacy.dart';

import '../../../shared/colors.dart';
import '../../../shared/compoents/components.dart';
import '../../../signin_client.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool checkboxValue = false;
  TextEditingController otpController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool otpVisibility = false;
  String verificationID = "";
  String phone = 'phone';
  bool isVerified = false;

  final _auth = FirebaseAuth.instance;

  late String email;

  late String password;

  var phoneController = TextEditingController();

  var passwordController = TextEditingController();

  var emailController = TextEditingController();

  var NameController = TextEditingController();

  TextEditingController dateCtl = TextEditingController();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: NameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "title must not be empty";
                }
                return null;
              },
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Name",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Your Car type",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.car_crash),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onChanged: (value) {
                email = value;
              },
              onSaved: (email) {},
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "title must not be empty";
                }
                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Your email",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              controller: passwordController,
              onChanged: (value) {
                password = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "title must not be empty";
                }
                return null;
              },
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: dateCtl,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Date of birth",
                hintText: "Ex. Insert your dob",
              ),
              onTap: () async {
                DateTime? date = DateTime(1900);
                FocusScope.of(context).requestFocus(FocusNode());

                date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100));

                dateCtl.text = date!.toIso8601String();
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: phoneController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "title must not be empty";
                }
                return null;
              },
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.phone,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Your Phone",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.phone),
                ),
              ),
            ),
            Visibility(
              visible: otpVisibility,
              child: TextField(
                controller: otpController,
                decoration: InputDecoration(),
                keyboardType: TextInputType.phone,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                      print(value);
                    });
                  },
                ),
                const Text("I agree "),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'Privacy');
                    },
                    child: const Text('Privacy')),
              ],
            ),
            const SizedBox(height: defaultPadding / 2),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ElevatedButton(
                    onPressed: () {
                      if (otpVisibility) {
                        verifyOTP();
                        try {
                          print(email);
                          setState(() {
                            isLoading = true;
                          });
                          _auth
                              .createUserWithEmailAndPassword(
                                  email: email, password: password)
                              .then((value) {
                            FirebaseFirestore.instance
                                .collection('Users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .set({
                              'email': email,
                              'carType': 'Car',
                              'name': NameController.text,
                              'phone': phoneController.text,
                              'password': passwordController.text,
                              'point': 0,
                              'listPoint': [],
                              'id': FirebaseAuth.instance.currentUser!.uid,
                              'typeUser': 'Client',
                            }).then((value) {
                              Navigator.pushNamed(context, 'HomeLayout');
                            });
                          });
                        } catch (e) {
                          print(e);
                        } finally {
                          setState(() {
                            isLoading = false;
                          });
                        }
                        if (_formKey.currentState!.validate() && !isChecked) {}
                      } else {
                        loginWithPhone();
                      }
                    },
                    child: Text(otpVisibility ? "Verify" : "Login"),
                  ),
            const SizedBox(height: defaultPadding),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen_client();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void loginWithPhone() async {
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneController.text,
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
