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
import 'package:barber_app/fragments/profile.dart';
import 'package:barber_app/main.dart';
import 'package:barber_app/network/Apiservice.dart';
import 'package:barber_app/network/BaseModel.dart';
import 'package:barber_app/network/Retro_Api.dart';
import 'package:barber_app/network/ServerError.dart';
import 'package:barber_app/screens/loginscreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
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

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;
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



  @override
  Widget build(BuildContext context) {
    PreferenceUtils.init();
    print("drawerName:$name");

    if (PreferenceUtils.getlogin(AppConstant.isLoggedIn) == true) {
      name = PreferenceUtils.getString(AppConstant.username);
    } else {
      name = "User";
    }
    return Material(
      child: SafeArea(
        child: Container(
            color: drawerColor,
            child: Column(
                
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Container(
                      padding: EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10),
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
                                    imageUrl: PreferenceUtils.getString(
                                        AppConstant.fullImage),
                                    imageBuilder: (context, imageProvider) =>
                                        ClipOval(
                                      child: Image(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        SpinKitFadingCircle(
                                      color: pinkColor,
                                      size: 5,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(DummyImage.noImage),
                                  ),
                                
                                Expanded(
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 12.0),
                                      child:   Text(
                                            name![0].toUpperCase() + name!.substring(1).toLowerCase(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: beigeColor,
                                                fontSize: 15,
                  
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Montserrat'),
                                          ),
                                      
                  
                                      //Text(
                                      //   'Hi, ' + name!,
                                      //   overflow: TextOverflow.ellipsis,
                                      //   maxLines: 1,
                                      //   style: TextStyle(
                                      //       color: beigeColor , fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Montserrat'),
                                      // ),
                                      ),
                                ),
                              ],
                            ),
                          ),
                          // IconButton(
                          //   onPressed: () {
                          //     Navigator.of(context).pop();
                          //   },
                          //   icon: Icon(
                          //     Icons.arrow_back_ios,
                          //     color: Colors.black,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                 
                  Column(
                    
                    
                    children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 20.0, top: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => new TopOffers(
                              -1,
                              null,
                              null,
                              null,
                              null,
                              null,
                              null,
                              null,
                              null,
                              null,
                              () => null,
                              () => null,
                              false,
                            ),
                          ));
                        },
                        child: Row(
                          children: [
                            Icon(Icons.card_giftcard_rounded, size: 25.0, color: beigeColor,),
                            SizedBox(width: 8.0), // Adjust the width as desired
                            Text(
                              StringConstant.topOffers,
                              style: TextStyle(
                                color: beigeColor ,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 20.0, top: 20.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => new TermsCondition(
                                    isDrawerOpen: false,
                                    onOpen: () => null,
                                    onClose: () => null)));
                          },
                          child: Row(
                            children: [
                              Icon(
                                //
                                Icons.list_alt_outlined,
                                size: 25.0,
                                 color: beigeColor 
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                StringConstant.termsAndConditions,
                                style: TextStyle(
                                    color: beigeColor ,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Montserrat'),
                              ),
                            ],
                          ),
                        )),
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 20.0, top: 20.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => new PrivacyPolicy(
                                    isDrawerOpen: false,
                                    onOpen: () => null,
                                    onClose: () => null)));
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.inventory_outlined,
                                size: 25.0,
                                color: beigeColor 
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                StringConstant.privacyAndPolicy,
                                style: TextStyle(
                                    color: beigeColor ,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Montserrat'),
                              ),
                            ],
                          ),
                        )),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 20.0, top: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.pop(context);
                          share();
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.group_add_outlined ,
                              size: 25.0,
                              color: beigeColor 

                      
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              StringConstant.inviteAFriends,
                              style: TextStyle(
                                  color: beigeColor ,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Montserrat'),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 20.0, top: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => new About(
                                  isDrawerOpen: false,
                                  onOpen: () => null,
                                  onClose: () => null)));
                        },
                        child: Row(children: [
                          Icon(
                            Icons.info_outline_rounded,
                            size: 25.0,
                            color: beigeColor 
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            StringConstant.about,
                            style: TextStyle(
                                color: beigeColor ,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Montserrat'),
                          ),
                        ]),
                      ),
                    ),
                    Visibility(
                      visible:
                          PreferenceUtils.getlogin(AppConstant.isLoggedIn) ==
                              true,
                      child: Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 20.0, top: 20.0),
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.of(context).pop();
                              showDeleteAccountDialog(context);
                              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => new About(isDrawerOpen: false,onOpen: ()=>null, onClose: ()=>null) ));
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete_outline,
                                  size: 25.0,
                                  color: beigeColor 
                                ),
                                SizedBox(width: 8.0),
                                Text(
                                  StringConstant.deleteAccount,
                                  style: TextStyle(
                                      color: beigeColor ,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Montserrat'),
                                ),
                              ],
                            ),
                          )),
                    )
                  ]),

                  Visibility(
                    visible: PreferenceUtils.getlogin(AppConstant.isLoggedIn) ==
                        true,
                    child: Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 20.0, top: 20.0, bottom:10.0),
                        child: GestureDetector(
                          onTap: () async {
                            showAlertDialog(context);
                          },
                          child: Row(children: [
                            Icon(
                              Icons.logout,
                              size: 25.0,
                              color: beigeColor 
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              StringConstant.logout,
                              style: TextStyle(
                                  color: beigeColor ,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Montserrat'),
                            ),
                          ]),
                        )),
                  ),
                ])),
      ),
    );
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
                    elevation: 0,
                    backgroundColor: beigeColor ,
                    side: BorderSide(color: grey99)),
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
        Navigator.of(NavigationService.navigatorKey.currentState!.context)
            .pushAndRemoveUntil(
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
