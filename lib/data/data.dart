import 'package:photo_box/model/category.dart';

String apiKey = '563492ad6f91700001000001fc80e67b4d9b4ec6bb422a7307f2f1a2';

List<Category> getCategories() {
  List<Category> categories = [];

  Category category = new Category();
  category.categoryName = 'Street Art';
  category.imgUrl =
      'https://images.pexels.com/photos/162379/lost-places-pforphoto-leave-factory-162379.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500';
  categories.add(category);

  category = new Category();
  category.categoryName = 'Wild Life';
  category.imgUrl =
      'https://images.pexels.com/photos/16066/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500';
  categories.add(category);

  category = new Category();
  category.categoryName = 'Nature';
  category.imgUrl =
      'https://images.pexels.com/photos/1671324/pexels-photo-1671324.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500';
  categories.add(category);

  category = new Category();
  category.categoryName = 'Cars';
  category.imgUrl =
      'https://images.pexels.com/photos/3311574/pexels-photo-3311574.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500';
  categories.add(category);

  return categories;
}
