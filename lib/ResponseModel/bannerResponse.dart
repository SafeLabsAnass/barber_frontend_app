class BannerResponse {
  String? msgBannerResponse;
  List<BannerData>? bannerDataResponse;
  bool? bannerResponseSuccess;

  BannerResponse({String? msg, List<BannerData>? data, bool? success}) {
    this.msgBannerResponse = msg;
    this.bannerDataResponse = data;
    this.bannerResponseSuccess = success;
  }

  String? get msg => msgBannerResponse;
  set msg(String? msg) => msgBannerResponse = msg;
  List<BannerData>? get data => bannerDataResponse;
  set data(List<BannerData>? data) => bannerDataResponse = data;
  bool? get success => bannerResponseSuccess;
  set success(bool? success) => bannerResponseSuccess = success;

  BannerResponse.fromJson(Map<String, dynamic> json) {
    msgBannerResponse = json['msg'];
    if (json['data'] != null) {
      bannerDataResponse = <BannerData>[];
      json['data'].forEach((v) {
        bannerDataResponse!.add(new BannerData.fromJson(v));
      });
    }
    bannerResponseSuccess = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msgBannerResponse;
    if (this.bannerDataResponse != null) {
      data['data'] = this.bannerDataResponse!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.bannerResponseSuccess;
    return data;
  }
}

class BannerData {
  int? bannerDataId;
  String? bannerDataImage;
  String? bannerDataTitle;
  int? bannerDataStatus;
  String? bannerDataCreatedAt;
  String? bannerDataUpdatedAt;
  String? bannerDataImagePath;

  BannerData(
      {int? id,
      String? image,
      String? title,
      int? status,
      String? createdAt,
      String? updatedAt,
      String? imagePath}) {
    this.bannerDataId = id;
    this.bannerDataImage = image;
    this.bannerDataTitle = title;
    this.bannerDataStatus = status;
    this.bannerDataCreatedAt = createdAt;
    this.bannerDataUpdatedAt = updatedAt;
    this.bannerDataImagePath = imagePath;
  }

  int? get id => bannerDataId;
  set id(int? id) => bannerDataId = id;
  String? get image => bannerDataImage;
  set image(String? image) => bannerDataImage = image;
  String? get title => bannerDataTitle;
  set title(String? title) => bannerDataTitle = title;
  int? get status => bannerDataStatus;
  set status(int? status) => bannerDataStatus = status;
  String? get createdAt => bannerDataCreatedAt;
  set createdAt(String? createdAt) => bannerDataCreatedAt = createdAt;
  String? get updatedAt => bannerDataUpdatedAt;
  set updatedAt(String? updatedAt) => bannerDataUpdatedAt = updatedAt;
  String? get imagePath => bannerDataImagePath;
  set imagePath(String? imagePath) => bannerDataImagePath = imagePath;

  BannerData.fromJson(Map<String, dynamic> json) {
    bannerDataId = json['id'];
    bannerDataImage = json['image'];
    bannerDataTitle = json['title'];
    bannerDataStatus = json['status'];
    bannerDataCreatedAt = json['created_at'];
    bannerDataUpdatedAt = json['updated_at'];
    bannerDataImagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.bannerDataId;
    data['image'] = this.bannerDataImage;
    data['title'] = this.bannerDataTitle;
    data['status'] = this.bannerDataStatus;
    data['created_at'] = this.bannerDataCreatedAt;
    data['updated_at'] = this.bannerDataUpdatedAt;
    data['imagePath'] = this.bannerDataImagePath;
    return data;
  }
}
