import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/color_constant.dart';
import 'package:barber_app/constant/constant_font.dart';
import 'package:barber_app/constant/dymmyimages.dart';
import 'package:barber_app/constant/string_constant.dart';
import 'package:barber_app/constant/toast_message.dart';
import 'package:barber_app/network/Apiservice.dart';
import 'package:barber_app/network/Retro_Api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
class RatingScreen extends StatefulWidget {
  final int bookingId;
  const RatingScreen({Key? key,required this.bookingId}) : super(key: key);

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  var rating = 0.0;
  final _formKey = GlobalKey<FormState>();
  TextEditingController reviewTextController = new TextEditingController();
  void callApiForAddReview(int? id, String message) {
    Map<String, String> body = {
      "message": message,
      "rate": rating.toString(),
      "booking_id": id.toString(),
    };
    RestClient(RetroApi().dioData()).addreview(body).then((response) {

        print(response.success);
        if (response.success = true) {
          print("sucess");
          ToastMessage.toastMessage(response.msg!);
        }
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response!;

          var responseCode = res.statusCode;
          var msg = res.statusMessage;

          if (responseCode == 401) {
            ToastMessage.toastMessage("Données invalides.");
            print(responseCode);
            print(res.statusMessage);
          } else if (responseCode == 422) {
            ToastMessage.toastMessage("Email invalide.");
            print("code:$responseCode");
            print("msg:$msg");
          }

          break;
        default:
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Form(
      key: _formKey,
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        new Container(
          margin: EdgeInsets.only(top: 5),
          child: Text(
            StringConstant.shareYourExperience,
            style: TextStyle(color: blackColor, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: ConstantFont.montserratMedium),
          ),
          alignment: Alignment.topLeft,
        ),
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(top: 10, bottom: 5),
          width: MediaQuery.of(context).size.width,
          height: 70,
          // color: whiteColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width:  MediaQuery.of(context).size.width * .2,
                height: 70,
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 40.0,
                      width: 40.0,
                      child: CircleAvatar(
                        radius: 55,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(DummyImage.theBarber),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 10,),
                  width:  MediaQuery.of(context).size.width * .65,
                  height: 90,
                  decoration: BoxDecoration(
                    color: whiteF1,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    child: TextFormField(
                      autofocus: false,
                      controller: reviewTextController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      maxLines: 8,
                      validator: (msg) {
                        Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                        RegExp regex = new RegExp(pattern as String);
                        if (!regex.hasMatch(msg!))
                          return 'Please Enter review message';
                        else
                          return null;
                      },
                      style: TextStyle(fontSize: 14.0, color: blackColor, fontFamily: ConstantFont.montserratMedium, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: whiteF1,
                        hintText: 'Enter review',
                        contentPadding: const EdgeInsets.only(left: 14.0, bottom: 0.0, top: 5.0, right: 5),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: whiteF1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: whiteF1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        new Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            StringConstant.howManyStarsYouWillGive,
            style: TextStyle(color: blackColor, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: ConstantFont.montserratMedium),
          ),
          alignment: Alignment.topLeft,
        ),
        new Container(
          margin: EdgeInsets.only(top: 10,),
          alignment: Alignment.topLeft,
          child: RatingStars(
            value: rating,
            onValueChanged: (v) {
              setState(() {
                rating = v;
                print(v);
              });
            },
            starBuilder: (index, color) => Icon(
              Icons.star,
              color: color,
            ),
            starCount: 5,
            starSize: 30,
            valueLabelColor: white9B,
            valueLabelTextStyle: TextStyle(color: whiteColor, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 12.0),
            valueLabelRadius: 10,
            maxValue: 5,
            starSpacing: 2,
            maxValueVisibility: true,
            valueLabelVisibility: false,
            animationDuration: Duration(milliseconds: 1000),
            valueLabelPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
            valueLabelMargin: const EdgeInsets.only(right: 8),
            starOffColor: whiteE7,
            starColor: yellowColor,
          ),
        ),
        Container(
          // margin: EdgeInsets.all(10),
          child: TextButton(
            style: TextButton.styleFrom(
              minimumSize: Size(double.infinity, 40),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7), side: BorderSide(color: pinkColor, width: 2)),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                if (rating != 0.0) {
                  AppConstant.checkNetwork().whenComplete(() => callApiForAddReview(widget.bookingId, reviewTextController.text));

                  Navigator.pop(context);
                  return;
                } else {
                  ToastMessage.toastMessage('Veuillez donner votre avis en étoiles.');
                  return;
                }
              }
            },
            child: Text(
              StringConstant.shareReview,
              style: TextStyle(color: pinkColor, fontFamily: ConstantFont.montserratMedium, fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
        ),
      ]),
    );
  }
}
