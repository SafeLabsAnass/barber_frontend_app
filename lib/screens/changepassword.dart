import 'package:barber_app/constant/color_constant.dart';
import 'package:barber_app/constant/dymmyimages.dart';
import 'package:barber_app/constant/string_constant.dart';
import 'package:barber_app/constant/toast_message.dart';
import 'package:flutter/material.dart';

import 'changepassworddone.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePassword createState() => new _ChangePassword();
}

String?  _email, _password = "";
final _formKey = GlobalKey<FormState>();

FocusNode _newpassword = FocusNode();
FocusNode _confirmPassword = FocusNode();

class _ChangePassword extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor:whiteColor ,
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
            StringConstant.changePassword,
            style: TextStyle(
                color: blackColor,
                fontFamily: 'Montserrat',
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          backgroundColor: whiteColor,
          elevation: 0.0,
        ),
        body: Form(
          key: _formKey,
          child: Stack(
            children: <Widget>[
              ListView(
                children: [
                  Container(
                    child: Container(
                      margin: const EdgeInsets.only(top: 50.0, left: 0.0),
                      alignment: FractionalOffset.center,
                      child: Image.asset(
                        DummyImage.changePassword,
                        width: 100,
                        height: 100,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 70.0, left: 0.0),
                      alignment: FractionalOffset.center,
                      child: Text(
                        StringConstant.setNewPassword,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: blackColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat'),
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 5.0, left: 0.0),
                      alignment: FractionalOffset.center,
                      child: Text(
                        StringConstant.setNewPasswordAndForgotOldOne,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Montserrat'),
                      )),
                  Container(
                    margin: const EdgeInsets.only(top: 50.0, left: 40.0),
                    alignment: FractionalOffset.topLeft,
                    child: Text(
                      StringConstant.newPassword,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color:  grey99,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                  Container(
                    alignment: FractionalOffset.topLeft,
                    margin: const EdgeInsets.only(
                        top: 5.0, left: 30.0, right: 30.0),
                    child: TextFormField(
                      obscureText: true,
                      autofocus: false,
                      validator: (password) {
                        Pattern pattern =
                            r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
                        RegExp regex = new RegExp(pattern as String);
                        if (!regex.hasMatch(password!))
                          return 'Invalid password';
                        else
                          return null;
                      },
                      onFieldSubmitted: (_) {
                        fieldFocusChange(
                            context, _newpassword, _confirmPassword);
                      },
                      onSaved: (password) => _password = password,
                      style: TextStyle(
                          fontSize: 14.0,
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat'),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: whiteF1,
                        hintText: 'New Password',
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: whiteF1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: whiteF1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10.0, left: 40.0),
                    alignment: FractionalOffset.topLeft,
                    child: Text(
                      StringConstant.confirmPassword,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color:  grey99,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                  Container(
                    alignment: FractionalOffset.topLeft,
                    margin: const EdgeInsets.only(
                        top: 5.0, left: 30.0, right: 30.0),
                    child: TextFormField(
                      obscureText: true,
                      focusNode: _confirmPassword,
                      validator: (password) {
                        Pattern pattern =
                            r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
                        RegExp regex = new RegExp(pattern as String);
                        if (!regex.hasMatch(password!))
                          return 'Invalid password';
                        else
                          return null;
                      },
                      style: TextStyle(
                          fontSize: 14.0,
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat'),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: whiteF1,
                        hintText: 'Confirm Password',
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: whiteF1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: whiteF1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      alignment: FractionalOffset.center,
                      child: MaterialButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0)),
                        minWidth: 300,
                        height: 40,
                        color: pinkColor,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            ToastMessage.toastMessage(
                                "Email: $_email\nPassword: $_password");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangePasswordDone()),
                            );
                          }
                        },
                        child: Text(
                         StringConstant.changePassword,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
