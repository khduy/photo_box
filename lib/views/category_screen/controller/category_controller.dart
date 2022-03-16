import 'dart:developer';

import 'package:get/get.dart';

import '../../../models/photo.dart';
import '../../../provider/photo_provider.dart';

class CategoryController extends GetxController {
  final _photoProvider = PhotoProvider();

  var currentPage = 0;
  var isLoading = false;
  var photos = <Photo>[];
  late String categoryName;

  CategoryController({required this.categoryName});

  @override
  onInit() async {
    super.onInit();
    await getPhotos();
  }

  Future<void> getPhotos({int perPage = 20}) async {
    if (!isLoading) {
      isLoading = true;
      currentPage++;
      log("page: $currentPage");

      var temp = await _photoProvider.searchPhotos(
        keyWord: categoryName,
        page: currentPage,
        perPage: perPage,
      );
      photos.addAll(temp);

      isLoading = false;
      update();
    }
  }
}
