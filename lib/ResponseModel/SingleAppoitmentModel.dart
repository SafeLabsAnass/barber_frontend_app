class SingleAppoitmentModel {
  String? _msg;
  SingleAppoitmentData? _data;
  bool? _success;

  SingleAppoitmentModel({String? msg, SingleAppoitmentData? data, bool? success}) {
    if (msg != null) {
      this._msg = msg;
    }
    if (data != null) {
      this._data = data;
    }
    if (success != null) {
      this._success = success;
    }
  }

  String? get msg => _msg;
  set msg(String? msg) => _msg = msg;
  SingleAppoitmentData? get data => _data;
  set data(SingleAppoitmentData? data) => _data = data;
  bool? get success => _success;
  set success(bool? success) => _success = success;

  SingleAppoitmentModel.fromJson(Map<String, dynamic> json) {
    _msg = json['msg'];
    _data = json['data'] != null ? new SingleAppoitmentData.fromJson(json['data']) : null;
    _success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this._msg;
    if (this._data != null) {
      data['data'] = this._data!.toJson();
    }
    data['success'] = this._success;
    return data;
  }
}

class SingleAppoitmentData {
  int? _id;
  String? _bookingId;
  int? _empId;
  String? _serviceId;
  dynamic _couponId;
  int? _discount;
  int? _payment;
  String? _date;
  String? _startTime;
  String? _endTime;
  String? _paymentType;
  int? _paymentStatus;
  String? _bookingStatus;
  Review? _review;
  List<Services>? _services;
  Employee? _employee;

  SingleAppoitmentData(
      {int? id,
      String? bookingId,
      int? empId,
      String? serviceId,
      dynamic couponId,
      int? discount,
      int? payment,
      String? date,
      String? startTime,
      String? endTime,
      String? paymentType,
      int? paymentStatus,
      String? bookingStatus,
      Review? review,
      List<Services>? services,
      Employee? employee}) {
    if (id != null) {
      this._id = id;
    }
    if (bookingId != null) {
      this._bookingId = bookingId;
    }
    if (empId != null) {
      this._empId = empId;
    }
    if (serviceId != null) {
      this._serviceId = serviceId;
    }
    if (couponId != null) {
      this._couponId = couponId;
    }
    if (discount != null) {
      this._discount = discount;
    }
    if (payment != null) {
      this._payment = payment;
    }
    if (date != null) {
      this._date = date;
    }
    if (startTime != null) {
      this._startTime = startTime;
    }
    if (endTime != null) {
      this._endTime = endTime;
    }
    if (paymentType != null) {
      this._paymentType = paymentType;
    }
    if (paymentStatus != null) {
      this._paymentStatus = paymentStatus;
    }
    if (bookingStatus != null) {
      this._bookingStatus = bookingStatus;
    }
    if (review != null) {
      this._review = review;
    }
    if (services != null) {
      this._services = services;
    }
    if (employee != null) {
      this._employee = employee;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get bookingId => _bookingId;
  set bookingId(String? bookingId) => _bookingId = bookingId;
  int? get empId => _empId;
  set empId(int? empId) => _empId = empId;
  String? get serviceId => _serviceId;
  set serviceId(String? serviceId) => _serviceId = serviceId;
  dynamic get couponId => _couponId;
  set couponId(dynamic couponId) => _couponId = couponId;
  int? get discount => _discount;
  set discount(int? discount) => _discount = discount;
  int? get payment => _payment;
  set payment(int? payment) => _payment = payment;
  String? get date => _date;
  set date(String? date) => _date = date;
  String? get startTime => _startTime;
  set startTime(String? startTime) => _startTime = startTime;
  String? get endTime => _endTime;
  set endTime(String? endTime) => _endTime = endTime;
  String? get paymentType => _paymentType;
  set paymentType(String? paymentType) => _paymentType = paymentType;
  int? get paymentStatus => _paymentStatus;
  set paymentStatus(int? paymentStatus) => _paymentStatus = paymentStatus;
  String? get bookingStatus => _bookingStatus;
  set bookingStatus(String? bookingStatus) => _bookingStatus = bookingStatus;
  Review? get review => _review;
  set review(Review? review) => _review = review;
  List<Services>? get services => _services;
  set services(List<Services>? services) => _services = services;
  Employee? get employee => _employee;
  set employee(Employee? employee) => _employee = employee;

  SingleAppoitmentData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _bookingId = json['booking_id'];
    _empId = json['emp_id'];
    _serviceId = json['service_id'];
    _couponId = json['coupon_id'];
    _discount = json['discount'];
    _payment = json['payment'];
    _date = json['date'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _paymentType = json['payment_type'];
    _paymentStatus = json['payment_status'];
    _bookingStatus = json['booking_status'];
    _review = json['review'] != null ? new Review.fromJson(json['review']) : null;
    if (json['services'] != null) {
      _services = <Services>[];
      json['services'].forEach((v) {
        _services!.add(new Services.fromJson(v));
      });
    }
    _employee = json['employee'] != null ? new Employee.fromJson(json['employee']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['booking_id'] = this._bookingId;
    data['emp_id'] = this._empId;
    data['service_id'] = this._serviceId;
    data['coupon_id'] = this._couponId;
    data['discount'] = this._discount;
    data['payment'] = this._payment;
    data['date'] = this._date;
    data['start_time'] = this._startTime;
    data['end_time'] = this._endTime;
    data['payment_type'] = this._paymentType;
    data['payment_status'] = this._paymentStatus;
    data['booking_status'] = this._bookingStatus;
    if (this._review != null) {
      data['review'] = this._review!.toJson();
    }
    if (this._services != null) {
      data['services'] = this._services!.map((v) => v.toJson()).toList();
    }
    if (this._employee != null) {
      data['employee'] = this._employee!.toJson();
    }
    return data;
  }
}

class Review {
  int? _reviewId;
  int? _rate;
  String? _message;
  int? _userId;
  String? _createdAt;
  User? _user;

  Review({int? reviewId, int? rate, String? message, int? userId, String? createdAt, User? user}) {
    if (reviewId != null) {
      this._reviewId = reviewId;
    }
    if (rate != null) {
      this._rate = rate;
    }
    if (message != null) {
      this._message = message;
    }
    if (userId != null) {
      this._userId = userId;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    if (user != null) {
      this._user = user;
    }
  }

  int? get reviewId => _reviewId;
  set reviewId(int? reviewId) => _reviewId = reviewId;
  int? get rate => _rate;
  set rate(int? rate) => _rate = rate;
  String? get message => _message;
  set message(String? message) => _message = message;
  int? get userId => _userId;
  set userId(int? userId) => _userId = userId;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  User? get user => _user;
  set user(User? user) => _user = user;

  Review.fromJson(Map<String, dynamic> json) {
    _reviewId = json['review_id'];
    _rate = json['rate'];
    _message = json['message'];
    _userId = json['user_id'];
    _createdAt = json['created_at'];
    _user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['review_id'] = this._reviewId;
    data['rate'] = this._rate;
    data['message'] = this._message;
    data['user_id'] = this._userId;
    data['created_at'] = this._createdAt;
    if (this._user != null) {
      data['user'] = this._user!.toJson();
    }
    return data;
  }
}

class User {
  int? _id;
  String? _name;
  String? _image;
  String? _imagePath;

  User({int? id, String? name, String? image, String? imagePath}) {
    if (id != null) {
      this._id = id;
    }
    if (name != null) {
      this._name = name;
    }
    if (image != null) {
      this._image = image;
    }
    if (imagePath != null) {
      this._imagePath = imagePath;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get image => _image;
  set image(String? image) => _image = image;
  String? get imagePath => _imagePath;
  set imagePath(String? imagePath) => _imagePath = imagePath;

  User.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
    _imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['image'] = this._image;
    data['imagePath'] = this._imagePath;
    return data;
  }
}

class Services {
  int? _serviceId;
  String? _image;
  String? _name;
  int? _time;
  String? _gender;
  int? _price;
  String? _imagePath;

  Services({int? serviceId, String? image, String? name, int? time, String? gender, int? price, String? imagePath}) {
    if (serviceId != null) {
      this._serviceId = serviceId;
    }
    if (image != null) {
      this._image = image;
    }
    if (name != null) {
      this._name = name;
    }
    if (time != null) {
      this._time = time;
    }
    if (gender != null) {
      this._gender = gender;
    }
    if (price != null) {
      this._price = price;
    }
    if (imagePath != null) {
      this._imagePath = imagePath;
    }
  }

  int? get serviceId => _serviceId;
  set serviceId(int? serviceId) => _serviceId = serviceId;
  String? get image => _image;
  set image(String? image) => _image = image;
  String? get name => _name;
  set name(String? name) => _name = name;
  int? get time => _time;
  set time(int? time) => _time = time;
  String? get gender => _gender;
  set gender(String? gender) => _gender = gender;
  int? get price => _price;
  set price(int? price) => _price = price;
  String? get imagePath => _imagePath;
  set imagePath(String? imagePath) => _imagePath = imagePath;

  Services.fromJson(Map<String, dynamic> json) {
    _serviceId = json['service_id'];
    _image = json['image'];
    _name = json['name'];
    _time = json['time'];
    _gender = json['gender'];
    _price = json['price'];
    _imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_id'] = this._serviceId;
    data['image'] = this._image;
    data['name'] = this._name;
    data['time'] = this._time;
    data['gender'] = this._gender;
    data['price'] = this._price;
    data['imagePath'] = this._imagePath;
    return data;
  }
}

class Employee {
  int? _empId;
  String? _name;
  String? _image;
  String? _imagePath;

  Employee({int? empId, String? name, String? image, String? imagePath}) {
    if (empId != null) {
      this._empId = empId;
    }
    if (name != null) {
      this._name = name;
    }
    if (image != null) {
      this._image = image;
    }
    if (imagePath != null) {
      this._imagePath = imagePath;
    }
  }

  int? get empId => _empId;
  set empId(int? empId) => _empId = empId;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get image => _image;
  set image(String? image) => _image = image;
  String? get imagePath => _imagePath;
  set imagePath(String? imagePath) => _imagePath = imagePath;

  Employee.fromJson(Map<String, dynamic> json) {
    _empId = json['emp_id'];
    _name = json['name'];
    _image = json['image'];
    _imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_id'] = this._empId;
    data['name'] = this._name;
    data['image'] = this._image;
    data['imagePath'] = this._imagePath;
    return data;
  }
}
