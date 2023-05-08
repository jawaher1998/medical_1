import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:medical_1/main.dart';
import '../repositpry/exceptions/signup_email_password_failure.dart';

class authentication  extends GetxController{
  static authentication get instance => Get.find();

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;


  void createUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      Get.to(() =>  WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      String? error =  ex.message;
      if (error != null) {
        Get.showSnackbar(GetSnackBar(message: error.toString(),));
      }
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      String? error =  ex.message;
      if (error != null) {
        Get.showSnackbar(GetSnackBar(message: error.toString(),));
      }
    }


  }

}
