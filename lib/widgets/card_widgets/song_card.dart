import 'package:chatapp_firebase/pages/song_screen.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
//import 'package:audio_manager/audio_manager.dart';

import '../../models/songs_model.dart';

class SongCard extends StatelessWidget {
  const SongCard({
    Key? key,
    required this.songs,
  }) : super(key: key);

  final List<Song> songs;

  @override
  Widget build(BuildContext context) {
    final player = AudioPlayer();

//play the song
    void playSong(Song song) async {
      try {
        final duration = await player
            .setUrl(song.songUri); // Schemes: (https: | file: | asset: )
        await player.play();
      } catch (error) {
        debugPrint(error.toString());
      }
    }

//stop the song
    void stopSong() {
      player.stop();
    }

    return Expanded(
      child: Container(
        height: 300.0,
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: songs.length,
            itemBuilder: (BuildContext context, int index) {
              final Song song = songs[index];
              int? currentIndex;

              return InkWell(
                onDoubleTap: () {
                  song;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SongScreen()),
                  );
                },
                onTap: () {
                  if (player.playing) {
                    if (player.currentIndex != currentIndex) {
                      playSong(song);
                      currentIndex = player.currentIndex;
                    } else if (player.currentIndex == currentIndex) {
                      stopSong();
                    }
                  } else {
                    playSong(song);
                    currentIndex = player.currentIndex;
                  }
                },
                child: Container(
                  margin:
                      const EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage: NetworkImage(song.songImgUri),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                song.songName,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Text(
                                  song.songGenre,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w600),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.linear_scale_sharp),
                            iconSize: 18.0,
                            color: Colors.white,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
