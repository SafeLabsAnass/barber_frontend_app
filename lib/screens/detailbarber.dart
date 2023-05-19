
import 'package:barber_app/ResponseModel/salonDetailResponse.dart';
import 'package:barber_app/appbar/app_bar_only.dart';
import 'package:barber_app/common/common_view.dart';
import 'package:barber_app/common/inndicator.dart';
import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/color_constant.dart';
import 'package:barber_app/constant/constant_font.dart';
import 'package:barber_app/constant/dymmyimages.dart';
import 'package:barber_app/constant/preferenceutils.dart';
import 'package:barber_app/constant/string_constant.dart';
import 'package:barber_app/constant/toast_message.dart';
import 'package:barber_app/detailtabscreen/galleryview.dart';
import 'package:barber_app/detailtabscreen/reviewtab.dart';
import 'package:barber_app/detailtabscreen/servicetab.dart';
import 'package:barber_app/detailtabscreen/tababout.dart';
import 'package:barber_app/drawer/drawer_only.dart';
import 'package:barber_app/network/Apiservice.dart';
import 'package:barber_app/network/Retro_Api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'homescreen.dart';

class DetailBarber extends StatefulWidget {
  final String? title;
  final VoidCallback onOpen;
  final VoidCallback onClose;
  final bool isDrawerOpen;

  final int? catId;
  final int? currentSelectedIndex;

  DetailBarber(
      {Key? key,
      this.title,
      this.catId,
      this.currentSelectedIndex,
      required isDrawerOpen,
      required this.onOpen,
      required this.onClose})
      : isDrawerOpen = isDrawerOpen,
        super(key: key);

  @override
  _DetailBarber createState() => new _DetailBarber();
}

class _DetailBarber extends State<DetailBarber>
    with SingleTickerProviderStateMixin {
  int index = 0;
  List<SalonData> categorydataList = <SalonData>[];
  List<SalonGallery> galleyDataList = <SalonGallery>[];
  List<SalonCategory> categoryList = <SalonCategory>[];
  List<SalonReview> reviewList = <SalonReview>[];
  SalonDetails salonData = SalonDetails(
      createdAt: "",
      updatedAt: "",
      status: 0,
      name: "",
      address: "",
      image: "",
      city: "",
      country: "",
      desc: "",
      fri: "",
      friday: Sunday(close: "", open: ""),
      gender: "",
      imagePath: "",
      latitude: "",
      logo: "",
      longitude: "",
      mon: "",
      monday: Sunday(
        open: "",
        close: "",
      ),
      ownerDetails: SalonOwnerDetails(
          imagePath: "",
          image: "",
          name: "",
          status: 0,
          updatedAt: "",
          createdAt: "",
          id: 0,
          otp: null,
          email: "",
          deviceToken: "",
          addedBy: null,
          code: "",
          emailVerifiedAt: null,
          mail: 0,
          notification: 0,
          phone: "",
          role: 0,
          salonName: "",
          verify: 0));

  var salonId;
  String? salonName = "Cindy Beauty";
  String? salonAddress = "No Address found";
  bool dataVisible = false;
  bool noDataVisible = true;
  bool _loading = false;
  String name = "User";
  String distance = "0";
  String salonImage = "";
  var salonTime;
  String openLabel = "OPEN";
  var day;
  String rating = "0";

  TabController? _controller;

  @override
  void initState() {
    super.initState();

    if (mounted) {
      var day = DateFormat('EEEE').format(DateTime.now());
      print("Today Is:$day");

      setState(() {
        _controller = new TabController(length: 4, vsync: this, initialIndex: 2);
        int? catId = widget.catId;
        print("catId:$catId");
        PreferenceUtils.init();
        AppConstant.checkNetwork().whenComplete(() => callApiForBarberDetail());
        name = PreferenceUtils.getString(AppConstant.username);
      });
    }
  }

  void callApiForBarberDetail() {
    setState(() {
      _loading = true;
    });
    RestClient(RetroApi().dioData()).salondetail().then((response) {
      setState(() {
        _loading = false;
        print(response.success);

        if (response.success = true) {
          print("detailResponse:${response.msg}");

          dataVisible = true;
          noDataVisible = false;
          print(response.data!.category!.length);

          salonId = response.data!.salon!.salonId;
          salonName = response.data!.salon!.name;
          salonAddress = response.data!.salon!.address;
          rating = response.data!.salon!.rate.toString();
          salonImage =
              response.data!.salon!.imagePath! + response.data!.salon!.image!;
          salonTime = response.data!.salon!.endTime!;
          salonData = response.data!.salon!;

          // if (day == "Sunday") {
          //   if (response.data!.salon!.sunday!.open == null &&
          //       response.data!.salon!.sunday!.close == null) {
          //     salonTime = "Close";
          //     openLabel = "CLOSE";
          //     print(salonTime);
          //   } else {
          //     DateTime tempStartTime = DateFormat("hh:mm")
          //         .parse(response.data!.salon!.sunday!.open!);
          //     DateTime tempEndTime = DateFormat("hh:mm")
          //         .parse(response.data!.salon!.sunday!.close!);
          //     var startTimeFormat = DateFormat("h:mm a");
          //     salonTime = startTimeFormat.format(tempStartTime) +
          //         " to " +
          //         startTimeFormat.format(tempEndTime);
          //     openLabel = "OPEN";
          //
          //     print(salonTime);
          //   }
          // }
          // day = DateFormat('EEEE').format(DateTime.now());
          // if (day == "Saturday") {
          //   if (response.data!.salon!.saturday!.open == null &&
          //       response.data!.salon!.saturday!.close == null) {
          //     salonTime = "Close";
          //     openLabel = "CLOSE";
          //     print(salonTime);
          //   } else {
          //     DateTime tempStartTime = DateFormat("hh:mm")
          //         .parse(response.data!.salon!.saturday!.open!);
          //     DateTime tempEndTime = DateFormat("hh:mm")
          //         .parse(response.data!.salon!.saturday!.close!);
          //     var startTimeFormat = DateFormat("h:mm a");
          //     salonTime = startTimeFormat.format(tempStartTime) +
          //         " to " +
          //         startTimeFormat.format(tempEndTime);
          //     openLabel = "OPEN";
          //     print(salonTime);
          //   }
          // }
          //
          // if (day == "Friday") {
          //   if (response.data!.salon!.friday!.open == null &&
          //       response.data!.salon!.friday!.close == null) {
          //     salonTime = "Close";
          //     openLabel = "CLOSE";
          //     print(salonTime);
          //   } else {
          //     DateTime tempStartTime = DateFormat("hh:mm")
          //         .parse(response.data!.salon!.friday!.open!);
          //     DateTime tempEndTime = DateFormat("hh:mm")
          //         .parse(response.data!.salon!.friday!.close!);
          //     var startTimeFormat = DateFormat("h:mm a");
          //     salonTime = startTimeFormat.format(tempStartTime) +
          //         " to " +
          //         startTimeFormat.format(tempEndTime);
          //     openLabel = "OPEN";
          //     print(salonTime);
          //   }
          // }
          //
          // if (day == "Thursday") {
          //   if (response.data!.salon!.thursday!.open == null &&
          //       response.data!.salon!.thursday!.close == null) {
          //     salonTime = "Close";
          //     openLabel = "CLOSE";
          //     print(salonTime);
          //   } else {
          //     DateTime tempStartTime = DateFormat("hh:mm")
          //         .parse(response.data!.salon!.thursday!.open!);
          //     DateTime tempEndTime = DateFormat("hh:mm")
          //         .parse(response.data!.salon!.thursday!.close!);
          //     var startTimeFormat = DateFormat("h:mm a");
          //     salonTime = startTimeFormat.format(tempStartTime) +
          //         " to " +
          //         startTimeFormat.format(tempEndTime);
          //     openLabel = "OPEN";
          //     print(salonTime);
          //   }
          // }
          //
          // if (day == "Wednesday") {
          //   if (response.data!.salon!.wednesday!.open == null &&
          //       response.data!.salon!.wednesday!.close == null) {
          //     salonTime = "Close";
          //     openLabel = "CLOSE";
          //     print(salonTime);
          //   } else {
          //     DateTime tempStartTime = DateFormat("hh:mm")
          //         .parse(response.data!.salon!.wednesday!.open!);
          //     DateTime tempEndTime = DateFormat("hh:mm")
          //         .parse(response.data!.salon!.wednesday!.close!);
          //     var startTimeFormat = DateFormat("h:mm a");
          //     salonTime = startTimeFormat.format(tempStartTime) +
          //         " to " +
          //         startTimeFormat.format(tempEndTime);
          //     openLabel = "OPEN";
          //     print(salonTime);
          //   }
          // }
          //
          // if (day == "Tuesday") {
          //   if (response.data!.salon!.tuesday!.open == null &&
          //       response.data!.salon!.tuesday!.close == null) {
          //     salonTime = "Close";
          //     openLabel = "CLOSE";
          //     print(salonTime);
          //   } else {
          //     DateTime tempStartTime = DateFormat("hh:mm")
          //         .parse(response.data!.salon!.tuesday!.open!);
          //     DateTime tempEndTime = DateFormat("hh:mm")
          //         .parse(response.data!.salon!.tuesday!.close!);
          //     var startTimeFormat = DateFormat("h:mm a");
          //     salonTime = startTimeFormat.format(tempStartTime) +
          //         " to " +
          //         startTimeFormat.format(tempEndTime);
          //     openLabel = "OPEN";
          //     print(salonTime);
          //   }
          // }
          // if (day == "Monday") {
          //   if (response.data!.salon!.monday!.open == null &&
          //       response.data!.salon!.monday!.close == null) {
          //     salonTime = "Close";
          //     openLabel = "CLOSE";
          //     print(salonTime);
          //   } else {
          //     DateTime tempStartTime = DateFormat("hh:mm")
          //         .parse(response.data!.salon!.monday!.open!);
          //     DateTime tempEndTime = DateFormat("hh:mm")
          //         .parse(response.data!.salon!.monday!.close!);
          //     var startTimeFormat = DateFormat("h:mm a");
          //     salonTime = startTimeFormat.format(tempStartTime) +
          //         " to " +
          //         startTimeFormat.format(tempEndTime);
          //     openLabel = "OPEN";
          //     print(salonTime);
          //   }
          // }

          double salonLat = double.parse(response.data!.salon!.latitude!);
          double salonLong = double.parse(response.data!.salon!.longitude!);

          AppConstant.getDistance(salonLat, salonLong).whenComplete(
              () => AppConstant.getDistance(salonLat, salonLong).then((value) {
                    distance = value;
                    print("Detail_Distance123896:$distance");
                  }));

          print("SalonId:$salonId");

          if (response.data!.gallery!.length > 0) {
            galleyDataList.clear();
            galleyDataList.addAll(response.data!.gallery!);
          }

          if (response.data!.category!.length > 0) {
            categoryList.clear();
            categoryList.addAll(response.data!.category!);
          }

          if (response.data!.review!.length > 0) {
            reviewList.clear();
            reviewList.addAll(response.data!.review!);
          }

          print(response.data!.salon!.ownerId);

          int catSize = categoryList.length;
          print("catSize:$catSize");
        } else {
          dataVisible = false;
          noDataVisible = true;

          ToastMessage.toastMessage("Pas de données");
        }
      });
    }).catchError((Object obj) {
      setState(() {
        _loading = false;
      });
      print("error:$obj");
      print(obj.runtimeType);
      ToastMessage.toastMessage("Erreur interne du serveur");
    });
  }

  final GlobalKey<ScaffoldState> _drawerScaffoldKey =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: ModalProgressHUD(
        inAsyncCall: _loading,
        opacity: 1.0,
        color: Colors.transparent.withOpacity(0.2),
        progressIndicator: SpinKitFadingCircle(color: pinkColor),
        child: SafeArea(
          child: Scaffold(
            appBar: appbar(context, salonName!, _drawerScaffoldKey, false,
                widget.isDrawerOpen, widget.onOpen, widget.onClose,
                drawer: true) as PreferredSizeWidget?,
            body: Scaffold(
              resizeToAvoidBottomInset: true,
              extendBody: true,
              key: _drawerScaffoldKey,
              drawer: new DrawerOnly(),
              body: new Stack(
                children: <Widget>[
                  Visibility(
                    visible: dataVisible,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: <Widget>[
                              Container(
                                height: 210,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(DummyImage.salonBg),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                left: 0,
                                bottom: 10,
                                child: Container(
                                  margin: EdgeInsets.only(left: 15, right: 15),
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: whiteColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: greyColor,
                                        offset: Offset(0.0, 1.0), //(x,y)
                                        blurRadius: 10.0,
                                      ),
                                    ],
                                  ),
                                  child: TabBar(
                                    controller: _controller,
                                    tabs: [
                                      new Tab(
                                        text: StringConstant.about,
                                      ),
                                      new Tab(
                                        text: StringConstant.gallery,
                                      ),
                                      new Tab(
                                        text: StringConstant.service,
                                      ),
                                      new Tab(
                                        text: StringConstant.review,
                                      ),
                                    ],
                                    labelColor: pinkColor,
                                    unselectedLabelColor: greyColor,
                                    unselectedLabelStyle: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        fontFamily:
                                            ConstantFont.montserratMedium),
                                    labelStyle: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        fontFamily:
                                            ConstantFont.montserratBold),
                                    indicatorSize: TabBarIndicatorSize.label,
                                    indicatorPadding: EdgeInsets.all(0.0),
                                    indicatorColor: pinkColor,
                                    indicatorWeight: 5.0,
                                    indicator: MD2Indicator(
                                      indicatorSize: MD2IndicatorSize.full,
                                      indicatorHeight: 8.0,
                                      indicatorColor: pinkColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Expanded(
                          flex: 6,
                          child: Container(
                            color: whiteColor,
                            child: new TabBarView(
                              controller: _controller,
                              children: <Widget>[
                                TabAbout(salonData, widget.catId, distance),
                                GalleryView(galleyDataList),
                                ServiceTab(categoryList, widget.currentSelectedIndex, salonId, salonData),
                                ReViewTab(reviewList),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: noDataVisible,
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 15, right: 15, top: 10, bottom: 40),
                      child: Center(
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.75,
                            alignment: Alignment.center,
                            child: ListView(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: <Widget>[
                                Image.asset(
                                  DummyImage.noData,
                                  alignment: Alignment.center,
                                  width: 150,
                                  height: 100,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    StringConstant.noData,
                                    style: TextStyle(
                                        color: whiteA3,
                                        fontFamily:
                                            ConstantFont.montserratMedium,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ),
                  // new Container(child: Body())
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    Navigator.pop(context);

    return (await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => new HomeScreen(0)))) ??
        false;
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        child: CustomView(),
      ),
    );
  }
}
