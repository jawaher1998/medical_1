import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_1/Model/commentD.dart';
import 'package:medical_1/style/color/color.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Doctors extends StatefulWidget {
  final Email;
  @override
  const Doctors({
    Key? key,
    required this.Email,
  }) : super(key: key);
  _DoctorsState createState() => _DoctorsState(id: Email);
}

class _DoctorsState extends State<Doctors> {
  double rating = 2.5;
  TextEditingController controller = new TextEditingController();
// ignore: non_constant_identifier_names
  DateTime dateTime = DateTime(2023, 3, 1, 5, 30);
  String id;
  _DoctorsState({required this.id});
  @override
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? UserName;
  String? userid;
  String? NameDoctor;
  void getInfo() async {
    CollectionReference users =
        await FirebaseFirestore.instance.collection('Users');
    final snapshot = await users.where('Email', isEqualTo: id).get();
    if (snapshot.size > 0) {
      final data = snapshot.docs[0].data() as Map<String, dynamic>;
      setState(() {
        UserName = data["Name"];
        userid = data["Email"];
      });
    } else {
      debugPrint('User Not Found!');
    }
  }
  void NameD() async{
    CollectionReference user = await FirebaseFirestore.instance.collection('User_Doctor');
    final snapshot = await user.where('Email', isEqualTo: _auth.currentUser?.email).get();
    if (snapshot.size > 0) {
      final data = snapshot.docs[0].data() as Map<String, dynamic>;
      setState(() {
        NameDoctor = data["displayName"];
      });
    } else {
      debugPrint('User Not Found!');
    }
  }

  Widget build(BuildContext context) {
    getInfo();
    NameD();
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorSchemeSeed: tLPurple,
          useMaterial3: true,
        ),
        home: Scaffold(
            backgroundColor: tLPurple,
            appBar: AppBar(
                backgroundColor: tLPurple,
                title: Text("${NameDoctor}"),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context, false),
                )),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(children: [
                    Container(
                        margin: EdgeInsets.all(20),
                        height: 120,
                        child: const Align(
                            alignment: Alignment.topLeft,

                            child: Image(
                              image: AssetImage(
                                'assets/images/user.png',
                              ),
                            ))),
                    Text(
                      "$UserName",
                      style: TextStyle(fontSize: 20),
                    )
                  ]),
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("التعليق",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.rtl)),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                      textDirection: TextDirection.rtl,
                      controller: controller,
                      maxLines: 5,
                      minLines: 1,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(vertical: 40),
                        suffixStyle: TextStyle(backgroundColor: Colors.white),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("مستوى النظافة",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                  Center(
                    child: RatingBar.builder(
                      initialRating: rating,
                      itemCount: 5,
                      onRatingUpdate: (value) {
                        rating = value;
                        print(rating);
                      },
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      allowHalfRating: true,
                      itemPadding: EdgeInsets.symmetric(horizontal: 6.0),
                      glow: true,
                      direction: Axis.horizontal,
                      textDirection: TextDirection.rtl,
                    ),
                    
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("تقيمك للمريض: $rating نجمة "),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("الزيارة التالية",
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          child: Text(
                              '${dateTime.year}/${dateTime.month}/${dateTime.day}'),
                          onPressed: () async {
                            final date = await pickdate();
                            if (date == null) return;
                            final newDateTime = DateTime(date.year, date.month,
                                date.day, dateTime.hour, dateTime.minute);
                            setState(() => dateTime = newDateTime);
                          },
                        ),
                        Center(

                          child: ElevatedButton(

                            child: Text('${hours}:${minutes}'),
                            onPressed: () async {
                              final time = await picktTime();
                              if (time == null) return;
                              final newDateTime = DateTime(
                                  dateTime.year,
                                  dateTime.month,
                                  dateTime.day,
                                  time.hour,
                                  time.minute);
                              setState(() => dateTime = newDateTime);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('تم حجز الموعد للمريض بتاريخ ${dateTime.year}/${dateTime.month}/${dateTime.day}  الساعة ${hours}:${minutes}'),
                  ),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 30),
        child:  ElevatedButton(


                      onPressed:() async {

                        // Map <String , String> DataToSave ={
                        //   'comment':controller.text,
                        //   'rating':"$rating",
                        //   'DateTime':"${dateTime.year}/${dateTime.month}/${dateTime.day}${hours}:${minutes}"
                        // };
                        // FirebaseFirestore.instance.collection("CommentD").add(DataToSave);

                        final DataToSave savedata = new DataToSave();
                        if (controller.text == null || controller.text == "") {
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.scale,
                            dialogType: DialogType.error,
                            body: Center(child: Text(
                              'الرجاء ادخال جميع البيانات الازمه ',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),),
                            title: "خطاء",
                            desc: 'This is also Ignored',
                            btnOkOnPress: () {},
                          ).show();
                        }
                        else {
                          savedata.DataTosave(controller.text, "$rating",
                              "${dateTime.year}/${dateTime.month}/${dateTime
                                  .day}", "${hours}:${minutes}", "${userid}","$NameDoctor");
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.scale,
                            dialogType: DialogType.success,
                            body: Center(child: Text(
                              'تم ارسال البيانات بنجاح ',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),),
                            title: "تم الارسال",
                            desc: 'This is also Ignored',
                            btnOkOnPress: () {},
                          ).show();
                        }
                      },

            child:Container(
                      padding:EdgeInsets.all( 16),
    child: Center(
        child: Text("أرسل")
    )
            )
        )
      )
                ],
              ),
            )));
  }

  Future<DateTime?> pickdate() => showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100));

  Future<TimeOfDay?> picktTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));

  Future PickDateTime() async {
    DateTime? date = await pickdate();
    if (date == null) return;
    TimeOfDay? time = await picktTime();
    if (time == null) return;
    final dateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() => this.dateTime = dateTime);
  }
}
