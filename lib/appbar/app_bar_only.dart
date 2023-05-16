import 'package:barber_app/constant/color_constant.dart';
import 'package:barber_app/constant/constant_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget appbar(
  BuildContext context,
  String title,
  dynamic otherData,
  bool appon,
  bool isDrawerOpen,
  VoidCallback onOpen,
  VoidCallback onClose,
   {bool drawer = false} 
) {
 

  return AppBar(
    backgroundColor: whiteColor,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    centerTitle: true,
    elevation: 0.0,
    iconTheme: IconThemeData(color: blackColor),
    title: drawer
        ? Text(
            'Cindyyyy Beauty',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: blackColor,
              fontFamily: ConstantFont.montserratBold,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          )
        : Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: blackColor,
              fontFamily: ConstantFont.montserratBold,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
    leading: drawer
        ? IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),

          )
        : (isDrawerOpen
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: onClose,
              )
            : IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: onOpen,
              )),
  );
}
