import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../models/photo.dart';

import '../views/detail_screen/detail_screen.dart';

class StaggeredPhotoGrid extends StatefulWidget {
  final List<Photo> photos;
  final VoidCallback onReachedMax;
  final String heroTagPrefix;

  const StaggeredPhotoGrid({
    Key? key,
    required this.photos,
    required this.onReachedMax,
    required this.heroTagPrefix,
  }) : super(key: key);

  @override
  State<StaggeredPhotoGrid> createState() => _StaggeredPhotoGridState();
}

class _StaggeredPhotoGridState extends State<StaggeredPhotoGrid> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      physics: const BouncingScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 5,
      crossAxisSpacing: 5,
      itemCount: widget.photos.length,
      controller: _scrollController,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Hero(
            tag: widget.heroTagPrefix + index.toString(),
            child: AspectRatio(
              aspectRatio: widget.photos[index].width / widget.photos[index].height,
              child: CachedNetworkImage(
                imageUrl: widget.photos[index].scr.large,
                placeholder: (context, url) => Container(
                  color: Color(int.parse('0xff' + widget.photos[index].avgColor.substring(1))),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          onTap: () {
            FocusScope.of(context).unfocus();

            Get.to(
              () => DetailScreen(
                photo: widget.photos[index],
                heroTag: widget.heroTagPrefix + index.toString(),
              ),
              transition: Transition.fadeIn,
            );
          },
        );
      },
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll == 0) {
      widget.onReachedMax();
    }
  }
}
