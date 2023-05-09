import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:medical_1/Patients/clinet.dart';
import 'package:medical_1/Patients/teethlevel.dart';
import 'package:medical_1/style/color/color.dart';
import 'package:medical_1/style/image/imagePath.dart';
import 'package:medical_1/utils/authentication.dart';
import 'package:medical_1/widgets/google_sign_in_button.dart';

import '../regester page/registration.dart';
import '../repositpry/exceptions/login_with_email_and_pssword_failure.dart';

class ClintLogin extends StatefulWidget {
  const ClintLogin({Key? key}) : super(key: key);
  @override
  stateclinetlogin createState() => stateclinetlogin();
}
class stateclinetlogin extends State<ClintLogin> {
   stateclinetlogin({Key? key}) ;
  final _auth = FirebaseAuth.instance;
  TextEditingController Email1 = TextEditingController();
  TextEditingController passWorld = TextEditingController();

 void singIn () async {
  try {
  await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: Email1.text.trim(), password: passWorld.text.trim());
  Get.to(() => clints());
  } on FirebaseAuthException catch (e) {
  final ex = LogInWithEmailAndPasswordFailure.code(e.code);
  String? error = ex.message;
  if (error != null) {
  Get.showSnackbar(GetSnackBar(message: error.toString(),snackPosition: SnackPosition.BOTTOM,
  margin: EdgeInsets.all(30),
  backgroundColor: tYalowColor,
  icon: Icon(Icons.sms_failed, color: tDarkBlueColor,)));
  }
  } catch (_) {
  const ex = LogInWithEmailAndPasswordFailure();
  String? error = ex.message;
  if (error != null) {
  Get.showSnackbar(GetSnackBar(message: error.toString(),snackPosition: SnackPosition.BOTTOM,
  margin: EdgeInsets.all(30),
  backgroundColor: tYalowColor,
  icon: Icon(Icons.sms_failed, color: tDarkBlueColor,)));
  }
  }
}



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const tDefaultSize = 30.0;
    const tSplashContainerSize = 30.0;
    const tButtonHeight = 15.0;
    const tFormHeight = 30.0;

    return SafeArea(
      child: Scaffold(
        backgroundColor: tLPurple,
        body: SingleChildScrollView(
          child: Container(
            padding:  EdgeInsets.all(tDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                      image:  AssetImage(logoT),
                      height: size.height * 0.2),
                  SizedBox(height: 20,),

                  Text("أهلاً بك مراجعنا العزيز", style: TextStyle(color: title, fontSize: 30, fontWeight: FontWeight.normal), textAlign: TextAlign.center, ),                  Text("تفضل بتسجيل الدخول"),
                ],
              ),
            Form(
              child: Container(
                padding:  EdgeInsets.symmetric(vertical: tFormHeight - 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                       controller: Email1,
                      textAlign: TextAlign.right,
                      style: TextStyle(color: title),
                      decoration:  InputDecoration(

                          suffixIcon: Icon(Icons.person_outline_outlined, color: title),
                          hintText: "البريد الإلكتروني",
                          hintTextDirection: TextDirection.rtl,
                          hintStyle: TextStyle(color: title),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: tDarkBlueColor),
                          ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: tDarkBlueColor),
                    ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: tDarkBlueColor),

                      ),)),
                    const SizedBox(height: tFormHeight - 20),
                    TextFormField(
                      controller: passWorld,
                      textAlign: TextAlign.right,
                      style: TextStyle(color: title),
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.fingerprint_rounded, color: title,),
                        hintText: "كلمة السر ",
                        hintTextDirection: TextDirection.rtl,
                        hintStyle: TextStyle(color: title),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: tDarkBlueColor),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: tDarkBlueColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: tDarkBlueColor),

                        ),
                        prefixIcon: IconButton(
                          onPressed: null,
                          icon: Icon(Icons.remove_red_eye_sharp,color: title,),
                        ),
                      ),
                    ),
                    const SizedBox(height: tFormHeight - 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: singIn,
                        child: Text("تسجيل الدخول".toUpperCase()),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(),
                          padding: EdgeInsets.symmetric(vertical: 20),
                          primary: tDarkPurple,

                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: tFormHeight - 20),
                const SizedBox(height: tFormHeight - 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context1) {
                          return registration();
                        }));
                  },
                  child: Text.rich(
                    TextSpan(
                        text: "لا تملك حسابا؟ ",
                        style: Theme.of(context).textTheme.bodyText1,
                        children: const [
                          TextSpan(text: "أنشيء حساب", style: TextStyle(color: tDarkPurple, fontWeight: FontWeight.bold))
                        ]),
                  ),
                ),
              ],
            ),
                FutureBuilder(
                  future: Authentication.initializeFirebase(context: context),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error initializing Firebase');
                    } else if (snapshot.connectionState == ConnectionState.done) {
                      return GoogleSignInButton();
                    }
                    return CircularProgressIndicator();
                  },
                ),
            ],
            ),
            ),
          ),
        ),
      );
     }
}
