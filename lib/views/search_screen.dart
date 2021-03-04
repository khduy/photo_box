import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:photo_box/data/data.dart';
import 'package:photo_box/model/photo.dart';
import 'package:photo_box/widgets/widget.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  final String query;
  SearchScreen({@required this.query});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Photo> photos = [];
  int page = 1;
  bool isLoading = false;
  String query;
  getPhoto(String query) async {
    var respone = await http.get(
      'https://api.pexels.com/v1/search?query=$query&page=$page&per_page=16',
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

  String formatSearchText(String text) {
    String formatedText = text.trim();
    formatedText = formatedText.replaceAll(RegExp(r'\s'), '+');
    return formatedText;
  }

  @override
  void initState() {
    query = widget.query;
    _searchController.text = query;
    getPhoto(query);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                        decoration:
                            InputDecoration(border: InputBorder.none, hintText: 'Search ...'),
                      ),
                    ),
                    InkWell(
                      child: Icon(Icons.search),
                      onTap: () {
                        if (_searchController.text.trim() != "") {
                          photos.clear();
                          FocusScope.of(context).unfocus();
                          query = formatSearchText(_searchController.text);
                          print(query);
                          getPhoto(query);
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (!isLoading &&
                      scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                    setState(() {
                      page++;
                      print(page);
                      getPhoto(query);
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
      ),
    );
  }
}
