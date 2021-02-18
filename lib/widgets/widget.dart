import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:photo_box/model/photo.dart';
import 'package:photo_box/views/detail_screen.dart';

class CategoryTile extends StatelessWidget {
  final String imgUrl;
  final String title;
  CategoryTile({@required this.imgUrl, @required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              color: Colors.grey,
              child: Image.network(
                imgUrl,
                width: 100,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

Widget staggeredPhotoGrid(List<Photo> photos, context) {
  return StaggeredGridView.countBuilder(
    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
    //shrinkWrap: true,
    physics: BouncingScrollPhysics(),
    crossAxisCount: 4,
    itemCount: photos.length,
    itemBuilder: (context, index) {
      return Container(
        child: GestureDetector(
          child: Hero(
            tag: photos[index].scr.portrait,
            child: Image.network(photos[index].scr.large),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(
                  photo: photos[index],
                ),
              ),
            );
          },
        ),
      );
    },
    staggeredTileBuilder: (index) => new StaggeredTile.fit(2),
    mainAxisSpacing: 8,
    crossAxisSpacing: 8,
  );
}

Widget appBarTilte() {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: 'Photo',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: 'Box',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
