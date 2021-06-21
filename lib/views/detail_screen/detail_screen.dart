import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:photo_box/models/photo.dart';

import 'package:gallery_saver/gallery_saver.dart';

class DetailScreen extends StatelessWidget {
  final Photo photo;
  final int indexPhoto;
  DetailScreen({required this.photo, required this.indexPhoto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          return Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: Hero(
                  transitionOnUserGestures: true,
                  tag: indexPhoto,
                  child: CachedNetworkImage(
                    imageUrl: photo.scr.large,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Container(
                height: 100,
                //color: Colors.black26,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black26,
                        Colors.transparent,
                      ]),
                ),
              ),
              SafeArea(
                bottom: false,
                minimum: EdgeInsets.all(5),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        photo.photographer,
                        style: TextStyle(
                            color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: [
                        Spacer(),
                        CupertinoButton(
                          padding: EdgeInsets.only(),
                          child: Icon(
                            Icons.download_sharp,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () => _saveNetworkImage(context),
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.only(),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _saveNetworkImage(context) async {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: Container(
          height: 60,
          width: 100,
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                padding: EdgeInsets.all(5),
                child: CircularProgressIndicator(),
              ),
              Text('Saving...'),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
    await GallerySaver.saveImage(photo.scr.original).then((success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Saved'),
          duration: Duration(seconds: 1),
        ),
      );
      Navigator.pop(context);
    });
  }
}
