import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/config.dart';
import 'controller/category_controller.dart';

import '../../widgets/app_bar_tilte.dart';
import '../../widgets/staggered_photo_grid.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({Key? key, required this.categoryName}) : super(key: key) {
    controller = Get.put(CategoryController(categoryName: categoryName));
  }

  final String categoryName;
  late final CategoryController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.backgroundColor,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              categoryName + ' photos',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xff3a3b3c),
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: GetBuilder<CategoryController>(builder: (controller) {
                return StaggeredPhotoGrid(
                  photos: controller.photos,
                  onReachedMax: () {
                    controller.getPhotos();
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
