class EditProfileResponse {
  String? msgEditProfileResponse;
  EditProfileData? editProfileDataResponse;
  bool? successEditProfileResponse;

  EditProfileResponse({String? msg, EditProfileData? data, bool? success}) {
    this.msgEditProfileResponse = msg;
    this.editProfileDataResponse = data;
    this.successEditProfileResponse = success;
  }

  String? get msg => msgEditProfileResponse;
  set msg(String? msg) => msgEditProfileResponse = msg;
  EditProfileData? get data => editProfileDataResponse;
  set data(EditProfileData? data) => editProfileDataResponse = data;
  bool? get success => successEditProfileResponse;
  set success(bool? success) => successEditProfileResponse = success;

  EditProfileResponse.fromJson(Map<String, dynamic> json) {
    msgEditProfileResponse = json['msg'];
    editProfileDataResponse = json['data'] != null ? new EditProfileData.fromJson(json['data']) : null;
    successEditProfileResponse = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msgEditProfileResponse;
    if (this.editProfileDataResponse != null) {
      data['data'] = this.editProfileDataResponse!.toJson();
    }
    data['success'] = this.successEditProfileResponse;
    return data;
  }
}

class EditProfileData {
  int? editProfileDataId;
  String? editProfileDataName;
  String? editProfileDataImage;
  String? editProfileDataEmail;
  int? editProfileDataOtp;
  Null editProfileDataAddedBy;
  Null editProfileDataEmailVerifiedAt;
  String? editProfileDataCode;
  String? editProfileDataPhone;
  int? editProfileDataStatus;
  int? editProfileDataRole;
  int? editProfileDataVerify;
  String? editProfileDataDeviceToken;
  int? editProfileDataNotification;
  int? editProfileDataMail;
  String? editProfileDataCreatedAt;
  String? editProfileDataUpdatedAt;
  String? editProfileDataImagePath;
  String? editProfileDataSalonName;

  EditProfileData(
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
        String? imagePath,
        String? salonName}) {
    this.editProfileDataId = id;
    this.editProfileDataName = name;
    this.editProfileDataImage = image;
    this.editProfileDataEmail = email;
    this.editProfileDataOtp = otp;
    this.editProfileDataAddedBy = addedBy;
    this.editProfileDataEmailVerifiedAt = emailVerifiedAt;
    this.editProfileDataCode = code;
    this.editProfileDataPhone = phone;
    this.editProfileDataStatus = status;
    this.editProfileDataRole = role;
    this.editProfileDataVerify = verify;
    this.editProfileDataDeviceToken = deviceToken;
    this.editProfileDataNotification = notification;
    this.editProfileDataMail = mail;
    this.editProfileDataCreatedAt = createdAt;
    this.editProfileDataUpdatedAt = updatedAt;
    this.editProfileDataImagePath = imagePath;
    this.editProfileDataSalonName = salonName;
  }

  int? get id => editProfileDataId;
  set id(int? id) => editProfileDataId = id;
  String? get name => editProfileDataName;
  set name(String? name) => editProfileDataName = name;
  String? get image => editProfileDataImage;
  set image(String? image) => editProfileDataImage = image;
  String? get email => editProfileDataEmail;
  set email(String? email) => editProfileDataEmail = email;
  int? get otp => editProfileDataOtp;
  set otp(int? otp) => editProfileDataOtp = otp;
  Null get addedBy => editProfileDataAddedBy;
  set addedBy(Null addedBy) => editProfileDataAddedBy = addedBy;
  Null get emailVerifiedAt => editProfileDataEmailVerifiedAt;
  set emailVerifiedAt(Null emailVerifiedAt) =>
      editProfileDataEmailVerifiedAt = emailVerifiedAt;
  String? get code => editProfileDataCode;
  set code(String? code) => editProfileDataCode = code;
  String? get phone => editProfileDataPhone;
  set phone(String? phone) => editProfileDataPhone = phone;
  int? get status => editProfileDataStatus;
  set status(int? status) => editProfileDataStatus = status;
  int? get role => editProfileDataRole;
  set role(int? role) => editProfileDataRole = role;
  int? get verify => editProfileDataVerify;
  set verify(int? verify) => editProfileDataVerify = verify;
  String? get deviceToken => editProfileDataDeviceToken;
  set deviceToken(String? deviceToken) => editProfileDataDeviceToken = deviceToken;
  int? get notification => editProfileDataNotification;
  set notification(int? notification) => editProfileDataNotification = notification;
  int? get mail => editProfileDataMail;
  set mail(int? mail) => editProfileDataMail = mail;
  String? get createdAt => editProfileDataCreatedAt;
  set createdAt(String? createdAt) => editProfileDataCreatedAt = createdAt;
  String? get updatedAt => editProfileDataUpdatedAt;
  set updatedAt(String? updatedAt) => editProfileDataUpdatedAt = updatedAt;
  String? get imagePath => editProfileDataImagePath;
  set imagePath(String? imagePath) => editProfileDataImagePath = imagePath;
  String? get salonName => editProfileDataSalonName;
  set salonName(String? salonName) => editProfileDataSalonName = salonName;

  EditProfileData.fromJson(Map<String, dynamic> json) {
    editProfileDataId = json['id'];
    editProfileDataName = json['name'];
    editProfileDataImage = json['image'];
    editProfileDataEmail = json['email'];
    editProfileDataOtp = json['otp'];
    editProfileDataAddedBy = json['added_by'];
    editProfileDataEmailVerifiedAt = json['email_verified_at'];
    editProfileDataCode = json['code'];
    editProfileDataPhone = json['phone'];
    editProfileDataStatus = json['status'];
    editProfileDataRole = json['role'];
    editProfileDataVerify = json['verify'];
    editProfileDataDeviceToken = json['device_token'];
    editProfileDataNotification = json['notification'];
    editProfileDataMail = json['mail'];
    editProfileDataCreatedAt = json['created_at'];
    editProfileDataUpdatedAt = json['updated_at'];
    editProfileDataImagePath = json['imagePath'];
    editProfileDataSalonName = json['salonName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.editProfileDataId;
    data['name'] = this.editProfileDataName;
    data['image'] = this.editProfileDataImage;
    data['email'] = this.editProfileDataEmail;
    data['otp'] = this.editProfileDataOtp;
    data['added_by'] = this.editProfileDataAddedBy;
    data['email_verified_at'] = this.editProfileDataEmailVerifiedAt;
    data['code'] = this.editProfileDataCode;
    data['phone'] = this.editProfileDataPhone;
    data['status'] = this.editProfileDataStatus;
    data['role'] = this.editProfileDataRole;
    data['verify'] = this.editProfileDataVerify;
    data['device_token'] = this.editProfileDataDeviceToken;
    data['notification'] = this.editProfileDataNotification;
    data['mail'] = this.editProfileDataMail;
    data['created_at'] = this.editProfileDataCreatedAt;
    data['updated_at'] = this.editProfileDataUpdatedAt;
    data['imagePath'] = this.editProfileDataImagePath;
    data['salonName'] = this.editProfileDataSalonName;
    return data;
  }
}