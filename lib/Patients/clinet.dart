import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:medical_1/Patients/CommnQu.dart';
import 'package:medical_1/Patients/Useworp.dart';
import 'package:medical_1/Patients/booking.dart';
import 'package:medical_1/style/color/color.dart';
import 'package:medical_1/Patients/teethlevel.dart';
import 'package:video_player/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'brush.dart';

class clintpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const MaterialApp(
      title: "home page",
      debugShowCheckedModeBanner: false,
      home: clints(),
    );
  }
}

class clints extends StatefulWidget {

  const clints({Key? key }) : super(key: key);
  @override
  State<clints> createState() => _clintsState();
}
class _clintsState extends State<clints> {
  String Name = "";
    User?  user;
  final userdata  =  FirebaseAuth.instance;
  User? _auth =  FirebaseAuth.instance.currentUser;

  String? UserName;
  String? userid;
  void getInfo() async {
    CollectionReference users =
    await FirebaseFirestore.instance.collection('Users');
    final snapshot = await users.where('Email', isEqualTo: _auth?.email).get();
    if (snapshot.size > 0) {
      final data = snapshot.docs[0].data() as Map<String, dynamic>;
      setState(() {
        UserName = data["Name"];
        userid = data["Email"];
        //print(UserName);

      });
    } else {
      debugPrint('User Not Found!');
    }
   //print(_auth?.email);
  }
 //   User?  user;
 // Future<void> getuserdata() async{
 //    User userdata  = await FirebaseAuth.instance.currentUser!;
 //    setState(() {
 //      user = userdata;
 //      print("${user?.uid}");
 //    });
 //  }
 //  @override
 //  void initState() {
 //    // TODO: implement initState
 //    super.initState();
 //    getuserdata();
 //  }

  // final _user = Rxn<User>();
  // late FirebaseAuth _auth ;
  // late Stream<User?> authstate ;
  //
  // void iniAuth() async {
  //   print("object");
  //
  //   await Future.delayed(const Duration(seconds: 2));
  //   _auth = FirebaseAuth.instance;
  //   authstate = _auth.authStateChanges();
  //   authstate.listen((User? user) {
  //     print("object66668888");
  //     _user.value = user;
  //     print("user id ${user?.uid}");
  //   });
  // }
  // User? getuser(){
  //   _user.value = _auth.currentUser;
  //   return _user.value;
  // }

  @override
  Widget build(BuildContext context) {
    getInfo();
    return Scaffold(
      backgroundColor: tLPurple,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal:10.0),
          child: GridView(
            children: [
              Row(
                children: [
                  Container(
                      height: 120,
                      child: const Align(
                          alignment: Alignment.center,
                          child: Image(
                            image: AssetImage(
                              'assets/images/user.png',
                            ),
                          ))),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("مرحبًا",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),

Text("$UserName",style: const TextStyle(fontSize: 35),),
                ],
              ),
        InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const brush()),
              );
            },child: Container(

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFF4EDFC).withOpacity(1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),

                  child: Column(
                    children: [
                      Image.asset("assets/images/toothbrushes in cup.png"),
                     const FittedBox(
                       child: Padding(
                         padding: EdgeInsets.symmetric(horizontal: 19.0 ,vertical: 10),
                         child: FittedBox(child: Text("كيف تفرش اسنانك ؟" ,style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.bold),textAlign: TextAlign.center, maxLines: 2,)),
                       ),
                     )
              ,

                    ],
                  )

        )
        ),
        InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const teethleve()),
              );
            }, child:Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color:const Color(0xFFF4EDFC).withOpacity(1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                  child: Column(
                    children: [
                      Image.asset("assets/images/yellow star.png"),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 19.0 ,vertical: 10),
                        child: FittedBox(child: Text("مستوى نظافة اسنانك",style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.bold),textAlign: TextAlign.center, maxLines: 2,)),
                      )
                    ],
                  )),),
          InkWell(
          onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const CommnQu()),
    );
    },child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color:const Color(0xFFF4EDFC).withOpacity(1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                  child: Column(
                    children: [
                      Image.asset(
                          "assets/images/close up of white question mark.png"),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 19),
                        child: FittedBox(child: Text("اسئلة شائعة",style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.bold),textAlign: TextAlign.center, maxLines: 2,)),
                      )
                    ],
                  )),),
        InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Useworp()),
              );
            },
              child:Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color:const Color(0xFFF4EDFC).withOpacity(1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                child: Column(
                  children: [
                    Image.asset("assets/images/line.png"),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 19.0 ,vertical: 10),

                      child:  Text("كيف تستخدم خيط الاسنان؟",style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.bold),textAlign: TextAlign.center, maxLines: 2,)),

                  ],
                ),
              ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
            margin: const EdgeInsets.symmetric(vertical: 70, horizontal: 30.0),
            child: TextButton(
                  onPressed: (){
                Get.to(booking());
              }, child: const Text("احجز موعد",style: TextStyle(fontSize: 20,),)
              )
          )

            ],
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
          ),
        ),
      ),
    );
  }


 // Future namepationt() async{
 //    final  firbaseuser = await FirebaseAuth.instance.currentUser!;
 //    if(firbaseuser!= null){
 //      await FirebaseFirestore.instance.collection('Users');
 //      final uid = firbaseuser.uid;
 //      // Similarly we can get email as well
 //      //final uemail = user.email;
 //      print("nnnnnn $uid");
 //    }
 //  }
}

