class DownloadDataModel {
  int? statusCode;
  String? message;
  Data? data;

  DownloadDataModel({this.statusCode, this.message, this.data});

  DownloadDataModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? dlLink;

  Data({this.dlLink});

  Data.fromJson(Map<String, dynamic> json) {
    dlLink = json['dlLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dlLink'] = dlLink!;
    return data;
  }
}
