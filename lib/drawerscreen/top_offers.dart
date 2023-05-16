import 'package:barber_app/ResponseModel/offerResponse.dart';
import 'package:barber_app/ResponseModel/offerbannerResppose.dart';
import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/color_constant.dart';
import 'package:barber_app/constant/constant_font.dart';
import 'package:barber_app/constant/dymmyimages.dart';
import 'package:barber_app/constant/preferenceutils.dart';
import 'package:barber_app/constant/string_constant.dart';
import 'package:barber_app/constant/toast_message.dart';
import 'package:barber_app/drawer/default_page.dart';
import 'package:barber_app/network/Apiservice.dart';
import 'package:barber_app/network/Retro_Api.dart';
import 'package:barber_app/screens/confirmbooking.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:barber_app/appbar/app_bar_only.dart';
import 'package:barber_app/common/common_view.dart';
import 'package:barber_app/drawer/drawer_only.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class TopOffers extends StatefulWidget {
  TopOffers(
    this.code,
    this.selectedEmpId,
    this.time,
    this.date,
    this.totalprice,
    this.selectedServices,
    this.salonId,
    this._selectedServicesName,
    this._totalprice,
    this.salonData,
    this.onOpen,
    this.onClose,
    this.isDrawerOpen,
  );

  final bool isDrawerOpen;
  final VoidCallback onOpen;
  final VoidCallback onClose;
  final int code;
  final double? totalprice;
  final List<int>? selectedServices;

  final int? salonId;
  final date;

  final time;
  final int? selectedEmpId;
  final List? _totalprice;

  final List<String>? _selectedServicesName;

  final salonData;

  @override
  _TopOffers createState() => new _TopOffers();
}

class _TopOffers extends State<TopOffers> {
  List<OfferData> offerDataList = <OfferData>[];
  List<OfferBannerList> bannerImage = <OfferBannerList>[];
  List<String> image12 = <String>[];
  bool _loading = false;
  int index = 0;
  int? code;
  String name = "User";
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;
  @override
  void initState() {
    super.initState();
    code = widget.code;
    PreferenceUtils.init();
    AppConstant.checkNetwork().whenComplete(() => callApiForBanner());
    AppConstant.checkNetwork().whenComplete(() => callApiForOfferData());
    name = PreferenceUtils.getString(AppConstant.username);
  }

  Future<void> _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 500));
    AppConstant.checkNetwork().whenComplete(() => callApiForBanner());
    AppConstant.checkNetwork().whenComplete(() => callApiForOfferData());
  }

  void callApiForBanner() {
    bannerImage.clear();
    image12.clear();
    setState(() {
      _loading = true;
    });
    RestClient(RetroApi().dioData()).offersbanner().then((response) {
      if (mounted) {
        setState(() {
          _loading = false;
          if (response.success = true) {
            print(response.data!.length);
            bannerImage.addAll(response.data!);
            for (int i = 0; i < bannerImage.length; i++) {
              image12.add(bannerImage[i].imagePath! + bannerImage[i].image!);
            }
            int length123 = image12.length;
            print("String List:$length123");
          } else {
            ToastMessage.toastMessage("No Data");
          }
        });
      } else {
        if (response.success = true) {
          print(response.data!.length);
          bannerImage.addAll(response.data!);
          image12.clear();
          for (int i = 0; i < bannerImage.length; i++) {
            image12.add(bannerImage[i].imagePath! + bannerImage[i].image!);
          }
          int length123 = image12.length;
          print("String List:$length123");
        } else {
          ToastMessage.toastMessage("No Data");
        }
      }
    }).catchError((Object obj) {
      setState(() {
        _loading = false;
      });
      print("error:$obj");
      print(obj.runtimeType);
      ToastMessage.toastMessage("Internal Server Error");
    });
  }

  void callApiForOfferData() {
    offerDataList.clear();
    setState(() {
      _loading = true;
    });
    RestClient(RetroApi().dioData()).coupon().then((response) {
      if (mounted) {
        setState(() {
          _loading = false;
          if (response.success = true) {
            print(response.data!.length);
            offerDataList.addAll(response.data!);
            int size = offerDataList.length;
            print("offerSize:$size");
          } else {
            ToastMessage.toastMessage("No Data");
          }
        });
      } else {
        _loading = false;
        if (response.success = true) {
          print(response.data!.length);
          offerDataList.addAll(response.data!);
          int size = offerDataList.length;
          print("offerSize:$size");
        } else {
          ToastMessage.toastMessage("No Data");
        }
      }
    }).catchError((Object obj) {
      setState(() {
        _loading = false;
      });
      print("error:$obj");
      print(obj.runtimeType);
      ToastMessage.toastMessage("Internal Server Error");
    });
  }

  CarouselSlider? carouselSlider;

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

  int _current = 0;
  double? totalprice;
  List<T?> map<T>(List list, Function handler) {
    List<T?> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  void callApiForApplyCoupon(String? code) {
    print(code);
    setState(() {
      _loading = true;
    });

    RestClient(RetroApi().dioData()).checkcoupon(code).then((response) {
      setState(() {
        _loading = false;
        print(response.success);
        if (response.success == true) {
          print("sucess");

          int discount = response.data!.discount!;
          ToastMessage.toastMessage(response.msg!);

          if (response.data!.type == "Percentage") {
            setState(() {
              double percentage = (widget.totalprice! * discount) / 100;
              totalprice = widget.totalprice! - percentage;
              print(totalprice);
            });
          } else if (response.data!.type == "Amount") {
            totalprice = widget.totalprice! - discount;
            print(totalprice);
          }
          print("newTotalPrice:$totalprice");
          print("oldTotalPrice:${widget.totalprice}");

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => ConfirmBooking(
                  widget.selectedEmpId,
                  widget.time,
                  widget.date,
                  totalprice,
                  widget.selectedServices,
                  widget.salonId,
                  widget._selectedServicesName,
                  widget._totalprice,
                  widget.salonData,
                  true,
                  false),
            ),
          );
        } else {
          ToastMessage.toastMessage(response.msg!);
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
            ToastMessage.toastMessage("Invalid Data");
            print(responseCode);
            print(res.statusMessage);
          } else if (responseCode == 422) {
            ToastMessage.toastMessage("Invalid Email");
            print("code:$responseCode");
            print("msg:$msg");
          }

          break;
        default:
      }
    });
  }

  final GlobalKey<ScaffoldState> _drawerScaffoldKey =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    dynamic screenHeight = MediaQuery.of(context).size.height;
    dynamic screenWidth = MediaQuery.of(context).size.width;

    return ModalProgressHUD(
      inAsyncCall: _loading,
      opacity: 1.0,
      color: Colors.transparent.withOpacity(0.2),
      progressIndicator: SpinKitFadingCircle(color: pinkColor),
      child: new SafeArea(
          child: Stack(
        children: [
          DrawerOnly(),
          DefaultPage(
            index: 1,
            isDrawerOpen: isDrawerOpen,
            scaleFactor: scaleFactor,
            xOffset: xOffset,
            yOffset: yOffset,
            child: Scaffold(
              backgroundColor: whiteColor,
              appBar: appbar(
                  context,
                  StringConstant.topOffers,
                  _drawerScaffoldKey,
                  false,
                  isDrawerOpen,
                  onOpen,
                  onClose) as PreferredSizeWidget?,
              body: Scaffold(
                  resizeToAvoidBottomInset: true,
                  backgroundColor: whiteColor,
                  key: _drawerScaffoldKey,
                  body: new Stack(
                    children: <Widget>[
                      RefreshIndicator(
                        onRefresh: _onRefresh,
                        child: ListView(
                          children: [
                            Column(
                              children: <Widget>[
                                image12.isEmpty
                                    ? Container(
                                        height: 0,
                                        width: 0,
                                      )
                                    : Container(
                                        width: 400,
                                        height: screenHeight * 0.25,
                                        alignment: Alignment.topCenter,
                                        color: Colors.transparent,
                                        margin: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Card(
                                          elevation: 20,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Container(
                                            child: Stack(
                                              alignment: Alignment.bottomCenter,
                                              children: <Widget>[
                                                CarouselSlider(
                                                  options: CarouselOptions(
                                                    height: 180,
                                                    viewportFraction: 1.0,
                                                    onPageChanged:
                                                        (index, index1) {
                                                      setState(() {
                                                        _current = index;
                                                      });
                                                    },
                                                  ),
                                                  items: image12.map((imgUrl) {
                                                    return Builder(
                                                      builder: (BuildContext
                                                          context) {
                                                        return Container(
                                                            child: Stack(
                                                          children: <Widget>[
                                                            Material(
                                                              color: whiteColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              elevation: 2.0,
                                                              clipBehavior: Clip
                                                                  .antiAliasWithSaveLayer,
                                                              type: MaterialType
                                                                  .transparency,
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl:
                                                                    imgUrl,
                                                                height: 200,
                                                                width: 500,
                                                                fit: BoxFit
                                                                    .fitWidth,
                                                                placeholder: (context,
                                                                        url) =>
                                                                    SpinKitFadingCircle(
                                                                        color:
                                                                            pinkColor),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    Image.asset(
                                                                        DummyImage
                                                                            .noImage),
                                                              ),
                                                            ),
                                                            Center(
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                20),
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      bannerImage[
                                                                              _current]
                                                                          .title!,
                                                                      style: TextStyle(
                                                                          color:
                                                                              whiteColor,
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight: FontWeight
                                                                              .w800,
                                                                          fontFamily:
                                                                              'Montserrat'),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                10),
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      bannerImage[_current]
                                                                              .discount
                                                                              .toString() +
                                                                          "%",
                                                                      style: TextStyle(
                                                                          color:
                                                                              whiteColor,
                                                                          fontSize:
                                                                              45,
                                                                          fontWeight: FontWeight
                                                                              .w800,
                                                                          fontFamily:
                                                                              'Montserrat'),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        top: 10,
                                                                        bottom:
                                                                            5),
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      StringConstant
                                                                          .isComingSoon,
                                                                      style: TextStyle(
                                                                          color:
                                                                              whiteColor,
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight: FontWeight
                                                                              .w800,
                                                                          fontFamily:
                                                                              'Montserrat'),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ));
                                                      },
                                                    );
                                                  }).toList(),
                                                ),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: List.generate(
                                                        image12.length,
                                                        (index) => Container(
                                                              alignment: Alignment
                                                                  .bottomCenter,
                                                              width: 9.0,
                                                              height: 9.0,
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          10.0,
                                                                      horizontal:
                                                                          2.0),
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: _current ==
                                                                        index
                                                                    ? pinkColor
                                                                    : whiteColor,
                                                              ),
                                                            ))),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                SizedBox(
                                  height: 15,
                                ),
                                offerDataList.isEmpty
                                    ? Column(
                                        children: [
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
                                                  fontFamily: ConstantFont
                                                      .montserratMedium,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: offerDataList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          Color lightColor;
                                          Color darkColor;

                                          int disc =
                                              offerDataList[index].discount!;
                                          if (disc >= 50) {
                                            lightColor =
                                                const Color(0xFFc8caff);
                                            darkColor = const Color(0xFFb5b8ff);
                                          } else if (disc >= 30) {
                                            lightColor =
                                                const Color(0xFFffc8c8);
                                            darkColor = const Color(0xFFffb5b5);
                                          } else {
                                            lightColor =
                                                const Color(0xFFffc8de);
                                            darkColor = const Color(0xFFffb5cc);
                                          }

                                          String? type =
                                              offerDataList[index].type;
                                          String type1 = "";

                                          if (type == "Percentage") {
                                            type1 = "%";
                                          } else if (type == "Amount") {
                                            type1 = "Rs.";
                                          }

                                          return new Container(
                                              color: Colors.transparent,
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Container(
                                                alignment: Alignment.topLeft,
                                                margin: EdgeInsets.all(10.0),
                                                width: screenWidth,
                                                decoration: BoxDecoration(
                                                  color: lightColor,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Container(
                                                  child: new Row(
                                                    children: <Widget>[
                                                      Container(
                                                          height: 75,
                                                          width: screenWidth *
                                                              .22,
                                                          alignment:
                                                              Alignment.topLeft,
                                                          decoration:
                                                              BoxDecoration(
                                                                  color:
                                                                      darkColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            10),
                                                                  )),
                                                          child: new Center(
                                                            child: new Text(
                                                              offerDataList[
                                                                          index]
                                                                      .discount
                                                                      .toString() +
                                                                  type1,
                                                              style: TextStyle(
                                                                  fontSize: 24,
                                                                  color: Color(
                                                                      0xFF213640),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontFamily:
                                                                      ConstantFont
                                                                          .montserratBold),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          )),
                                                      Container(
                                                          width:
                                                              screenWidth * .41,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 1.0,
                                                                  right: 10.0),
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: ListView(
                                                            shrinkWrap: true,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            children: <Widget>[
                                                              Container(
                                                                transform: Matrix4
                                                                    .translationValues(
                                                                        5.0,
                                                                        0.0,
                                                                        0.0),
                                                                child: Text(
                                                                  offerDataList[
                                                                          index]
                                                                      .code!,
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xFFfff9fb),
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                      fontFamily:
                                                                          ConstantFont
                                                                              .montserratBold),
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            5),
                                                                child: Text(
                                                                  offerDataList[
                                                                          index]
                                                                      .desc!,
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xFFfff9fb),
                                                                      fontSize:
                                                                          11,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontFamily:
                                                                          ConstantFont
                                                                              .montserratBold),
                                                                ),
                                                              ),
                                                            ],
                                                          )),
                                                      GestureDetector(
                                                        child: Container(
                                                            width: screenWidth *
                                                                .20,
                                                            height: 35,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 1.0),
                                                            alignment: Alignment
                                                                .topCenter,
                                                            child: TextButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  print(
                                                                      "code123:$code");

                                                                  if (code ==
                                                                      -1) {
                                                                    ToastMessage
                                                                        .toastMessage(
                                                                            "First Book Appointment from Home");
                                                                    print(
                                                                        "not apply");
                                                                  } else if (code ==
                                                                      1) {
                                                                    AppConstant
                                                                            .checkNetwork()
                                                                        .whenComplete(() =>
                                                                            callApiForApplyCoupon(offerDataList[index].code));
                                                                  }
                                                                });
                                                              },
                                                              style: TextButton
                                                                  .styleFrom(
                                                                backgroundColor:
                                                                    whiteColor,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            7)),
                                                              ),
                                                              child: Text(
                                                                StringConstant
                                                                    .apply,
                                                                style: TextStyle(
                                                                    color:
                                                                        darkColor,
                                                                    fontFamily:
                                                                        ConstantFont
                                                                            .montserratBold,
                                                                    fontSize:
                                                                        11,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ));
                                        },
                                      ),
                                Container(
                                  height: 50,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      new Container(alignment: Alignment.bottomCenter, child: Body())
                    ],
                  )),
            ),
          ),
        ],
      )),
    );
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
