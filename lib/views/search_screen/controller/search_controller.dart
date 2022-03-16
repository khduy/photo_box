import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../models/photo.dart';
import '../../../provider/photo_provider.dart';

class SearchController extends GetxController {
  final _photoProvider = PhotoProvider();

  var searchController = TextEditingController();
  var currentPage = 0;
  var isLoading = false;
  var photos = <Photo>[];

  SearchController({required String keyWord}) {
    searchController.text = keyWord;
  }

  @override
  onInit() async {
    super.onInit();
    await searchPhotos(isNewSearch: true);
  }

  Future<void> searchPhotos({int perPage = 20, bool isNewSearch = false}) async {
    if (!isLoading && searchController.text.trim().isNotEmpty) {
      isLoading = true;

      if (isNewSearch) {
        currentPage = 1;
        photos.clear();
      } else {
        currentPage++;
      }
      log("page: $currentPage");

      var temp = await _photoProvider.searchPhotos(
        keyWord: searchController.text,
        page: currentPage,
        perPage: perPage,
      );
      photos.addAll(temp);

      isLoading = false;
      update();
    }
  }
}
