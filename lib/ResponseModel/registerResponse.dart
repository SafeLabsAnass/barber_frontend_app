class RegisterResponse {
  bool? successRegisterResponse;
  RegisterData? dataRegisterResponse;
  String? messageRegisterResponse;

  RegisterResponse({bool? success, RegisterData? data, String? message}) {
    this.successRegisterResponse = success;
    this.dataRegisterResponse = data;
    this.messageRegisterResponse = message;
  }

  bool? get success => successRegisterResponse;
  set success(bool? success) => successRegisterResponse = success;
  RegisterData? get data => dataRegisterResponse;
  set data(RegisterData? data) => dataRegisterResponse = data;
  String? get message => messageRegisterResponse;
  set message(String? message) => messageRegisterResponse = message;

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    successRegisterResponse = json['success'];
    dataRegisterResponse = json['data'] != null ? new RegisterData.fromJson(json['data']) : null;
    messageRegisterResponse = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.successRegisterResponse;
    if (this.dataRegisterResponse != null) {
      data['data'] = this.dataRegisterResponse!.toJson();
    }
    data['message'] = this.messageRegisterResponse;
    return data;
  }
}

class RegisterData {
  String? registerDataName;
  String? registerDataEmail;
  String? registerDataCode;
  String? registerDataPhone;
  int? registerDataVerify;
  String? registerDataUpdatedAt;
  String? registerDataCreatedAt;
  int? registerDataId;
  int? registerDataOtp;
  String? registerDataImagePath;
  String? registerDataSalonName;

  RegisterData(
      {String? name,
        String? email,
        String? code,
        String? phone,
        int? verify,
        String? updatedAt,
        String? createdAt,
        int? id,
        int? otp,
        String? imagePath,
        String? salonName}) {
    this.registerDataName = name;
    this.registerDataEmail = email;
    this.registerDataCode = code;
    this.registerDataPhone = phone;
    this.registerDataVerify = verify;
    this.registerDataUpdatedAt = updatedAt;
    this.registerDataCreatedAt = createdAt;
    this.registerDataId = id;
    this.registerDataOtp = otp;
    this.registerDataImagePath = imagePath;
    this.registerDataSalonName = salonName;
  }

  String? get name => registerDataName;
  set name(String? name) => registerDataName = name;
  String? get email => registerDataEmail;
  set email(String? email) => registerDataEmail = email;
  String? get code => registerDataCode;
  set code(String? code) => registerDataCode = code;
  String? get phone => registerDataPhone;
  set phone(String? phone) => registerDataPhone = phone;
  int? get verify => registerDataVerify;
  set verify(int? verify) => registerDataVerify = verify;
  String? get updatedAt => registerDataUpdatedAt;
  set updatedAt(String? updatedAt) => registerDataUpdatedAt = updatedAt;
  String? get createdAt => registerDataCreatedAt;
  set createdAt(String? createdAt) => registerDataCreatedAt = createdAt;
  int? get id => registerDataId;
  set id(int? id) => registerDataId = id;
  int? get otp => registerDataOtp;
  set otp(int? otp) => registerDataOtp = otp;
  String? get imagePath => registerDataImagePath;
  set imagePath(String? imagePath) => registerDataImagePath = imagePath;
  String? get salonName => registerDataSalonName;
  set salonName(String? salonName) => registerDataSalonName = salonName;

  RegisterData.fromJson(Map<String, dynamic> json) {
    registerDataName = json['name'];
    registerDataEmail = json['email'];
    registerDataCode = json['code'];
    registerDataPhone = json['phone'];
    registerDataVerify = json['verify'];
    registerDataUpdatedAt = json['updated_at'];
    registerDataCreatedAt = json['created_at'];
    registerDataId = json['id'];
    registerDataOtp = json['otp'];
    registerDataImagePath = json['imagePath'];
    registerDataSalonName = json['salonName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.registerDataName;
    data['email'] = this.registerDataEmail;
    data['code'] = this.registerDataCode;
    data['phone'] = this.registerDataPhone;
    data['verify'] = this.registerDataVerify;
    data['updated_at'] = this.registerDataUpdatedAt;
    data['created_at'] = this.registerDataCreatedAt;
    data['id'] = this.registerDataId;
    data['otp'] = this.registerDataOtp;
    data['imagePath'] = this.registerDataImagePath;
    data['salonName'] = this.registerDataSalonName;
    return data;
  }
}