import 'dart:convert';
import 'dart:ui';
import 'package:barber_app/ResponseModel/settingResponse.dart';
import 'package:barber_app/constant/color_constant.dart';
import 'package:barber_app/constant/constant_font.dart';
import 'package:barber_app/constant/dymmyimages.dart';
import 'package:barber_app/constant/string_constant.dart';
import 'package:barber_app/constant/toast_message.dart';
import 'package:barber_app/network/Apiservice.dart';
import 'package:barber_app/network/BaseModel.dart';
import 'package:barber_app/network/Retro_Api.dart';
import 'package:barber_app/network/ServerError.dart';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/preferenceutils.dart';
import 'package:barber_app/screens/otpscreen.dart';
import 'package:barber_app/screens/registerScreen.dart';
import 'package:flutter/material.dart';
import 'forgotpassword.dart';
import 'homescreen.dart';
import 'package:email_validator/email_validator.dart';

class LoginScreen extends StatefulWidget {
  final int index;

  LoginScreen(this.index);

  @override
  _LoginScreen createState() => new _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  FocusNode? myFocusNode;
  String? _email, _password;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    PreferenceUtils.getBool(AppConstant.disclaimerDialog) == false
        ? Future.delayed(Duration.zero, () {
            showAlertDialog(context);
          })
        : null;
    return ModalProgressHUD(
      inAsyncCall: _loading,
      opacity: 1.0,
      color: Colors.transparent.withOpacity(0.2),
      progressIndicator: SpinKitFadingCircle(color: pinkColor),
      child: Form(
        key: _formKey,
        child: new SafeArea(
          child: Scaffold(
            body: Stack(children: <Widget>[
              new Container(
                child: new BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: new Container(
                    decoration: new BoxDecoration(color: whiteColor.withOpacity(0.0)),
                  ),
                ),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new ExactAssetImage(DummyImage.loginBG),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              new ListView(
                children: [
                  Container(
                    width: double.infinity,
                    
                    child: Container(
                       margin: const EdgeInsets.only(top: 150.0),
                      alignment: FractionalOffset.center,
                      child: Image.asset(
                        DummyImage.mainLogo,
                                  height: 170,
                                  width: double.infinity,
                                  fit: BoxFit.contain,
                      ),
                    ),
                  ),
                 
                  Container(
                    margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                    alignment: FractionalOffset.topCenter,
                    child: TextFormField(
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      validator: (email) => EmailValidator.validate(email!) ? null : "Invalid email address",
                      onSaved: (email) => _email = email,
                      onFieldSubmitted: (_) {
                        fieldFocusChange(context, _emailFocusNode, _passwordFocusNode);
                      },
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      style: TextStyle(
                          fontSize: 14.0,
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                          fontFamily: ConstantFont.montserratMedium),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: whiteColor,
                        hintText: 'Email id',
                        hintStyle:
                            TextStyle(fontSize: 14.0, color: greyColor, fontFamily: ConstantFont.montserratMedium),
                        contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent.withOpacity(0.50)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent.withOpacity(0.50)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                    alignment: FractionalOffset.topCenter,
                    child: TextFormField(
                      obscureText: _obscureText,
                      controller: passwordController,
                      focusNode: _passwordFocusNode,
                      validator: (password) {
                        Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                        RegExp regex = new RegExp(pattern as String);
                        if (!regex.hasMatch(password!))
                          return 'Invalid password';
                        else
                          return null;
                      },
                      onSaved: (password) => _password = password,
                      style: TextStyle(
                          fontSize: 14.0,
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                          fontFamily: ConstantFont.montserratMedium),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: whiteColor,
                        hintText: 'Password',
                        hintStyle:
                            TextStyle(fontSize: 14.0, color: greyColor, fontFamily: ConstantFont.montserratMedium),
                        contentPadding: EdgeInsets.only(left: 14.0, bottom: 5.0, top: 14.0),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent.withOpacity(0.50)),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent.withOpacity(0.50)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent.withOpacity(0.50)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: new Icon(
                            _obscureText ? Icons.visibility : Icons.visibility_off,
                            color: whiteColor,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 10, right: 15.0),
                      alignment: FractionalOffset.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => ForgotPassword()), (context) => false);
                        },
                        child: Text(
                          StringConstant.ForgotPassword,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: pinkColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: ConstantFont.montserratMedium),
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      alignment: FractionalOffset.center,
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width * .90,
                        height: 45,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        color: pinkColor,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            AppConstant.checkNetwork().whenComplete(() => CallApiForLogin(_email, _password));
                          }
                        },
                        child: Text(
                          StringConstant.login,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: 18,
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
                            margin: const EdgeInsets.only(top: 20),
                            alignment: FractionalOffset.bottomCenter,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                                );
                              },
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Text(
                                    StringConstant.donHaveAnAccount,
                                    style: TextStyle(
                                        color: grey99,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: ConstantFont.montserratMedium),
                                  ),
                                  new Text(
                                    StringConstant.signUp,
                                    style: TextStyle(
                                        color: pinkColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: ConstantFont.montserratBold),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    PreferenceUtils.init();
    PreferenceUtils.getBool(AppConstant.disclaimerDialog) == true ? callSettingApi() : null;
    WidgetsFlutterBinding.ensureInitialized();

    if (mounted) {
      setState(() {
        PreferenceUtils.init();
      });
    }
  }

  void fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  /*Login Api Call*/
  CallApiForLogin(String? email, String? password) async {
    String fcmtoken = PreferenceUtils.getString(AppConstant.fcmtoken);

    Map<String, String> body = {
      "email": email!,
      "password": password!,
      "device_token": fcmtoken,
    };
    print("login_fcmtoken123:$fcmtoken");
    print("login_email:$email");
    print("login_password:$password");

    setState(() {
      _loading = true;
    });
    RestClient(RetroApi().dioData()).login(body).then((response) {
      setState(() {
        _loading = false;
      });
      print(response.toString());
      final body = json.decode(response);

      bool? sucess = body['success'];
      print(sucess);
      if (sucess == true) {
        var token = body['data']['token'];

        PreferenceUtils.setString(AppConstant.headertoken, token);

        print(token);

        PreferenceUtils.setlogin(AppConstant.isLoggedIn, true);
        bool? login123 = PreferenceUtils.getlogin(AppConstant.isLoggedIn);
        print("login123:$login123");
        ToastMessage.toastMessage("Connexion réussie");

        print("WidgetIndex:${widget.index}");

        PreferenceUtils.setString(AppConstant.userimage, body['data']['image']);
        PreferenceUtils.setString(AppConstant.username, body['data']['name']);
        PreferenceUtils.setString(AppConstant.imagePath, body['data']['imagePath']);
        PreferenceUtils.setString(AppConstant.fullImage, body['data']['imagePath'] + body['data']['image']);
        if (widget.index == 6) {
          Navigator.pop(context);
        } else {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(widget.index)));
        }
      } else if (sucess == false) {
        var msg = body['msg'];
        print(msg);

        if (msg == "Verify your account") {
          ToastMessage.toastMessage("Veuillez vérifier votre compte.");

          var userid = body['data'].toString();
          print("loginUserid:$userid");
          PreferenceUtils.setString(AppConstant.userid, userid);
          PreferenceUtils.setString(AppConstant.useremail, email);
          PreferenceUtils.setlogin(AppConstant.isLoggedIn, true);
          ToastMessage.toastMessage("Connexion réussie.");

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OtpScreen()),
          );
        }
      }
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

          if (responseCode == 401) {
            ToastMessage.toastMessage("Email ou mot de passe invalide.");

            print("Got error : ${res.statusCode} -> ${res.statusMessage}");
            print("Invalid email or password");
          } else if (responseCode == 422) {
            print("Invalid Data");
          }

          break;
        default:
      }
    });
  }

  void callApiForgetProfile() {
    setState(() {
      _loading = true;
    });
    RestClient(RetroApi().dioData()).profile().then((response) {
      if (mounted) {
        setState(() {
          _loading = false;
          if (response.success = true) {
            PreferenceUtils.setString(AppConstant.username, response.data!.name!);
            print("profileNameLogin:${PreferenceUtils.getString(AppConstant.username)}");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen(1)),
            );
          } else {
            ToastMessage.toastMessage("Pas de données");
          }
        });
      }
    }).catchError((Object obj) {
      setState(() {
        _loading = false;
      });
      print("error:$obj");
      print(obj.runtimeType);
      ToastMessage.toastMessage("Erreur interne du serveur");
    });
  }

  Future<BaseModel<SettingResponse>> callSettingApi() async {
    SettingResponse response;
    try {
      response = await RestClient(RetroApi().dioData()).settings();
      if (response.success == true) {
        PreferenceUtils.setString(AppConstant.currencySymbol, response.data!.currencySymbol!);
        if (response.data!.appId != null) {
          getOneSingleToken(response.data!.appId!);
        }
      }
    } catch (error) {
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        PreferenceUtils.putBool(AppConstant.disclaimerDialog, true);
        callSettingApi();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(
        "Disclaimer",
        style: TextStyle(fontSize: 20),
      ),
      content: Text(
        "Cindy Beauty App uses location data to find nearby Barber Shops, even when app is in background.",
        style: TextStyle(fontSize: 18),
      ),
      actions: [
        okButton,
      ],
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

getOneSingleToken(String appId) async {
  String? userId = '';
  OneSignal.shared.consentGranted(true);
  await OneSignal.shared.setAppId(appId);
  await OneSignal.shared.promptUserForPushNotificationPermission(fallbackToSettings: true);
  OneSignal.shared.promptLocationPermission();
  var status = await (OneSignal.shared.getDeviceState());
  userId = status!.userId;
  print("One Signal Token :$userId");
  if (PreferenceUtils.getString(AppConstant.fcmtoken).isEmpty) {
    if (userId != null) {
      PreferenceUtils.setString(AppConstant.fcmtoken, userId);
    } else {
      PreferenceUtils.setString(AppConstant.fcmtoken, "");
    }
  }
}
