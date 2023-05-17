import 'package:barber_app/appbar/app_bar_only.dart';
import 'package:barber_app/common/common_view.dart';
import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/color_constant.dart';
import 'package:barber_app/constant/constant_font.dart';
import 'package:barber_app/constant/dymmyimages.dart';
import 'package:barber_app/constant/preferenceutils.dart';
import 'package:barber_app/constant/string_constant.dart';
import 'package:barber_app/constant/toast_message.dart';
import 'package:barber_app/drawer/default_page.dart';
import 'package:barber_app/drawer/drawer_only.dart';
import 'package:barber_app/network/Apiservice.dart';
import 'package:barber_app/network/Retro_Api.dart';
import 'package:barber_app/screens/homescreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class About extends StatefulWidget {
  About({Key? key, isDrawerOpen, required this.onOpen, required this.onClose})
      : isDrawerOpen = isDrawerOpen,
        super(key: key);

  final bool isDrawerOpen;
  final VoidCallback onOpen;
  final VoidCallback onClose;
  @override
  _About createState() => new _About();
}

class _About extends State<About> {
  bool dataVisible = false;
  bool noDataVisible = true;
  bool _loading = false;
  String? footer1 = "";
  String? footer2 = "";
  String image = "";
  String? appVersion = "";
  String? termsData = "";
  String name = "User";
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;

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

  @override
  void initState() {
    super.initState();
    PreferenceUtils.init();
    AppConstant.checkNetwork().whenComplete(() => callApiForSettings());
    name = PreferenceUtils.getString(AppConstant.username);
  }

  void callApiForSettings() {
    setState(() {
      _loading = true;
    });
    RestClient(RetroApi().dioData()).settings().then((response) {
      setState(() {
        _loading = false;
        if (response.success = true) {
          dataVisible = true;
          noDataVisible = false;
          termsData = response.data!.termsConditions;
          footer1 = response.data!.footer1;
          footer2 = response.data!.footer2;
          image = response.data!.imagePath! + response.data!.blackLogo!;
          appVersion = response.data!.appVersion;
          PreferenceUtils.setString(
              AppConstant.currencySymbol, response.data!.currencySymbol!);
          PreferenceUtils.setString(appId,
              response.data!.appId!.isNotEmpty ? response.data!.appId! : "");
        } else {
          dataVisible = false;
          noDataVisible = true;
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
        child: new SafeArea(
            child: Stack(children: [
          DrawerOnly(),
          DefaultPage(
            index: 1,
            yOffset: yOffset,
            xOffset: xOffset,
            scaleFactor: scaleFactor,
            isDrawerOpen: isDrawerOpen,
            onClose: onClose,
            child: Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: whiteColor,
              appBar: appbar(
                  context,
                  StringConstant.aboutApp,
                  _drawerScaffoldKey,
                  false,
                  isDrawerOpen,
                  onOpen,
                  onClose) as PreferredSizeWidget?,
              body: Scaffold(
                resizeToAvoidBottomInset: true,
                key: _drawerScaffoldKey,
                drawer: new DrawerOnly(),
                body: new Stack(children: <Widget>[
                  Visibility(
                    visible: dataVisible,
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 15, right: 15, top: 0, bottom: 60),
                      child: Center(
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.75,
                            alignment: Alignment.center,
                            child: ListView(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: <Widget>[
                                CachedNetworkImage(
                                  height: 70,
                                  width: 80,
                                  imageUrl: image,
                                  alignment: Alignment.center,
                                  placeholder: (context, url) =>
                                      SpinKitFadingCircle(color: pinkColor),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(DummyImage.noImage),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    appVersion!,
                                    style: TextStyle(
                                        color: whiteA3,
                                        fontFamily:
                                            ConstantFont.montserratMedium,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 30),
                                    child: Text(
                                      footer1!,
                                      style: TextStyle(
                                          color: whiteA3,
                                          fontFamily:
                                              ConstantFont.montserratMedium,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 1),
                                    child: Text(
                                      footer2!,
                                      style: TextStyle(
                                          color: whiteA3,
                                          fontFamily:
                                              ConstantFont.montserratMedium,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: noDataVisible,
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 15, right: 15, top: 0, bottom: 60),
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
                                        fontFamily: ConstantFont.montserratBold,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ),
                  new Container(
                      alignment: Alignment.bottomCenter, child: Body()),
                ]),
              ),
            ),
          )
        ])),
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
