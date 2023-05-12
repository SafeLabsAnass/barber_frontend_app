import 'package:barber_app/ResponseModel/SingleAppoitmentModel.dart';
import 'package:barber_app/common/rating_screen.dart';
import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/color_constant.dart';
import 'package:barber_app/constant/constant_font.dart';
import 'package:barber_app/constant/preferenceutils.dart';
import 'package:barber_app/constant/string_constant.dart';
import 'package:barber_app/network/Apiservice.dart';
import 'package:barber_app/network/BaseModel.dart';
import 'package:barber_app/network/Retro_Api.dart';
import 'package:barber_app/network/ServerError.dart';
import 'package:barber_app/separator/separator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:extended_image/extended_image.dart';
import '../constant/dymmyimages.dart';
import '../constant/toast_message.dart';

class SingleAppoitmentScreen extends StatefulWidget {
  final int appoitmentId;

  const SingleAppoitmentScreen({Key? key, required this.appoitmentId}) : super(key: key);

  @override
  State<SingleAppoitmentScreen> createState() => _SingleAppoitmentScreenState();
}

class _SingleAppoitmentScreenState extends State<SingleAppoitmentScreen> {
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    callGetSingleAppointment(widget.appoitmentId);
  }

  SingleAppoitmentData? appoitmentData;
  Future<BaseModel<SingleAppoitmentModel>> callGetSingleAppointment(int id) async {
    SingleAppoitmentModel response;
    try {
      setState(() {
        _loading = false;
      });
      response = await RestClient(RetroApi().dioData()).getSingleAppoitment(id);
      if (response.success == true) {
        setState(() {
          appoitmentData = response.data!;
        });
      }
      setState(() {
        _loading = false;
      });
    } catch (error) {
      setState(() {
        _loading = true;
      });
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pinkColor,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Appointment Details",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontFamily: ConstantFont.montserratBold, fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      body: _loading == true
          ? Center(
              child: Text("No Data Found"),
            )
          : appoitmentData == null
              ? Center(child: SpinKitFadingCircle(color: pinkColor))
              : buildPage(appoitmentData!),
      bottomNavigationBar: appoitmentData == null ? SizedBox() : buildBottomSheet(appoitmentData!),
    );
  }

  Widget buildPage(SingleAppoitmentData appoitmentDatas) {
    print(PreferenceUtils.getString(AppConstant.salonImage));
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 100,
                width: 100,
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 5),
                child: ExtendedImage.network(
                  PreferenceUtils.getString(AppConstant.salonImage),
                  clipBehavior: Clip.hardEdge,
                  fit: BoxFit.fill,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  height: 100,
                  width: 100,
                  loadStateChanged: (ExtendedImageState state) {
                    switch (state.extendedImageLoadState) {
                      case LoadState.loading:
                        return SizedBox(
                          height: 0,
                          width: 0,
                        );
                      case LoadState.completed:
                        return ExtendedImage.network(
                          PreferenceUtils.getString(AppConstant.salonImage),
                          width: 100,
                          height: 100,
                          clipBehavior: Clip.hardEdge,
                          fit: BoxFit.fill,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                        );
                      case LoadState.failed:
                        return Image.asset("images/sp1.png");
                    }
                  },
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    PreferenceUtils.getString(AppConstant.singlesalonName) == ""
                        ? "The Single Barber"
                        : PreferenceUtils.getString(AppConstant.singlesalonName),
                    style: TextStyle(
                        fontFamily: ConstantFont.montserratBold,
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    PreferenceUtils.getString(AppConstant.salonAddress) == ""
                        ? ""
                        : PreferenceUtils.getString(AppConstant.salonAddress),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontFamily: ConstantFont.montserratRegular,
                    ),
                  )
                ],
              ))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          MySeparator(),
          SizedBox(
            height: 10,
          ),

          ///employee Details
          Text(
            "Employee Details",
            style: TextStyle(
                fontFamily: ConstantFont.montserratBold,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              ExtendedImage.network(
                appoitmentDatas.employee!.imagePath! + appoitmentDatas.employee!.image!,
                clipBehavior: Clip.hardEdge,
                fit: BoxFit.cover,
                shape: BoxShape.circle,
                height: 65,
                width: 65,
                loadStateChanged: (ExtendedImageState state) {
                  switch (state.extendedImageLoadState) {
                    case LoadState.loading:
                      return SizedBox(
                        height: 0,
                        width: 0,
                      );
                    case LoadState.completed:
                      return ExtendedImage.network(
                        appoitmentDatas.employee!.imagePath! + appoitmentDatas.employee!.image!,
                        width: 65,
                        height: 65,
                        clipBehavior: Clip.hardEdge,
                        fit: BoxFit.cover,
                        shape: BoxShape.circle,
                      );
                    case LoadState.failed:
                      return Image.asset("images/the_barber_small.png");
                  }
                },
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                appoitmentDatas.employee!.name!,
                style: TextStyle(
                    fontFamily: ConstantFont.montserratBold,
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),

          ///divider
          SizedBox(
            height: 10,
          ),
          MySeparator(),
          SizedBox(
            height: 10,
          ),

          /// service
          Text(
            "Services",
            style: TextStyle(
                fontFamily: ConstantFont.montserratBold,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          SizedBox(
            height: 10,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: appoitmentDatas.services!.length,
            itemBuilder: (context, index) {
              Services service = appoitmentDatas.services![index];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                leading: ExtendedImage.network(
                  service.imagePath! + service.image!,
                  clipBehavior: Clip.hardEdge,
                  fit: BoxFit.cover,
                  shape: BoxShape.circle,
                  height: 30,
                  width: 30,
                  loadStateChanged: (ExtendedImageState state) {
                    switch (state.extendedImageLoadState) {
                      case LoadState.loading:
                        return SizedBox(
                          height: 0,
                          width: 0,
                        );
                      case LoadState.completed:
                        return ExtendedImage.network(
                          service.imagePath! + service.image!,
                          width: 30,
                          height: 30,
                          clipBehavior: Clip.hardEdge,
                          fit: BoxFit.cover,
                          shape: BoxShape.circle,
                        );
                      case LoadState.failed:
                        return Image.asset("images/the_barber_small.png");
                    }
                  },
                ),
                title: Text(
                  service.name!,
                  style: TextStyle(
                      color: grey99,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      fontFamily: ConstantFont.montserratRegular),
                ),
                trailing: Text(
                  PreferenceUtils.getString(AppConstant.currencySymbol) + " " + service.price.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      fontFamily: ConstantFont.montserratRegular),
                ),
              );
            },
          ),

          ///divider
          SizedBox(
            height: 10,
          ),
          MySeparator(),
          SizedBox(
            height: 10,
          ),

          ///booking details
          Text(
            "Booking Details",
            style: TextStyle(
                fontFamily: ConstantFont.montserratBold,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          SizedBox(
            height: 10,
          ),

          ///date
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 0, top: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    "Date",
                    style: TextStyle(
                        color: grey99,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        fontFamily: ConstantFont.montserratRegular),
                  ),
                ),
                Container(
                  child: Text(
                    appoitmentDatas.date!,
                    style: TextStyle(
                        color: grey99,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        fontFamily: ConstantFont.montserratRegular),
                  ),
                ),
              ],
            ),
          ),

          ///time
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 0, top: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    "Time",
                    style: TextStyle(
                        color: grey99,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        fontFamily: ConstantFont.montserratRegular),
                  ),
                ),
                Container(
                  child: Text(
                    appoitmentDatas.startTime! + "-" + appoitmentDatas.endTime!,
                    style: TextStyle(
                        color: grey99,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        fontFamily: ConstantFont.montserratRegular),
                  ),
                ),
              ],
            ),
          ),

          ///payment status
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 0, top: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    "Payment Status",
                    style: TextStyle(
                        color: grey99,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        fontFamily: ConstantFont.montserratRegular),
                  ),
                ),
                Container(
                  child: Text(
                    appoitmentDatas.paymentStatus == 0 ? "pending" : "complete",
                    style: TextStyle(
                        color: grey99,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        fontFamily: ConstantFont.montserratRegular),
                  ),
                ),
              ],
            ),
          ),

          ///payment method
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 0, top: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    "Payment Method",
                    style: TextStyle(
                        color: grey99,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        fontFamily: ConstantFont.montserratRegular),
                  ),
                ),
                Container(
                  child: Text(
                    appoitmentDatas.paymentType!,
                    style: TextStyle(
                        color: grey99,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        fontFamily: ConstantFont.montserratRegular),
                  ),
                ),
              ],
            ),
          ),

          ///appoitment status
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 0, top: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    "Appointment Status",
                    style: TextStyle(
                        color: grey99,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        fontFamily: ConstantFont.montserratRegular),
                  ),
                ),
                Container(
                  child: Text(
                    appoitmentDatas.bookingStatus!,
                    style: TextStyle(
                        color: grey99,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        fontFamily: ConstantFont.montserratRegular),
                  ),
                ),
              ],
            ),
          ),

          ///review
          Visibility(
            visible: appoitmentDatas.review != null ? true : false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                MySeparator(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Review",
                  style: TextStyle(
                      fontFamily: ConstantFont.montserratBold,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  width: MediaQuery.of(context).size.width,
                  color: whiteColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * .12,
                        height: 75,
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              height: 40.0,
                              width: MediaQuery.of(context).size.width * .12,
                              alignment: Alignment.centerLeft,
                              child: CachedNetworkImage(
                                height: 35,
                                width: 35,
                                imageUrl: appoitmentDatas.review != null
                                    ? appoitmentDatas.review!.user!.imagePath! + appoitmentDatas.review!.user!.image!
                                    : "",
                                imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.fill,
                                      alignment: Alignment.topCenter,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => SpinKitFadingCircle(color: pinkColor),
                                errorWidget: (context, url, error) => Image.asset(DummyImage.noImage),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(top: 1),
                              height: 12.0,
                              width: MediaQuery.of(context).size.width * .12,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 2),
                                    child: Container(
                                      margin: EdgeInsets.only(top: 0, left: 10),
                                      child: SvgPicture.asset(
                                        DummyImage.star,
                                        width: 10,
                                        height: 10,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 0, left: 2),
                                      child: Text(
                                          appoitmentDatas.review != null ? appoitmentDatas.review!.rate.toString() : "",
                                          style: TextStyle(
                                              color: yellowColor,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: ConstantFont.montserratMedium)),
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
                        margin: EdgeInsets.only(top: 5, left: 0, right: 5),
                        width: MediaQuery.of(context).size.width * .75,
                        decoration: BoxDecoration(
                          color: whiteF1,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 30,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      appoitmentDatas.review != null ? appoitmentDatas.review!.user!.name! : "",
                                      style: TextStyle(
                                        color: blackColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: ConstantFont.montserratSemiBold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(left: 10, right: 20, bottom: 10),
                              child: Text(
                                appoitmentDatas.review != null ? appoitmentDatas.review!.message! : "",
                                style: TextStyle(
                                  color: grey99,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: ConstantFont.montserratRegular,
                                ),
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          ///add review
          Visibility(
            visible: appoitmentDatas.bookingStatus == "Completed" && appoitmentDatas.review == null ? true : false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                MySeparator(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Add Review",
                  style: TextStyle(
                      fontFamily: ConstantFont.montserratBold,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                RatingScreen(bookingId: widget.appoitmentId),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildBottomSheet(SingleAppoitmentData appoitmentData) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible:
              appoitmentData.bookingStatus == "Pending" || appoitmentData.bookingStatus == "Approved" ? true : false,
          child: ElevatedButton(
            child: Text("Cancel Booking"),
            onPressed: () {
              showCancelDialog(context, int.parse(appoitmentData.id.toString()));
            },
            style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width, 50),
                backgroundColor: pinkColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
          ),
        ),
      ],
    );
  }

  void showCancelDialog(BuildContext context, int? id) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          Widget cancelButton = TextButton(
            child: Text(
              StringConstant.no,
              style: TextStyle(color: greyColor, fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Montserrat'),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          );
          Widget continueButton = TextButton(
            child: Text(
              StringConstant.yes,
              style: TextStyle(color: pinkColor, fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Montserrat'),
            ),
            onPressed: () {
              print("BookingId:$id");

              AppConstant.checkNetwork().whenComplete(() => callApiForCancelBooking(id!));
              Navigator.pop(context);
            },
          );

          return AlertDialog(
            actions: [
              cancelButton,
              continueButton,
            ],
            title: Align(
              alignment: Alignment.center,
              child: Text(
                StringConstant.cancelAppointment,
                style:
                    TextStyle(color: blackColor, fontSize: 20, fontWeight: FontWeight.w600, fontFamily: 'Montserrat'),
                textAlign: TextAlign.center,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      StringConstant.areYouSureYouWantToCancelYourAppointment,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: greyColor, fontWeight: FontWeight.w600, fontSize: 18, fontFamily: 'Montserrat'),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void callApiForCancelBooking(int id) {
    setState(() {
      _loading = true;
    });
    RestClient(RetroApi().dioData()).removeappointment(id).then((response) {
      setState(() {
        _loading = false;
        if (response.success = true) {
          ToastMessage.toastMessage(response.msg!);
          Navigator.of(context).pop();
        } else {
          ToastMessage.toastMessage("No Data");
        }
      });
    }).catchError((Object obj) {
      setState(() {
        _loading = false;
      });
      print("error:$obj");
      print(obj.runtimeType);
    });
  }
}
