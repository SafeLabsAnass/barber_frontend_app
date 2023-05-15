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

  BottomBar(this.index);

  @override
  State<StatefulWidget> createState() {
    return BottomBar1();
  }
}

class BottomBar1 extends State<BottomBar> {
  ListQueue<int> _navigationQueue = ListQueue();
  int index = 0;
  bool? login = false;

  // late PageController _pageController;

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

    /*return new DefaultTabController(
      length: 4,
      initialIndex: widget.index,
      child: new Scaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            FgHome(),
            Appoinment(),
            Notification1(),
            Profile(),
          ],
        ),
        bottomNavigationBar: new TabBar(
          tabs: [
            Tab(
              icon: Container(
                  width: 20,
                  height: 20,
                  child: new SvgPicture.asset(DummyImage.homeWhite)),
            ),
            Tab(
              icon: GestureDetector(
                child: Container(
                    width: 20,
                    height: 20,
                    child: new SvgPicture.asset(DummyImage.calenderWhite)),
              ),
            ),
            Tab(
              icon: Container(
                width: 20,
                height: 20,
                child: Icon(Icons.notifications),
              ),
            ),
            Tab(
              icon: Container(
                  width: 20,
                  height: 20,
                  child: new SvgPicture.asset(DummyImage.profileWhite)),
            ),
          ],
          labelColor: whiteColor,
          unselectedLabelColor: whiteColor,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.all(0.0),
          indicatorColor: whiteColor,
          indicatorWeight: 3.0,
          indicator: MD2Indicator(
            indicatorSize: MD2IndicatorSize.full,
            indicatorHeight: 5.0,
            indicatorColor: whiteColor,
          ),
          onTap: (value) {
            _navigationQueue.addLast(index);
            setState(() => index = value);
            print(value);
          },
        ),
        backgroundColor: pinkColor,
      ),
    );*/
  }
}
