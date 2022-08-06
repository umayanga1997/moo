import 'dart:math';
import 'package:moo/helper/raw_data.dart';

String formatBytes(int bytes, int decimals) {
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(bytes) / log(1024)).floor();
  return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
}

String findCategoryValue(String key) {
  int index = categories.indexWhere((element) => element.key == key);
  return categories[index].title;
}

String findLanguageValue(String key) {
  int index = languages.indexWhere((element) => element.key == key);
  return languages[index].data;
}
