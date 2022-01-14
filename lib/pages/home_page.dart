import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String id = "home_page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController _videoPlayerController;
  int current = 0;

  final List _video = [
    "assets/video/video_1.mp4",
    "assets/video/video_2.mp4",
    "assets/video/video_3.mp4",
    "assets/video/video_4.mp4",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoPlayerController = VideoPlayerController.asset(_video[current])
      ..initialize().then((value) {
        setState(() {});
        _videoPlayerController.play();
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode (SystemUiMode.manual, overlays: []);
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        onPageChanged: ((value) {
          setState(() {
            current = value;
            _videoPlayerController = VideoPlayerController.asset(_video[current])
              ..initialize().then((value) {
                setState(() {});
                _videoPlayerController.play();
              });
          });
        }),
        children: [
          _playVideo(),
          _playVideo(),
          _playVideo(),
          _playVideo(),
        ],
      ),
    );
  }

  Widget _playVideo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          child: _videoPlayerController.value.isInitialized
              ? AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController))
              : Container(),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 100),
          child: IconButton(
            icon: const Icon(Icons.play_circle_fill_outlined, size: 50,),
            onPressed: (){
              setState(() {
                if(_videoPlayerController.value.isPlaying) {
                  _videoPlayerController.pause();
                } else {
                  _videoPlayerController.play();
                }
              });
            },
          ),
        ),
      ],
    );
  }
}
