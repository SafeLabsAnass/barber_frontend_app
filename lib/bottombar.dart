import 'dart:collection';

import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/dymmyimages.dart';
import 'package:barber_app/constant/preferenceutils.dart';
import 'package:barber_app/fragments/appoinment.dart';
import 'package:barber_app/fragments/fghome.dart';
import 'package:barber_app/fragments/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'common/inndicator.dart';
import 'constant/color_constant.dart';
import 'fragments/profile.dart';

class BottomBar extends StatefulWidget {

 final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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

    return  AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)..scale(scaleFactor),
      duration: const Duration(milliseconds: 400) ,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isDrawerOpen? 30: 0.0),
        child: DefaultTabController(
          length: 4,
          initialIndex: widget.index,
          child: new Scaffold(
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                FgHome(onOpen: onOpen, onClose:onClose,isDrawerOpen: isDrawerOpen),
                Appoinment(onOpen: onOpen, onClose:onClose, isDrawerOpen: isDrawerOpen,),
               Notification1(onOpen: onOpen, onClose:onClose ,isDrawerOpen: isDrawerOpen,),
                Profile(onOpen: onOpen, onClose:onClose, isDrawerOpen: isDrawerOpen, ),
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
            backgroundColor:pinkColor,
          ),
        ),
      ),
    );
  }
}
 