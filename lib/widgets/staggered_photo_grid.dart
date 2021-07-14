import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../models/photo.dart';
import '../views/detail_screen/detail_screen.dart';

class StaggeredPhotoGrid extends StatelessWidget {
  final List<Photo> photos;
  StaggeredPhotoGrid(
    this.photos,
  );

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      physics: BouncingScrollPhysics(),
      crossAxisCount: 2,
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Container(
          child: GestureDetector(
            child: Hero(
              tag: index,
              child: AspectRatio(
                aspectRatio: photos[index].width / photos[index].height,
                child: CachedNetworkImage(
                  imageUrl: photos[index].scr.large,
                  placeholder: (context, url) => Container(
                    color: Color(int.parse('0xff' + photos[index].avgColor.substring(1))),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            onTap: () {
              FocusScope.of(context).unfocus();
              Get.to(
                () => DetailScreen(photo: photos[index], indexPhoto: index),
                transition: Transition.fadeIn,
              );
            },
          ),
        );
      },
      staggeredTileBuilder: (index) => StaggeredTile.fit(1),
      mainAxisSpacing: 5,
      crossAxisSpacing: 5,
    );
  }
}
