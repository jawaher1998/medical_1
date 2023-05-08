import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:medical_1/Login%20Pages/Clint%20Login.dart';
import 'package:medical_1/Login%20Pages/Login.dart';
import 'package:medical_1/style/color/color.dart';
import 'package:medical_1/style/image/imagePath.dart';
import 'package:flutter/foundation.dart';
import 'package:medical_1/shared/constants.dart';
//import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      name: 'my teeth',
      options: FirebaseOptions(
        apiKey: "AIzaSyCt05ClNK4vjj2SaUx1XPX3SetcufxnfHc",
      appId: '1:776473703039:web:8d45958b102e6c06d4454a',
      messagingSenderId: '776473703039',
      projectId: 'medical-31bb1'
    ),);

  runApp( WelcomeScreen());
}

class WelcomeScreen extends StatefulWidget {
  @override
  _mState createState() => _mState();
}

class _mState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "my app",
      home: Builder(

        builder: (context) => Scaffold(
          backgroundColor: tDarkPurple,
          body:  Container(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image(image: const AssetImage(logoT)),
                Column(
                  children: const [
                    Text("مرحباً بك",
                      style: TextStyle(color: title, fontSize: 40, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,  ),

                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context1) {
                                return ClintLogin();
                              }));
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(),
                          backgroundColor: tWhiteColor,
                          side: BorderSide(color: tDarkBlueColor),
                          padding: EdgeInsets.symmetric(vertical: 20),
                        ),

                        child: Text("تسجيل دخول للمريض", style: TextStyle(color: title),),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(),
                          side: BorderSide(color: tWhiteColor),
                          padding: EdgeInsets.symmetric(vertical: 20),
                          primary: tDarkBlueColor,

                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context1) {
                                return Login();
                              }));
                        },
                        child: Text("تسجيل دخول للأطباء ", style: TextStyle(color: tWhiteColor),),

                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),),);
  }
}

