import 'package:flutter/material.dart';
import 'package:photo_box/model/photo.dart';

class DetailScreen extends StatelessWidget {
  final Photo photo;
  final int indexPhoto;
  DetailScreen({this.photo, this.indexPhoto});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GestureDetector(
            child: Hero(
              tag: indexPhoto,
              child: Image.network(
                photo.scr.portrait,
                fit: BoxFit.cover,
              ),
            ),
            onTap: () => Navigator.pop(context),
          ),
        )
      ],
    );
  }
}
