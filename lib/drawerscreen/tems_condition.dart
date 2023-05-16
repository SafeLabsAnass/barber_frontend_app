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
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class TermsCondition extends StatefulWidget {
  TermsCondition(
      {Key? key, isDrawerOpen, required this.onOpen, required this.onClose})
      : isDrawerOpen = isDrawerOpen,
        super(key: key);

  final bool isDrawerOpen;
  final VoidCallback onOpen;
  final VoidCallback onClose;
  @override
  _TermsCondition createState() => new _TermsCondition();
}

class _TermsCondition extends State<TermsCondition> {
  bool dataVisible = false;
  bool _loading = false;
  String? termsData = '';
  String name = "User";
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;

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
        //  if (response.success = true) {
        //   _loading = false;
        //   dataVisible = true;
        //   PreferenceUtils.setString(appId, response.data!.appId!.isNotEmpty?response.data!.appId!:"");
        //   PreferenceUtils.setString(AppConstant.currencySymbol, response.data!.currencySymbol!);
        //   termsData = response.data?.termsConditions;
        // } else {
        //   dataVisible = false;

        //   ToastMessage.toastMessage("No Data");
        // }
        _loading = false;
        if (response.success = true) {
          dataVisible = true;
          PreferenceUtils.setString(
              AppConstant.currencySymbol, response.data!.currencySymbol!);
          if (response.data!.termsConditions == null) {
            dataVisible = false;
          } else {
            dataVisible = true;
            termsData = response.data?.termsConditions;
          }
          PreferenceUtils.setString(appId,
              response.data!.appId!.isNotEmpty ? response.data!.appId! : "");
        } else {
          dataVisible = false;
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
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: ModalProgressHUD(
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
              yOffset: yOffset,
              xOffset: xOffset,
              scaleFactor: scaleFactor,
              isDrawerOpen: isDrawerOpen,
              child: Scaffold(
                appBar: appbar(
                    context,
                    StringConstant.termsAndConditions,
                    _drawerScaffoldKey,
                    false,
                    isDrawerOpen,
                    onOpen,
                    onClose) as PreferredSizeWidget?,
                body: Scaffold(
                  backgroundColor: whiteColor,
                  resizeToAvoidBottomInset: true,
                  key: _drawerScaffoldKey,
                  drawer: new DrawerOnly(),
                  body: new Stack(children: <Widget>[
                    dataVisible
                        ? Container(
                            margin: EdgeInsets.only(
                                left: 15, right: 15, top: 10, bottom: 60),
                            child: new SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Html(
                                data: termsData,
                              ),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.only(
                                left: 15, right: 15, top: 10, bottom: 60),
                            child: Center(
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.75,
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
                                                  ConstantFont.montserratBold,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                    new Container(
                        alignment: Alignment.bottomCenter, child: Body())
                  ]),
                ),
              ),
            )
          ],
        )),
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
