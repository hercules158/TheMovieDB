import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';

class VideoPlayer extends StatefulWidget {
  final String id;

  const VideoPlayer({super.key, required this.id});

  @override
  State<StatefulWidget> createState() => _VideoPlayer();
}

class _VideoPlayer extends State<VideoPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
        initialVideoId: widget.id,
        flags: const YoutubePlayerFlags(autoPlay: false));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Trailer"),
        toolbarHeight: 45,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(2.0),
              child: YoutubePlayerBuilder(
                player: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  bottomActions: [
                    CurrentPosition(),
                    ProgressBar(
                      isExpanded: true,
                    ),
                    FullScreenButton(
                      controller: _controller,
                      color: Colors.blueAccent,
                    ),
                    const PlaybackSpeedButton(),
                  ],
                ),
                builder: (context, player) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: width*0.99,
                            height: height*0.78,
                            child: player),
                      ],
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }
}