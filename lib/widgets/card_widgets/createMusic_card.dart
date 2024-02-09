import 'package:chatapp_firebase/models/category.dart';
import 'package:chatapp_firebase/models/music.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
//import 'package:audio_manager/audio_manager.dart';

import '../../models/playlist_model.dart';

class CreateMusicCard extends StatelessWidget {
  const CreateMusicCard({
    Key? key,
    required this.musics,
  }) : super(key: key);

  final List<Music> musics;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black12,
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: musics.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          final Music music = musics[index];

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 100,
                width: 100,
                child: InkWell(
                  child: Image.network(
                    music.songImgUri,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 0.5,
                width: 10,
              ),
              Text(
                music.songName,
                style: const TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 14),
              ),
              const SizedBox(
                height: 0.5,
                width: 10,
              ),
              Text(music.songGenre,
                  style: const TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontSize: 12))
            ],
          );
        },
      ),
    );
  }
}
