import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:medical_1/style/color/color.dart';

void main() async {
  runApp(const teethleve());
}

class teethleve extends StatefulWidget {
  const teethleve({Key? key}) : super(key: key);
  @override
  State<teethleve> createState() => _teethleveState();
}

class _teethleveState extends State<teethleve> {
  final User? _auth = FirebaseAuth.instance.currentUser;

  String? comment;
  String? rating;
  String? Data;
  String? Time;
  String? NameD;

  Future getInfo() async {
    CollectionReference users =
    await FirebaseFirestore.instance.collection('CommentD');
    final snapshot = await users.where('uid', isEqualTo: _auth?.email).get();
    if (snapshot.size > 0) {
      final data = snapshot.docs[0].data() as Map<String, dynamic>;
      setState(() {
        comment = data["comment"];
        rating = data["rating"];
        Data = data["Date"];
        Time = data["Time"];
        NameD = data["nameD"];
      });
    } else {
      debugPrint('User Not Found!');
    }
  }

  @override
  Widget build(BuildContext context) {

    getInfo();
    return MaterialApp(
        title: 'مستوى نظافة الأسنان',
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          colorSchemeSeed: tLPurple,
          useMaterial3: true,
        ),
        home: Scaffold(
            backgroundColor: tLPurple,
            appBar: AppBar(
                // Here we take the value from the MyHomePage object that was created by
                // the App.build method, and use it to set our appbar title.
                title: const Text("مستوى نظافة الأسنان"),
                backgroundColor: tLPurple,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context, false),
                )),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Row(children: [

                  Container(
                      margin: const EdgeInsets.all(20),
                      height: 120,
                      child: const Align(
                          alignment: Alignment.topRight,
                          child: Image(
                            image: AssetImage(
                              'assets/images/doctor.png',
                            ),
                          ))),
                 if (NameD != null)
                   Text(
                    "$NameD",
                    style: const TextStyle(fontSize: 20),
                  ) else if (NameD == null)
                    const Text("لم يتم تعيين دكتور")
                    ],),
                const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("التعليق",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.justify,
                        textDirection: TextDirection.rtl)),
                if(comment == null)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("لا يوجد تعليق "),
                  )
                else
                  Padding(
                  padding: const EdgeInsets.all(15),
                  child: Expanded(
                    child:  Text(
                      '$comment',
                      maxLines: 4,
                      style: const TextStyle(fontSize: 15),
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("مستوى النظافة",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))),
               if(rating == null)
                 const Padding(
                   padding: EdgeInsets.all(8.0),
                   child: Text("لم يتم تقيم مستوى نظافة اسنانك الى الان"),
                 )
                else
                 Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text("$rating",  style: const TextStyle(fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,),
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("تاريخ الزيارة التالية ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                if(Data == null && Time == null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("لم يتم تعين تاريخ للزياره التالية "),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Center(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      textDirection: TextDirection.rtl,
                      children: [
                        Text("$Data", style: const TextStyle(fontSize: 20)),
                        const SizedBox(
                          width: 20,
                        ),
                        Text("$Time", style: const TextStyle(fontSize: 20))
                      ],
                    ))),
              ],
            )));
  }
}
