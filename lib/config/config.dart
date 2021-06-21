import 'package:flutter/cupertino.dart';
import 'package:photo_box/models/category.dart';

class Config {
  static final String apiKey = '563492ad6f91700001000001fc80e67b4d9b4ec6bb422a7307f2f1a2';

  static final List<Category> categories = [
    Category(
      categoryName: 'Ocean',
      imgUrl:
          'https://images.pexels.com/photos/1350197/pexels-photo-1350197.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280',
    ),
    Category(
      categoryName: 'Wild Life',
      imgUrl:
          'https://images.pexels.com/photos/247431/pexels-photo-247431.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280',
    ),
    Category(
      categoryName: 'Colors',
      imgUrl:
          'https://images.pexels.com/photos/1209843/pexels-photo-1209843.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280',
    ),
    Category(
      categoryName: 'Words',
      imgUrl:
          'https://images.pexels.com/photos/954599/pexels-photo-954599.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280',
    ),
    Category(
      categoryName: 'Nature',
      imgUrl:
          'https://images.pexels.com/photos/1671324/pexels-photo-1671324.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280',
    ),
    Category(
      categoryName: 'Street Art',
      imgUrl:
          'https://images.pexels.com/photos/162379/lost-places-pforphoto-leave-factory-162379.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280',
    ),
    Category(
      categoryName: 'Retro',
      imgUrl:
          'https://images.pexels.com/photos/1626481/pexels-photo-1626481.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280',
    ),
    Category(
      categoryName: 'Candle',
      imgUrl:
          'https://images.pexels.com/photos/1123256/pexels-photo-1123256.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280',
    ),
    Category(
      categoryName: 'Cars',
      imgUrl:
          'https://images.pexels.com/photos/3311574/pexels-photo-3311574.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280',
    ),
    Category(
      categoryName: 'Landscapes',
      imgUrl:
          'https://images.pexels.com/photos/3867818/pexels-photo-3867818.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280',
    ),
  ];

  static final backgroundColor = Color(0xFFF6F6F6);

  static final headerTilteColor = Color(0xFF0E0B0D);

  //static final textColor = Color(0xFF747485);
}
