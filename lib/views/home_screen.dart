import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:photo_box/model/category.dart';
import 'package:photo_box/data/data.dart';
import 'package:http/http.dart' as http;
import 'package:photo_box/model/photo.dart';
import 'package:photo_box/widgets/widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Category> categories = new List();
  List<Photo> photos = new List();
  int page = 1;
  bool isLoading = false;
  getTrendingWallpaper() async {
    var respone = await http.get(
      'https://api.pexels.com/v1/curated?page=$page',
      headers: {'Authorization': apiKey},
    );

    setState(() {
      Map<String, dynamic> jsonData = jsonDecode(respone.body);
      jsonData["photos"].forEach((element) {
        Photo photo = new Photo();
        photo = Photo.fromJson(element);
        photos.add(photo);
      });
      isLoading = false;
    });
  }

  @override
  void initState() {
    getTrendingWallpaper();
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Photo',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'Box',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Color(0xfff5f8fd),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(border: InputBorder.none, hintText: 'Search ...'),
                    ),
                  ),
                  Icon(Icons.search),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 50,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 10),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: categories.length,
                separatorBuilder: (context, index) => SizedBox(width: 6),
                itemBuilder: (context, index) => CategoryTile(
                  imgUrl: categories[index].imgUrl,
                  title: categories[index].categoryName,
                ),
              ),
            ),
            SizedBox(height: 20),
            NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!isLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                  setState(() {
                    page++;
                    print(page);
                    getTrendingWallpaper();
                    isLoading = true;
                  });
                }
                return isLoading;
              },
              child: Expanded(
                child: staggeredPhotoGrid(photos, context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
