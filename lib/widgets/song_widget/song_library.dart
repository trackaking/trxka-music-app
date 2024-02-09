import 'dart:convert';
import 'package:chatapp_firebase/models/playlist_model.dart';
import 'package:chatapp_firebase/widgets/card_widgets/song_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../models/songs_model.dart';
import '../../shared/constants.dart';
import '../card_widgets/playlist_card.dart';

class SongLibrary extends StatefulWidget {
  const SongLibrary({super.key});

  @override
  State<SongLibrary> createState() => _SongLibraryState();
}

//import
List<Playlist> songs = [];
const storage = FlutterSecureStorage();

//get playlist function
Future<List<Playlist>> getPlaylists() async {
  List<Playlist> result = [];

  String? token = await storage.read(key: "token") as String;

  var headers = {
    'access-token': token,
    "Accept": "application/json",
    'Content-Type': 'application/json; charset=UTF-8',
  };

  try {
    final response = await http
        .get(
          Uri.parse("${Constants.serverUrl}playlist/user-playlist"),
          headers: headers,
        )
        .timeout(const Duration(seconds: 5));

    var jsonData = jsonDecode(response.body);

    for (var song in jsonData) {
      Playlist newPlaylist = Playlist(
        playlistId: song['playlistId'],
        userId: song['userId'],
        playlistName: song['playlistName'],
        playlistCoverUrl: song['playlistCoverUrl'],
        playlistDuration: song['playlistDuration'],
      );
      result.add(newPlaylist);
    }
  } catch (error) {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    debugPrint(error.toString());
    throw Exception('Failed to load songs');
  }

  return result;
}

//get songs
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
          songId: song["songid"],
          songName: song["songname"],
          songUri: song["songuri"],
          songGenre: song["songgenre"],
          songImgUri: song["songimguri"],
          userId: song["userid"]);
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

class _SongLibraryState extends State<SongLibrary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 150,
        leading: const SizedBox(
          child: Center(
            child: Text(
              "Your Library",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: <Widget>[
          //const CategorySelector(),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Column(
                children: <Widget>[
                  FutureBuilder(
                      future: getSongs(), //getPlaylist()
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          //return PlaylistCard(playlists: snapshot.data);
                          return SongCard(songs: snapshot.data);
                        }
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
