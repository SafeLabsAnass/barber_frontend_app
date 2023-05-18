import 'dart:collection';

import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/color_constant.dart';
import 'package:barber_app/constant/preferenceutils.dart';
import 'package:barber_app/fragments/appoinment.dart';
import 'package:barber_app/fragments/fghome.dart';
import 'package:barber_app/fragments/notification.dart';
import 'package:barber_app/fragments/profile.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_ccc/persistent-tab-view.dart';

class BottomBar extends StatefulWidget {
  final int index;
  final int savePrevIndex = 2;
 

  BottomBar(this.index, );
    

  @override
  State<StatefulWidget> createState() {
    return BottomBar1();
  }
}

class BottomBar1 extends State<BottomBar> {
  ListQueue<int> _navigationQueue = ListQueue();
  int index = 0;
  bool? login = false;

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;

 
  @override
  Widget build(BuildContext context) {


  login = PreferenceUtils.getlogin(AppConstant.isLoggedIn);


    void onOpen(){
    setState(() {
      xOffset=220;
      yOffset=130;
      scaleFactor=0.7;
      isDrawerOpen=true;
    });
    }

   void onClose(){
    setState(() {
      xOffset=0;
      yOffset=0;
      scaleFactor=1;
      isDrawerOpen=false;
    });
   }

    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)..scale(scaleFactor),
      duration: const Duration(milliseconds: 400) ,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isDrawerOpen? 30.0 : 0.0),
        child: Stack(
          children: [
            PersistentTabView(
            context,
            backgroundColor: whiteColor,
            screens: [
              FgHome(isDrawerOpen: isDrawerOpen, onClose: onClose, onOpen: onOpen,),
              Appoinment(isDrawerOpen: isDrawerOpen, onClose: onClose, onOpen: onOpen,),
              Notification1(isDrawerOpen: isDrawerOpen, onClose: onClose, onOpen: onOpen,),
              Profile(isDrawerOpen: isDrawerOpen, onClose: onClose, onOpen: onOpen,),
            ],
            hideNavigationBarWhenKeyboardShows: true,
            handleAndroidBackButtonPress: true,
             stateManagement: false,
            navBarHeight: 70,
            padding: NavBarPadding.only(left: 1, right: 1),
             confineInSafeArea: false,
            resizeToAvoidBottomInset: false,
            items: [
              PersistentBottomNavBarItem(
                icon: Icon(Icons.home),
                title: "Home",
                activeColorPrimary: pinkColor,
                inactiveColorPrimary: Colors.grey.shade700,
                iconSize: 20,
              ),
              PersistentBottomNavBarItem(
                icon: Icon(Icons.calendar_today),
                title: "Schedule",
                activeColorPrimary: pinkColor,
                inactiveColorPrimary: Colors.grey.shade700,
                iconSize: 20,
              ),
              PersistentBottomNavBarItem(
                icon: Icon(Icons.notifications),
                title: "Notification",
                activeColorPrimary: pinkColor,
                inactiveColorPrimary: Colors.grey.shade700,
                iconSize: 20,
              ),
              PersistentBottomNavBarItem(
                icon: Icon(Icons.person),
                title: "Profile",
                activeColorPrimary: pinkColor,
                inactiveColorPrimary: Colors.grey.shade700,
                iconSize: 20,
              ),
            ],
          ),
           if (isDrawerOpen)
      GestureDetector(
        onTap: () {
          // Toggle the value of isDrawerOpen when the container is tapped
          onClose(); // Assuming this function updates the value of isDrawerOpen to false
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.transparent,
        ),
      ),
          ],
        ),
      ),
    );
  }
}
 