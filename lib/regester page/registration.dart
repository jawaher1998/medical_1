import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:medical_1/Patients/brush.dart';
import 'package:medical_1/Patients/clinet.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../authentication/signup_controller.dart';
import '../login-signup/authentication process.dart';
import '../repositpry/exceptions/signup_email_password_failure.dart';
import '../style/color/color.dart';
// import 'package:login_pages/style/size/size.dart';
import '../repositpry/authentication_repositpry/authentication_repository.dart';

class registration extends StatefulWidget {
  @override
  _registrationState createState() => _registrationState();
}

class _registrationState extends State<registration> {
  _MyFormState() {

  }

  final _formkey = GlobalKey<FormState>();
  // Variables :
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  late int fileName = Random().nextInt(1000000);
  late String UserName;
  late String ID;
  late String phoneNumber;
  late String Email1;
  late String passWorld;
  String? _selectvalcity = "";
  String? _selectvaltype = "";

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());

    return MaterialApp(
        title: "Registartion",
        home: Builder(
            builder: (context1) => Scaffold(
                backgroundColor: tLPurple,
                appBar: AppBar(
                    title: Text(
                      "إنشاء حساب للمريض ",
                      style: TextStyle(color: tWhiteColor),
                    ),
                    centerTitle: true,
                    backgroundColor: tDarkPurple,
                  ),
                  body: SingleChildScrollView(
                    child: Container(
                    padding: EdgeInsets.all(30),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            validator: ((value) {
                              if(value==null||value.isEmpty){
                                return 'الرجاء ادخال الأسم';
                              }
                              else {
                                null;
                              }
                            }
                            ),
                            style: TextStyle(color: Colors.black87),
                            textAlign: TextAlign.right,
                            onChanged: (value) {
                              UserName = value;
                            },
                            decoration: InputDecoration(
                              label: Align(
                                child: Text("اسم المريض"),
                                alignment: Alignment.bottomRight,
                              ),
                              labelStyle: TextStyle(color: tDarkBlueColor),
                              suffixIcon: Icon(
                                Icons.person_outline_rounded,
                                color: tDarkBlueColor,
                              ),
                            ),
                          ),
                          TextFormField(
                            validator: ((value) {
                              if(value==null||value.isEmpty){
                                return 'الرجاء ادخال الهوية';
                              }
                              if (value.length>10 || value.length<10) {
                               return 'الرجاء ادخال رقم هوية صحيح';
                              }
                              else null;
                            }
                            ),
                            textAlign: TextAlign.right,
                            onChanged: (value) {
                              ID = value;
                            },
                            decoration: InputDecoration(
                              label: Align(
                                child: Text("رقم الهوية"),
                                alignment: Alignment.bottomRight,
                              ),
                              labelStyle: TextStyle(color: tDarkBlueColor),
                              suffixIcon: Icon(
                                Icons.numbers,
                                color: tDarkBlueColor,
                              ),
                            ),
                          ),
                          TextFormField(
                            validator: ((value) {
                              if(value==null||value.isEmpty){
                                return 'الرجاء ادخال الهاتف';
                              }
                              if (value.length>10 || value.length<10) {
                                return 'الرجاء ادخال رقم هاتف صحيح';
                              }
                              else null;
                            }
                            ),
                            textAlign: TextAlign.right,
                            onChanged: (value) {
                              phoneNumber = value;
                            },
                            decoration: InputDecoration(
                              label: Align(
                                child: Text("رقم الجوال"),
                                alignment: Alignment.bottomRight,
                              ),
                              labelStyle: TextStyle(color: tDarkBlueColor),
                              suffixIcon: Icon(
                                Icons.phone_android,
                                color: tDarkBlueColor,
                              ),
                            ),
                          ),
                          TextFormField(
                            validator: ((value) {
                              if(value==null||value.isEmpty){
                                return 'الرجاء ادخال البريد';
                              }
                              else {
                                null;
                              }
                            }
                            ),
                            controller: controller.email,
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.right,
                            onChanged: (value) {
                              Email1 = value;
                            },
                            decoration: InputDecoration(
                              label: Align(
                                child: Text("البريد الألكتروني"),
                                alignment: Alignment.bottomRight,
                              ),
                              labelStyle: TextStyle(color: tDarkBlueColor),
                              suffixIcon: Icon(
                                Icons.email_outlined,
                                color: tDarkBlueColor,
                              ),
                            ),
                          ),
                          TextFormField(
                            validator: ((value) {
                              if(value==null||value.isEmpty){
                                return 'الرجاء ادخال كلمة السر';
                              }
                              else {
                                null;
                              }
                            }
                            ),
                            controller: controller.password,
                            obscureText: true,
                            textAlign: TextAlign.right,
                            onChanged: (value) {
                              passWorld = value;
                            },
                            decoration: InputDecoration(
                              label: Align(
                                child: Text("الرقم السري"),
                                alignment: Alignment.bottomRight,
                              ),
                              labelStyle: TextStyle(color: tDarkBlueColor),
                              suffixIcon: Icon(
                                Icons.fingerprint,
                                color: tDarkBlueColor,
                              ),
                            ),
                          ),
//                          TextFormField(
//                            textAlign: TextAlign.right,
//                            onChanged: (value) {
//                              address = value;
//                            },
//                            decoration: InputDecoration(
//                              filled: true,
//                              fillColor: tLiteBlue,
//                              label: Align(
//                                child: Text("العنوان"),
//                                alignment: Alignment.bottomRight,
//                              ),
//                              labelStyle: TextStyle(color: Colors.black54),
//                              suffixIcon: Icon(Icons.location_on_outlined),
//                            ),
//                          ),

                          SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              child: Text("إنشاء حساب"),
                              onPressed: () async {
                                if(_formkey.currentState!.validate()){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const clints()),
                                  );
                                }
                                try {
                                  await _auth.createUserWithEmailAndPassword(email: Email1, password: passWorld);
                                  await _firestore.collection("Users").add({
                                    "Name": UserName,
                                    "User ID": ID,
                                    "Phone Number": phoneNumber,
                                    "Email": Email1,
                                    "passworld": passWorld,
                                  });
                                } on FirebaseAuthException catch (e) {
                                  final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
                                  String? error =  ex.message;
                                  if (error != null) {
                                    Get.showSnackbar(GetSnackBar(message: error.toString(), snackPosition: SnackPosition.BOTTOM,
                                        margin: EdgeInsets.all(30),
                                        backgroundColor: tYalowColor,
                                        icon: Icon(Icons.sms_failed, color: tDarkBlueColor,)));
                                  }
                                  Get.to(() =>  clints());

                                } catch (_) {
                                  const ex = SignUpWithEmailAndPasswordFailure();
                                  String? error =  ex.message;
                                  if (error != null) {
                                    Get.showSnackbar(GetSnackBar(message: error.toString(),
                                      snackPosition: SnackPosition.BOTTOM,
                                    margin: EdgeInsets.all(30),
                                    backgroundColor: tYalowColor,
                                    icon: Icon(Icons.sms_failed, color: tDarkBlueColor,),));
                                  }

                                }

                              },
                              style: ElevatedButton.styleFrom(
                                textStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                primary: tDarkPurple,
                                elevation: 15,
                                shadowColor: Color(0xff497174),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ))));
  }
}
