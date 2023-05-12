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
          color: pinkColor,
          alignment: FractionalOffset.center,
          height: 50,
          child: Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(0)));
                  },
                  child: Container(width: 20, height: 20, child: new SvgPicture.asset(DummyImage.homeWhite)),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(1)));
                  },
                  child: Container(width: 20, height: 20, child: new SvgPicture.asset(DummyImage.calenderWhite)),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(2)));
                  },
                  child: Container(
                      width: 20,
                      height: 20,
                      child: Icon(
                        Icons.notifications,
                        color: Colors.white,
                      )),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(3)));
                  },
                  child: Container(width: 20, height: 20, child: new SvgPicture.asset(DummyImage.profileWhite)),
                ),
              ),
            ],
          ),
        ));
  }
}
