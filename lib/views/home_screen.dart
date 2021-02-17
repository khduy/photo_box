import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_box/model/category.dart';
import 'package:photo_box/data/data.dart';
import 'package:http/http.dart' as http;
import 'package:photo_box/model/photo.dart';
import 'package:photo_box/views/category_screen.dart';
import 'package:photo_box/views/search_screen.dart';
import 'package:photo_box/widgets/widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Category> categories = List();
  List<Photo> photos = List();
  int page = 1;
  bool isLoading = false;

  TextEditingController _searchController = TextEditingController();
  getTrendingPhoto() async {
    var respone = await http.get(
      'https://api.pexels.com/v1/curated?page=$page',
      headers: {'Authorization': apiKey},
    );

    setState(() {
      Map<String, dynamic> jsonData = jsonDecode(respone.body);
      jsonData["photos"].forEach((element) {
        Photo photo = Photo.fromJson(element);
        photos.add(photo);
      });
      isLoading = false;
    });
  }

  @override
  void initState() {
    getTrendingPhoto();
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: appBarTilte(),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Color(0xfff5f8fd),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(border: InputBorder.none, hintText: 'Search ...'),
                    ),
                  ),
                  InkWell(
                    child: Icon(Icons.search),
                    onTap: () {
                      if (_searchController.text != "") {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => SearchScreen(keyWord: _searchController.text),
                          ),
                        );
                      }
                    },
                  ),
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
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) =>
                            CategoryScreen(categoryName: categories[index].categoryName),
                      ),
                    );
                  },
                  child: CategoryTile(
                    imgUrl: categories[index].imgUrl,
                    title: categories[index].categoryName,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 5),
              child: Text(
                'Trending',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff3a3b3c),
                ),
              ),
            ),
            NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!isLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                  setState(() {
                    page++;
                    print(page);
                    getTrendingPhoto();
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
