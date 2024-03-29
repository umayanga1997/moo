import 'package:moo/helper/help_functions.dart';

class MovieModel {
  String? id;
  String? name;
  String? description;
  String? thumbnailURl;
  String? year;
  String? category;
  String? language;
  String? director;
  String? actors;
  String? downloadID;
  String? catName;
  String? lanName;
  MovieModel({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnailURl,
    required this.year,
    required this.category,
    required this.language,
    required this.director,
    required this.actors,
    required this.downloadID,
    required this.catName,
    required this.lanName,
  });

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['id'] = id ?? '';
    data['name'] = name ?? '';
    data['description'] = description ?? '';
    data['thumbnailURl'] = thumbnailURl ?? '';
    data['year'] = year ?? '';
    data['category'] = category ?? '';
    data['language'] = language ?? '';
    data['director'] = director ?? '';
    data['actors'] = actors ?? '';
    data['actors'] = actors ?? '';
    data['downloadID'] = downloadID ?? '';
    data['catName'] = catName ?? '';
    return data;
  }

  MovieModel.fromJson(json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    thumbnailURl = json['thumbnailURl'];
    year = json['year'];
    category = json['category'];
    language = json['language'];
    director = json['director'];
    actors = json['actors'];
    downloadID = json['downloadID'];
    catName = findCategoryValue(json['category']);
    lanName = findLanguageValue(json['language']);
  }
}
