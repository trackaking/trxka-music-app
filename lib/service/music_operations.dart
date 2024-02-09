import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../models/music.dart';
import '../shared/constants.dart';

class MusicOperations {
  MusicOperations._() {}

  static Future<List<Music>> getMusic() async {
    const storage = FlutterSecureStorage();
    List<Music> result = [];

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
        Music newCategory = Music(
            songId: song["songid"],
            songName: song["songname"],
            songGenre: song["songgenre"],
            userId: song["userid"],
            songUri: song["songuri"],
            songImgUri: song["songimguri"]);
        result.add(newCategory);
      }
      print(result);
    } catch (error) {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      debugPrint(error.toString());
      throw Exception('Failed to load songs');
    }

    return result;
  }
  /*
  static List<Music> getMusic() {
    return <Music>[
      Music(
          'The life of Pablo',
          'https://tse2.mm.bing.net/th?id=OIP.EtW2ZApKN_s6KoSodlix1QHaHa&pid=Api&P=0&h=180',
          'Kanye West',
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/2e/e2/7d/2ee27d35-5e1e-0fd0-42ea-359b5256403e/mzaf_9335390342361255150.plus.aac.p.m4a'),
      Music(
          'DAMN.',
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbmFHlLzvUftfqxtti2gYfZe4e-jGHfydq1g&usqp=CAU',
          'Kendrick Lamar',
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/ad/53/bf/ad53bf8c-9bf2-90d7-05d4-ec34186f33ff/mzaf_13379019530104319252.plus.aac.p.m4a'),
      Music(
          'DS2 (Deluxe)',
          'https://tse1.mm.bing.net/th?id=OIP.l9vE-BnkstbhMzyVU9pQYAHaHa&pid=Api&P=0&h=180',
          'Future',
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/09/17/bb/0917bbe1-58c3-6252-d00e-9b70d42ef5dc/mzaf_2269500085377778268.plus.aac.p.m4a'),
      Music(
          'Scorpion',
          'https://tse2.mm.bing.net/th?id=OIP.jAXEVWr0KYQ6vOkUNCbywAAAAA&pid=Api&P=0&h=180',
          'Drake',
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/71/f8/b2/71f8b2fd-b62b-55e2-cc4b-d3b0a4e5f0f8/mzaf_16351999812808951944.plus.aac.p.m4a')
    ];
  }
  */
}
