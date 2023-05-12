class SendOtpResponse {
  String? msgSendOtpResponse;
  SendOtpData? dataSendOtpResponse;
  bool? successSendOtpResponse;

  SendOtpResponse({String? msg, SendOtpData? data, bool? success}) {
    this.msgSendOtpResponse = msg;
    this.dataSendOtpResponse = data;
    this.successSendOtpResponse = success;
  }

  String? get msg => msgSendOtpResponse;
  set msg(String? msg) => msgSendOtpResponse = msg;
  SendOtpData? get data => dataSendOtpResponse;
  set data(SendOtpData? data) => dataSendOtpResponse = data;
  bool? get success => successSendOtpResponse;
  set success(bool? success) => successSendOtpResponse = success;

  SendOtpResponse.fromJson(Map<String, dynamic> json) {
    msgSendOtpResponse = json['msg'];
    dataSendOtpResponse = json['data'] != null ? new SendOtpData.fromJson(json['data']) : null;
    successSendOtpResponse = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msgSendOtpResponse;
    if (this.dataSendOtpResponse != null) {
      data['data'] = this.dataSendOtpResponse!.toJson();
    }
    data['success'] = this.successSendOtpResponse;
    return data;
  }
}

class SendOtpData {
  int? sendOtpDataId;
  String? sendOtpDataName;
  String? sendOtpDataImage;
  String? sendOtpDataEmail;
  int? sendOtpDataOtp;
  Null sendOtpDataAddedBy;
  Null sendOtpDataEmailVerifiedAt;
  String? sendOtpDataCode;
  String? sendOtpDataPhone;
  int? sendOtpDataStatus;
  int? sendOtpDataRole;
  int? sendOtpDataVerify;
  Null sendOtpDataDeviceToken;
  int? sendOtpDataNotification;
  int? sendOtpDataMail;
  String? sendOtpDataCreatedAt;
  String? sendOtpDataUpdatedAt;
  String? sendOtpDataImagePath;
  String? sendOtpDataSalonName;

  SendOtpData(
      {int? id,
        String? name,
        String? image,
        String? email,
        int? otp,
        Null addedBy,
        Null emailVerifiedAt,
        String? code,
        String? phone,
        int? status,
        int? role,
        int? verify,
        Null deviceToken,
        int? notification,
        int? mail,
        String? createdAt,
        String? updatedAt,
        String? imagePath,
        String? salonName}) {
    this.sendOtpDataId = id;
    this.sendOtpDataName = name;
    this.sendOtpDataImage = image;
    this.sendOtpDataEmail = email;
    this.sendOtpDataOtp = otp;
    this.sendOtpDataAddedBy = addedBy;
    this.sendOtpDataEmailVerifiedAt = emailVerifiedAt;
    this.sendOtpDataCode = code;
    this.sendOtpDataPhone = phone;
    this.sendOtpDataStatus = status;
    this.sendOtpDataRole = role;
    this.sendOtpDataVerify = verify;
    this.sendOtpDataDeviceToken = deviceToken;
    this.sendOtpDataNotification = notification;
    this.sendOtpDataMail = mail;
    this.sendOtpDataCreatedAt = createdAt;
    this.sendOtpDataUpdatedAt = updatedAt;
    this.sendOtpDataImagePath = imagePath;
    this.sendOtpDataSalonName = salonName;
  }

  int? get id => sendOtpDataId;
  set id(int? id) => sendOtpDataId = id;
  String? get name => sendOtpDataName;
  set name(String? name) => sendOtpDataName = name;
  String? get image => sendOtpDataImage;
  set image(String? image) => sendOtpDataImage = image;
  String? get email => sendOtpDataEmail;
  set email(String? email) => sendOtpDataEmail = email;
  int? get otp => sendOtpDataOtp;
  set otp(int? otp) => sendOtpDataOtp = otp;
  Null get addedBy => sendOtpDataAddedBy;
  set addedBy(Null addedBy) => sendOtpDataAddedBy = addedBy;
  Null get emailVerifiedAt => sendOtpDataEmailVerifiedAt;
  set emailVerifiedAt(Null emailVerifiedAt) =>
      sendOtpDataEmailVerifiedAt = emailVerifiedAt;
  String? get code => sendOtpDataCode;
  set code(String? code) => sendOtpDataCode = code;
  String? get phone => sendOtpDataPhone;
  set phone(String? phone) => sendOtpDataPhone = phone;
  int? get status => sendOtpDataStatus;
  set status(int? status) => sendOtpDataStatus = status;
  int? get role => sendOtpDataRole;
  set role(int? role) => sendOtpDataRole = role;
  int? get verify => sendOtpDataVerify;
  set verify(int? verify) => sendOtpDataVerify = verify;
  Null get deviceToken => sendOtpDataDeviceToken;
  set deviceToken(Null deviceToken) => sendOtpDataDeviceToken = deviceToken;
  int? get notification => sendOtpDataNotification;
  set notification(int? notification) => sendOtpDataNotification = notification;
  int? get mail => sendOtpDataMail;
  set mail(int? mail) => sendOtpDataMail = mail;
  String? get createdAt => sendOtpDataCreatedAt;
  set createdAt(String? createdAt) => sendOtpDataCreatedAt = createdAt;
  String? get updatedAt => sendOtpDataUpdatedAt;
  set updatedAt(String? updatedAt) => sendOtpDataUpdatedAt = updatedAt;
  String? get imagePath => sendOtpDataImagePath;
  set imagePath(String? imagePath) => sendOtpDataImagePath = imagePath;
  String? get salonName => sendOtpDataSalonName;
  set salonName(String? salonName) => sendOtpDataSalonName = salonName;

  SendOtpData.fromJson(Map<String, dynamic> json) {
    sendOtpDataId = json['id'];
    sendOtpDataName = json['name'];
    sendOtpDataImage = json['image'];
    sendOtpDataEmail = json['email'];
    sendOtpDataOtp = json['otp'];
    sendOtpDataAddedBy = json['added_by'];
    sendOtpDataEmailVerifiedAt = json['email_verified_at'];
    sendOtpDataCode = json['code'];
    sendOtpDataPhone = json['phone'];
    sendOtpDataStatus = json['status'];
    sendOtpDataRole = json['role'];
    sendOtpDataVerify = json['verify'];
    sendOtpDataDeviceToken = json['device_token'];
    sendOtpDataNotification = json['notification'];
    sendOtpDataMail = json['mail'];
    sendOtpDataCreatedAt = json['created_at'];
    sendOtpDataUpdatedAt = json['updated_at'];
    sendOtpDataImagePath = json['imagePath'];
    sendOtpDataSalonName = json['salonName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sendOtpDataId;
    data['name'] = this.sendOtpDataName;
    data['image'] = this.sendOtpDataImage;
    data['email'] = this.sendOtpDataEmail;
    data['otp'] = this.sendOtpDataOtp;
    data['added_by'] = this.sendOtpDataAddedBy;
    data['email_verified_at'] = this.sendOtpDataEmailVerifiedAt;
    data['code'] = this.sendOtpDataCode;
    data['phone'] = this.sendOtpDataPhone;
    data['status'] = this.sendOtpDataStatus;
    data['role'] = this.sendOtpDataRole;
    data['verify'] = this.sendOtpDataVerify;
    data['device_token'] = this.sendOtpDataDeviceToken;
    data['notification'] = this.sendOtpDataNotification;
    data['mail'] = this.sendOtpDataMail;
    data['created_at'] = this.sendOtpDataCreatedAt;
    data['updated_at'] = this.sendOtpDataUpdatedAt;
    data['imagePath'] = this.sendOtpDataImagePath;
    data['salonName'] = this.sendOtpDataSalonName;
    return data;
  }
}
