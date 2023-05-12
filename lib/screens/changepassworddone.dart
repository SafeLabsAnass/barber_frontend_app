import 'package:barber_app/constant/color_constant.dart';
import 'package:barber_app/constant/dymmyimages.dart';
import 'package:barber_app/constant/string_constant.dart';
import 'package:flutter/material.dart';

import 'loginscreen.dart';

class ChangePasswordDone extends StatefulWidget {
  @override
  _ChangePasswordDone createState() => new _ChangePasswordDone();
}

class _ChangePasswordDone extends State<ChangePasswordDone> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: whiteColor,
      body: Container(
        child: Stack(
          children: <Widget>[
            ListView(
              children: [
                Container(
                  child: Container(
                    margin: const EdgeInsets.only(top: 200.0, left: 0.0),
                    alignment: FractionalOffset.center,
                    child: Image.asset(
                      DummyImage.changePasswordDone,
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 100.0, left: 0.0),
                    alignment: FractionalOffset.center,
                    child: Text(
                      StringConstant.congratulation,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: blackColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Montserrat'),
                    )),
                Container(
                    margin: const EdgeInsets.only(top: 5.0, left: 0.0),
                    alignment: FractionalOffset.center,
                    child: Text(
                      StringConstant.yourPasswordHasBeenChangedSucessFully,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: blackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat'),
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 15.0, left: 5.0),
                  alignment: FractionalOffset.center,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => LoginScreen(2)),
                        );
                      },
                      child: Text(
                        StringConstant.goToLogin,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color:  blue4a,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat'),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
