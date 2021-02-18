import 'package:flutter/material.dart';
import 'package:photo_box/model/photo.dart';

class DetailScreen extends StatelessWidget {
  final Photo photo;
  DetailScreen({this.photo});
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
              tag: photo.scr.portrait,
              child: Image.network(
                photo.scr.large,
                fit: BoxFit.contain,
              ),
            ),
            onTap: () => Navigator.pop(context),
          ),
        )
      ],
    );
  }
}
