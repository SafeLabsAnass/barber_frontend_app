class LoginResponse {
  bool? successLoginResponse;
  String? msgLoginResponse;
  LoginData? dataLoginResponse;

  LoginResponse({bool? success, String? msg, LoginData? data}) {
    this.successLoginResponse = success;
    this.msgLoginResponse = msg;
  }

  bool? get success => successLoginResponse;
  set success(bool? success) => successLoginResponse = success;
  String? get msg => msgLoginResponse;
  set msg(String? msg) => msgLoginResponse = msg;
  LoginData? get data => dataLoginResponse;
  set data(LoginData? data) => dataLoginResponse = data;

  LoginResponse.fromJson(Map<String, dynamic> json) {
    successLoginResponse = json['success'];
    msgLoginResponse = json['msg'];

    dataLoginResponse = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.successLoginResponse;
    data['msg'] = this.msgLoginResponse;
    if (this.dataLoginResponse != null) {
      data['data'] = this.dataLoginResponse!.toJson();
    }
    return data;
  }
}

class LoginData {
  String? loginDataToken;

  LoginData({String? token}) {
    this.loginDataToken = token;
  }

  String? get token => loginDataToken;
  set token(String? token) => loginDataToken = token;

  LoginData.fromJson(Map<String, dynamic> json) {
    loginDataToken = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.loginDataToken;
    return data;
  }
}
