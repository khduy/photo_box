import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

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
      body: Builder(
        builder: (context) => Stack(
          alignment: AlignmentDirectional.bottomStart,
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
            // SafeArea(
            //   child: Padding(
            //     padding: const EdgeInsets.only(top: 3, left: 3),
            //     child: Text(
            //       widget.photo.photographer,
            //       style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
            //     ),
            //   ),
            // ),
            // Container(
            //   //color: Colors.blue,
            //   height: MediaQuery.of(context).size.height,
            //   width: MediaQuery.of(context).size.width,
            //   alignment: Alignment.bottomCenter,
            //   child: Column(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       InkWell(
            //         child: Container(
            //           alignment: Alignment.center,
            //           width: MediaQuery.of(context).size.width / 2,
            //           height: 50,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(20),
            //             color: Colors.black26,
            //             border: Border.all(width: 1, color: Colors.white30),
            //           ),
            //           child: Column(
            //             mainAxisSize: MainAxisSize.min,
            //             children: [
            //               Text(
            //                 'Save photo',
            //                 style: TextStyle(
            //                     fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white70),
            //               ),
            //               Text(
            //                 'Photo will be saved to gallery',
            //                 style: TextStyle(fontSize: 11, color: Colors.white60),
            //               ),
            //             ],
            //           ),
            //         ),
            //         onTap: () {
            //           //todo: handle permission
            //           _saveNetworkImage(context);
            //         },
            //       ),
            //       SizedBox(height: 5),
            //       CupertinoButton(
            //         child: Text(
            //           'Cancel',
            //           style: TextStyle(
            //               fontSize: 15,
            //               decoration: TextDecoration.underline,
            //               color: Colors.white70,
            //               fontWeight: FontWeight.w500),
            //         ),
            //         onPressed: () {
            //           Navigator.pop(context);
            //         },
            //       ),
            //       SizedBox(
            //         height: 50,
            //       ),
            //     ],
            //   ),
            // ),
            Container(
              height: 50,
              //color: Colors.black26,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black38,
                      Colors.transparent,
                    ]),
              ),
            ),
            SafeArea(
              bottom: false,
              minimum: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      widget.photo.photographer,
                      style:
                          TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
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
            ),
          ],
        ),
      ),
    );
  }

  void _saveNetworkImage(context) async {
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
    await GallerySaver.saveImage(widget.photo.scr.original).then((bool success) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Saved'),
        duration: Duration(seconds: 1),
      ));
      Navigator.pop(context);
    });
  }
}
