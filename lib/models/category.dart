/*class Category {
  String name;
  String imageURL;
  Category(this.name, this.imageURL);
}
*/
class Category {
  final int categoryId;
  final String categoryName;
  final String categoryImg;
  final String catgoryGenre;

  const Category({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImg,
    required this.catgoryGenre,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      categoryImg: json['categoryImg'],
      catgoryGenre: json['catgoryGenre'],
    );
  }
}
