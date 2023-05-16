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

  BottomBar(this.index);

  @override
  State<StatefulWidget> createState() {
    return BottomBar1();
  }
}

class BottomBar1 extends State<BottomBar> {
  int index = 0;
  bool? login = false;

  @override
  Widget build(BuildContext context) {
    login = PreferenceUtils.getlogin(AppConstant.isLoggedIn);

    return PersistentTabView(
      context,
      backgroundColor: whiteColor,
      screens: [
        FgHome(),
        Appoinment(),
        Notification1(),
        Profile(),
      ],
      hideNavigationBarWhenKeyboardShows: true,
      handleAndroidBackButtonPress: true,
      stateManagement: true,
      navBarHeight: 60,
      confineInSafeArea: true,
      resizeToAvoidBottomInset: true,
      items: [
        PersistentBottomNavBarItem(
          // icon: SvgPicture.asset(DummyImage.homeWhite),
          icon: Icon(Icons.home),
          title: "Home",
          activeColorPrimary: pinkColor,
          inactiveColorPrimary: Colors.grey.shade700,
          iconSize: 20,
        ),
        PersistentBottomNavBarItem(
          // icon: SvgPicture.asset(DummyImage.calenderWhite),
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
          // icon: SvgPicture.asset(DummyImage.profile),
          icon: Icon(Icons.person),
          title: "Profile",
          activeColorPrimary: pinkColor,
          inactiveColorPrimary: Colors.grey.shade700,
          iconSize: 20,
        ),
      ],
    );
  }
}
