import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:photo_box/model/photo.dart';

import 'package:gallery_saver/gallery_saver.dart';

class DetailScreen extends StatefulWidget {
  final Photo photo;
  final int indexPhoto;
  DetailScreen({this.photo, this.indexPhoto});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Hero(
              transitionOnUserGestures: true,
              tag: widget.indexPhoto,
              child: CachedNetworkImage(
                imageUrl: widget.photo.scr.portrait,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5, right: 3),
            child: Text(
              widget.photo.photographer,
              style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            //color: Colors.blue,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 2,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black26,
                      border: Border.all(width: 1, color: Colors.white30),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Save photo',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white70),
                        ),
                        Text(
                          'Photo will be saved to gallery',
                          style: TextStyle(fontSize: 11, color: Colors.white60),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
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
                    _saveNetworkImage();
                  },
                ),
                SizedBox(height: 5),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _saveNetworkImage() async {
    GallerySaver.saveImage(widget.photo.scr.original).then((bool success) {
      setState(() {
        Navigator.pop(context);
      });
    });
  }
}
