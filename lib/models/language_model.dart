class LanguageModel {
  dynamic key;
  dynamic data;

  LanguageModel({
    required this.key,
    required this.data,
  });

  factory LanguageModel.fromDocument(document) {
    return LanguageModel(
      key: document['key'],
      data: document['data'],
    );
  }

  LanguageModel.fromJson(Map<String, String> json) {
    key = json['key'];
    data = json['data'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['key'] = key;
    data['data'] = this.data;
    return data;
  }
}
