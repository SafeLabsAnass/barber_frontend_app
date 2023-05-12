class NotificationResponse {
  String? msg;
  List<NotificationDataList>? data;
  bool? success;

  NotificationResponse({this.msg, this.data, this.success});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = <NotificationDataList>[];
      json['data'].forEach((v) {
        data!.add(new NotificationDataList.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class NotificationDataList {
  int? id;

  int? bookingId;
  String? title;
  String? msg;

  NotificationDataList({
    this.id,
    this.bookingId,
    this.title,
    this.msg,
  });

  NotificationDataList.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    bookingId = json['booking_id'];
    title = json['title'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;

    data['booking_id'] = this.bookingId;
    data['title'] = this.title;
    data['msg'] = this.msg;
    return data;
  }
}
