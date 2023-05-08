import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:medical_1/Doctor%20Page/Doctors.dart';
import 'package:medical_1/firebase_options.dart';
import '../style/color/color.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(AdminUserList());
}
class AdminUserList extends StatefulWidget {

  @override
  _AdminUserListState createState() => _AdminUserListState();
}

class _AdminUserListState extends State<AdminUserList> {

  String serchKeyWord = "";
  String phoneNumber = "";
 String? name;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,

        title: "User List ",
      home: Scaffold(
            backgroundColor: tLPurple,
            appBar: AppBar(
              centerTitle: true,
              title: Card(
                child: TextFormField(
                  textAlign: TextAlign.right,
                  onChanged: (value){
                    setState(() {
                      serchKeyWord = value;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: tDarkPurple,
                    label: Align(child: Text("ابحث بإستخدام اسم المريض"),alignment: Alignment.bottomRight,),
                    labelStyle: TextStyle(color: Colors.black54),
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              backgroundColor: tDarkPurple,
              actions: <Widget>[
                // add the icon to this list
                Icon(Icons.account_circle, color: tWhiteColor, size: 40),
              ],
            ),

            body: StreamBuilder<QuerySnapshot>(

            stream: FirebaseFirestore.instance.collection("Users").snapshots(),
                builder: (context, snapshot){
                  return (snapshot.connectionState == ConnectionState.waiting)
                      ? Center( child: CircularProgressIndicator(),)
                      : ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index){
                        var data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                        if(serchKeyWord.isEmpty){
                          return Container(
                            padding: EdgeInsets.only(top: 16),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(data['Name'], style: TextStyle(
                                    color: tDarkBlueColor,
                                  ), textAlign: TextAlign.center,),
                                  leading: Icon(Icons.people, color: tDarkBlueColor,),
                                  trailing: IconButton(icon: Icon(Icons.navigate_next, color: tDarkBlueColor) ,onPressed: (){
                                    name = data["Email"];
                                    print("$name");

                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => Doctors(Email: name)
                                        )
                                    );
                                    // name = data["uid"];
                                    // Doctors(id1: name));
                                  },
                                  ),
                                ),
                                Divider(
                                  thickness: 2,
                                )
                              ],
                            ),
                          );
                        }
                        if(data['Name'].toString().toLowerCase().startsWith(serchKeyWord.toLowerCase())){
                          return Container(
                            padding: EdgeInsets.only(top: 16),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(data['Name'], style: TextStyle(
                                    color: tDarkBlueColor,
                                  ), textAlign: TextAlign.center,),
                                  leading: Icon(Icons.people, color: tDarkBlueColor),
                                  trailing: IconButton(icon: Icon(Icons.navigate_next, color: tDarkBlueColor) ,
                                    onPressed: (){
                                      name = data["Email"];
                                      print("$name");
                                      Navigator.push(
                                          context, MaterialPageRoute(builder: (context) => Doctors(Email: name)
                                      )
                                      );
                                        //Get.to(() => Doctors(id1: name));
                                        }
                                    ),
                                ),
                                Divider(
                                  thickness: 2,
                                )
                              ],
                            ),
                          );
                        }
                        return Container();
                      }
                  );
                }

            ),
          )
      );
  }
}
