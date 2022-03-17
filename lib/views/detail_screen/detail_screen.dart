import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' as html;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';

import '../../models/photo.dart';

class DetailScreen extends StatelessWidget {
  final Photo photo;
  final String heroTag;
  const DetailScreen({
    Key? key,
    required this.photo,
    required this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          PhotoView(
            imageProvider: CachedNetworkImageProvider(
              photo.scr.large2x,
            ),
            heroAttributes: PhotoViewHeroAttributes(
              tag: heroTag,
              transitionOnUserGestures: true,
            ),
            minScale: PhotoViewComputedScale.contained,
          ),
          // text can be see if the photo is white
          Container(
            height: 100,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black26,
                  Colors.transparent,
                ],
              ),
            ),
          ),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  padding: const EdgeInsets.only(),
                  child: const Icon(
                    Icons.download_sharp,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    checkPermission(context);
                  },
                ),
                CupertinoButton(
                  padding: const EdgeInsets.only(),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> checkPermission(context) async {
    if (kIsWeb) {
      showSavingDialog(context);
      await downloadImage(photo.scr.original);
      Get.back();
      return;
    }

    var status;
    if (Platform.isIOS) {
      status = await Permission.photos.request();
    }
    if (Platform.isAndroid) {
      status = await Permission.storage.request();
    } else {
      return;
    }

    switch (status) {
      case PermissionStatus.granted:
        showSavingDialog(context);
        await _saveNetworkImage(context);
        Get.back();
        break;
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Need permission to save photo'),
            duration: Duration(seconds: 1),
          ),
        );
    }
  }

  Future<void> _saveNetworkImage(context) async {
    await GallerySaver.saveImage(photo.scr.original).then((success) {
      if (success!) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Saved'),
            duration: Duration(seconds: 1),
          ),
        );
      }
      Get.back();
    });
  }

  Future<void> downloadImage(String imageUrl) async {
    try {
      // first we make a request to the url like you did
      // in the android and ios version
      final http.Response r = await http.get(
        Uri.parse(imageUrl),
      );

      // we get the bytes from the body
      final data = r.bodyBytes;
      // and encode them to base64
      final base64data = base64Encode(data);

      // then we create and AnchorElement with the html package
      final a = html.AnchorElement(href: 'data:image/jpeg;base64,$base64data');

      // set the name of the file we want the image to get
      // downloaded to
      a.download = 'photo.jpg';

      // and we click the AnchorElement which downloads the image
      a.click();
      // finally we remove the AnchorElement
      a.remove();
    } catch (e) {
      print(e);
    }
  }

  void showSavingDialog(context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: SizedBox(
          height: 60,
          width: 100,
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                padding: const EdgeInsets.all(5),
                child: const CircularProgressIndicator(),
              ),
              const Text('Saving...'),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
