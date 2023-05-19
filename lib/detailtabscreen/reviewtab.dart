import 'package:barber_app/ResponseModel/salonDetailResponse.dart';
import 'package:barber_app/constant/color_constant.dart';
import 'package:barber_app/constant/constant_font.dart';
import 'package:barber_app/constant/dymmyimages.dart';
import 'package:barber_app/constant/string_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';



class ReViewTab extends StatefulWidget {
  final List<SalonReview> reviewList;

  ReViewTab(this.reviewList);

  @override
  _ReViewTab createState() => _ReViewTab();
}

class _ReViewTab extends State<ReViewTab> {
  List<SalonReview> reviewList = <SalonReview>[];

  int? currentSelectedIndex;
  String? categoryName;
  var rating = 0.0;
  bool dataVisible = false;
  bool noDataVisible = true;


  @override
  void initState() {
    super.initState();
    if (widget.reviewList.length > 0) {
      reviewList = widget.reviewList;
      dataVisible = true;
      noDataVisible = false;
    } else {
      dataVisible = false;
      noDataVisible = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    dynamic screenHeight = MediaQuery.of(context).size.height;
    dynamic screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: whiteColor,
          body: Padding(
              padding: EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 0),

              child: ListView(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 10, top: 5, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            StringConstant.review,
                            style: TextStyle(
                                color: blackColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                fontFamily: ConstantFont.montserratBold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 15),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Total Review' + "(" + reviewList.length.toString() + ")",
                      style: TextStyle(
                          color: const Color(0xFFaeaeae),
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          fontFamily: ConstantFont.montserratMedium),
                    ),
                  ),
                  ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        Visibility(
                          visible: dataVisible,
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 0.0, left: 0, right: 10, bottom: 10),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                DateTime today = new DateTime.now();

                                String difference;
                                String difference1;

                                String date = reviewList[index].createdAt!;

                                difference1 =
                                    "${today.difference(DateTime.parse(date)).inHours}" +
                                        " Hours Ago.";
                                difference =
                                    "${today.difference(DateTime.parse(date)).inHours}";

                                int anotherDifference = int.parse(difference);

                                if (anotherDifference > 24) {
                                  difference1 =
                                      "${today.difference(DateTime.parse(date)).inDays}" +
                                          " Days Ago.";
                                }

                                return new Container(
                                  alignment: Alignment.topLeft,
                                  width: screenWidth,
                                  color: whiteColor,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: screenWidth * .12,
                                        height: 75,
                                        // color: whiteColor,
                                        alignment: Alignment.topLeft,
                                        margin: EdgeInsets.only(left: 0),

                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(top: 15),
                                              height: 40.0,
                                              width: screenWidth * .12,
                                              alignment: Alignment.centerLeft,
                                              child: CachedNetworkImage(
                                                height: 35,
                                                width: 35,
                                                imageUrl: reviewList[index]
                                                        .user!
                                                        .imagePath! +
                                                    reviewList[index]
                                                        .user!
                                                        .image!,
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
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
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Image.asset(DummyImage.noImage),
                                              ),
                                              // ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              margin: EdgeInsets.only(top: 1),
                                              height: 12.0,
                                              width: screenWidth * .12,

                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    margin:
                                                        EdgeInsets.only(top: 2),
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          top: 0, left: 10),
                                                      child: SvgPicture.asset(
                                                        DummyImage.star,
                                                        width: 10,
                                                        height: 10,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          top: 0, left: 2),
                                                      child: Text(
                                                          reviewList[index]
                                                              .rate
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: yellowColor,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                              ConstantFont.montserratMedium)),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topCenter,
                                        margin: EdgeInsets.only(
                                            top: 5, left: 0, right: 5),
                                        width: screenWidth * .75,
                                        decoration: BoxDecoration(
                                          color: whiteF1,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              height: 30,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      reviewList[index]
                                                          .user!
                                                          .name!,
                                                      style: TextStyle(
                                                        color: blackColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily:
                                                        ConstantFont.montserratSemiBold,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 5, right: 10),
                                                    child: Text(
                                                      difference1,
                                                      style: TextStyle(
                                                        color:
                                                            grey99,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily:
                                                        ConstantFont.montserratMedium,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.topLeft,
                                              margin: EdgeInsets.only(
                                                  left: 10,
                                                  right: 20,
                                                  bottom: 10),

                                              child: Text(
                                                reviewList[index].message!,
                                                style: TextStyle(
                                                  color: grey99,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: ConstantFont.montserratRegular,
                                                ),
                                                maxLines: 5,
                                                overflow: TextOverflow.ellipsis,
                                              ),

                                              // color:yellowColor
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              itemCount: reviewList.length,
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
                                  Matrix4.translationValues(5.0, 50.0, 0.0),
                              child: Center(
                                child: Container(
                                    width: screenWidth,
                                    height: screenHeight,
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
                                            StringConstant.noReview,
                                            style: TextStyle(
                                                color: whiteA3,
                                                fontFamily: ConstantFont.montserratMedium,
                                                fontWeight: FontWeight.w600,
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
                ],
              ))),
    );
  }
}
