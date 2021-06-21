import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_box/config/config.dart';
import 'package:photo_box/views/search_screen/controller/search_controller.dart';
import 'package:photo_box/widgets/app_bar_tilte.dart';
import 'package:photo_box/widgets/search_box.dart';
import 'package:photo_box/widgets/staggered_photo_grid.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({required this.keyWord}) {
    controller = Get.put(SearchController(keyWord: keyWord));
  }

  final String keyWord;
  late final controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Config.backgroundColor,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.indigo, //change your color here
          ),
          title: AppBarTilte(),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Config.backgroundColor,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SearchBox(
                  controller: controller.searchController,
                  onSearch: (_) {
                    controller.searchPhotos(isNewSearch: true);
                  },
                ),
                SizedBox(height: 20),
                NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                      controller.searchPhotos();
                    }
                    return true;
                  },
                  child: Expanded(
                    child: GetBuilder<SearchController>(
                      builder: (controller) => StaggeredPhotoGrid(controller.photos),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
