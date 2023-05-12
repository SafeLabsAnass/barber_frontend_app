class SharedSettingResponse {
  SharedSettingResponse({
      String? msg, 
      Data? data, 
      bool? success,}){
    _msg = msg;
    _data = data;
    _success = success;
}

  SharedSettingResponse.fromJson(dynamic json) {
    _msg = json['msg'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _success = json['success'];
  }
  String? _msg;
  Data? _data;
  bool? _success;

  String? get msg => _msg;
  Data? get data => _data;
  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['success'] = _success;
    return map;
  }

}
class Data {
  Data({
      String? sharedName, 
      String? sharedImage, 
      String? sharedUrl, 
      String? imagePath,}){
    _sharedName = sharedName;
    _sharedImage = sharedImage;
    _sharedUrl = sharedUrl;
    _imagePath = imagePath;
}

  Data.fromJson(dynamic json) {
    _sharedName = json['shared_name'];
    _sharedImage = json['shared_image'];
    _sharedUrl = json['shared_url'];
    _imagePath = json['imagePath'];
  }
  String? _sharedName;
  String? _sharedImage;
  String? _sharedUrl;
  String? _imagePath;

  String? get sharedName => _sharedName;
  String? get sharedImage => _sharedImage;
  String? get sharedUrl => _sharedUrl;
  String? get imagePath => _imagePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['shared_name'] = _sharedName;
    map['shared_image'] = _sharedImage;
    map['shared_url'] = _sharedUrl;
    map['imagePath'] = _imagePath;
    return map;
  }

}