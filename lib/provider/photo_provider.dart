import 'dart:convert';

import '../config/config.dart';
import '../models/photo.dart';
import 'package:http/http.dart' as http;

class PhotoProvider {
  Future<List<Photo>> getCuratedPhotos({required int page, int perPage = 16}) async {
    var photos = <Photo>[];
    var respone = await http.get(
      Uri.parse('https://api.pexels.com/v1/curated?page=$page&per_page=$perPage'),
      headers: {'Authorization': Config.apiKey},
    );
    Map<String, dynamic> jsonData = jsonDecode(respone.body);
    jsonData["photos"].forEach((element) {
      Photo photo = Photo.fromJson(element);
      photos.add(photo);
    });
    return photos;
  }

  Future<List<Photo>> searchPhotos({
    required String keyWord,
    required int page,
    int perPage = 16,
  }) async {
    var photos = <Photo>[];
    var respone = await http.get(
      Uri.parse('https://api.pexels.com/v1/search?query=$keyWord&page=$page&per_page=$perPage'),
      headers: {'Authorization': Config.apiKey},
    );
    Map<String, dynamic> jsonData = jsonDecode(respone.body);
    jsonData["photos"].forEach((element) {
      Photo photo = Photo.fromJson(element);
      photos.add(photo);
    });
    return photos;
  }
}
