import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:photo_box/config/config.dart';
import 'package:photo_box/models/photo.dart';
import 'package:photo_box/provider/photo_provider.dart';

class HomeController extends GetxController {
  final _photoProvider = PhotoProvider();
  var currentPage = 0;
  var searchController = TextEditingController();
  var categories = Config.categories;

  var isLoading = false;
  var photos = <Photo>[];

  @override
  onInit() async {
    super.onInit();
    await getCuratedPhotos();
  }

  Future<void> getCuratedPhotos({int perPage = 16}) async {
    if (!isLoading) {
      isLoading = true;
      currentPage++;
      log("current page: $currentPage");

      var temp = await _photoProvider.getCuratedPhotos(page: currentPage, perPage: perPage);
      photos.addAll(temp);

      isLoading = false;

      update();
    }
  }
}
