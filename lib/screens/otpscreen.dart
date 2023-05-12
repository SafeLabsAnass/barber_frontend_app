import 'dart:async';
import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/color_constant.dart';
import 'package:barber_app/constant/constant_font.dart';
import 'package:barber_app/constant/dymmyimages.dart';
import 'package:barber_app/constant/preferenceutils.dart';
import 'package:barber_app/constant/string_constant.dart';
import 'package:barber_app/constant/toast_message.dart';
import 'package:barber_app/network/Apiservice.dart';
import 'package:barber_app/network/Retro_Api.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import 'loginscreen.dart';

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreen createState() => new _OtpScreen();
}

class _OtpScreen extends State<OtpScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _loading = false;
  TextEditingController otpTextEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    startTimer();
    setState(() {
      PreferenceUtils.init();
    });
  }

  Timer? _timer;
  int _start = 60;
  var otp = "";

  @override
  Widget build(BuildContext context) {
    var otp1 = PreferenceUtils.getString(AppConstant.userotp);
    print(otp1);
    return ModalProgressHUD(
      inAsyncCall: _loading,
      opacity: 1.0,
      color: Colors.transparent.withOpacity(0.2),
      progressIndicator: SpinKitFadingCircle(color: pinkColor),
      child: Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new ExactAssetImage(DummyImage.loginBG),
            fit: BoxFit.cover,
            ),
        ),
        child: Scaffold(
            key: _scaffoldKey,
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_left,
                  color: blackColor,
                  size: 30,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                StringConstant.verification,
                style: TextStyle(
                    color: blackColor,
                    fontFamily: ConstantFont.montserratBold,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: Container(
                child: Stack(children: <Widget>[
              ListView(
                children: [
                  Container(
                    child: Container(
                      margin: const EdgeInsets.only(top: 100.0, left: 0.0),
                      alignment: FractionalOffset.center,
                      child: Text(
                        StringConstant.otp,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: blackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            fontFamily: ConstantFont.montserratBold),
                      ),
                    ),
                  ),
                  Container(
                    child: Container(
                      margin: const EdgeInsets.only(top: 1.0, left: 0.0),
                      alignment: FractionalOffset.center,
                      child: Text(
                        "Set your $otp1 here.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: blackColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: ConstantFont.montserratMedium),
                      ),
                    ),
                  ),
                  Container(
                    child: Container(
                      margin: const EdgeInsets.only(top: 30.0, left: 0.0),
                      alignment: FractionalOffset.center,
                      child: Text(
                        "00:" + "$_start",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: grey99,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            fontFamily: ConstantFont.montserratMedium),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    margin: const EdgeInsets.only(top: 20.0, left: 0.0),
                    alignment: FractionalOffset.center,
                    child: PinCodeTextField(
                      autofocus: true,
                      hideCharacter: false,
                      highlight: false,
                      pinBoxColor: whiteF1,
                      controller: otpTextEditingController,
                      highlightColor: whiteF1,
                      defaultBorderColor: whiteF1,
                      hasTextBorderColor: whiteF1,
                      pinBoxBorderWidth: 2,
                      maxLength: 4,
                      onTextChanged: (text) {
                        setState(() {
                          print('hi');
                        });
                      },
                      onDone: (text) async {
                        print("DONE $text");
      
                        otp = text;
      
                        var connectivityResult = await (Connectivity().checkConnectivity());
                        if (connectivityResult == ConnectivityResult.mobile) {
                          callOtpCheckApi(otp);
                        } else if (connectivityResult == ConnectivityResult.wifi) {
                          callOtpCheckApi(otp);
                        } else {
                          ToastMessage.toastMessage("No Internet Connection");
                        }
                      },
                      pinBoxWidth: 50,
                      pinBoxHeight: 50,
                      pinBoxOuterPadding: const EdgeInsets.all(10.0),
                      pinBoxRadius: 10,
                      hasUnderline: false,
                      wrapAlignment: WrapAlignment.center,
                      pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                      pinTextStyle: TextStyle(fontSize: 22.0, color: grey99, fontFamily: ConstantFont.montserratMedium),
                      pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.defaultNoTransition,
                      highlightPinBoxColor: whiteF1,
                      pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
                      highlightAnimationBeginColor: whiteF1,
                      highlightAnimationEndColor: whiteF1,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      alignment: FractionalOffset.center,
                      child: MaterialButton(
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                        minWidth: 300,
                        height: 40,
                        color: pinkColor,
                        onPressed: () async {
                          if (otp.length == 0 && otp.length < 4) {
                            ToastMessage.toastMessage("Invalid Text");
                          } else {
                            var connectivityResult = await (Connectivity().checkConnectivity());
                            if (connectivityResult == ConnectivityResult.mobile) {
                              callOtpCheckApi(otp);
                            } else if (connectivityResult == ConnectivityResult.wifi) {
                              callOtpCheckApi(otp);
                            } else {
                              ToastMessage.toastMessage("No Internet Connection");
                            }
                          }
                        },
                        child: Text(
                          StringConstant.next,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontFamily: ConstantFont.montserratMedium,
                          ),
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            alignment: FractionalOffset.bottomCenter,
                            child: GestureDetector(
                              onTap: () async {
                                var connectivityResult = await (Connectivity().checkConnectivity());
                                if (connectivityResult == ConnectivityResult.mobile) {
                                  callResendOtpApi();
                                } else if (connectivityResult == ConnectivityResult.wifi) {
                                  callResendOtpApi();
                                } else {
                                  ToastMessage.toastMessage("No Internet Connection");
                                }
                              },
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Text(
                                    StringConstant.donReceiveOtp,
                                    style: TextStyle(
                                        color: blackColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: ConstantFont.montserratMedium),
                                  ),
                                  new Text(
                                    StringConstant.resend,
                                    style: TextStyle(
                                        color: pinkColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: ConstantFont.montserratBold),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ]))),
      ),
    );
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  void startTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    } else {
      _timer = new Timer.periodic(
        const Duration(seconds: 1),
        (Timer timer) => setState(
          () {
            if (_start < 1) {
              timer.cancel();
            } else {
              _start = _start - 1;
            }
          },
        ),
      );
    }
  }

  void callOtpCheckApi(String otp) {
    var userid = PreferenceUtils.getString(AppConstant.userid);
    print("userid:$userid");
    Map<String, String> body = {
      "otp": otp,
      "user_id": userid,
    };
    setState(() {
      _loading = true;
    });
    RestClient(RetroApi().dioData()).checkotp(body).then((response) {
      setState(() {
        _loading = false;
        print(response.success);
        if (response.success = true) {
          ToastMessage.toastMessage(response.msg!);

          PreferenceUtils.setString(AppConstant.userid, response.data!.id.toString());
          PreferenceUtils.setString(AppConstant.username, response.data!.name!);
          PreferenceUtils.setString(AppConstant.useremail, response.data!.email!);
          PreferenceUtils.setString(AppConstant.userotp, response.data!.otp.toString());
          PreferenceUtils.setString(AppConstant.userphone, response.data!.phone!);
          PreferenceUtils.setString(AppConstant.userphonecode, response.data!.code!);
          PreferenceUtils.setString(AppConstant.userimage, response.data!.image!);
          PreferenceUtils.setString(AppConstant.imagePath, response.data!.imagePath!);
          PreferenceUtils.setString(AppConstant.role, response.data!.role.toString());

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen(1)),
          );
        } else if (response.success = false) {
          print(response.msg);
          ToastMessage.toastMessage(response.msg!);
        }
      });
    }).catchError((Object obj) {
      setState(() {
        _loading = false;
      });
      print("error:$obj.");
      print(obj.runtimeType);

      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response!;
          print(res);

          var responseCode = res.statusCode;
          print(responseCode);
          print(responseCode);

          if (responseCode == 401) {
            ToastMessage.toastMessage("Invalid Otp");
          } else if (responseCode == 422) {
            print("Invalid OTP");
          } else if (responseCode == 500) {
            ToastMessage.toastMessage("Internal Server Error");
          }

          break;
        default:
      }
    });
  }

  /*Call Api For resend Api */

  void callResendOtpApi() {
    var useremail = PreferenceUtils.getString(AppConstant.useremail);
    print("useremail:$useremail");

    setState(() {
      _loading = true;
    });
    RestClient(RetroApi().dioData()).sendotp(useremail).then((response) {
      setState(() {
        _loading = false;
        print(response.success);
        if (response.success = true) {
          ToastMessage.toastMessage(response.msg!);

          PreferenceUtils.setString(AppConstant.userid, response.data!.id.toString());
          PreferenceUtils.setString(AppConstant.username, response.data!.name!);
          PreferenceUtils.setString(AppConstant.useremail, response.data!.email!);
          PreferenceUtils.setString(AppConstant.userotp, response.data!.otp.toString());
          PreferenceUtils.setString(AppConstant.userphone, response.data!.phone!);
          PreferenceUtils.setString(AppConstant.userphonecode, response.data!.code!);
          PreferenceUtils.setString(AppConstant.userimage, response.data!.image!);
          PreferenceUtils.setString(AppConstant.imagePath, response.data!.imagePath!);
          PreferenceUtils.setString(AppConstant.role, response.data!.role.toString());

          startTimer();
        } else if (response.success = false) {
          print(response.msg);
          ToastMessage.toastMessage(response.msg!);
        }
      });
    }).catchError((Object obj) {
      setState(() {
        _loading = false;
      });
      print("error:$obj.");
      print(obj.runtimeType);

      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response!;
          print(res);

          var responseCode = res.statusCode;
          print(responseCode);
          print(responseCode);

          if (responseCode == 401) {
            ToastMessage.toastMessage("Invalid Otp");
          } else if (responseCode == 422) {
            print("Invalid OTP");
          } else if (responseCode == 500) {
            ToastMessage.toastMessage("Internal Server Error");
          }

          break;
        default:
      }
    });
  }
}
