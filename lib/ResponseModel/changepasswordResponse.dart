class ChangePasswordResponse {
  String? msg;
  Null data;
  bool? success;

  ChangePasswordResponse({this.msg, this.data, this.success});

  ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    data = json['data'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['data'] = this.data;
    data['success'] = this.success;
    return data;
  }
}