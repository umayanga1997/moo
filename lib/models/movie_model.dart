class MovieModel {
  String? name;
  String? description;
  String? thumbnailURl;
  String? year;
  String? category;
  String? language;
  String? director;
  String? actors;
  String? movieDownloadName;
  String? downloadID;
  MovieModel({
    required this.name,
    required this.description,
    required this.thumbnailURl,
    required this.year,
    required this.category,
    required this.language,
    required this.director,
    required this.actors,
    required this.movieDownloadName,
    required this.downloadID,
  });

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['name'] = name ?? '';
    data['description'] = description ?? '';
    data['thumbnailURl'] = thumbnailURl ?? '';
    data['year'] = year ?? '';
    data['category'] = category ?? '';
    data['language'] = language ?? '';
    data['director'] = director ?? '';
    data['actors'] = actors ?? '';
    data['movieDownloadName'] = movieDownloadName ?? '';
    data['downloadID'] = downloadID ?? '';
    return data;
  }

  MovieModel.fromJson(Map<String, String> json) {
    name = json['name'];
    description = json['description'];
    thumbnailURl = json['thumbnailURl'];
    year = json['year'];
    category = json['category'];
    language = json['language'];
    director = json['director'];
    actors = json['actors'];
    movieDownloadName = json['movieDownloadName'];
    downloadID = json['downloadID'];
  }
}
