import 'package:barber_app/ResponseModel/DeleteAccountResponse.dart';
import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/color_constant.dart';
import 'package:barber_app/constant/dymmyimages.dart';
import 'package:barber_app/constant/preferenceutils.dart';
import 'package:barber_app/constant/string_constant.dart';
import 'package:barber_app/constant/toast_message.dart';
import 'package:barber_app/constant/transaction.dart';
import 'package:barber_app/drawerscreen/about.dart';
import 'package:barber_app/drawerscreen/privacypolicy.dart';
import 'package:barber_app/drawerscreen/tems_condition.dart';
import 'package:barber_app/drawerscreen/top_offers.dart';
import 'package:barber_app/main.dart';
import 'package:barber_app/network/Apiservice.dart';
import 'package:barber_app/network/BaseModel.dart';
import 'package:barber_app/network/Retro_Api.dart';
import 'package:barber_app/network/ServerError.dart';
import 'package:barber_app/screens/loginscreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: must_be_immutable
class DrawerOnly extends StatefulWidget {
  @override
  State<DrawerOnly> createState() => _DrawerOnlyState();
}

class _DrawerOnlyState extends State<DrawerOnly> {
  late String? name = "User";

  @override
  Widget build(BuildContext context) {
    PreferenceUtils.init();
    print("drawerName:$name");

    if (PreferenceUtils.getlogin(AppConstant.isLoggedIn) == true) {
      name = PreferenceUtils.getString(AppConstant.username);
    } else {
      name = "User";
    }
    return new Drawer(
        child: ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10),
          alignment: Alignment.center,
          height: 80,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    CachedNetworkImage(
                      height: 60,
                      width: 60,
                      imageUrl: PreferenceUtils.getString(AppConstant.fullImage),
                      imageBuilder: (context, imageProvider) => ClipOval(
                        child: Image(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                      placeholder: (context, url) => SpinKitFadingCircle(
                        color: pinkColor,
                        size: 5,
                      ),
                      errorWidget: (context, url, error) => Image.asset(DummyImage.noImage),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Hi, ' + name!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              color: blackColor, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Container(
            height: 0,
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
            child: DottedLine(
              direction: Axis.horizontal,
              lineLength: double.infinity,
              lineThickness: 1.0,
              dashLength: 5.0,
              dashColor: blackColor,
              dashRadius: 0.0,
              dashGapLength: 8.0,
              dashGapColor: Colors.transparent,
              dashGapRadius: 0.0,
            )),
        Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 20.0, top: 10.0),
            child: ListTile(
              title: Text(
                StringConstant.topOffers,
                style:
                    TextStyle(color: blackColor, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Montserrat'),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => new TopOffers(-1, null, null, null, null, null, null, null, null, null)));
              },
            )),
        Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 20.0, top: 0.0),
            child: ListTile(
              title: Text(
                StringConstant.termsAndConditions,
                style:
                    TextStyle(color: blackColor, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Montserrat'),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => new TermsCondition()));
              },
            )),
        Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 20.0, top: 0.0),
            child: ListTile(
              title: Text(
                StringConstant.privacyAndPolicy,
                style:
                    TextStyle(color: blackColor, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Montserrat'),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => new PrivacyPolicy()));
              },
            )),
        Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 20.0, top: 0.0),
            child: ListTile(
              title: Text(
                StringConstant.inviteAFriends,
                style:
                    TextStyle(color: blackColor, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Montserrat'),
              ),
              onTap: () {
                Navigator.pop(context);
                share();
              },
            )),
        Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 20.0, top: 0.0),
            child: ListTile(
              title: Text(
                StringConstant.about,
                style:
                    TextStyle(color: blackColor, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Montserrat'),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => new About()));
              },
            )),
        Visibility(
          visible: PreferenceUtils.getlogin(AppConstant.isLoggedIn) == true,
          child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20.0, top: 0.0),
              child: ListTile(
                title: Text(
                  StringConstant.deleteAccount,
                  style:
                      TextStyle(color: blackColor, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Montserrat'),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  showDeleteAccountDialog(context);
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => new About()));
                },
              )),
        ),
        Visibility(
          visible: PreferenceUtils.getlogin(AppConstant.isLoggedIn) == true,
          child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20.0, top: 0.0),
              child: ListTile(
                title: Text(
                  StringConstant.logout,
                  style:
                      TextStyle(color: blackColor, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Montserrat'),
                ),
                onTap: () async {
                  showAlertDialog(context);
                },
              )),
        ),
      ],
    ));
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text(
        StringConstant.cancel,
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget okButton = TextButton(
      child: Text(
        StringConstant.logout,
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () {
        PreferenceUtils.remove(AppConstant.username);
        PreferenceUtils.remove(AppConstant.userid);
        PreferenceUtils.remove(AppConstant.fcmtoken);
        PreferenceUtils.remove(AppConstant.headertoken);
        PreferenceUtils.remove(AppConstant.useremail);
        PreferenceUtils.remove(AppConstant.userphone);
        PreferenceUtils.remove(AppConstant.userotp);
        PreferenceUtils.remove(AppConstant.userphonecode);
        PreferenceUtils.remove(AppConstant.userimage);
        PreferenceUtils.remove(AppConstant.imagePath);
        PreferenceUtils.remove(AppConstant.isLoggedIn);
        PreferenceUtils.remove(AppConstant.stripekey);
        PreferenceUtils.remove(AppConstant.rozarkey);
        PreferenceUtils.remove(AppConstant.fullImage);
        PreferenceUtils.remove(AppConstant.appId);
        PreferenceUtils.remove(AppConstant.singlesalonName);
        PreferenceUtils.remove(AppConstant.salonAddress);
        PreferenceUtils.remove(AppConstant.salonRating);
        PreferenceUtils.remove(AppConstant.salonImage);
        PreferenceUtils.remove(AppConstant.salonName);
        PreferenceUtils.remove(AppConstant.role);
        PreferenceUtils.remove(AppConstant.sharedName);
        PreferenceUtils.remove(AppConstant.sharedUrl);
        PreferenceUtils.remove(AppConstant.sharedImage);
        PreferenceUtils.setlogin(AppConstant.isLoggedIn, false);
        Navigator.of(context).pushAndRemoveUntil(
            Transitions(
                transitionType: TransitionType.slideUp,
                curve: Curves.bounceInOut,
                reverseCurve: Curves.fastLinearToSlowEaseIn,
                widget: LoginScreen(0)),
            (route) => false);
      },
    );

    AlertDialog alert = AlertDialog(
      content: Text(StringConstant.areYouWantToSureLogoutYourAccount),
      actions: [cancelButton, okButton],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showDeleteAccountDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(StringConstant.deleteAccount),
            content: Text("You will not able to access data anymore."),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  StringConstant.cancel,
                  style: TextStyle(color: grey99),
                ),
                style: ElevatedButton.styleFrom(
                    elevation: 0, backgroundColor: whiteColor, side: BorderSide(color: grey99)),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  deleteAccountCall();
                },
                child: Text(StringConstant.delete),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: pinkColor,
                ),
              ),
            ],
          );
        });
  }

  Future<void> share() async {
    await FlutterShare.share(
      text: PreferenceUtils.getString(AppConstant.sharedName) +
          "\n" +
          PreferenceUtils.getString(AppConstant.sharedImage) +
          "\n" +
          PreferenceUtils.getString(AppConstant.sharedUrl),
      title: PreferenceUtils.getString(AppConstant.sharedName),
      chooserTitle: PreferenceUtils.getString(AppConstant.sharedName),
    );
  }

  Future<BaseModel<DeleteAccountResponse>> deleteAccountCall() async {
    DeleteAccountResponse response;
    try {
      response = await RestClient(RetroApi().dioData()).deleteAccount();
      if (response.success == true) {
        if (response.message != null) {
          ToastMessage.toastMessage(response.message!);
        }

        PreferenceUtils.remove(AppConstant.username);
        PreferenceUtils.remove(AppConstant.userid);
        PreferenceUtils.remove(AppConstant.fcmtoken);
        PreferenceUtils.remove(AppConstant.headertoken);
        PreferenceUtils.remove(AppConstant.useremail);
        PreferenceUtils.remove(AppConstant.userphone);
        PreferenceUtils.remove(AppConstant.userotp);
        PreferenceUtils.remove(AppConstant.userphonecode);
        PreferenceUtils.remove(AppConstant.userimage);
        PreferenceUtils.remove(AppConstant.imagePath);
        PreferenceUtils.remove(AppConstant.isLoggedIn);
        PreferenceUtils.remove(AppConstant.stripekey);
        PreferenceUtils.remove(AppConstant.rozarkey);
        PreferenceUtils.remove(AppConstant.fullImage);
        PreferenceUtils.remove(AppConstant.appId);
        PreferenceUtils.remove(AppConstant.singlesalonName);
        PreferenceUtils.remove(AppConstant.salonAddress);
        PreferenceUtils.remove(AppConstant.salonRating);
        PreferenceUtils.remove(AppConstant.salonImage);
        PreferenceUtils.remove(AppConstant.salonName);
        PreferenceUtils.remove(AppConstant.role);
        PreferenceUtils.remove(AppConstant.sharedName);
        PreferenceUtils.remove(AppConstant.sharedUrl);
        PreferenceUtils.remove(AppConstant.sharedImage);
        PreferenceUtils.setlogin(AppConstant.isLoggedIn, false);
        Navigator.of(NavigationService.navigatorKey.currentState!.context).pushAndRemoveUntil(
            Transitions(
                transitionType: TransitionType.slideUp,
                curve: Curves.bounceInOut,
                reverseCurve: Curves.fastLinearToSlowEaseIn,
                widget: LoginScreen(0)),
            (route) => false);
      } else {
        if (response.message != null) {
          ToastMessage.toastMessage(response.message!);
        }
      }
    } catch (error) {
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data;
  }
}
