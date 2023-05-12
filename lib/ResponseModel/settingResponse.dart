class SettingResponse {
  String? msg;
  SettingData? data;
  bool? success;

  SettingResponse({this.msg, this.data, this.success});

  SettingResponse.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    data = json['data'] != null ? new SettingData.fromJson(json['data']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}

class SettingData {
  String? mapkey;
  String? projectNo;
  String? appId;
  String? currency;
  String? currencySymbol;
  String? privacyPolicy;
  String? termsConditions;
  String? blackLogo;
  String? whiteLogo;
  String? appVersion;
  String? footer1;
  String? footer2;
  String? imagePath;

  SettingData(
      {this.mapkey,
        this.projectNo,
        this.appId,
        this.currency,
        this.currencySymbol,
        this.privacyPolicy,
        this.termsConditions,
        this.blackLogo,
        this.whiteLogo,
        this.appVersion,
        this.footer1,
        this.footer2,
        this.imagePath});

  SettingData.fromJson(Map<String, dynamic> json) {
    mapkey = json['mapkey'];
    projectNo = json['project_no'];
    appId = json['app_id'];
    currency = json['currency'];
    currencySymbol = json['currency_symbol'];
    privacyPolicy = json['privacy_policy'];
    termsConditions = json['terms_conditions'];
    blackLogo = json['black_logo'];
    whiteLogo = json['white_logo'];
    appVersion = json['app_version'];
    footer1 = json['footer1'];
    footer2 = json['footer2'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mapkey'] = this.mapkey;
    data['project_no'] = this.projectNo;
    data['app_id'] = this.appId;
    data['currency'] = this.currency;
    data['currency_symbol'] = this.currencySymbol;
    data['privacy_policy'] = this.privacyPolicy;
    data['terms_conditions'] = this.termsConditions;
    data['black_logo'] = this.blackLogo;
    data['white_logo'] = this.whiteLogo;
    data['app_version'] = this.appVersion;
    data['footer1'] = this.footer1;
    data['footer2'] = this.footer2;
    data['imagePath'] = this.imagePath;
    return data;
  }
}