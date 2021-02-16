import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper_app/model/category.dart';
import 'package:wallpaper_app/data/data.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/model/photo.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Category> categories = new List();
  List<Photo> photos = new List();

  getTrendingWallpaper() async {
    var respone = await http.get(
      'https://api.pexels.com/v1/curated?per_page=20',
      headers: {'Authorization': apiKey},
    );

    setState(() {
      Map<String, dynamic> jsonData = jsonDecode(respone.body);
      jsonData["photos"].forEach((element) {
        Photo photo = new Photo();
        photo = Photo.fromJson(element);
        photos.add(photo);
      });
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
                text: 'Wallpaper',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'Hub',
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
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
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Search wallpaper...'),
                      ),
                    ),
                    Icon(Icons.search),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 50,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index) => CategoryTile(
                    imgUrl: categories[index].imgUrl,
                    title: categories[index].categoryName,
                  ),
                ),
              ),
              SizedBox(height: 20),
              StaggeredGridView.countBuilder(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                crossAxisCount: 4,
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Image.network(photos[index].scr.large),
                  );
                },
                staggeredTileBuilder: (index) => new StaggeredTile.fit(2),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String imgUrl;
  final String title;
  CategoryTile({@required this.imgUrl, @required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              imgUrl,
              width: 100,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
