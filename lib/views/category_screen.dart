import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:photo_box/data/data.dart';
import 'package:photo_box/model/photo.dart';
import 'package:photo_box/widgets/widget.dart';
import 'package:http/http.dart' as http;

class CategoryScreen extends StatefulWidget {
  final String categoryName;
  CategoryScreen({@required this.categoryName});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Photo> photos = [];
  int page = 1;

  bool isLoading = false;
  getPhoto(String keyWord) async {
    var respone = await http.get(
      'https://api.pexels.com/v1/search?page=$page&per_page=16&query=$keyWord',
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
    getPhoto(widget.categoryName);
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
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 5),
              child: Text(
                widget.categoryName + ' photos',
                style: TextStyle(
                  fontSize: 16,
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
                    getPhoto(widget.categoryName);
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
