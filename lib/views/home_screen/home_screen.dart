import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/config.dart';
import 'controller/home_controller.dart';

import '../category_screen/category_screen.dart';
import '../search_screen/search_screen.dart';
import '../../widgets/app_bar_tilte.dart';
import '../../widgets/category_item.dart';
import '../../widgets/search_box.dart';
import '../../widgets/staggered_photo_grid.dart';

class Home extends StatelessWidget {
  final controller = Get.put(HomeController());

  Home({Key? key}) : super(key: key);

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBox(
                controller: controller.searchController,
                onSearch: (value) {
                  controller.searchController.text = controller.searchController.text.trim();
                  if (controller.searchController.text.isNotEmpty) {
                    Get.to(
                      () => SearchScreen(keyWord: controller.searchController.text),
                    );
                    FocusScope.of(context).unfocus();
                  }
                },
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 40,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: controller.categories.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 6),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(
                            () => CategoryScreen(
                              categoryName: controller.categories[index].categoryName,
                            ),
                          );
                          FocusScope.of(context).unfocus();
                        },
                        child: CategoryItem(
                          imgUrl: controller.categories[index].imgUrl,
                          title: controller.categories[index].categoryName,
                        ),
                      );
                    }),
              ),
              const SizedBox(height: 20),
              const Text(
                'Trending',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Config.headerTilteColor,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GetBuilder<HomeController>(builder: (controller) {
                  return StaggeredPhotoGrid(
                    photos: controller.photos,
                    heroTagPrefix: 'home_',
                    onReachedMax: () {
                      controller.getCuratedPhotos();
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
