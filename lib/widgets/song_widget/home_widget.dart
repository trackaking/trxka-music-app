import 'dart:convert';
import 'package:chatapp_firebase/widgets/card_widgets/category_card.dart';
import 'package:chatapp_firebase/widgets/card_widgets/createMusic_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../models/music.dart';
import '../../models/songs_model.dart';
import '../../pages/settings_page.dart';
import '../../service/category_operations.dart';
import '../../service/music_operations.dart';
import '../../shared/constants.dart';

class homeWidget extends StatefulWidget {
  const homeWidget({super.key});

  @override
  State<homeWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<homeWidget> {
  List<Song> songs = [];
  final storage = const FlutterSecureStorage();

  Future<List<Song>> getSongs() async {
    List<Song> result = [];

    String? token = await storage.read(key: "token") as String;

    var headers = {
      'access-token': token,
      "Accept": "application/json",
      'Content-Type': 'application/json; charset=UTF-8',
    };
    try {
      final response = await http.get(
        Uri.parse("${Constants.serverUrl}song/all"),
        headers: headers,
      );

      var jsonData = jsonDecode(response.body);

      for (var song in jsonData) {
        Song newSong = Song(
            songId: song["songId"],
            songName: song["songName"],
            songUri: song["songUri"],
            songGenre: song["songGenre"],
            songImgUri: song["songImgUri"],
            userId: song["userId"]);
        result.add(newSong);
        print(result);
      }
    } catch (error) {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      debugPrint(error.toString());
      throw Exception('Failed to load songs');
    }

    return result;
  }

  Widget createMusicList(String label) {
    Future<List<Music>> musicListFuture = MusicOperations.getMusic();
    List<Music> musicList = [];
    musicListFuture.then((value) => musicList = value);
    print(musicList);
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 300,
            child: FutureBuilder(
                future: MusicOperations.getMusic(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    print(snapshot.data);
                    return CreateMusicCard(musics: snapshot.data);
                  }
                }),
          )
        ],
      ),
    );
  }

//widgets
  Widget createAppBar(String message) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(message),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          iconSize: 30.0,
          color: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            );
          },
        ),
      ],
    );
  }

  Widget createGrid() {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 250,
      child: GridView.count(
        childAspectRatio: 5 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 1,
        children: [
          FutureBuilder(
              future: CategoryOperations.getCategories(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  print(snapshot.data);
                  return CategoryCard(categories: snapshot.data);
                }
              }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
          child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blueGrey.shade300, Colors.black],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0.1, 0.3])),
        child: Column(
          children: [
            createAppBar('Welcome'),
            const SizedBox(
              height: 5,
            ),
            createGrid(),
            createMusicList('Made for you'),
            createMusicList('Popular PlayList')
          ],
        ),
        //child: Text('Hello Flutter'),
        //color: Colors.orange,
      )),
    );
  }
}
