class CategoryModel {
  dynamic key;
  dynamic title;
  dynamic image;

  CategoryModel({required this.key, required this.title, required this.image});

  factory CategoryModel.fromDocument(document) {
    return CategoryModel(
      key: document['key'],
      title: document['title'],
      image: document['image'],
    );
  }

  CategoryModel.fromJson(Map<String, String> json) {
    key = json['key'];
    title = json['title'];
    image = json['image'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['key'] = key;
    data['title'] = title;
    data['image'] = image;
    return data;
  }
}
