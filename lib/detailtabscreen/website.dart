import 'package:barber_app/constant/color_constant.dart';
import 'package:barber_app/constant/dymmyimages.dart';
import 'package:barber_app/constant/string_constant.dart';
import 'package:flutter/material.dart';
class WebSite extends StatefulWidget {
  @override
  _WebSite createState() => new _WebSite();
}

class _WebSite extends State<WebSite> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor:whiteColor,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: blackColor,
              size: 30,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            StringConstant.barberQue,
            style: TextStyle(color: blackColor),
          ),
          centerTitle: true,
          backgroundColor: whiteColor,
          elevation: 0.0,
        ),
        body: Center(
          child: Container(
            child: Image(
              image: AssetImage(DummyImage.webView),
            ),
          ),
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(


          ),
    );
  }
}
