import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:photo_box/data/data.dart';
import 'package:photo_box/model/photo.dart';
import 'package:photo_box/widgets/widget.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  final String keyWord;
  SearchScreen({@required this.keyWord});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Photo> photos = List();
  int page = 1;
  bool isLoading = false;
  String keyWord;
  getPhoto(String keyWord) async {
    var respone = await http.get(
      'https://api.pexels.com/v1/search?query=$keyWord&page=$page',
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
    keyWord = widget.keyWord;
    _searchController.text = keyWord;
    getPhoto(keyWord);
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
                        photos.clear();
                        keyWord = _searchController.text;
                        getPhoto(keyWord);
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!isLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                  setState(() {
                    page++;
                    print(page);
                    getPhoto(keyWord);
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
