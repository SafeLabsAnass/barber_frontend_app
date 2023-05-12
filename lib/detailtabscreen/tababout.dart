import 'dart:convert';

import 'package:barber_app/ResponseModel/WorkingHourDisplayModel.dart';
import 'package:barber_app/ResponseModel/salonDetailResponse.dart';
import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/color_constant.dart';
import 'package:barber_app/constant/constant_font.dart';
import 'package:barber_app/constant/dymmyimages.dart';
import 'package:barber_app/constant/preferenceutils.dart';
import 'package:barber_app/constant/string_constant.dart';
import 'package:barber_app/constant/toast_message.dart';
import 'package:barber_app/network/Apiservice.dart';
import 'package:barber_app/network/BaseModel.dart';
import 'package:barber_app/network/Retro_Api.dart';
import 'package:barber_app/network/ServerError.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:barber_app/detailtabscreen/website.dart';
import 'package:barber_app/screens/directiondestination.dart';
import 'package:barber_app/separator/separator.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:url_launcher/url_launcher.dart';

class TabAbout extends StatefulWidget {
  final SalonDetails salonData;
  final int? catId;
  final String distance;

  TabAbout(this.salonData, this.catId, this.distance);

  @override
  _TabAbout createState() => new _TabAbout();
}

class _TabAbout extends State<TabAbout> {
  var salonData1;

  // String? mondayTime = "";
  // String? tuesdayTime = "";
  // String? wednesDayTime = "";
  // String? thursDayTime = "";
  // String? fridayTime = "";
  // String? saturdayTime = "";
  // String? sundayTime = "";

  double? currentLat;
  double? currentLong;
  String distance = " ";
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    distance = widget.distance;
    callGetSalonWorkingHour();
    if (mounted) {
      setState(() {
        var salonLat = double.parse(widget.salonData.latitude!);
        var salonLong = double.parse(widget.salonData.longitude!);
        // ignore: unnecessary_type_check
        assert(salonLat is double);
        // ignore: unnecessary_type_check
        assert(salonLong is double);

        double distanceInMeters =
            Geolocator.distanceBetween(AppConstant.currentlat, AppConstant.currentlong, salonLat, salonLong);
        double distanceinkm = distanceInMeters / 1000;
        print("current_distanceInMeters:$distanceInMeters");
        print("current_distanceinkm:$distanceinkm");

        String str = distanceinkm.toString();
        var distance12 = str.split('.');

        distance = distance12[0];
        print("km123:$distance");
      });
    }
    checkPermission();
    salonData1 = widget.salonData;
    PreferenceUtils.init();

    // if (widget.salonData.sunday!.open == null &&
    //     widget.salonData.sunday!.close == null) {
    //   sundayTime = "Close";
    // } else {
    //   DateTime tempStartTime=DateFormat("hh:mm").parse(widget.salonData.sunday!.open!);
    //   DateTime tempEndTime=DateFormat("hh:mm").parse(widget.salonData.sunday!.close!);
    //   var startTimeFormat=DateFormat("h:mm a");
    //   sundayTime=startTimeFormat.format(tempStartTime)+" to "+startTimeFormat.format(tempEndTime);
    // }
    //
    // if (widget.salonData.monday!.open == null &&
    //     widget.salonData.monday!.close == null) {
    //   mondayTime = "Close";
    // } else {
    //   DateTime tempStartTime=DateFormat("hh:mm").parse(widget.salonData.monday!.open!);
    //   DateTime tempEndTime=DateFormat("hh:mm").parse(widget.salonData.monday!.close!);
    //   var startTimeFormat=DateFormat("h:mm a");
    //   mondayTime=startTimeFormat.format(tempStartTime)+" to "+startTimeFormat.format(tempEndTime);
    // }
    //
    // if (widget.salonData.tuesday!.open == null &&
    //     widget.salonData.tuesday!.close == null) {
    //   tuesdayTime = "Close";
    // } else {
    //
    //   DateTime tempStartTime=DateFormat("hh:mm").parse(widget.salonData.tuesday!.open!);
    //   DateTime tempEndTime=DateFormat("hh:mm").parse(widget.salonData.tuesday!.close!);
    //   var startTimeFormat=DateFormat("h:mm a");
    //   tuesdayTime=startTimeFormat.format(tempStartTime)+" to "+startTimeFormat.format(tempEndTime);
    // }
    //
    // if (widget.salonData.wednesday!.open == null &&
    //     widget.salonData.wednesday!.close == null) {
    //   wednesDayTime = "Close";
    // } else {
    //   DateTime tempStartTime=DateFormat("hh:mm").parse(widget.salonData.wednesday!.open!);
    //   DateTime tempEndTime=DateFormat("hh:mm").parse(widget.salonData.wednesday!.close!);
    //   var startTimeFormat=DateFormat("h:mm a");
    //   wednesDayTime=startTimeFormat.format(tempStartTime)+" to "+startTimeFormat.format(tempEndTime);
    // }
    //
    // if (widget.salonData.thursday!.open == null &&
    //     widget.salonData.thursday!.close == null) {
    //   thursDayTime = "Close";
    // } else {
    //   DateTime tempStartTime=DateFormat("hh:mm").parse(widget.salonData.thursday!.open!);
    //   DateTime tempEndTime=DateFormat("hh:mm").parse(widget.salonData.thursday!.close!);
    //   var startTimeFormat=DateFormat("h:mm a");
    //   thursDayTime=startTimeFormat.format(tempStartTime)+" to "+startTimeFormat.format(tempEndTime);
    // }
    //
    // if (widget.salonData.friday!.open == null &&
    //     widget.salonData.friday!.close == null) {
    //   fridayTime = "Close";
    // } else {
    //
    //   DateTime tempStartTime=DateFormat("hh:mm").parse(widget.salonData.friday!.open!);
    //   DateTime tempEndTime=DateFormat("hh:mm").parse(widget.salonData.friday!.close!);
    //   var startTimeFormat=DateFormat("h:mm a");
    //   fridayTime=startTimeFormat.format(tempStartTime)+" to "+startTimeFormat.format(tempEndTime);
    // }
    //
    // if (widget.salonData.saturday!.open == null &&
    //     widget.salonData.saturday!.close == null) {
    //   saturdayTime = "Close";
    // } else {
    //   DateTime tempStartTime=DateFormat("hh:mm").parse(widget.salonData.saturday!.open!);
    //   DateTime tempEndTime=DateFormat("hh:mm").parse(widget.salonData.saturday!.close!);
    //   var startTimeFormat=DateFormat("h:mm a");
    //   saturdayTime=startTimeFormat.format(tempStartTime)+" to "+startTimeFormat.format(tempEndTime);
    // }
  }

  void checkPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();

    permission = await Geolocator.checkPermission();
    print("permissionResult:$permission");

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      print("denied");
    } else if (permission == LocationPermission.whileInUse) {
      print("whileInUse56362");

      setState(() {
        double salonLat = double.parse(widget.salonData.latitude!);
        double salonLong = double.parse(widget.salonData.longitude!);
        // ignore: unnecessary_type_check
        assert(salonLat is double);
        // ignore: unnecessary_type_check
        assert(salonLong is double);

        AppConstant.getDistance(salonLat, salonLong)
            .whenComplete(() => AppConstant.getDistance(salonLat, salonLong).then((value) {
                  distance = value;
                  print("Distance123:$distance");
                }));
      });
    } else if (permission == LocationPermission.always) {
      print("always");
      setState(() {
        double salonLat = double.parse(widget.salonData.latitude!);
        double salonLong = double.parse(widget.salonData.longitude!);
        // ignore: unnecessary_type_check
        assert(salonLat is double);
        // ignore: unnecessary_type_check
        assert(salonLong is double);

        AppConstant.getDistance(salonLat, salonLong)
            .whenComplete(() => AppConstant.getDistance(salonLat, salonLong).then((value) {
                  distance = value;
                  print("Distance123:$distance");
                }));
      });
    }
  }

  List<WorkingHourDataList> serviceDataList = [];

  Future<BaseModel<WorkingHourDisplayModel>> callGetSalonWorkingHour() async {
    WorkingHourDisplayModel response;
    try {
      setState(() {
        _loading = true;
        serviceDataList.clear();
      });
      response = await RestClient(RetroApi().dioData()).getSalonWorkingHour();
      if (response.success == true) {
        setState(() {
          serviceDataList.addAll(response.data!);
        });
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
    return BaseModel()..data;
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      opacity: 1.0,
      color: Colors.transparent.withOpacity(0.2),
      progressIndicator: SpinKitFadingCircle(color: pinkColor, size: 20),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: whiteColor,
          body: Padding(
              padding: EdgeInsets.only(top: 0, left: 20, right: 15, bottom: 50),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 0, top: 1),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "About " + " " + salonData1.name,
                      style: TextStyle(
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          fontFamily: ConstantFont.montserratSemiBold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 0, top: 10, right: 10),
                    alignment: Alignment.topLeft,
                    child: Text(
                      salonData1.desc,
                      style: TextStyle(
                          color: grey99,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          fontFamily: ConstantFont.montserratRegular),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 0, top: 15),
                    alignment: Alignment.topLeft,
                    child: Text(
                      StringConstant.serviceOnDays,
                      style: TextStyle(
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          fontFamily: ConstantFont.montserratSemiBold),
                    ),
                  ),
                  ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: serviceDataList.length,
                    itemBuilder: (context, index) {
                      List<HourPeriod> decodeAmount = [];
                      var deliveryCharge = json.decode(serviceDataList[index].periodList!);
                      decodeAmount = (deliveryCharge as List).map((i) => HourPeriod.fromJson(i)).toList();
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            serviceDataList[index].dayIndex!,
                            style: TextStyle(
                                color: grey99,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: ConstantFont.montserratRegular),
                          ),
                          Expanded(
                            child: serviceDataList[index].status == 0
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Close",
                                        style: TextStyle(
                                            color: grey99,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            fontFamily: ConstantFont.montserratRegular),
                                      ),
                                    ],
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: decodeAmount.length,
                                    itemBuilder: (context, day) {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            decodeAmount[day].startTime!,
                                            style: TextStyle(
                                                color: grey99,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                fontFamily: ConstantFont.montserratRegular),
                                          ),
                                          Text(
                                            "-" + decodeAmount[day].endTime!,
                                            style: TextStyle(
                                                color: grey99,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                fontFamily: ConstantFont.montserratRegular),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                          )
                        ],
                      );
                    },
                  ),
                  // Container(
                  //    width: double.infinity,
                  //    margin: EdgeInsets.only(left: 0, top: 10, right: 10),
                  //    child: Row(
                  //      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //      children: [
                  //        Container(
                  //          child: Text(
                  //            StringConstant.startTime,
                  //            style: TextStyle(
                  //                color:  grey99,
                  //                fontWeight: FontWeight.w600,
                  //                fontSize: 14,
                  //                fontFamily: ConstantFont.montserratRegular),
                  //          ),
                  //        ),
                  //        Container(
                  //          child: Text(
                  //            widget.salonData.startTime!,
                  //            style: TextStyle(
                  //                color:  grey99,
                  //                fontWeight: FontWeight.w600,
                  //                fontSize: 14,
                  //                fontFamily: ConstantFont.montserratRegular),
                  //          ),
                  //        ),
                  //      ],
                  //    ),
                  //  ),
                  // Container(
                  //    width: double.infinity,
                  //    margin: EdgeInsets.only(left: 0, top: 10, right: 10),
                  //    child: Row(
                  //      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //      children: [
                  //        Container(
                  //          child: Text(
                  //            StringConstant.endTime,
                  //            style: TextStyle(
                  //                color:  grey99,
                  //                fontWeight: FontWeight.w600,
                  //                fontSize: 14,
                  //                fontFamily: ConstantFont.montserratRegular),
                  //          ),
                  //        ),
                  //        Container(
                  //          child: Text(
                  //            widget.salonData.endTime!,
                  //            style: TextStyle(
                  //                color:  grey99,
                  //                fontWeight: FontWeight.w600,
                  //                fontSize: 14,
                  //                fontFamily: ConstantFont.montserratRegular),
                  //          ),
                  //        ),
                  //      ],
                  //    ),
                  //  ),
                  /* Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 0, top: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            StringConstant.Sunday,
                            style: TextStyle(
                                color:  grey99,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: ConstantFont.montserratRegular),
                          ),
                        ),
                        Container(
                          child: Text(
                            sundayTime!,
                            style: TextStyle(
                                color:  grey99,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: ConstantFont.montserratRegular),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 00, top: 5, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            StringConstant.Monday,
                            style: TextStyle(
                                color:  grey99,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: ConstantFont.montserratRegular),
                          ),
                        ),
                        Container(
                          child: Text(
                            mondayTime!,
                            style: TextStyle(
                                color:  grey99,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: ConstantFont.montserratRegular),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 00, top: 5, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            StringConstant.Tuesday,
                            style: TextStyle(
                                color:  grey99,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: ConstantFont.montserratRegular),
                          ),
                        ),
                        Container(
                          child: Text(
                            tuesdayTime!,
                            style: TextStyle(
                                color:  grey99,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: ConstantFont.montserratRegular),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 00, top: 5, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            StringConstant.Wednesday,
                            style: TextStyle(
                                color:grey99,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: ConstantFont.montserratRegular),
                          ),
                        ),
                        Container(
                          child: Text(
                            wednesDayTime!,
                            style: TextStyle(
                                color:  grey99,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: ConstantFont.montserratRegular),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 00, top: 5, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            StringConstant.Thursday,
                            style: TextStyle(
                                color:  grey99,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: ConstantFont.montserratRegular),
                          ),
                        ),
                        Container(
                          child: Text(
                            thursDayTime!,
                            style: TextStyle(
                                fontSize: 14,
                                color:  grey99,
                                fontWeight: FontWeight.w600,
                                fontFamily: ConstantFont.montserratRegular),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 00, top: 5, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            StringConstant.Friday,
                            style: TextStyle(
                                color:  grey99,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: ConstantFont.montserratRegular),
                          ),
                        ),
                        Container(
                          child: Text(
                            fridayTime!,
                            style: TextStyle(
                                color:grey99,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: ConstantFont.montserratRegular),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 00, top: 5, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            StringConstant.Saturday,
                            style: TextStyle(
                                color:  grey99,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: ConstantFont.montserratRegular),
                          ),
                        ),
                        Container(
                          child: Text(
                            saturdayTime!,
                            style: TextStyle(
                                color: grey99,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: ConstantFont.montserratRegular),
                          ),
                        ),
                      ],
                    ),
                  ),*/
                  Container(
                    margin: EdgeInsets.only(left: 00, top: 15),
                    alignment: Alignment.topLeft,
                    child: Text(
                      StringConstant.location,
                      style: TextStyle(
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          fontFamily: ConstantFont.montserratSemiBold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, left: 00, right: 10),
                    width: double.infinity,
                    height: 110,
                    color: whiteColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        new Container(
                          height: 70,
                          width: 70,
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: AssetImage(DummyImage.mapLocation),
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 20, left: 10, right: 20),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    widget.salonData.address!,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: grey99,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                        fontFamily: ConstantFont.montserratMedium),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      height: 2,
                                      child: MySeparator(),
                                    )),
                                Container(
                                  margin: EdgeInsets.only(top: 5, left: 10, right: 00),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        color: whiteColor,
                                        alignment: Alignment.topRight,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(top: 1),
                                              child: Container(
                                                margin: EdgeInsets.only(top: 2, left: 0),
                                                child: SvgPicture.asset(
                                                  DummyImage.locationIcon,
                                                  width: 10,
                                                  height: 10,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Container(
                                                margin: EdgeInsets.only(top: 2, left: 5),
                                                child: Text(distance + " km",
                                                    style: TextStyle(
                                                        color: const Color(0xFF999999),
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w600,
                                                        fontFamily: ConstantFont.montserratMedium)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => new DirectionDest(widget.salonData)));
                                        },
                                        child: Container(
                                          color: whiteColor,
                                          alignment: Alignment.topRight,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(top: 2),
                                                child: Container(
                                                  margin: EdgeInsets.only(top: 2, left: 5),
                                                  child: SvgPicture.asset(
                                                    DummyImage.direction,
                                                    width: 10,
                                                    height: 10,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Container(
                                                  margin: EdgeInsets.only(top: 2, left: 5),
                                                  child: Text(StringConstant.seeTheDirection,
                                                      style: TextStyle(
                                                          color: blue4a,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w600,
                                                          fontFamily: ConstantFont.montserratMedium)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 0, top: 15),
                    alignment: Alignment.topLeft,
                    child: Text(
                      StringConstant.contactInformation,
                      style: TextStyle(
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          fontFamily: ConstantFont.montserratSemiBold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 0, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          color: whiteColor,
                          alignment: Alignment.topRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 1),
                                child: Container(
                                  margin: EdgeInsets.only(top: 2, left: 0),
                                  child: SvgPicture.asset(
                                    DummyImage.website,
                                    width: 12,
                                    height: 12,
                                  ),
                                ),
                              ),
                              Container(
                                child: Container(
                                  margin: EdgeInsets.only(top: 2, left: 5),
                                  child: Text(StringConstant.Website,
                                      style: TextStyle(
                                          color: pinkColor,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: ConstantFont.montserratMedium)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            child: GestureDetector(
                          onTap: () {
                            if (widget.salonData.website != null) {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => new WebSite()));
                            } else {
                              ToastMessage.toastMessage('Website not available.');
                            }
                          },
                          child: Text(
                            StringConstant.visitTheWebsite,
                            style: TextStyle(
                                color: blue4a,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: ConstantFont.montserratMedium),
                          ),
                        )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 0, top: 15, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          color: whiteColor,
                          alignment: Alignment.topRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 1),
                                child: Container(
                                  margin: EdgeInsets.only(top: 2, left: 0),
                                  child: SvgPicture.asset(
                                    DummyImage.phone,
                                    width: 12,
                                    height: 12,
                                  ),
                                ),
                              ),
                              Container(
                                child: Container(
                                  margin: EdgeInsets.only(top: 2, left: 5),
                                  child: Text("Call",
                                      style: TextStyle(
                                          color: pinkColor,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: ConstantFont.montserratMedium)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: GestureDetector(
                            onTap: () {
                              launchUrl(Uri.parse('tel://' + widget.salonData.phone.toString()));
                              // launch(('tel://' + widget.salonData.phone.toString()));
                            },
                            child: Text(
                              widget.salonData.phone.toString(),
                              style: TextStyle(
                                  color: blue4a,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  fontFamily: ConstantFont.montserratMedium),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(),
    );
  }
}

class HourPeriod {
  String? startTime;
  String? endTime;

  HourPeriod({this.startTime, this.endTime});

  factory HourPeriod.fromJson(Map<String, dynamic> persiod) {
    return HourPeriod(startTime: persiod["start_time"], endTime: persiod["end_time"]);
  }
}
