import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

class DataToSave{
  final  uderid = FirebaseFirestore.instance.collection('Users');
  final CollectionReference collectioData = FirebaseFirestore.instance.collection("CommentD");
  String? comments;
  String? Ratings ;
  String? date;
  String? time;
  String? uid;
  String? nameD;
  DataToSave();
  Future<void> DataTosave(
    String comments , String Ratings , String date,String time , String uid ,String name){
    return collectioData.add({
      'comment':comments,
      'rating':Ratings,
      'Date':date,
      'Time':time,
      'uid':uid,
      'nameD':name,
    });
}
// Future getdataDoctor() async{
//     try{
//       await collectioData.get().then((querySnapshot) {
//         QuerySnapshot.documents.forEach((element){
//
//         });
//       });
//     }catch(e){
//       print(e.toString());
//       return null;    }
// }
}