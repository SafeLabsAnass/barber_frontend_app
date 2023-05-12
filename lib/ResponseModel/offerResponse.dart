class OfferResponse {
  String? msgOfferResponse;
  List<OfferData>? dataOfferResponse;
  bool? successOfferResponse;

  OfferResponse({String? msg, List<OfferData>? data, bool? success}) {
    this.msgOfferResponse = msg;
    this.dataOfferResponse = data;
    this.successOfferResponse = success;
  }

  String? get msg => msgOfferResponse;
  set msg(String? msg) => msgOfferResponse = msg;
  List<OfferData>? get data => dataOfferResponse;
  set data(List<OfferData>? data) => dataOfferResponse = data;
  bool? get success => successOfferResponse;
  set success(bool? success) => successOfferResponse = success;

  OfferResponse.fromJson(Map<String, dynamic> json) {
    msgOfferResponse = json['msg'];
    if (json['data'] != null) {
      dataOfferResponse = <OfferData>[];
      json['data'].forEach((v) {
        dataOfferResponse!.add(new OfferData.fromJson(v));
      });
    }
    successOfferResponse = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msgOfferResponse;
    if (this.dataOfferResponse != null) {
      data['data'] = this.dataOfferResponse!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.successOfferResponse;
    return data;
  }
}

class OfferData {
  int? offerDataCouponId;
  String? offerDataDesc;
  String? offerDataCode;
  int? offerDataMaxUse;
  int? offerDataUseCount;
  String? offerDataType;
  int? offerDataDiscount;
  String? offerDataStartDate;
  String? offerDataEndDate;
  int? offerDataStatus;
  String? offerDataCreatedAt;
  String? offerDataUpdatedAt;

  OfferData(
      {int? couponId,
        String? desc,
        String? code,
        int? maxUse,
        int? useCount,
        String? type,
        int? discount,
        String? startDate,
        String? endDate,
        int? status,
        String? createdAt,
        String? updatedAt}) {
    this.offerDataCouponId = couponId;
    this.offerDataDesc = desc;
    this.offerDataCode = code;
    this.offerDataMaxUse = maxUse;
    this.offerDataUseCount = useCount;
    this.offerDataType = type;
    this.offerDataDiscount = discount;
    this.offerDataStartDate = startDate;
    this.offerDataEndDate = endDate;
    this.offerDataStatus = status;
    this.offerDataCreatedAt = createdAt;
    this.offerDataUpdatedAt = updatedAt;
  }

  int? get couponId => offerDataCouponId;
  set couponId(int? couponId) => offerDataCouponId = couponId;
  String? get desc => offerDataDesc;
  set desc(String? desc) => offerDataDesc = desc;
  String? get code => offerDataCode;
  set code(String? code) => offerDataCode = code;
  int? get maxUse => offerDataMaxUse;
  set maxUse(int? maxUse) => offerDataMaxUse = maxUse;
  int? get useCount => offerDataUseCount;
  set useCount(int? useCount) => offerDataUseCount = useCount;
  String? get type => offerDataType;
  set type(String? type) => offerDataType = type;
  int? get discount => offerDataDiscount;
  set discount(int? discount) => offerDataDiscount = discount;
  String? get startDate => offerDataStartDate;
  set startDate(String? startDate) => offerDataStartDate = startDate;
  String? get endDate => offerDataEndDate;
  set endDate(String? endDate) => offerDataEndDate = endDate;
  int? get status => offerDataStatus;
  set status(int? status) => offerDataStatus = status;
  String? get createdAt => offerDataCreatedAt;
  set createdAt(String? createdAt) => offerDataCreatedAt = createdAt;
  String? get updatedAt => offerDataUpdatedAt;
  set updatedAt(String? updatedAt) => offerDataUpdatedAt = updatedAt;

  OfferData.fromJson(Map<String, dynamic> json) {
    offerDataCouponId = json['coupon_id'];
    offerDataDesc = json['desc'];
    offerDataCode = json['code'];
    offerDataMaxUse = json['max_use'];
    offerDataUseCount = json['use_count'];
    offerDataType = json['type'];
    offerDataDiscount = json['discount'];
    offerDataStartDate = json['start_date'];
    offerDataEndDate = json['end_date'];
    offerDataStatus = json['status'];
    offerDataCreatedAt = json['created_at'];
    offerDataUpdatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coupon_id'] = this.offerDataCouponId;
    data['desc'] = this.offerDataDesc;
    data['code'] = this.offerDataCode;
    data['max_use'] = this.offerDataMaxUse;
    data['use_count'] = this.offerDataUseCount;
    data['type'] = this.offerDataType;
    data['discount'] = this.offerDataDiscount;
    data['start_date'] = this.offerDataStartDate;
    data['end_date'] = this.offerDataEndDate;
    data['status'] = this.offerDataStatus;
    data['created_at'] = this.offerDataCreatedAt;
    data['updated_at'] = this.offerDataUpdatedAt;
    return data;
  }
}