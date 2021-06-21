import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_box/config/config.dart';
import 'package:photo_box/views/category_screen/controller/category_controller.dart';

import 'package:photo_box/widgets/app_bar_tilte.dart';
import 'package:photo_box/widgets/staggered_photo_grid.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({required this.categoryName}) {
    controller = Get.put(CategoryController(categoryName: categoryName));
  }

  final String categoryName;
  late final CategoryController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.backgroundColor,
      appBar: AppBar(
        title: AppBarTilte(),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Config.backgroundColor,
        iconTheme: IconThemeData(
          color: Colors.indigo, //change your color here
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              categoryName + ' photos',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xff3a3b3c),
              ),
            ),
            SizedBox(height: 5),
            NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                  controller.getPhotos();
                }
                return true;
              },
              child: Expanded(
                child: GetBuilder<CategoryController>(
                  builder: (controller) => StaggeredPhotoGrid(controller.photos),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
