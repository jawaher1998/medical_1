import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:medical_1/style/color/color.dart';
class VideoScreen extends StatefulWidget{
  final String name, mediaUrl;

  VideoScreen({required this.name, required this.mediaUrl});

  @override
  ViedoScreenState createState() => ViedoScreenState();
}

class ViedoScreenState extends State<VideoScreen> {
   late BetterPlayerController betterPlayerController;
   GlobalKey betterplaykey = GlobalKey();

   @override
  void initState() {
     BetterPlayerConfiguration betterPlayerConfiguration = BetterPlayerConfiguration(
       aspectRatio: 16/9,
       fit: BoxFit.contain
     );
     BetterPlayerDataSource dataSource = BetterPlayerDataSource(
         BetterPlayerDataSourceType.network,
         widget.mediaUrl
     );
     betterPlayerController =BetterPlayerController(betterPlayerConfiguration);
     betterPlayerController.setupDataSource(dataSource);
     betterPlayerController.setBetterPlayerGlobalKey(betterplaykey);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            title: Text(""),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )),
    body: Column(
      children: [
        const SizedBox(
          height: 8,),

          Expanded(child: AspectRatio
            (aspectRatio: 16/9,
        child: BetterPlayer(
       key: betterplaykey,
        controller: betterPlayerController
        )
            ,)
          ,)
      ],

    )
    )
    );
    }

}