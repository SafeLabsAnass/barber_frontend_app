import 'dart:async';

import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/color_constant.dart';
import 'package:barber_app/constant/constant_font.dart';
import 'package:barber_app/constant/dymmyimages.dart';
import 'package:barber_app/constant/string_constant.dart';
import 'package:barber_app/constant/toast_message.dart';
import 'package:barber_app/network/Apiservice.dart';
import 'package:barber_app/network/Retro_Api.dart';
import 'package:barber_app/screens/loginscreen.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPassword createState() => new _ForgotPassword();
}

class _ForgotPassword extends State<ForgotPassword> {
  bool _loading = false;
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
  }

  final _formKey = GlobalKey<FormState>();
  Future<bool> _onWillPop() async {
    final completer = Completer<bool>();
    Navigator.pushAndRemoveUntil(
        context,
        new MaterialPageRoute(
            builder: (context) => new LoginScreen(2)),(context)=>false);
    completer.complete(true);
    return completer.future;
  }
  FocusNode _emailFocusNode = FocusNode();
  String?  _email = "";

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      opacity: 1.0,
      color: Colors.transparent.withOpacity(0.2),
      progressIndicator: SpinKitFadingCircle(color: pinkColor),
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image:ExactAssetImage( DummyImage.loginBG) ,
              fit: BoxFit.cover,
              ), 
            
              ),
          child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_left,
                    color: blackColor,
                    size: 30,
                  ),
                  onPressed: () =>   Navigator.pushAndRemoveUntil(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new LoginScreen(2)),(context)=>false),
                ),
                title: Text(
                  StringConstant.forgotPassword,
                  style: TextStyle(
                      color: blackColor,
                      fontFamily:  ConstantFont.montserratBold,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ),
              body: Form(
                  key: _formKey,
                  child: Container(
                      child: Column(children: <Widget>[
                    Expanded(
                      child: ListView(
                        children: [
                          Container(
                            child: Container(
                              margin: const EdgeInsets.only(top: 50.0, left: 0.0),
                              alignment: FractionalOffset.center,
                              child: Image.asset(
                                DummyImage.forgotPassword,
                                width: 100,
                                height: 100,
                                alignment: Alignment.center,
                              ),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 70.0, left: 0.0),
                              alignment: FractionalOffset.center,
                              child: Text(
                                StringConstant.forgotPasswordNot,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: blackColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    fontFamily:  ConstantFont.montserratBold),
                              )),
                          Container(
                              margin: const EdgeInsets.only(top: 2.0, left: 0.0),
                              alignment: FractionalOffset.center,
                              child: Text(
                                StringConstant.donWorryWeWillFindYourAccount,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: blackColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    fontFamily:  ConstantFont.montserratMedium),
                              )),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 50, left: 40, right: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    StringConstant.emailId,
                                    style: TextStyle(
                                        color:  grey99,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontFamily:  ConstantFont.montserratMedium),
                                  ),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  autofocus: false,
                                  focusNode: _emailFocusNode,
                                  validator: (email) =>
                                      EmailValidator.validate(email!)
                                          ? null
                                          : "Invalid email address",
                                  onSaved: (email) => _email = email,
                                  onFieldSubmitted: (_) {},
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: blackColor,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: ConstantFont.montserratMedium),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor:  whiteF1,
                                    hintText: 'Enter your email id',
                                    contentPadding: const EdgeInsets.only(
                                        left: 14.0, bottom: 8.0, top: 8.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color:  whiteF1),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color:  whiteF1),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                MaterialButton(
                                  shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(5.0)),
                                  minWidth: 300,
                                  height: 40,
                                  color:pinkColor,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
        
                                      AppConstant.checkNetwork().whenComplete(
                                          () => callApiForForgotpassword(_email));
                                    }
                                  },
                                  child: Text(
                                    StringConstant.sendMeOTP,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: whiteColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: ConstantFont.montserratMedium,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 2, top: 10),
                            alignment: FractionalOffset.bottomCenter,
                            child: Text(
                              StringConstant.pleaseCheckYourEmail,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                  color: greyColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: ConstantFont.montserratMedium),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            alignment: FractionalOffset.bottomCenter,
                            child: Text(
                              StringConstant.weWillSendYouPasswordOnYourMail,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                  color: greyColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: ConstantFont.montserratMedium),
                            ),
                          )
                        ],
                      ),
                    ),
                  ])))),
        ),
      ),
    );
  }

  void callApiForForgotpassword(String? email) {
    setState(() {
      _loading = true;
    });
    RestClient(RetroApi().dioData()).forgetpassword(email).then((response) {
      setState(() {
        _loading = false;
        print(response.success);
        if (response.success = true) {
          print("sucess");
          showSucess();
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

            ToastMessage.toastMessage("Données invalide");
            print(responseCode);
            print(res.statusMessage);
          } else if (responseCode == 422) {
            ToastMessage.toastMessage("Email invalide");
            print("code:$responseCode");
            print("msg:$msg");
          }

          break;
        default:
      }
    });
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
                            width: 100,
                            height: 100,
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
                           "Congratulation!",
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
                            "Your password has been send your email...!",
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
                          Navigator.pushAndRemoveUntil(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new LoginScreen(2)),(context)=>false);
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 40.0, left: 15.0, right: 15, bottom: 20),
                            child: Text(
                              "Go To Login",
                              style: TextStyle(
                                  color: blue21,
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
