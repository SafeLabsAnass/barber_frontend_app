import 'package:barber_app/constant/color_constant.dart';
import 'package:barber_app/constant/dymmyimages.dart';
import 'package:flutter_svg/svg.dart';
import 'package:barber_app/screens/homescreen.dart';
import 'package:flutter/material.dart';

class CustomView extends StatefulWidget {
  const CustomView({Key? key}) : super(key: key);

  @override
  _CustomView createState() => _CustomView();
}

class _CustomView extends State<CustomView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          color: whiteColor,
          alignment: FractionalOffset.center,
          height: 45,
          padding: EdgeInsets.zero,
          child: Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomeScreen(0)));
                  },
                  child: Container(
                      // width: 15,
                      // height: 15,
                      child: new SvgPicture.asset(
                        DummyImage.homeWhite,
                        color: Colors.grey.shade700,
                        width: MediaQuery.of(context).size.aspectRatio * 37.5,
                      )),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomeScreen(1)));
                  },
                  child: Container(
                      // width: 15,
                      // height: 15,
                      child: new SvgPicture.asset(
                        DummyImage.calenderWhite,
                        color: Colors.grey.shade700,
                        width: MediaQuery.of(context).size.aspectRatio * 37.5,
                      )),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomeScreen(2)));
                  },
                  child: Container(
                      // width: 15,
                      // height: 15,
                      child: Icon(
                    Icons.notifications,
                    color: Colors.grey.shade700,
                    size: MediaQuery.of(context).size.aspectRatio * 50,
                  )),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomeScreen(3)));
                  },
                  child: Container(
                      width: 20,
                      height: 20,
                      child: new SvgPicture.asset(
                        DummyImage.profileWhite,
                        color: Colors.grey.shade700,
                        width: MediaQuery.of(context).size.aspectRatio * 37.5,
                      )),
                ),
              ),
            ],
          ),
        ));
  }
}
