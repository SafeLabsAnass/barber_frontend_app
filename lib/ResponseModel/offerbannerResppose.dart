class OfferBannerResponse {
  String? msgOfferBannerResponse;
  List<OfferBannerList>? offerBannerResponseList;
  bool? successOfferBannerResponse;

  OfferBannerResponse({String? msg, List<OfferBannerList>? data, bool? success}) {
    this.msgOfferBannerResponse = msg;
    this.offerBannerResponseList = data;
    this.successOfferBannerResponse = success;
  }

  String? get msg => msgOfferBannerResponse;
  set msg(String? msg) => msgOfferBannerResponse = msg;
  List<OfferBannerList>? get data => offerBannerResponseList;
  set data(List<OfferBannerList>? data) => offerBannerResponseList = data;
  bool? get success => successOfferBannerResponse;
  set success(bool? success) => successOfferBannerResponse = success;

  OfferBannerResponse.fromJson(Map<String, dynamic> json) {
    msgOfferBannerResponse = json['msg'];
    if (json['data'] != null) {
      offerBannerResponseList = <OfferBannerList>[];
      json['data'].forEach((v) {
        offerBannerResponseList!.add(new OfferBannerList.fromJson(v));
      });
    }
    successOfferBannerResponse = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msgOfferBannerResponse;
    if (this.offerBannerResponseList != null) {
      data['data'] = this.offerBannerResponseList!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.successOfferBannerResponse;
    return data;
  }
}

class OfferBannerList {
  int? offerBannerListId;
  String? offerBannerListImage;
  String? offerBannerListTitle;
  int? offerBannerListDiscount;
  int? offerBannerListStatus;
  String? offerBannerListCreatedAt;
  String? offerBannerListUpdatedAt;
  String? offerBannerListImagePath;

  OfferBannerList(
      {int? id,
      String? image,
      String? title,
      int? discount,
      int? status,
      String? createdAt,
      String? updatedAt,
      String? imagePath}) {
    this.offerBannerListId = id;
    this.offerBannerListImage = image;
    this.offerBannerListTitle = title;
    this.offerBannerListDiscount = discount;
    this.offerBannerListStatus = status;
    this.offerBannerListCreatedAt = createdAt;
    this.offerBannerListUpdatedAt = updatedAt;
    this.offerBannerListImagePath = imagePath;
  }

  int? get id => offerBannerListId;
  set id(int? id) => offerBannerListId = id;
  String? get image => offerBannerListImage;
  set image(String? image) => offerBannerListImage = image;
  String? get title => offerBannerListTitle;
  set title(String? title) => offerBannerListTitle = title;
  int? get discount => offerBannerListDiscount;
  set discount(int? discount) => offerBannerListDiscount = discount;
  int? get status => offerBannerListStatus;
  set status(int? status) => offerBannerListStatus = status;
  String? get createdAt => offerBannerListCreatedAt;
  set createdAt(String? createdAt) => offerBannerListCreatedAt = createdAt;
  String? get updatedAt => offerBannerListUpdatedAt;
  set updatedAt(String? updatedAt) => offerBannerListUpdatedAt = updatedAt;
  String? get imagePath => offerBannerListImagePath;
  set imagePath(String? imagePath) => offerBannerListImagePath = imagePath;

  OfferBannerList.fromJson(Map<String, dynamic> json) {
    offerBannerListId = json['id'];
    offerBannerListImage = json['image'];
    offerBannerListTitle = json['title'];
    offerBannerListDiscount = json['discount'];
    offerBannerListStatus = json['status'];
    offerBannerListCreatedAt = json['created_at'];
    offerBannerListUpdatedAt = json['updated_at'];
    offerBannerListImagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.offerBannerListId;
    data['image'] = this.offerBannerListImage;
    data['title'] = this.offerBannerListTitle;
    data['discount'] = this.offerBannerListDiscount;
    data['status'] = this.offerBannerListStatus;
    data['created_at'] = this.offerBannerListCreatedAt;
    data['updated_at'] = this.offerBannerListUpdatedAt;
    data['imagePath'] = this.offerBannerListImagePath;
    return data;
  }
}
