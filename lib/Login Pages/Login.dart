
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_1/Doctor%20Page/AdminUserList.dart';
import 'package:medical_1/regester%20page/registrationDcotor.dart';
import 'package:medical_1/repositpry/exceptions/login_with_email_and_pssword_failure.dart';
import 'package:medical_1/style/color/color.dart';
import 'package:medical_1/style/image/imagePath.dart';
import 'package:medical_1/widgets/google_sign_in_buttonD.dart';

import '../utils/authentication.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginPageD createState() => LoginPageD();

}
class LoginPageD extends State<Login> {

  final email = TextEditingController();
  final pass = TextEditingController();
 //  final _auth = FirebaseAuth.instance;

   Future singIn() async {
     try {
       await FirebaseAuth.instance.signInWithEmailAndPassword(
           email: email.text.trim(),
           password: pass.text.trim());
       Get.to(() => AdminUserList());
     } on FirebaseAuthException catch (e) {
       final ex = LogInWithEmailAndPasswordFailure.code(e.code);
       String? error = ex.message;
       if (error != null) {
         Get.showSnackbar(GetSnackBar(message: error.toString(),
             snackPosition: SnackPosition.BOTTOM,
             margin: EdgeInsets.all(30),
             backgroundColor: tYalowColor,
             icon: Icon(Icons.sms_failed, color: tDarkBlueColor,)));
         print("$email");
       }
     } catch (_) {
       const ex = LogInWithEmailAndPasswordFailure();
       String? error = ex.message;
       if (error != null) {
         Get.showSnackbar(GetSnackBar(message: error.toString(),
             snackPosition: SnackPosition.BOTTOM,
             margin: EdgeInsets.all(30),
             backgroundColor: tYalowColor,
             icon: Icon(Icons.sms_failed, color: tDarkBlueColor,)));
       }
     }
   }
  @override
  void dispose() {
    super.dispose();
    email.dispose();
    pass.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: tLPurple,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment:  MainAxisAlignment.center,
                children: [
                  Image(
                      image:  AssetImage(logoT),
                      height: size.height * 0.2),
                  SizedBox(height: 15,),
                  Text("مرحبًا بك ", style: TextStyle(color: title,
                      fontSize: 30, fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center, ),
                  Text("تفضل بتسجيل الدخول"),
                  SizedBox(height: 50,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)
                      ),
                    child:Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextField(
                        controller: email,
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(
                          // filled: true,
                          suffixIcon: Icon(Icons.person_outline_outlined, color: title),
                        border: InputBorder.none,
                          hintText: "البريد الالكتروني",
                            hintTextDirection: TextDirection.rtl

                        ),
                      ),
                    )
                    ),
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child:Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: TextField(
                            controller: pass,
                            obscureText: true,
                            textDirection: TextDirection.rtl,

                            decoration: InputDecoration(
                              // filled: true,
                              suffixIcon: Icon(Icons.fingerprint_rounded, color: title,),

                              border: InputBorder.none,
                                hintText: "كلمة المرور",
                                hintTextDirection: TextDirection.rtl,


                            ),

                          ),
                        )
                    ),
                  ),
                  SizedBox(height: 50,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: GestureDetector(
                      onTap: singIn,
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color:tDarkPurple ,
borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(
                            child: Text("تسجيل الدخول",
                              style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),)),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context1) {
                            return registrationDoctor();
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
                  FutureBuilder(
                    future: Authentication.initializeFirebase(context: context),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error initializing Firebase');
                      } else if (snapshot.connectionState == ConnectionState.done) {
                        return GoogleSignInButtonD();
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                ],
              ),
            ),
          ),

        ),
      ),
    );
  }
}

