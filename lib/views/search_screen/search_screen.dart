import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/config.dart';
import 'controller/search_controller.dart';
import '../../widgets/app_bar_tilte.dart';
import '../../widgets/search_box.dart';
import '../../widgets/staggered_photo_grid.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key, required this.keyWord}) : super(key: key) {
    controller = Get.put(SearchController(keyWord: keyWord));
  }

  final String keyWord;
  late final SearchController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Config.backgroundColor,
        appBar: const CustomAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SearchBox(
                controller: controller.searchController,
                onSearch: (_) {
                  controller.searchPhotos(isNewSearch: true);
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GetBuilder<SearchController>(
                  builder: (controller) => StaggeredPhotoGrid(
                    photos: controller.photos,
                    heroTagPrefix: 'search_',
                    onReachedMax: () {
                      controller.searchPhotos(isNewSearch: false);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
