import 'dart:convert';

List<Playlist> playlistFromJson(String str) =>
    List<Playlist>.from(json.decode(str).map((x) => Playlist.fromJson(x)));

class Playlist {
  final String playlistId;
  final String userId;
  final String playlistName;
  final String playlistCoverUrl;
  final int playlistDuration;

  const Playlist({
    required this.playlistId,
    required this.userId,
    required this.playlistName,
    required this.playlistCoverUrl,
    required this.playlistDuration,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      playlistId: json['playlistId'],
      userId: json['userId'],
      playlistName: json['playlistName'],
      playlistCoverUrl: json['playlistCoverUrl'],
      playlistDuration: json['playlistDuration'],
    );
  }
}
