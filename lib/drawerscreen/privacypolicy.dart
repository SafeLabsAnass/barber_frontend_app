import 'package:barber_app/appbar/app_bar_only.dart';
import 'package:barber_app/common/common_view.dart';
import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/color_constant.dart';
import 'package:barber_app/constant/constant_font.dart';
import 'package:barber_app/constant/dymmyimages.dart';
import 'package:barber_app/constant/preferenceutils.dart';
import 'package:barber_app/constant/string_constant.dart';
import 'package:barber_app/constant/toast_message.dart';
import 'package:barber_app/drawer/drawer_only.dart';
import 'package:barber_app/network/Apiservice.dart';
import 'package:barber_app/network/Retro_Api.dart';
import 'package:barber_app/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class PrivacyPolicy extends StatefulWidget {
  PrivacyPolicy({Key? key, isDrawerOpen,required this.onOpen, required this.onClose}) :
  isDrawerOpen = isDrawerOpen, super(key: key);

  final bool isDrawerOpen;
    final VoidCallback onOpen;
  final VoidCallback onClose;
  @override
  _PrivacyPolicy createState() => new _PrivacyPolicy();
}

class _PrivacyPolicy extends State<PrivacyPolicy> {
  bool dataVisible = false;
  bool noDataVisible = true;
  bool _loading = false;
  String? privacyData = '';
  String name = "User";

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
          PreferenceUtils.setString(AppConstant.currencySymbol, response.data!.currencySymbol!);
          if(response.data!.privacyPolicy==null)
            {
              noDataVisible=true;
              dataVisible=false;
            }
          else
            {dataVisible=true;
            noDataVisible=false;
              privacyData = response.data!.privacyPolicy;
            }
          PreferenceUtils.setString(appId, response.data!.appId!.isNotEmpty?response.data!.appId!:"");
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
        progressIndicator:
            SpinKitFadingCircle(color: pinkColor),
        child: new SafeArea(
          child: Scaffold(
            backgroundColor: whiteColor,
            appBar: appbar(context, StringConstant.privacyPolicy, _drawerScaffoldKey, false,widget.isDrawerOpen, widget.onOpen, widget.onClose)
                as PreferredSizeWidget?,
            body: Scaffold(
              backgroundColor:whiteColor,
              resizeToAvoidBottomInset: true,
              key: _drawerScaffoldKey,
              drawer: new DrawerOnly(),
              body: new Stack(children: <Widget>[
                Visibility(
                  visible: dataVisible,
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 60),
                    child: new SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Html(
                        data: privacyData,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: noDataVisible,
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 60),
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
                new Container(alignment: Alignment.bottomCenter, child: Body())
              ]),
            ),
          ),
        ),
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
