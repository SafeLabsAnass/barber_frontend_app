class CategoryDataResponse {
  String? msgCategoryDataResponse;
  List<CategoryData>? dataCategoryDataResponse;
  bool? successCategoryDataResponse;

  CategoryDataResponse({String? msg, List<CategoryData>? data, bool? success}) {
    this.msgCategoryDataResponse = msg;
    this.dataCategoryDataResponse = data;
    this.successCategoryDataResponse = success;
  }

  String? get msg => msgCategoryDataResponse;
  set msg(String? msg) => msgCategoryDataResponse = msg;
  List<CategoryData>? get data => dataCategoryDataResponse;
  set data(List<CategoryData>? data) => dataCategoryDataResponse = data;
  bool? get success => successCategoryDataResponse;
  set success(bool? success) => successCategoryDataResponse = success;

  CategoryDataResponse.fromJson(Map<String, dynamic> json) {
    msgCategoryDataResponse = json['msg'];
    if (json['data'] != null) {
      dataCategoryDataResponse = <CategoryData>[];
      json['data'].forEach((v) {
        dataCategoryDataResponse!.add(new CategoryData.fromJson(v));
      });
    }
    successCategoryDataResponse = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msgCategoryDataResponse;
    if (this.dataCategoryDataResponse != null) {
      data['data'] = this.dataCategoryDataResponse!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.successCategoryDataResponse;
    return data;
  }
}

class CategoryData {
  int? categoryDataId;
  String? categoryDataName;
  String? categoryDataImage;
  int? categoryDataStatus;
  String? categoryDataCreatedAt;
  String? categoryDataUpdatedAt;
  String? categoryDataImagePath;

  CategoryData(
      {int? catId,
      String? name,
      String? image,
      int? status,
      String? createdAt,
      String? updatedAt,
      String? imagePath}) {
    this.categoryDataId = catId;
    this.categoryDataName = name;
    this.categoryDataImage = image;
    this.categoryDataStatus = status;
    this.categoryDataCreatedAt = createdAt;
    this.categoryDataUpdatedAt = updatedAt;
    this.categoryDataImagePath = imagePath;
  }

  int? get catId => categoryDataId;
  set catId(int? catId) => categoryDataId = catId;
  String? get name => categoryDataName;
  set name(String? name) => categoryDataName = name;
  String? get image => categoryDataImage;
  set image(String? image) => categoryDataImage = image;
  int? get status => categoryDataStatus;
  set status(int? status) => categoryDataStatus = status;
  String? get createdAt => categoryDataCreatedAt;
  set createdAt(String? createdAt) => categoryDataCreatedAt = createdAt;
  String? get updatedAt => categoryDataUpdatedAt;
  set updatedAt(String? updatedAt) => categoryDataUpdatedAt = updatedAt;
  String? get imagePath => categoryDataImagePath;
  set imagePath(String? imagePath) => categoryDataImagePath = imagePath;

  CategoryData.fromJson(Map<String, dynamic> json) {
    categoryDataId = json['cat_id'];
    categoryDataName = json['name'];
    categoryDataImage = json['image'];
    categoryDataStatus = json['status'];
    categoryDataCreatedAt = json['created_at'];
    categoryDataUpdatedAt = json['updated_at'];
    categoryDataImagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cat_id'] = this.categoryDataId;
    data['name'] = this.categoryDataName;
    data['image'] = this.categoryDataImage;
    data['status'] = this.categoryDataStatus;
    data['created_at'] = this.categoryDataCreatedAt;
    data['updated_at'] = this.categoryDataUpdatedAt;
    data['imagePath'] = this.categoryDataImagePath;
    return data;
  }
}
