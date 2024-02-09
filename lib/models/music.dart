/*class Music {
  String name;
  String image;
  String desc;
  String audioURL;
  Music(this.name, this.image, this.desc, this.audioURL);
}*/

class Music {
  final String songId;
  final String songName;
  final String songGenre;
  final String userId;
  final String songUri;
  final String songImgUri;

  const Music({
    required this.songId,
    required this.songName,
    required this.songGenre,
    required this.userId,
    required this.songUri,
    required this.songImgUri,
  });

  factory Music.fromJson(Map<String, dynamic> json) {
    return Music(
      songId: json['songId'],
      songName: json['songName'],
      songGenre: json['songGenre'],
      userId: json['userId'],
      songUri: json['songUri'],
      songImgUri: json['songImgUri'],
    );
  }
}
