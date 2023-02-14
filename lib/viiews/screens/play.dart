import 'package:flutter/material.dart';
import 'package:you_tube_pr/global.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Play extends StatefulWidget {
  const Play({Key? key}) : super(key: key);

  @override
  State<Play> createState() => _PlayState();
}

class _PlayState extends State<Play> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: Global.id,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      onReady: () {
        _controller.addListener(() {});
      },
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controller,
            ),
            builder: (context, player) {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    player,
                    const SizedBox(height: 25),
                    Text(
                      Global.data!.title,
                      style: const TextStyle(fontSize: 17),
                    ),
                    const SizedBox(height: 10),

                    SingleChildScrollView(
                      child: Row(
                        children: [
                          buttons(Icons.thumb_up_outlined, "Like"),
                          SizedBox(
                            width: 20,
                          ),
                          buttons(Icons.thumb_down_alt_outlined, "Dislike"),
                          SizedBox(
                            width: 20,
                          ),
                          buttons(Icons.share_outlined, "Share"),
                          SizedBox(
                            width: 20,
                          ),
                          buttons(Icons.download_outlined, "Download"),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    const SizedBox(height: 10),
                    Text(
                      "${Global.data!.publishedAt}",
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "${Global.data!.description}",
                      style: const TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    //some other widgets
                  ],
                ),
              );
            }),
      ),
    );
  }

  buttons(icon, String text) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(icon),
            color: Colors.white,
          ),
          Center(
            child: Text(
              text,
              style: const TextStyle(fontSize: 11, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
