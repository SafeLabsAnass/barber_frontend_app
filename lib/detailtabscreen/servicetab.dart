import 'package:barber_app/ResponseModel/salonDetailResponse.dart';
import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/color_constant.dart';
import 'package:barber_app/constant/constant_font.dart';
import 'package:barber_app/constant/dymmyimages.dart';
import 'package:barber_app/constant/preferenceutils.dart';
import 'package:barber_app/constant/string_constant.dart';
import 'package:barber_app/screens/loginscreen.dart';
import 'package:barber_app/separator/separator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:barber_app/screens/bookapointment.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Selectable GridView',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: ServiceTab(),
    );
  }
}

class ServiceTab extends StatefulWidget {
  final List<SalonCategory> categoryList;
  final salonId;
  final SalonDetails salonData;
  final int? currentSelectedIndex;

  ServiceTab(this.categoryList, this.currentSelectedIndex, this.salonId,
      this.salonData);

  @override
  _ServiceTab createState() => _ServiceTab();
}

class _ServiceTab extends State<ServiceTab> {
  List<SalonCategory> categoryList = <SalonCategory>[];
  List<SalonService> catService = <SalonService>[];
  List<int?> _selectedServices = <int?>[];
  List<String?> _selectedServicesName = <String?>[];
  List _totalprice = [];
  var salonId;
  SalonDetails? salonData;
  bool viewVisible = false;
  double totalprice = 0;

  bool dataVisible = false;
  bool noDataVisible = true;
  AutoScrollController _scrollController = AutoScrollController();

  @override
  void initState() {
    super.initState();
    PreferenceUtils.init();
    categoryList = widget.categoryList;
    salonId = widget.salonId;
    salonData = widget.salonData;
    currentSelectedIndex = widget.currentSelectedIndex!;
    currentSelectedIndex1 = 0;

    if (categoryList[currentSelectedIndex].service!.length > 0) {
      dataVisible = true;
      noDataVisible = false;

      catService.addAll(categoryList[currentSelectedIndex].service!);
      var catServiceLength = catService.length;
      print("categoryLength:$catServiceLength");
    } else {
      dataVisible = false;
      noDataVisible = true;
    }
  }

  int currentSelectedIndex = 0;
  int currentSelectedIndex1 = 0;
  String? categoryName;
  bool value = false;

  void bookapointment() {
    print('CALLBACK: _onDaySelected');
    setState(() {});
  }

  void _scrollToSelectedIndex(int index) {
    print('_scrollToSelectedIndex is called');
    _scrollController.scrollToIndex(index,
        preferPosition: AutoScrollPosition.begin);
  }

  @override
  Widget build(BuildContext context) {
    dynamic screenHeight = MediaQuery.of(context).size.height;
    dynamic screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: new Container(
            color: whiteColor,
            margin: EdgeInsets.only(bottom: 0),
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          Container(
                            color: whiteColor,
                            alignment: FractionalOffset.topCenter,
                            child: ListView(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: <Widget>[
                                Container(
                                  color: whiteColor,
                                  margin: EdgeInsets.only(
                                      top: 0.0, left: 15, right: 15),
                                  height: 45,
                                  child: ListView.builder(
                                    controller: _scrollController,
                                    itemCount: categoryList.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      bool isSelected =
                                          currentSelectedIndex == index;

                                      return GestureDetector(
                                        onTap: () {
                                          catService.clear();
                                          setState(() {
                                            categoryName =
                                                categoryList[index].name;
                                            currentSelectedIndex = index;

                                            if (categoryList[index]
                                                    .service!
                                                    .length >
                                                0) {
                                              dataVisible = true;
                                              noDataVisible = false;

                                              catService.addAll(
                                                  categoryList[index].service!);
                                              var catServiceLength =
                                                  catService.length;
                                              print(
                                                  "catServiceLength:$catServiceLength");
                                            } else {
                                              dataVisible = false;
                                              noDataVisible = true;
                                            }
                                          });
                                          _scrollToSelectedIndex(
                                              currentSelectedIndex);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(5.0),
                                          child: TextButton(
                                            onPressed: null,
                                            style: TextButton.styleFrom(
                                              backgroundColor: whiteColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  side: BorderSide(
                                                      color: isSelected
                                                          ? pinkColor
                                                          : greyA5)),
                                            ),
                                            child: Text(
                                              categoryList[index].name!,
                                              style: TextStyle(
                                                  color: isSelected
                                                      ? pinkColor
                                                      : greyA5,
                                                  fontSize: 14,
                                                  fontFamily: ConstantFont
                                                      .montserratMedium,
                                                  fontWeight: FontWeight.w600),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                          decoration: isSelected
                                              ? BoxDecoration(
                                                  color: pinkColor,
                                                  border: Border.all(
                                                    color: pinkColor,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                )
                                              : BoxDecoration(),
                                        ),
                                      );
                                    },

                                    
                                  ),
                                ),
                                Visibility(
                                  visible: false,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: 0.0, left: 10, right: 10),
                                    color: blackColor,
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          margin:
                                              EdgeInsets.only(left: 20, top: 5),
                                          alignment: Alignment.topLeft,
                                          child: Text("",
                                              style: TextStyle(
                                                  color: blackColor,
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 16)),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(
                                                left: 20, right: 20, top: 5),
                                            alignment: Alignment.topRight,
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: "Filter ",
                                                      style: TextStyle(
                                                          color: blackColor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily: ConstantFont
                                                              .montserratMedium)),
                                                  WidgetSpan(
                                                    child: Icon(
                                                      Icons.filter_alt_sharp,
                                                      size: 14,
                                                      color: blackColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 00),
                                  height: 300,
                                  child: ListView(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      children: <Widget>[
                                        Visibility(
                                          visible: dataVisible,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: 0.0,
                                                left: 15,
                                                right: 0,
                                                bottom: 130),
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                var catId = categoryList[
                                                        currentSelectedIndex]
                                                    .catId;
                                                var serId =
                                                    catService[index].serviceId;
                                                print("serId:$serId" +
                                                    "  " +
                                                    "catId:$catId");
                                                print("value123456:$serId");

                                                var color =
                                                    catService[index].isSelected
                                                        ? pinkColor
                                                        : greyA5;

                                                return GestureDetector(
                                                  child: Container(
                                                    height: 60,
                                                    width: screenWidth,
                                                    child: Row(
                                                      children: <Widget>[
                                                        new Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  top: 5),
                                                          width: 20,
                                                          height: 20,
                                                          color: whiteColor,
                                                          child: Container(
                                                              width: 15,
                                                              height: 15,
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    catService[
                                                                            index]
                                                                        .isSelected = !catService[
                                                                            index]
                                                                        .isSelected;
                                                                    print(catService[
                                                                            index]
                                                                        .isSelected);
                                                                    print(catService[
                                                                            index]
                                                                        .serviceId);

                                                                    if (catService[index]
                                                                            .isSelected ==
                                                                        true) {
                                                                      setState(
                                                                          () {
                                                                        currentSelectedIndex1 =
                                                                            index;
                                                                        _selectedServices
                                                                            .add(catService[index].serviceId);
                                                                        _selectedServicesName
                                                                            .add(catService[index].name);
                                                                        _totalprice
                                                                            .add(catService[index].price);
                                                                      });
                                                                    } else {
                                                                      setState(
                                                                          () {
                                                                        _selectedServices
                                                                            .remove(catService[index].serviceId);
                                                                        _selectedServicesName
                                                                            .remove(catService[index].name);
                                                                        _totalprice
                                                                            .remove(catService[index].price);
                                                                      });
                                                                    }

                                                                    if (_selectedServices
                                                                        .isEmpty) {
                                                                      setState(
                                                                          () {
                                                                        viewVisible =
                                                                            false;
                                                                      });
                                                                    } else {
                                                                      setState(
                                                                          () {
                                                                        viewVisible =
                                                                            true;
                                                                      });
                                                                    }

                                                                    String
                                                                        _selectedServicesLength =
                                                                        _selectedServices
                                                                            .toString();
                                                                    print(
                                                                        "selectedServiceLength:$_selectedServicesLength");
                                                                    totalprice = _totalprice.fold(
                                                                        0,
                                                                        (p, c) =>
                                                                            p +
                                                                            c);
                                                                    print(
                                                                        "sum:$totalprice");
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 20,
                                                                  height: 20,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color:
                                                                        color,
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: const Color(
                                                                          0xFFdddddd),
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            1.0),
                                                                    child: catService[index]
                                                                            .isSelected
                                                                        ? Icon(
                                                                            Icons.check,
                                                                            size:
                                                                                15.0,
                                                                            color:
                                                                                whiteColor,
                                                                          )
                                                                        : Icon(
                                                                            Icons.check_box_outline_blank_outlined,
                                                                            size:
                                                                                15.0,
                                                                            color:
                                                                                color,
                                                                          ),
                                                                  ),
                                                                ),
                                                              )),
                                                        ),
                                                        new Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  top: 5),
                                                          height: 35,
                                                          width: 35,
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child:
                                                              CachedNetworkImage(
                                                            height: 35,
                                                            width: 35,
                                                            imageUrl: catService[
                                                                        index]
                                                                    .imagePath! +
                                                                catService[
                                                                        index]
                                                                    .image!,
                                                            imageBuilder: (context,
                                                                    imageProvider) =>
                                                                Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                                image:
                                                                    DecorationImage(
                                                                  image:
                                                                      imageProvider,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  alignment:
                                                                      Alignment
                                                                          .topCenter,
                                                                ),
                                                              ),
                                                            ),
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
                                                        new Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    top: 10),
                                                            height: 50,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      .60,
                                                                  height: 30,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              1,
                                                                          top:
                                                                              2,
                                                                          right:
                                                                              15),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Container(
                                                                        child:
                                                                            Text(
                                                                          catService[index]
                                                                              .name!,
                                                                          style: TextStyle(
                                                                              color: blackColor,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 12,
                                                                              fontFamily: ConstantFont.montserratMedium),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        child:
                                                                            Text(
                                                                          catService[index].price.toString() +
                                                                              ' ₹',
                                                                          style: TextStyle(
                                                                              color: grey99,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 12,
                                                                              fontFamily: ConstantFont.montserratMedium),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      .65,
                                                                  height: 10,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              1,
                                                                          top:
                                                                              8,
                                                                          right:
                                                                              10),
                                                                  child:
                                                                      MySeparator(),
                                                                ),
                                                              ],
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              itemCount: catService.length,
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: noDataVisible,
                                          child: SizedBox(
                                            width: screenWidth,
                                            height: 130,
                                            child: Container(
                                              transform:
                                                  Matrix4.translationValues(
                                                      5.0, 50.0, 0.0),
                                              child: Center(
                                                child: Container(
                                                    width: screenWidth,
                                                    height: screenHeight,
                                                    alignment: Alignment.center,
                                                    child: ListView(
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      children: <Widget>[
                                                        Image.asset(
                                                          DummyImage.noData,
                                                          alignment:
                                                              Alignment.center,
                                                          width: 150,
                                                          height: 100,
                                                        ),
                                                        Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            StringConstant
                                                                .noServiceAvailable,
                                                            style: TextStyle(
                                                                color: whiteA3,
                                                                fontFamily:
                                                                    ConstantFont
                                                                        .montserratMedium,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: viewVisible,
                      child: Container(
                        height: 50,
                        color: Colors.white,
                        alignment: FractionalOffset.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              alignment: FractionalOffset.centerLeft,
                              child: Text(
                                ("Total : " + totalprice.toString()) + " ₹ ",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: black1E,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: ConstantFont.montserratMedium),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                alignment: FractionalOffset.center,
                                child: MaterialButton(
                                  onPressed: () {
                                    if (PreferenceUtils.getlogin(
                                            AppConstant.isLoggedIn) ==
                                        true) {
                                      print("totalprice:$totalprice");
                                      print(_selectedServices);
                                      print(salonId);
                                      print(_selectedServicesName);
                                      print(_totalprice);
                                      print(salonData!.name!);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  new BookAppoitment(
                                                      totalprice,
                                                      _selectedServices,
                                                      salonId,
                                                      _selectedServicesName,
                                                      _totalprice,
                                                      salonData)));
                                    } else {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  new LoginScreen(6)));
                                    }
                                  },
                                  color: pinkColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text(
                                    StringConstant.bookService,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontFamily:
                                            ConstantFont.montserratMedium,
                                        fontSize: 14),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  void openBottomSheetForOrderType() {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Container(
                height: 50,
                margin: EdgeInsets.only(top: 30, left: 15, bottom: 20),
                color: redFF,
                padding: EdgeInsets.symmetric(
                  horizontal: 1,
                ),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[]),
              );
            },
          );
        });
  }
}
