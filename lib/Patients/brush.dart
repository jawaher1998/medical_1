import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../style/color/color.dart';
import 'VideoScreen.dart';
//
// var videoList=[
//   {
//     'name':'طريقة تنظيف تقويم الأسنان',
//     'media_url':'https://firebasestorage.googleapis.com/v0/b/medical-31bb1.appspot.com/o/%D8%B7%D8%B1%D9%8A%D9%82%D8%A9%20%D8%AA%D9%86%D8%B8%D9%8A%D9%81%20%D8%AA%D9%82%D9%88%D9%8A%D9%85%20%D8%A7%D9%84%D8%A7%D8%B3%D9%86%D8%A7%D9%86.mp4?alt=media&token=16fc25a1-7f5c-4b7d-b7de-89eb50aefc0c',
//     'thumb_url':'https://esteshary.com/mwfiles/thumbs/fit630x300/28877/1592913648/%D9%83%D9%84_%D9%85%D8%A7_%D8%AA%D8%B1%D9%8A%D8%AF_%D9%85%D8%B9%D8%B1%D9%81%D8%AA%D9%87_%D8%B9%D9%86_%D8%AA%D9%82%D9%88%D9%8A%D9%85_%D8%A7%D9%84%D8%A3%D8%B3%D9%86%D8%A7%D9%86.jpg'
//   },
//   {
//     'name':'طريقة تفريش الأسنان لمرضى التقويم',
//     'media_url':'https://firebasestorage.googleapis.com/v0/b/medical-31bb1.appspot.com/o/videoplayback.mp4?alt=media&token=0e5d6b37-5e64-4529-901f-a93e3b84fbd4',
//     'thumb_url':'https://www.crushpixel.com/big-static15/preview4/closeup-teeth-braces-tooth-brush-2204168.jpg'
//   }
// ];
class brush extends StatefulWidget {
  const brush({
    super.key,});
  _VideoAppState createState() => _VideoAppState();

}

class _VideoAppState extends State<brush> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network("https://firebasestorage.googleapis.com/v0/b/medical-31bb1.appspot.com/o/%D8%B7%D8%B1%D9%8A%D9%82%D8%A9%20%D8%AA%D9%86%D8%B8%D9%8A%D9%81%20%D8%AA%D9%82%D9%88%D9%8A%D9%85%20%D8%A7%D9%84%D8%A7%D8%B3%D9%86%D8%A7%D9%86.mp4?alt=media&token=16fc25a1-7f5c-4b7d-b7de-89eb50aefc0c");

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
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
  title: Text("فيديوهات تعليميه"),
  leading: IconButton(
  icon: Icon(Icons.arrow_back),
  onPressed: () => Navigator.pop(context, false),
  )),
  body:
  //
  FutureBuilder(
  future: _initializeVideoPlayerFuture,
  builder: (context, snapshot) {
  if (snapshot.connectionState == ConnectionState.done) {
  // If the VideoPlayerController has finished initialization, use
  // the data it provides to limit the aspect ratio of the video.
  return AspectRatio(
  aspectRatio: _controller.value.aspectRatio,
  // Use the VideoPlayer widget to display the video.
  child: VideoPlayer(_controller),
  );
  } else {
  // If the VideoPlayerController is still initializing, show a
  // loading spinner.
  return const Center(
  child: CircularProgressIndicator(),
  );
  }
  },
  ),
  floatingActionButton: FloatingActionButton(
  onPressed: () {
  // Wrap the play or pause in a call to `setState`. This ensures the
  // correct icon is shown.
  setState(() {
  // If the video is playing, pause it.
  if (_controller.value.isPlaying) {
  _controller.pause();
  } else {
  // If the video is paused, play it.
  _controller.play();
  }
  });
  },
  // Display the correct icon depending on the state of the player.
  child: Icon(
  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
  ),
  ),
  // ListView(
  //       children: videoList.map(
  //               (e) => GestureDetector(
  //                 onTap: ()=> Navigator.push(context,
  //                     MaterialPageRoute(builder: (context)=>VideoScreen(
  //                         name:e['name']!,
  //                         mediaUrl:(e['media_url']!)
  //                     ))),
  //
  //                 child: Column(
  //                   children: [
  //
  //                     Text(e["name"]!,style: TextStyle(fontSize: 17 , ),),
  //                      Image.network(e["thumb_url"]!),
  //                   ],
  //                 )
  //
  //
  //       )).toList(),
  //     ),

  ),

  //
  // FutureBuilder(
  //   future: _initializeVideoPlayerFuture,
  //   builder: (context, snapshot) {
  //     if (snapshot.connectionState == ConnectionState.done) {
  //       // If the VideoPlayerController has finished initialization, use
  //       // the data it provides to limit the aspect ratio of the video.
  //       return AspectRatio(
  //         aspectRatio: _controller.value.aspectRatio,
  //         // Use the VideoPlayer widget to display the video.
  //         child: VideoPlayer(_controller),
  //       );
  //     } else {
  //       // If the VideoPlayerController is still initializing, show a
  //       // loading spinner.
  //       return const Center(
  //         child: CircularProgressIndicator(),
  //       );
  //     }
  //   },
  // ),
  // floatingActionButton: FloatingActionButton(
  //   onPressed: () {
  //     // Wrap the play or pause in a call to `setState`. This ensures the
  //     // correct icon is shown.
  //     setState(() {
  //       // If the video is playing, pause it.
  //       if (_controller.value.isPlaying) {
  //         _controller.pause();
  //       } else {
  //         // If the video is paused, play it.
  //         _controller.play();
  //       }
  //     });
  //   },
  //   // Display the correct icon depending on the state of the player.
  //   child: Icon(
  //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
  //   ),
  // ),

  );
  }

}

