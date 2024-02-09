import 'dart:convert';

List<Song> songFromJson(String str) =>
    List<Song>.from(json.decode(str).map((x) => Song.fromJson(x)));

class Song {
  final String songId;
  final String songName;
  final String songUri;
  //final String songDuration;
  final String songGenre;
  final String userId;
  final String songImgUri;
  //final String releaseDate;

  const Song(
      {required this.songId,
      required this.songName,
      required this.songUri,
      required this.songGenre,
      required this.songImgUri,
      required this.userId});

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
        songId: json['songId'],
        songName: json['songName'],
        songUri: json['songUri'],
        songGenre: json['songGenre'],
        songImgUri: json['songImgUrl'],
        userId: json['userId']);
  }
}
