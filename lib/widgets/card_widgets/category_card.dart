import 'package:chatapp_firebase/models/category.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
//import 'package:audio_manager/audio_manager.dart';

import '../../models/playlist_model.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.categories,
  }) : super(key: key);

  final List<Category> categories;

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
        itemCount: categories.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          final Category category = categories[index];

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // add this line
                children: [
                  //Image.network(category.imageURL, fit: BoxFit.cover),
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(category.categoryImg),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      category.categoryName,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
