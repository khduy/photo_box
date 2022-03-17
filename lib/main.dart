import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_box/config/custom_scroll_behavior.dart';
import 'views/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'PhotoBox',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: Home(),
    );
  }
}
