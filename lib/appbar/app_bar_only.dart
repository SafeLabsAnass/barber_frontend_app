import 'package:barber_app/constant/color_constant.dart';
import 'package:barber_app/constant/constant_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget appbar(
    BuildContext context, String title, dynamic otherData, bool appon) {
  final GlobalKey<ScaffoldState> _drawerscaffoldkey = otherData;

  return AppBar(
    backgroundColor: whiteColor,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    centerTitle: true,
    elevation: 0.0,
    iconTheme: new IconThemeData(color: blackColor),
    title: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: blackColor,
          fontFamily: ConstantFont.montserratBold,
          fontSize: 15,
          fontWeight: FontWeight.w600),
    ),
    leading: IconButton(
      onPressed: () {
        if (_drawerscaffoldkey.currentState!.isDrawerOpen) {
          Navigator.pop(context);
        } else {
          _drawerscaffoldkey.currentState!.openDrawer();
        }
      },
      icon: Icon(Icons.menu),
    ),
  );
}
