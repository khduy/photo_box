import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_box/config/config.dart';
import 'package:photo_box/views/home_screen/controller/home_controller.dart';

import '../category_screen/category_screen.dart';
import '../search_screen/search_screen.dart';
import '../../widgets/app_bar_tilte.dart';
import '../../widgets/category_item.dart';
import '../../widgets/search_box.dart';
import '../../widgets/staggered_photo_grid.dart';

class Home extends StatelessWidget {
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Config.backgroundColor,
        appBar: AppBar(
          title: AppBarTilte(),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Config.backgroundColor,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBox(
                controller: controller.searchController,
                onSearch: (_) {
                  controller.searchController.text = controller.searchController.text.trim();
                  if (controller.searchController.text.isNotEmpty) {
                    Get.to(
                      () => SearchScreen(keyWord: controller.searchController.text),
                      //transition: Transition.fadeIn,
                    );
                    FocusScope.of(context).unfocus();
                  }
                },
              ),
              SizedBox(height: 10),
              Container(
                height: 40,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: controller.categories.length,
                    separatorBuilder: (context, index) => SizedBox(width: 6),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(
                            () => CategoryScreen(
                              categoryName: controller.categories[index].categoryName,
                            ),
                            //transition: Transition.fadeIn,
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
              SizedBox(height: 20),
              Text(
                'Trending',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Config.headerTilteColor,
                ),
              ),
              SizedBox(height: 10),
              NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                    controller.getCuratedPhotos();
                  }
                  return true;
                },
                child: Expanded(
                  child: GetBuilder<HomeController>(
                    builder: (controller) => StaggeredPhotoGrid(controller.photos),
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
