import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:photo_box/models/photo.dart';

import 'package:gallery_saver/gallery_saver.dart';
import 'package:photo_view/photo_view.dart';

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
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              PhotoView(
                imageProvider: CachedNetworkImageProvider(
                  photo.scr.large,
                ),
                heroAttributes: PhotoViewHeroAttributes(
                  tag: indexPhoto,
                  transitionOnUserGestures: true,
                ),
                minScale: PhotoViewComputedScale.contained,
              ),
              // Container(
              //   height: Get.height,
              //   width: Get.width,
              //   child: Hero(
              //     transitionOnUserGestures: true,
              //     tag: indexPhoto,
              //     child: InteractiveViewer(
              //       minScale: 1,
              //       maxScale: 4,
              //       child: CachedNetworkImage(
              //         imageUrl: photo.scr.large,
              //         fit: BoxFit.fitWidth,
              //       ),
              //     ),
              //   ),
              // ),
              // text can be see if the photo is white
              Container(
                height: 100,
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
                // use Stack for the case where the photographer's name is too long
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        photo.photographer,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
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
                          onPressed: () async {
                            await checkPermission(context);
                          },
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.only(),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () => Get.back(),
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

  Future<void> checkPermission(context) async {
    var status;
    if (Platform.isIOS) {
      status = await Permission.photos.request();
    }
    if (Platform.isAndroid) {
      status = await Permission.storage.request();
    }
    
    switch (status) {
      case PermissionStatus.granted:
        await _saveNetworkImage(context);
        break;
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Need permission to save photo'),
            duration: Duration(seconds: 1),
          ),
        );
    }
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
      if (success!) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Saved'),
            duration: Duration(seconds: 1),
          ),
        );
      }
      Get.back();
    });
  }
}
