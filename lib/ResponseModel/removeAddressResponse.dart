class RemoveAddressResponse {
  String? msg;
  bool? success;

  RemoveAddressResponse({this.msg, this.success});

  RemoveAddressResponse.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['success'] = this.success;
    return data;
  }
}