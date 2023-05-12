class OtpMatchResponse {
  String? msgOtpMatchResponse;
  OtpMatchData? dataOtpMatchDataResponse;
  bool? successOtpMatchSuccessResponse;

  OtpMatchResponse({String? msg, OtpMatchData? data, bool? success}) {
    this.msgOtpMatchResponse = msg;
    this.dataOtpMatchDataResponse = data;
    this.successOtpMatchSuccessResponse = success;
  }

  String? get msg => msgOtpMatchResponse;
  set msg(String? msg) => msgOtpMatchResponse = msg;
  OtpMatchData? get data => dataOtpMatchDataResponse;
  set data(OtpMatchData? data) => dataOtpMatchDataResponse = data;
  bool? get success => successOtpMatchSuccessResponse;
  set success(bool? success) => successOtpMatchSuccessResponse = success;

  OtpMatchResponse.fromJson(Map<String, dynamic> json) {
    msgOtpMatchResponse = json['msg'];
    dataOtpMatchDataResponse = json['data'] != null ? new OtpMatchData.fromJson(json['data']) : null;
    successOtpMatchSuccessResponse = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msgOtpMatchResponse;
    if (this.dataOtpMatchDataResponse != null) {
      data['data'] = this.dataOtpMatchDataResponse!.toJson();
    }
    data['success'] = this.successOtpMatchSuccessResponse;
    return data;
  }
}

class OtpMatchData {
  int? otpMatchDataId;
  String? otpMatchDataName;
  String? otpMatchDataImage;
  String? otpMatchDataEmail;
  int? otpMatchDataOtp;
  Null otpMatchDataAddedBy;
  Null otpMatchDataEmailVerifiedAt;
  String? otpMatchDataCode;
  String? otpMatchDataPhone;
  int? otpMatchDataStatus;
  int? otpMatchDataRole;
  int? otpMatchDataVerify;
  String? otpMatchDataDeviceToken;
  int? otpMatchDataNotification;
  int? otpMatchDataMail;
  String? otpMatchDataCreatedAt;
  String? otpMatchDataUpdatedAt;
  String? otpMatchDataToken;
  String? otpMatchDataImagePath;
  String? otpMatchDataSalonName;

  OtpMatchData(
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
        String? deviceToken,
        int? notification,
        int? mail,
        String? createdAt,
        String? updatedAt,
        String? token,
        String? imagePath,
        String? salonName}) {
    this.otpMatchDataId = id;
    this.otpMatchDataName = name;
    this.otpMatchDataImage = image;
    this.otpMatchDataEmail = email;
    this.otpMatchDataOtp = otp;
    this.otpMatchDataAddedBy = addedBy;
    this.otpMatchDataEmailVerifiedAt = emailVerifiedAt;
    this.otpMatchDataCode = code;
    this.otpMatchDataPhone = phone;
    this.otpMatchDataStatus = status;
    this.otpMatchDataRole = role;
    this.otpMatchDataVerify = verify;
    this.otpMatchDataDeviceToken = deviceToken;
    this.otpMatchDataNotification = notification;
    this.otpMatchDataMail = mail;
    this.otpMatchDataCreatedAt = createdAt;
    this.otpMatchDataUpdatedAt = updatedAt;
    this.otpMatchDataToken = token;
    this.otpMatchDataImagePath = imagePath;
    this.otpMatchDataSalonName = salonName;
  }

  int? get id => otpMatchDataId;
  set id(int? id) => otpMatchDataId = id;
  String? get name => otpMatchDataName;
  set name(String? name) => otpMatchDataName = name;
  String? get image => otpMatchDataImage;
  set image(String? image) => otpMatchDataImage = image;
  String? get email => otpMatchDataEmail;
  set email(String? email) => otpMatchDataEmail = email;
  int? get otp => otpMatchDataOtp;
  set otp(int? otp) => otpMatchDataOtp = otp;
  Null get addedBy => otpMatchDataAddedBy;
  set addedBy(Null addedBy) => otpMatchDataAddedBy = addedBy;
  Null get emailVerifiedAt => otpMatchDataEmailVerifiedAt;
  set emailVerifiedAt(Null emailVerifiedAt) =>
      otpMatchDataEmailVerifiedAt = emailVerifiedAt;
  String? get code => otpMatchDataCode;
  set code(String? code) => otpMatchDataCode = code;
  String? get phone => otpMatchDataPhone;
  set phone(String? phone) => otpMatchDataPhone = phone;
  int? get status => otpMatchDataStatus;
  set status(int? status) => otpMatchDataStatus = status;
  int? get role => otpMatchDataRole;
  set role(int? role) => otpMatchDataRole = role;
  int? get verify => otpMatchDataVerify;
  set verify(int? verify) => otpMatchDataVerify = verify;
  String? get deviceToken => otpMatchDataDeviceToken;
  set deviceToken(String? deviceToken) => otpMatchDataDeviceToken = deviceToken;
  int? get notification => otpMatchDataNotification;
  set notification(int? notification) => otpMatchDataNotification = notification;
  int? get mail => otpMatchDataMail;
  set mail(int? mail) => otpMatchDataMail = mail;
  String? get createdAt => otpMatchDataCreatedAt;
  set createdAt(String? createdAt) => otpMatchDataCreatedAt = createdAt;
  String? get updatedAt => otpMatchDataUpdatedAt;
  set updatedAt(String? updatedAt) => otpMatchDataUpdatedAt = updatedAt;
  String? get token => otpMatchDataToken;
  set token(String? token) => otpMatchDataToken = token;
  String? get imagePath => otpMatchDataImagePath;
  set imagePath(String? imagePath) => otpMatchDataImagePath = imagePath;
  String? get salonName => otpMatchDataSalonName;
  set salonName(String? salonName) => otpMatchDataSalonName = salonName;

  OtpMatchData.fromJson(Map<String, dynamic> json) {
    otpMatchDataId = json['id'];
    otpMatchDataName = json['name'];
    otpMatchDataImage = json['image'];
    otpMatchDataEmail = json['email'];
    otpMatchDataOtp = json['otp'];
    otpMatchDataAddedBy = json['added_by'];
    otpMatchDataEmailVerifiedAt = json['email_verified_at'];
    otpMatchDataCode = json['code'];
    otpMatchDataPhone = json['phone'];
    otpMatchDataStatus = json['status'];
    otpMatchDataRole = json['role'];
    otpMatchDataVerify = json['verify'];
    otpMatchDataDeviceToken = json['device_token'];
    otpMatchDataNotification = json['notification'];
    otpMatchDataMail = json['mail'];
    otpMatchDataCreatedAt = json['created_at'];
    otpMatchDataUpdatedAt = json['updated_at'];
    otpMatchDataToken = json['token'];
    otpMatchDataImagePath = json['imagePath'];
    otpMatchDataSalonName = json['salonName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.otpMatchDataId;
    data['name'] = this.otpMatchDataName;
    data['image'] = this.otpMatchDataImage;
    data['email'] = this.otpMatchDataEmail;
    data['otp'] = this.otpMatchDataOtp;
    data['added_by'] = this.otpMatchDataAddedBy;
    data['email_verified_at'] = this.otpMatchDataEmailVerifiedAt;
    data['code'] = this.otpMatchDataCode;
    data['phone'] = this.otpMatchDataPhone;
    data['status'] = this.otpMatchDataStatus;
    data['role'] = this.otpMatchDataRole;
    data['verify'] = this.otpMatchDataVerify;
    data['device_token'] = this.otpMatchDataDeviceToken;
    data['notification'] = this.otpMatchDataNotification;
    data['mail'] = this.otpMatchDataMail;
    data['created_at'] = this.otpMatchDataCreatedAt;
    data['updated_at'] = this.otpMatchDataUpdatedAt;
    data['token'] = this.otpMatchDataToken;
    data['imagePath'] = this.otpMatchDataImagePath;
    data['salonName'] = this.otpMatchDataSalonName;
    return data;
  }
}