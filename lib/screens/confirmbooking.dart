import 'dart:async';

import 'package:barber_app/ResponseModel/paymentGatwayResponse.dart';
import 'package:barber_app/ResponseModel/salonDetailResponse.dart';
import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/color_constant.dart';
import 'package:barber_app/constant/constant_font.dart';
import 'package:barber_app/constant/dymmyimages.dart';
import 'package:barber_app/constant/preferenceutils.dart';
import 'package:barber_app/constant/string_constant.dart';
import 'package:barber_app/constant/toast_message.dart';
import 'package:barber_app/fragments/appoinment.dart';
import 'package:barber_app/network/Apiservice.dart';
import 'package:barber_app/network/BaseModel.dart';
import 'package:barber_app/network/Retro_Api.dart';
import 'package:barber_app/network/ServerError.dart';
import 'package:barber_app/screens/generateStripToken.dart';
import 'package:barber_app/screens/homescreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:persistent_bottom_nav_bar_ccc/persistent-tab-view.dart';

class ConfirmBooking extends StatefulWidget {
  final double? totalprice;
  final List<int?>? selectedServices;

  final int? salonId;
  final date;

  final time;
  final int? selectedEmpId;
  final List? _totalprice;

  final List<String?>? _selectedServicesName;

  final SalonDetails salonData;
  final bool couponVisible;
  final bool couponNotVisible;

  ConfirmBooking(
      this.selectedEmpId,
      this.time,
      this.date,
      this.totalprice,
      this.selectedServices,
      this.salonId,
      this._selectedServicesName,
      this._totalprice,
      this.salonData,
      this.couponVisible,
      this.couponNotVisible);

  @override
  _ConfirmBooking createState() => new _ConfirmBooking();
}

class _ConfirmBooking extends State<ConfirmBooking> {
  bool _loading = false;
  double? totalprice;
  List<int>? selectedServices = <int>[];
  int? salonId;
  var date;
  var time;
  int? selectedEmpId;
  List? _totalprice = [];
  var rating = 1.0;

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;

  void onOpen() {
    setState(() {
      xOffset = 220;
      yOffset = 130;
      scaleFactor = 0.7;
      isDrawerOpen = true;
    });
  }

  void onClose() {
    setState(() {
      xOffset = 0;
      yOffset = 0;
      scaleFactor = 1;
      isDrawerOpen = false;
    });
  }

  List<String>? _selectedServicesName = <String>[];
  late var parsedDate;

  SalonDetails? salonData;
  bool couponVisible = true;
  bool couponNotVisible = false;
  CardFieldInputDetails? card = CardFieldInputDetails(complete: false);
  String radioItem = 'Pay Local';
  int? id;
  String? image = "assets/images/localpay.png";
  List<PaymentType> fList = [];

  @override
  void initState() {
    super.initState();
    print(widget.salonData.salonId);
    WidgetsFlutterBinding.ensureInitialized();

    PreferenceUtils.init();

    AppConstant.checkNetwork().whenComplete(() => getPaymentSettingData());

    totalprice = widget.totalprice;
    selectedServices = widget.selectedServices!.cast<int>();
    salonId = widget.salonId;
    date = widget.date;
    time = widget.time;
    selectedEmpId = widget.selectedEmpId;
    _totalprice = widget._totalprice;
    _selectedServicesName = widget._selectedServicesName!.cast<String>();
    salonData = widget.salonData;
    couponVisible = widget.couponVisible;
    couponNotVisible = widget.couponNotVisible;
    parsedDate = DateTime.parse(date);
    var df = new DateFormat('MMMM dd,yyyy');

    parsedDate = df.format(parsedDate);
  }

  PaymentGatwayResponse? paymentSetting;

  void callApiForAddReview(int id, String? message) {
    print("bookId:$id");
    print("bookSalonId:$salonId");
    print("bookRate:$rating");
    print("bookMessage:$message");
    Map<String, String> body = {
      "message": message!,
      "rate": rating.toString(),
      "booking_id": id.toString(),
    };
    setState(() {
      _loading = true;
    });
    RestClient(RetroApi().dioData()).addreview(body).then((response) {
      setState(() {
        _loading = false;
        print(response.success);
        if (response.success = true) {
          print("sucess");

          ToastMessage.toastMessage(response.msg!);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen(1)),
          );
        }
      });
    }).catchError((Object obj) {
      setState(() {
        _loading = false;
      });
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response!;

          var responseCode = res.statusCode;
          var msg = res.statusMessage;

          if (responseCode == 401) {
            ToastMessage.toastMessage("Data Invalide");
            print(responseCode);
            print(res.statusMessage);
          } else if (responseCode == 422) {
            ToastMessage.toastMessage("Email Invalide");
            print("code:$responseCode");
            print("msg:$msg");
          }

          break;
        default:
      }
    });
  }

  Future<BaseModel<PaymentGatwayResponse>> getPaymentSettingData() async {
    PaymentGatwayResponse response;
    try {
      setState(() {
        _loading = true;
      });
      response = await RestClient(RetroApi().dioData()).paymentgateway();
      if (response.success == true) {
        paymentSetting = response;
        if (response.data!.cod == 1) {
          fList.add(PaymentType(
              index: 1, name: "LOCAL", image: "images/localpay.png"));
        }
        if (response.data!.stripe == 1) {
          stripKey = response.data!.stripePublicKey;
          stripKey = response.data!.stripePublicKey;
          Stripe.publishableKey = stripKey!;
          fList.add(
            PaymentType(index: 2, name: "STRIPE", image: "images/stripe.png"),
          );
        }
      } else {
        print(response.msg);
        ToastMessage.toastMessage(response.msg.toString());
      }

      setState(() {
        _loading = false;
      });
    } catch (error) {
      setState(() {
        _loading = false;
      });
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  String _result = "";
  int? _radioValue = -1;

  String? stripKey = "";

  void _sucessPayment(BuildContext context, int? radioValue, String result) {
    String paymentToken = "";

    AppConstant.checkNetwork()
        .whenComplete(() => callApiForBookService(result, paymentToken));
  }

  void callApiForBookService(String result1, String paymentToken) {
    Map<String, String> body = {
      "emp_id": selectedEmpId.toString(),
      "service_id": selectedServices.toString(),
      "payment": totalprice.toString(),
      "date": date.toString(),
      "start_time": time.toString(),
      "payment_type": result1,
      "payment_token": paymentToken
    };
    print(body);
    setState(() {
      _loading = true;
    });
    RestClient(RetroApi().dioData()).booking(body).then((response) {
      print("bookingResponse:${response.toString()}");
      setState(() {
        _loading = false;
        if (response.success = true) {
          showSucess();
        } else {
          ToastMessage.toastMessage(response.msg!);
        }
      });
    }).catchError((Object obj) {
      print(obj);
      setState(() {
        _loading = false;
      });
    });
  }

  int? currentSelectedIndex;
  String? categoryName;

  bool viewVisible = false;

  void showWidget() {
    setState(() {
      viewVisible = true;
    });
  }

  void hideWidget() {
    setState(() {
      viewVisible = false;
    });
  }

  List<T?> map<T>(List list, Function handler) {
    List<T?> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  Future<bool> _onWillPop() async {
    final completer = Completer<bool>();
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new HomeScreen(1)));
    completer.complete(true);
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    dynamic screenWidth = MediaQuery.of(context).size.width;

    return ModalProgressHUD(
      inAsyncCall: _loading,
      opacity: 1.0,
      color: Colors.transparent.withOpacity(0.2),
      progressIndicator: SpinKitFadingCircle(color: pinkColor),
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: SafeArea(
          child: Scaffold(
              backgroundColor: whiteColor,
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_left,
                    color: blackColor,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                title: Text(
                  StringConstant.bookAppointment,
                  style: TextStyle(
                      color: blackColor,
                      fontFamily: ConstantFont.montserratBold,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
                centerTitle: true,
                backgroundColor: whiteColor,
                elevation: 0.0,
              ),
              body: new Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.05),
                    child: Container(
                      child: new Column(
                        children: <Widget>[
                          ///confirm your booking text
                          Container(
                            margin: EdgeInsets.only(
                              top: 10.0,
                              bottom: 00.0,
                              left: 30.0,
                              right: 0.0,
                            ),
                            color: whiteColor,
                            child: Text(
                              StringConstant.confirmationYourBooking,
                              style: TextStyle(
                                  color: blackColor,
                                  fontFamily: ConstantFont.montserratBold,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                          ),

                          ///salon details
                          Container(
                            height: 120,
                            margin: EdgeInsets.all(10),
                            child: Container(
                              margin: EdgeInsets.only(
                                left: 10,
                                right: 10,
                              ),
                              height: 120,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: whiteF1, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: ListView(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: <Widget>[
                                  Container(
                                      alignment: Alignment.topLeft,
                                      margin:
                                          EdgeInsets.only(left: 5.0, top: 0.0),
                                      child: Row(
                                        children: <Widget>[
                                          new Container(
                                            height: 70,
                                            width: 70,
                                            alignment: Alignment.topLeft,
                                            child: CachedNetworkImage(
                                              imageUrl: salonData!.imagePath! +
                                                  salonData!.image!,
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.fill,
                                                    alignment:
                                                        Alignment.topCenter,
                                                  ),
                                                ),
                                              ),
                                              placeholder: (context, url) =>
                                                  SpinKitFadingCircle(
                                                      color: pinkColor),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Image.asset(
                                                          DummyImage.noImage),
                                            ),
                                          ),
                                          new Container(
                                              width: screenWidth * .65,
                                              height: 110,
                                              margin: EdgeInsets.only(
                                                  left: 5.0, top: 0.0),
                                              alignment: Alignment.topLeft,
                                              color: whiteColor,
                                              child: ListView(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                children: <Widget>[
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 20.0),
                                                    child: Text(
                                                      salonData!.name!,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: blackColor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily: ConstantFont
                                                              .montserratSemiBold),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 5.0),
                                                    child: Text(
                                                      salonData!.address!,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          color: greyColor,
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily: ConstantFont
                                                              .montserratMedium),
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: <Widget>[
                                                          Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 0.0,
                                                                      top: 5.0),
                                                              child: RichText(
                                                                text: TextSpan(
                                                                  children: [
                                                                    WidgetSpan(
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .star,
                                                                        size:
                                                                            14,
                                                                        color:
                                                                            yellowColor,
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                        text: salonData!
                                                                            .rate
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                greyColor,
                                                                            fontSize:
                                                                                11,
                                                                            fontWeight:
                                                                                FontWeight.w600)),
                                                                    TextSpan(
                                                                        text: StringConstant
                                                                            .rating,
                                                                        style: TextStyle(
                                                                            color:
                                                                                greyColor,
                                                                            fontSize:
                                                                                11,
                                                                            fontFamily:
                                                                                ConstantFont.montserratMedium,
                                                                            fontWeight: FontWeight.w600)),
                                                                  ],
                                                                ),
                                                              )),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            alignment: Alignment
                                                                .center,
                                                            width: 5.0,
                                                            height: 5.0,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 5.0,
                                                                    top: 5.0),
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: greyColor,
                                                            ),
                                                          ),
                                                          Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 5.0,
                                                                      top: 5.0,
                                                                      right: 0),
                                                              child: RichText(
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                textScaleFactor:
                                                                    1,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                text: TextSpan(
                                                                  children: [
                                                                    WidgetSpan(
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .calendar_today,
                                                                        size:
                                                                            14,
                                                                        color:
                                                                            pinkColor,
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                        text: time.toString() +
                                                                            " - " +
                                                                            parsedDate
                                                                                .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                greyColor,
                                                                            fontFamily: ConstantFont
                                                                                .montserratMedium,
                                                                            fontSize:
                                                                                11,
                                                                            fontWeight:
                                                                                FontWeight.w600)),
                                                                  ],
                                                                ),
                                                              )),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              )),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),

                          ///select your service text
                          Container(
                            margin: EdgeInsets.only(
                              top: 10.0,
                              bottom: 00.0,
                              left: 30.0,
                              right: 0.0,
                            ),
                            color: whiteColor,
                            child: Text(
                              StringConstant.serviceYouSelected,
                              style: TextStyle(
                                  color: blackColor,
                                  fontFamily: ConstantFont.montserratBold,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                          ),

                          ///service list
                          Container(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: _selectedServicesName!.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 00.0,
                                    left: 30.0,
                                    right: 15.0,
                                  ),
                                  color: whiteColor,
                                  child: ListView(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Text(
                                              _selectedServicesName![index],
                                              style: TextStyle(
                                                  color: grey99,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  fontFamily: ConstantFont
                                                      .montserratMedium),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              _totalprice![index].toString() +
                                                  " DH",
                                              style: TextStyle(
                                                  color: grey99,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  fontFamily: ConstantFont
                                                      .montserratMedium),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                          child: DottedLine(
                                        direction: Axis.horizontal,
                                        lineLength: double.infinity,
                                        lineThickness: 1.0,
                                        dashLength: 4.0,
                                        dashColor:
                                            Color(0xe2777474).withOpacity(0.3),
                                        dashRadius: 0.0,
                                        dashGapLength: 4.0,
                                        dashGapColor: Colors.transparent,
                                        dashGapRadius: 0.0,
                                      )),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),

                          ///only sized box
                          SizedBox(height: 10.0),

                          ///Coupon applied
                          Container(
                            height: 30,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: 25, right: 15),
                            decoration: BoxDecoration(
                                color: pinkColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Column(
                              children: [
                                Visibility(
                                  visible: couponNotVisible,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.only(left: 15, top: 5),
                                        alignment: Alignment.center,
                                        child: Text(
                                          StringConstant.youHaveACouponToUse,
                                          style: TextStyle(
                                              color: whiteColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              fontFamily: ConstantFont
                                                  .montserratMedium),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) => Text(
                                                    "TopOffers") //new TopOffers(
                                                //     1,
                                                //     selectedEmpId,
                                                //     time,
                                                //     date,
                                                //     totalprice,
                                                //     selectedServices,
                                                //     salonId,
                                                //     _selectedServicesName,
                                                //     _totalprice,
                                                //     salonData),
                                                ),
                                          );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              right: 10, top: 6),
                                          alignment: Alignment.center,
                                          child: Text(
                                            StringConstant.clickHere,
                                            style: TextStyle(
                                                color: whiteColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                fontFamily: ConstantFont
                                                    .montserratBold),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: couponVisible,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.only(left: 15, top: 5),
                                        alignment: Alignment.center,
                                        child: Text(
                                          StringConstant.couponApplied,
                                          style: TextStyle(
                                              color: whiteColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              fontFamily: ConstantFont
                                                  .montserratMedium),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              right: 10, top: 6),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'new price: ' +
                                                totalprice.toString() +
                                                " DH",
                                            style: TextStyle(
                                                color: whiteColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                fontFamily: ConstantFont
                                                    .montserratMedium),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          ///select payment method text
                          Container(
                            margin: EdgeInsets.only(
                              top: 20.0,
                              bottom: 00.0,
                              left: 30.0,
                              right: 0.0,
                            ),
                            color: whiteColor,
                            child: Text(
                              StringConstant.selectPaymentMethod,
                              style: TextStyle(
                                  color: blackColor,
                                  fontFamily: ConstantFont.montserratBold,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                          ),

                          ///payment type select
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: fList.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: RadioListTile(
                                  groupValue: id,
                                  value: fList[index].index,
                                  activeColor: pinkColor,
                                  onChanged: (val) {
                                    setState(() {
                                      radioItem = fList[index].name;
                                      id = fList[index].index;
                                      image = fList[index].image;
                                      _result = fList[index].name;
                                    });
                                  },
                                  title: Text(
                                    "${fList[index].name}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily:
                                            ConstantFont.montserratMedium,
                                        color: Colors.black),
                                  ),
                                  secondary: Container(
                                      height: 20,
                                      width: 30,
                                      child: Image.asset(
                                        "${fList[index].image.toString()}",
                                        color: pinkColor,
                                        height: 20,
                                        width: 30,
                                        fit: BoxFit.fill,
                                      )),
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                ),
                              );
                            },
                          ),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding:
                                    EdgeInsets.only(right: 10.0, bottom: 25),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_result == "") {
                                      ToastMessage.toastMessage(
                                          "Veuillez sélectionner le mode de paiement.");
                                    } else {
                                      setState(() {
                                        print(_result);
                                        if (_result == "STRIPE") {
                                          print(stripKey);
                                          print(_result);
                                          print(widget.selectedEmpId);
                                          print(selectedServices);
                                          print(widget.totalprice);
                                          print(widget.time);
                                          print(widget.date);
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      GenerateStripeToken(
                                                        stripeKey: stripKey!,
                                                        salonDetails:
                                                            widget.salonData,
                                                        result: "STRIPE",
                                                        empId: widget
                                                            .selectedEmpId!,
                                                        selectedServices:
                                                            selectedServices!,
                                                        totalPrice:
                                                            widget.totalprice!,
                                                        date: widget.date,
                                                        time: widget.time,
                                                      )));
                                        } else {
                                          _sucessPayment(
                                              context, _radioValue, _result);

                                        }
                                      });
                                    }
                                  },
                                  child: Text("Pay"),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: pinkColor),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment.bottomCenter,
                  //   child: CustomView(),
                  // ),
                ],
              )),
        ),
      ),
    );
  }

  void showSucess() {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
             
              return Container(
                margin: EdgeInsets.only(top: 30, left: 15, bottom: 20),
                color: whiteColor,
                padding: EdgeInsets.symmetric(
                  horizontal: 1,
                ),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 20.0, left: 0.0),
                          alignment: FractionalOffset.center,
                          child: Image.asset(
                            DummyImage.changePasswordDone,
                            width: 75,
                            height: 75,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 20.0, left: 15.0, right: 15),
                          child: Text(
                            StringConstant.yourAppointmentBookingIsSuccessfully,
                            style: TextStyle(
                                color: blackColor,
                                fontFamily: ConstantFont.montserratMedium,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 20.0, left: 15.0, right: 15),
                          child: Text(
                            StringConstant
                                .youCanSeeYourUpcomingAppointmentInAppointmentSection,
                            style: TextStyle(
                                color: greyColor,
                                fontFamily: ConstantFont.montserratMedium,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _radioValue = -1;
                          // Navigator.push(context, new MaterialPageRoute(builder: (context) =>  HomeScreen(1) ));
                          pushNewScreen(
                            context,
                            screen: Appoinment(isDrawerOpen: isDrawerOpen, onOpen: onOpen, onClose: onClose),
                            withNavBar: false,
                          );
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: const EdgeInsets.only(top: 40.0, left: 15.0, right: 15, bottom: 20),
                            child: Text(
                              StringConstant.goThere,
                              style: TextStyle(
                                  color: pinkColor,
                                  fontFamily: ConstantFont.montserratMedium,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ]),
              );
            },
          );
        });
  }
}

class PaymentType {
  String name;
  int index;
  String image;

  PaymentType({
    required this.name,
    required this.index,
    required this.image,
  });
}
