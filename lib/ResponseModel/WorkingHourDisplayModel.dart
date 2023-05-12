class WorkingHourDisplayModel {
  WorkingHourDisplayModel({
    bool? success,
    List<WorkingHourDataList>? data,
  }) {
    _success = success;
    _data = data;
  }

  WorkingHourDisplayModel.fromJson(dynamic json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(WorkingHourDataList.fromJson(v));
      });
    }
  }
  bool? _success;
  List<WorkingHourDataList>? _data;
  WorkingHourDisplayModel copyWith({
    bool? success,
    List<WorkingHourDataList>? data,
  }) =>
      WorkingHourDisplayModel(
        success: success ?? _success,
        data: data ?? _data,
      );
  bool? get success => _success;
  List<WorkingHourDataList>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// salon_id : 1
/// day_index : "Sunday"
/// period_list : "[{\"start_time\":\"08:00 AM\",\"end_time\":\"03:00 PM\"},{\"start_time\":\"03:30 PM\",\"end_time\":\"06:00 PM\"}]"
/// status : 1
/// created_at : "2022-10-18T04:31:53.000000Z"
/// updated_at : "2022-10-21T04:17:17.000000Z"

class WorkingHourDataList {
  WorkingHourDataList({
    num? id,
    num? salonId,
    String? dayIndex,
    String? periodList,
    num? status,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _salonId = salonId;
    _dayIndex = dayIndex;
    _periodList = periodList;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  WorkingHourDataList.fromJson(dynamic json) {
    _id = json['id'];
    _salonId = json['salon_id'];
    _dayIndex = json['day_index'];
    _periodList = json['period_list'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _salonId;
  String? _dayIndex;
  String? _periodList;
  num? _status;
  String? _createdAt;
  String? _updatedAt;
  WorkingHourDataList copyWith({
    num? id,
    num? salonId,
    String? dayIndex,
    String? periodList,
    num? status,
    String? createdAt,
    String? updatedAt,
  }) =>
      WorkingHourDataList(
        id: id ?? _id,
        salonId: salonId ?? _salonId,
        dayIndex: dayIndex ?? _dayIndex,
        periodList: periodList ?? _periodList,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  num? get salonId => _salonId;
  String? get dayIndex => _dayIndex;
  String? get periodList => _periodList;
  num? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['salon_id'] = _salonId;
    map['day_index'] = _dayIndex;
    map['period_list'] = _periodList;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
