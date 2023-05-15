import 'package:barber_app/constant/color_constant.dart';
import 'package:barber_app/constant/constant_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget appbar(
    BuildContext context, String title, dynamic otherData, bool appon,bool  isDrawerOpen, VoidCallback onOpen, VoidCallback onClose) {
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
              // leading:
                
                      
              //      _drawerscaffoldkey.currentState!.isDrawerOpen ? IconButton(
              //             icon: const Icon(Icons.arrow_back_ios,  color: Colors.black,),
              //             onPressed: onClose,   
              //             ): IconButton(
              //             icon: const Icon(Icons.menu,  color: Colors.black,),
              //             onPressed: onOpen,   
              //             ) 
                      
                    
                    
    // leading: IconButton(
    //   onPressed: () {
    //     if (_drawerscaffoldkey.currentState!.isDrawerOpen) {
    //     onClose();
    //     Navigator.pop(context);
        
    //     } else {
    //       onOpen();
    //      }
    //   },
    //   icon: Icon(Icons.menu),
    // ),
    leading:  isDrawerOpen? IconButton(
                        icon: const Icon(Icons.arrow_back_ios,  color: Colors.black,),
                         onPressed: onClose,   
                        ): IconButton(
                        icon: const Icon(Icons.menu,  color: Colors.black,),
                         onPressed: onOpen,   
                        ) ,

  );
}
