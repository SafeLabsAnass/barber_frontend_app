import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/preferenceutils.dart';
import 'package:barber_app/constant/toast_message.dart';
import 'package:barber_app/drawer/drawer_only.dart';
import 'package:barber_app/network/Apiservice.dart';
import 'package:barber_app/network/Retro_Api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:barber_app/bottombar.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new HomeScreen(1),
  ));
}

class HomeScreen extends StatefulWidget {
  final int index;
  HomeScreen(this.index);

  @override
  _HomeScreen createState() => new _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  String? name = "User";

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();

    PreferenceUtils.init();

    name = PreferenceUtils.getString(AppConstant.username);
    print("UserName:$name");

    if (PreferenceUtils.getlogin(AppConstant.isLoggedIn) == true) {
      callProfileApi();
      AppConstant.checkNetwork().whenComplete(() => callApiForBarberDetail());
    }
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent
    ));
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarBrightness: Brightness.dark));

    return new Scaffold(

      body: Stack(
        children:[ 
        DrawerOnly(),
        BottomBar(widget.index),
        ],
      ));
  }

  void callApiForBarberDetail() {
    RestClient(RetroApi().dioData()).salondetail().then((response) {
      setState(() {
        print(response.success);

        if (response.success = true) {
          print("detailResponse:${response.msg}");

          print(response.data!.category!.length);

          PreferenceUtils.setString(
              AppConstant.singlesalonName, response.data!.salon!.name!);
          PreferenceUtils.setString(
              AppConstant.salonAddress, response.data!.salon!.address!);
          PreferenceUtils.setString(
              AppConstant.salonRating, response.data!.salon!.rate.toString());
          PreferenceUtils.setString(AppConstant.salonImage,
              response.data!.salon!.imagePath! + response.data!.salon!.logo!);
        }
      });
    }).catchError((Object obj) {
      print("error:$obj");
      print(obj.runtimeType);
    });
  }

  void callProfileApi() {
    RestClient(RetroApi().dioData()).profile().then((response) {
      if (mounted) {
        setState(() {
          if (response.success = true) {
            name = response.data!.name;
            PreferenceUtils.setString(
                AppConstant.username, response.data!.name!);
          } else {
            ToastMessage.toastMessage("No Data");
          }
        });
      }
    }).catchError((Object obj) {
      print("error:$obj");
      print(obj.runtimeType);
    });
  }
}
