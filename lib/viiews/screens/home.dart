import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:you_tube_pr/global.dart';
import 'package:youtube_api/youtube_api.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool typing = false;
  static String key = "AIzaSyBRVa7iu7N03OuNEqZKHQGK1au-zbeRwZw";
  String header = "new song";

  YoutubeAPI youtube = YoutubeAPI(key);
  List<YouTubeVideo> videoResult = [];

  Future<void> callAPI() async {
    videoResult = await youtube.search(
      "trending",
      order: 'relevance',
      videoDuration: 'any',
    );
    videoResult = await youtube.nextPage();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    callAPI();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          title: Row(
            children: [
              SvgPicture.asset(
                "assets/images/youtube.svg",
                width: 35,
              ),
              const SizedBox(width: 5),
              const Text(
                "YouTube",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
          actions: [
            const Icon(
              Icons.notifications_none_outlined,
              color: Colors.white,
              size: 27,
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed("search_page");
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.grey.withOpacity(0.5),
              backgroundImage: const AssetImage(
                "assets/images/Screenshot 2023-01-04 140656.jpg",
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: videoResult.map<Widget>(listItem).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listItem(YouTubeVideo video) {
    return GestureDetector(
      onTap: () {
        Global.data = video;
        Global.id = video.id.toString();
        Navigator.of(context).pushNamed("player_page");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              image: DecorationImage(
                image: NetworkImage("${video.thumbnail.high.url}"),
                fit: BoxFit.cover,
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.25,
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  video.title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                Text(
                  video.channelTitle,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
