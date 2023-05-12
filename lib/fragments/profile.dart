import 'dart:async';
import 'package:barber_app/ResponseModel/appointmentResponse.dart';
import 'package:barber_app/ResponseModel/showprofileResponse.dart';
import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/color_constant.dart';
import 'package:barber_app/constant/constant_font.dart';
import 'package:barber_app/constant/dymmyimages.dart';
import 'package:barber_app/constant/preferenceutils.dart';
import 'package:barber_app/constant/string_constant.dart';
import 'package:barber_app/constant/toast_message.dart';
import 'package:barber_app/network/Apiservice.dart';
import 'package:barber_app/network/Retro_Api.dart';
import 'package:barber_app/screens/homescreen.dart';
import 'package:barber_app/screens/loginscreen.dart';
import 'package:barber_app/screens/single_appoitment_screen.dart';
import 'package:barber_app/separator/separator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:barber_app/appbar/app_bar_only.dart';
import 'package:barber_app/drawer/drawer_only.dart';
import 'package:barber_app/fragments/editprofile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Profile extends StatefulWidget {
  @override
  _Profile createState() => new _Profile();
}

class _Profile extends State<Profile> {
  ShowProfileData? showProfile = new ShowProfileData();

  int index = 0;
  var day;
  var salonTime;

  String? profileName = "";
  String name = "User";
  String? imageUrl;

  List<Completed> completedDataList = <Completed>[];
  List<Cancel> cancelDataList = <Cancel>[];
  List<UpcomingOrder> upcomingOrderDataList = <UpcomingOrder>[];
  List<Services> serviceList = <Services>[];
  bool noCompleteDataVisible = false;
  bool completeListVisible = false;
  bool _loading = false;

  List<String?> upcomingServiceList = <String?>[];
  List<String> cancelServiceList = <String>[];
  List<String?> completedServiceList = <String?>[];

  FocusNode _oldPasswordFocusNode = FocusNode();
  FocusNode _newpasswordFocusNode = FocusNode();
  FocusNode _confirmPasswordFocusNode = FocusNode();

  String? oldPasswordString, newpassword, confirmPasswordString = "";

  TextEditingController _textEditingControllerOldPassword = new TextEditingController();
  TextEditingController _textEditingControllerNewPassword = new TextEditingController();
  TextEditingController _textEditingControllerConfPassword = new TextEditingController();

  String? kValidatePassword(String? value) {
    Pattern pattern = r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regex = new RegExp(pattern as String);
    if (value!.length == 0) {
      return 'Password is Required';
    } else if (!regex.hasMatch(value))
      return 'Password required: Alphabet, Number & 8 chars';
    else
      return null;
  }

  String? kValidatePasswordConfirm(String? value) {
    Pattern pattern = r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regex = new RegExp(pattern as String);
    if (value!.length == 0) {
      return 'Password is Required';
    } else if (!regex.hasMatch(value))
      return 'Confirm Password required: Alphabet, Number & 8 chars';
    else
      return null;
  }

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    PreferenceUtils.init();

    if (mounted) {
      setState(() {
        print("Login Status:${PreferenceUtils.getlogin(AppConstant.isLoggedIn)}");

        if (PreferenceUtils.getlogin(AppConstant.isLoggedIn) == true) {
          AppConstant.checkNetwork().whenComplete(() => callApiForGetProfile());
          AppConstant.checkNetwork().whenComplete(() => callApiForAppointment());
        } else {
          Future.delayed(
            Duration(seconds: 0),
            () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(3))),
          );
        }
      });
    }
  }

  Future<void> _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 500));
    if (mounted) {
      setState(() {
        print("Login Status:${PreferenceUtils.getlogin(AppConstant.isLoggedIn)}");

        if (PreferenceUtils.getlogin(AppConstant.isLoggedIn) == true) {
          AppConstant.checkNetwork().whenComplete(() => callApiForGetProfile());
          AppConstant.checkNetwork().whenComplete(() => callApiForAppointment());
        } else {
          Future.delayed(
            Duration(seconds: 0),
            () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(3))),
          );
        }
      });
    }
  }

  void callApiForGetProfile() {
    var appToken = PreferenceUtils.getString(AppConstant.headertoken);
    print("AppToken:$appToken");

    setState(() {
      _loading = true;
    });
    RestClient(RetroApi().dioData()).profile().then((response) {
      if (mounted) {
        setState(() {
          _loading = false;
          if (response.success = true) {
            showProfile = response.data;

            PreferenceUtils.setString(AppConstant.username, response.data!.name!);
            PreferenceUtils.setString(AppConstant.fullImage, response.data!.imagePath! + response.data!.image!);

            profileName = showProfile!.name;
            imageUrl = showProfile!.imagePath! + showProfile!.image!;
            print("Profile Image:$imageUrl");
          } else {
            ToastMessage.toastMessage("No Data");
          }
        });
      }
    }).catchError((Object obj) {
      setState(() {
        _loading = false;
      });
      print("error:$obj");
      print(obj.runtimeType);
      ToastMessage.toastMessage("Internal Server Error__123");
    });
  }

  void callApiForAppointment() {
    setState(() {
      _loading = true;
    });
    completedDataList.clear();
    upcomingOrderDataList.clear();
    RestClient(RetroApi().dioData()).appointment().then((response) {
      if (mounted) {
        setState(() {
          _loading = false;

          if (response.success = true) {
            upcomingOrderDataList.clear();
            cancelDataList.clear();
            completedDataList.clear();

            print(response.data!.upcomingOrder!.length);
            print(response.data!.completed!.length);
            if (response.data!.upcomingOrder!.isNotEmpty) {
              upcomingOrderDataList.addAll(response.data!.upcomingOrder!);
            } else {}

            if (response.data!.completed!.isNotEmpty) {
              completedDataList.addAll(response.data!.completed!);
              completeListVisible = true;
              noCompleteDataVisible = false;
            } else {
              completeListVisible = false;
              noCompleteDataVisible = true;
            }
          } else {
            ToastMessage.toastMessage("No Data");
          }
        });
      }
    }).catchError((Object obj) {
      setState(() {
        _loading = false;
      });
      print("error:$obj");
      print(obj.runtimeType);
      ToastMessage.toastMessage("Internal Server Error_ _456");
    });
  }

  void callApiForCancelBooking(int id) {
    setState(() {
      _loading = true;
    });
    RestClient(RetroApi().dioData()).removeappointment(id).then((response) {
      setState(() {
        _loading = false;
        if (response.success = true) {
          ToastMessage.toastMessage(response.msg!);

          AppConstant.checkNetwork().whenComplete(() => callApiForAppointment());
        } else {
          ToastMessage.toastMessage("No Data");
        }
      });
    }).catchError((Object obj) {
      setState(() {
        _loading = false;
      });
      print("error:$obj");
      print(obj.runtimeType);
    });
  }

  void callApiForChangePassword(String? oldPassword, String? newpassword, String? confirmPassword) {
    Map<String, String> body = {
      "oldPassword": oldPassword!,
      "new_Password": newpassword!,
      "confirm": confirmPassword!,
    };
    setState(() {
      _loading = true;
    });
    RestClient(RetroApi().dioData()).changepassword(body).then((response) {
      setState(() {
        _loading = false;
        if (response.success = true) {
          _textEditingControllerOldPassword.clear();
          _textEditingControllerNewPassword.clear();
          _textEditingControllerConfPassword.clear();
          ToastMessage.toastMessage("Password Change Successfully");
        } else {
          ToastMessage.toastMessage(response.msg!);
        }
      });
    }).catchError((Object obj) {
      setState(() {
        _loading = false;
      });
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response!;

          var responseCode = res.statusCode;
          var msg = res.statusMessage;

          if (responseCode == 401) {
            ToastMessage.toastMessage("Invalid Data");
            print(responseCode);
            print(res.statusMessage);
          } else if (responseCode == 422) {
            ToastMessage.toastMessage("The new  password must be at least 8 characters.");
            print("code:$responseCode");
            print("msg:$msg");
          }
          break;
        default:
      }
    });
  }

  final _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _drawerScaffoldKey = new GlobalKey<ScaffoldState>();
  final picker = ImagePicker();
  bool oldPassword = true;
  bool newPassword = true;
  bool confirmPassword = true;
  @override
  Widget build(BuildContext context) {
    dynamic screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: ModalProgressHUD(
        inAsyncCall: _loading,
        opacity: 1.0,
        color: Colors.transparent.withOpacity(0.2),
        progressIndicator: SpinKitFadingCircle(color: pinkColor),
        child: new SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            key: _drawerScaffoldKey,
            backgroundColor: whiteColor,
            appBar: appbar(context, StringConstant.profile, _drawerScaffoldKey, false) as PreferredSizeWidget?,
            drawer: new DrawerOnly(),
            body: Form(
              key: _formKey,
              child: new Stack(children: <Widget>[
                RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: ListView(
                    physics: AlwaysScrollableScrollPhysics(),
                    children: [
                      Column(
                        children: <Widget>[
                          ///profile image,user name, edit profile icon
                          Container(
                            margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: whiteF1, width: 2),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: imageUrl == null
                                          ? Image.asset(DummyImage.noImage)
                                          : CachedNetworkImage(
                                              imageUrl: imageUrl!,
                                              width: 60,
                                              height: 60,
                                              fit: BoxFit.fill,
                                              imageBuilder: (context, imageProvider) => ClipOval(
                                                child: Image(
                                                  image: imageProvider,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              placeholder: (context, url) => SpinKitFadingCircle(color: pinkColor),
                                              errorWidget: (context, url, error) => Image.asset(DummyImage.noImage),
                                            ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Text(
                                        profileName!,
                                        style: TextStyle(
                                            color: blackColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            fontFamily: ConstantFont.montserratBold),
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        new MaterialPageRoute(builder: (context) => new EditProfile(showProfile)));
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(right: 15),
                                      child: SvgPicture.asset(
                                        DummyImage.edit,
                                        width: 30,
                                        height: 30,
                                      )),
                                ),
                              ],
                            ),
                          ),

                          ///change password keyword
                          Container(
                            margin: EdgeInsets.only(left: 20, top: 15),
                            alignment: Alignment.topLeft,
                            child: Text(
                              StringConstant.changePassword,
                              style: TextStyle(
                                  color: blackColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  fontFamily: ConstantFont.montserratBold),
                            ),
                          ),

                          ///old password keyword
                          Container(
                            margin: EdgeInsets.only(left: 25, top: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              StringConstant.oldPassword,
                              style: TextStyle(
                                  color: grey99,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  fontFamily: ConstantFont.montserratMedium),
                            ),
                          ),

                          ///old password text field
                          Container(
                            height: 45,
                            margin: EdgeInsets.only(left: 20, top: 5, right: 20),
                            child: TextFormField(
                              autofocus: false,
                              obscureText: oldPassword,
                              focusNode: _oldPasswordFocusNode,
                              textInputAction: TextInputAction.next,
                              controller: _textEditingControllerOldPassword,
                              validator: (name) {
                                Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                                RegExp regex = new RegExp(pattern as String);
                                if (!regex.hasMatch(name!))
                                  return 'Invalid Password';
                                else
                                  return null;
                              },
                              onSaved: (name) => oldPasswordString = name,
                              onFieldSubmitted: (_) {
                                fieldFocusChange(context, _oldPasswordFocusNode, _newpasswordFocusNode);
                              },
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: blackColor,
                                  fontFamily: ConstantFont.montserratMedium,
                                  fontWeight: FontWeight.w600),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: whiteF1,
                                hintText: 'Enter your old Password',
                                contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: whiteF1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: whiteF1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      oldPassword = !oldPassword;
                                    });
                                  },
                                  child: new Icon(
                                    oldPassword ? Icons.visibility : Icons.visibility_off,
                                    color: blackColor,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          ///new password keyword
                          Container(
                            margin: EdgeInsets.only(left: 25, top: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              StringConstant.newPassword,
                              style: TextStyle(
                                  color: grey99,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  fontFamily: ConstantFont.montserratMedium),
                            ),
                          ),

                          ///new password controller
                          Container(
                            height: 45,
                            margin: EdgeInsets.only(left: 20, top: 5, right: 20),
                            child: TextFormField(
                              autofocus: false,
                              obscureText: newPassword,
                              focusNode: _newpasswordFocusNode,
                              textInputAction: TextInputAction.next,
                              controller: _textEditingControllerNewPassword,
                              validator: kValidatePassword,
                              onSaved: (name) => newpassword = name,
                              onFieldSubmitted: (_) {
                                fieldFocusChange(context, _newpasswordFocusNode, _confirmPasswordFocusNode);
                              },
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: blackColor,
                                  fontFamily: ConstantFont.montserratMedium,
                                  fontWeight: FontWeight.w600),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: whiteF1,
                                hintText: 'Enter your new Password',
                                contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: whiteF1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: whiteF1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      newPassword = !newPassword;
                                    });
                                  },
                                  child: new Icon(
                                    newPassword ? Icons.visibility : Icons.visibility_off,
                                    color: blackColor,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          ///confirm password keyword
                          Container(
                            margin: EdgeInsets.only(left: 25, top: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              StringConstant.confirmPassword,
                              style: TextStyle(
                                  color: grey99,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  fontFamily: ConstantFont.montserratMedium),
                            ),
                          ),

                          ///confirm password text field
                          Container(
                            height: 45,
                            margin: EdgeInsets.only(left: 20, top: 5, right: 20),
                            child: TextFormField(
                              autofocus: false,
                              obscureText: confirmPassword,
                              controller: _textEditingControllerConfPassword,
                              focusNode: _confirmPasswordFocusNode,
                              textInputAction: TextInputAction.done,
                              validator: kValidatePasswordConfirm,
                              onSaved: (name) => confirmPasswordString = name,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: blackColor,
                                  fontFamily: ConstantFont.montserratMedium,
                                  fontWeight: FontWeight.w600),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: whiteF1,
                                hintText: 'Enter your confirm Password',
                                contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: whiteF1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: whiteF1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      confirmPassword = !confirmPassword;
                                    });
                                  },
                                  child: new Icon(
                                    confirmPassword ? Icons.visibility : Icons.visibility_off,
                                    color: blackColor,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          ///change password button
                          Container(
                              margin: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                              alignment: FractionalOffset.center,
                              child: MaterialButton(
                                minWidth: screenWidth,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                height: 45,
                                color: pinkColor,
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();

                                    print("pass_newpassword:$newpassword");
                                    print("pass_confirmPassword:$confirmPasswordString");

                                    if (newpassword == confirmPasswordString) {
                                      AppConstant.checkNetwork().whenComplete(() => callApiForChangePassword(
                                          oldPasswordString, newpassword, confirmPasswordString));
                                    } else {
                                      ToastMessage.toastMessage("Password not Match");
                                    }
                                  }
                                },
                                child: Text(
                                  StringConstant.changePassword,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: ConstantFont.montserratMedium,
                                  ),
                                ),
                              )),

                          ///upcoming appointment text
                          Container(
                            margin: EdgeInsets.only(left: 20, top: 25),
                            alignment: Alignment.topLeft,
                            child: Text(
                              StringConstant.upcomingAppointments,
                              style: TextStyle(
                                  color: blackColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  fontFamily: ConstantFont.montserratMedium),
                            ),
                          ),

                          ///upcoming appointment list
                          upcomingOrderDataList.isEmpty
                              ? Center(
                                  child: Container(
                                      width: screenWidth,
                                      height: MediaQuery.of(context).size.height * 0.2,
                                      alignment: Alignment.center,
                                      child: ListView(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        children: <Widget>[
                                          Image.asset(
                                            DummyImage.noData,
                                            alignment: Alignment.center,
                                            width: 150,
                                            height: 100,
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              StringConstant.youHavenAnyAppointmentSet,
                                              style: TextStyle(
                                                  color: whiteA3,
                                                  fontFamily: ConstantFont.montserratMedium,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      )),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: upcomingOrderDataList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    var parsedDate;
                                    parsedDate = DateTime.parse(upcomingOrderDataList[index].date!);
                                    var df = new DateFormat('MMM dd,yyyy');
                                    parsedDate = df.format(parsedDate);

                                    upcomingServiceList.clear();
                                    for (int i = 0; i < upcomingOrderDataList[index].services!.length; i++) {
                                      upcomingServiceList.add(upcomingOrderDataList[index].services![i].name);
                                    }

                                    return InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => SingleAppoitmentScreen(
                                                  appoitmentId: upcomingOrderDataList[index].id!,
                                                )));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(left: 5, right: 5, top: 10),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: whiteF1, width: 3),
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                        ),
                                        padding: EdgeInsets.only(bottom: 5),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Padding(
                                                padding: const EdgeInsets.only(left: 0.0),
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: new Container(
                                                        height: 75,
                                                        width: screenWidth * .35,
                                                        alignment: Alignment.topLeft,
                                                        margin: EdgeInsets.only(left: 10),
                                                        child: PreferenceUtils.getString(AppConstant.salonImage)
                                                                .isNotEmpty
                                                            ? CachedNetworkImage(
                                                                imageUrl:
                                                                    PreferenceUtils.getString(AppConstant.salonImage),
                                                                imageBuilder: (context, imageProvider) => Container(
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                    image: DecorationImage(
                                                                      image: imageProvider,
                                                                      fit: BoxFit.fill,
                                                                      alignment: Alignment.topCenter,
                                                                    ),
                                                                  ),
                                                                ),
                                                                placeholder: (context, url) =>
                                                                    SpinKitFadingCircle(color: pinkColor),
                                                                fit: BoxFit.scaleDown,
                                                              )
                                                            : Image.asset(DummyImage.noImage),
                                                      ),
                                                    ),
                                                    new Container(
                                                        width: screenWidth * .65,
                                                        height: 110,
                                                        margin: EdgeInsets.only(left: 5.0, top: 0.0),
                                                        alignment: Alignment.topLeft,
                                                        color: whiteColor,
                                                        child: ListView(
                                                          physics: NeverScrollableScrollPhysics(),
                                                          children: <Widget>[
                                                            Container(
                                                              margin: EdgeInsets.only(top: 25.0),
                                                              child: Text(
                                                                PreferenceUtils.getString(AppConstant.singlesalonName),
                                                                style: TextStyle(
                                                                    color: black1E,
                                                                    fontSize: 14,
                                                                    fontWeight: FontWeight.w600,
                                                                    fontFamily: ConstantFont.montserratMedium),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets.only(top: 5.0, left: 0.0),
                                                              child: Text(
                                                                PreferenceUtils.getString(AppConstant.salonAddress),
                                                                overflow: TextOverflow.ellipsis,
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    color: greyColor,
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.w600,
                                                                    fontFamily: ConstantFont.montserratMedium),
                                                              ),
                                                            ),
                                                            Row(
                                                              children: <Widget>[
                                                                Container(
                                                                  margin: EdgeInsets.only(top: 2, left: 0),
                                                                  child: SvgPicture.asset(
                                                                    DummyImage.star,
                                                                    width: 10,
                                                                    height: 10,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  child: Container(
                                                                    margin: EdgeInsets.only(top: 2, left: 2),
                                                                    child: Text(
                                                                        PreferenceUtils.getString(
                                                                                AppConstant.salonRating) +
                                                                            " Rating",
                                                                        style: TextStyle(
                                                                            color: grey99,
                                                                            fontSize: 11,
                                                                            fontWeight: FontWeight.w600,
                                                                            fontFamily: ConstantFont.montserratMedium)),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  alignment: Alignment.center,
                                                                  width: 5.0,
                                                                  height: 5.0,
                                                                  margin: EdgeInsets.only(left: 5.0, top: 5.0),
                                                                  decoration: BoxDecoration(
                                                                    shape: BoxShape.circle,
                                                                    color: greyColor,
                                                                  ),
                                                                ),
                                                                Container(
                                                                    margin:
                                                                        EdgeInsets.only(left: 0.0, top: 5.0, right: 0),
                                                                    child: RichText(
                                                                      maxLines: 2,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      textScaleFactor: 1,
                                                                      textAlign: TextAlign.center,
                                                                      text: TextSpan(
                                                                        children: [
                                                                          WidgetSpan(
                                                                            child: Icon(
                                                                              Icons.calendar_today,
                                                                              size: 14,
                                                                              color: pinkColor,
                                                                            ),
                                                                          ),
                                                                          TextSpan(
                                                                              text: upcomingOrderDataList[index]
                                                                                      .startTime! +
                                                                                  " - " +
                                                                                  parsedDate,
                                                                              style: TextStyle(
                                                                                  color: greyColor,
                                                                                  fontSize: 11,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontFamily:
                                                                                      ConstantFont.montserratMedium)),
                                                                        ],
                                                                      ),
                                                                    ))
                                                              ],
                                                            ),
                                                          ],
                                                        )),
                                                  ],
                                                )),
                                            Container(
                                              child: Container(
                                                margin: const EdgeInsets.only(top: 1.0, bottom: 1.0),
                                                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                                child: MySeparator(color: greyColor),
                                              ),
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.all(0),
                                                child: Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    margin: EdgeInsets.only(left: 5.0, right: 5.0),
                                                    color: whiteColor,
                                                    child: ListView(
                                                      shrinkWrap: true,
                                                      physics: NeverScrollableScrollPhysics(),
                                                      children: <Widget>[
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                StringConstant.serviceType,
                                                                style: TextStyle(
                                                                    color: whiteB3,
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.w600,
                                                                    fontFamily: ConstantFont.montserratMedium),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                children: [
                                                                  Text(
                                                                    StringConstant.bookingStatus,
                                                                    style: TextStyle(
                                                                        color: whiteB3,
                                                                        fontSize: 12,
                                                                        fontWeight: FontWeight.w600,
                                                                        fontFamily: ConstantFont.montserratMedium),
                                                                  ),
                                                                  Text(
                                                                    " : " + upcomingOrderDataList[index].bookingStatus!,
                                                                    style: TextStyle(
                                                                        color: whiteB3,
                                                                        fontSize: 12,
                                                                        fontWeight: FontWeight.w600,
                                                                        fontFamily: ConstantFont.montserratMedium),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Visibility(
                                                          visible: upcomingOrderDataList[index].serListVisible,
                                                          child: Container(
                                                            margin: EdgeInsets.only(left: 5),
                                                            child: Text(
                                                              upcomingOrderDataList[index].services![0].name!,
                                                              style: TextStyle(
                                                                  color: white4B,
                                                                  fontSize: 12,
                                                                  fontWeight: FontWeight.w600,
                                                                  fontFamily: ConstantFont.montserratMedium),
                                                            ),
                                                          ),
                                                        ),
                                                        upcomingOrderDataList[index].services!.length == 1
                                                            ? Row(
                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                children: [
                                                                  GestureDetector(
                                                                      onTap: () {
                                                                        showCancelDialog(
                                                                            context, upcomingOrderDataList[index].id);
                                                                      },
                                                                      child: RichText(
                                                                        text: TextSpan(
                                                                          children: [
                                                                            WidgetSpan(
                                                                              child: Container(
                                                                                margin: EdgeInsets.only(top: 5),
                                                                                child: SvgPicture.asset(
                                                                                  DummyImage.delete,
                                                                                  color: redFF,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            WidgetSpan(
                                                                              child: Container(
                                                                                margin:
                                                                                    EdgeInsets.only(top: 5, left: 5),
                                                                                child: Text(
                                                                                    StringConstant.cancelBooking,
                                                                                    style: TextStyle(
                                                                                        color: redFF,
                                                                                        fontSize: 12,
                                                                                        fontWeight: FontWeight.w500,
                                                                                        fontFamily: ConstantFont
                                                                                            .montserratMedium)),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )),
                                                                ],
                                                              )
                                                            : Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    child: Visibility(
                                                                      visible:
                                                                          upcomingOrderDataList[index].seeAllVisible,
                                                                      child: GestureDetector(
                                                                        onTap: () {
                                                                          setState(() {
                                                                            upcomingOrderDataList[index].seeAllVisible =
                                                                                false;
                                                                            upcomingOrderDataList[index]
                                                                                .serListVisible = false;
                                                                            upcomingOrderDataList[index]
                                                                                .newListVisible = true;
                                                                          });
                                                                        },
                                                                        child: Container(
                                                                          margin: EdgeInsets.only(left: 5, top: 5),
                                                                          child: Text(
                                                                            StringConstant.seeAll,
                                                                            style: TextStyle(
                                                                                color: blue4a,
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w600,
                                                                                fontFamily:
                                                                                    ConstantFont.montserratMedium),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                      children: [
                                                                        GestureDetector(
                                                                            onTap: () {
                                                                              showCancelDialog(context,
                                                                                  upcomingOrderDataList[index].id);
                                                                            },
                                                                            child: RichText(
                                                                              text: TextSpan(
                                                                                children: [
                                                                                  WidgetSpan(
                                                                                    child: Container(
                                                                                      margin: EdgeInsets.only(top: 5),
                                                                                      child: SvgPicture.asset(
                                                                                        DummyImage.delete,
                                                                                        color: redFF,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  WidgetSpan(
                                                                                    child: Container(
                                                                                      margin: EdgeInsets.only(
                                                                                          top: 5, left: 5),
                                                                                      child: Text(
                                                                                          StringConstant.cancelBooking,
                                                                                          style: TextStyle(
                                                                                              color: redFF,
                                                                                              fontSize: 12,
                                                                                              fontWeight:
                                                                                                  FontWeight.w500,
                                                                                              fontFamily: ConstantFont
                                                                                                  .montserratMedium)),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            )),
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                        Visibility(
                                                          visible: upcomingOrderDataList[index].newListVisible,
                                                          child: GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                print("SeeAllTapData");
                                                                upcomingOrderDataList[index].seeAllVisible = true;
                                                                upcomingOrderDataList[index].serListVisible = true;
                                                                upcomingOrderDataList[index].newListVisible = false;
                                                              });
                                                            },
                                                            child: ListView(
                                                              shrinkWrap: true,
                                                              physics: NeverScrollableScrollPhysics(),
                                                              children: <Widget>[
                                                                Container(
                                                                  margin: EdgeInsets.only(left: 5, top: 5),
                                                                  child: Text(
                                                                    upcomingServiceList.join(" , "),
                                                                    maxLines: 5,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: TextStyle(
                                                                        color: white4B,
                                                                        fontSize: 12,
                                                                        fontWeight: FontWeight.w600,
                                                                        fontFamily: ConstantFont.montserratMedium),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )))
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),

                          ///appointment history text
                          Container(
                            margin: EdgeInsets.only(
                              left: 15,
                              top: 25,
                            ),
                            alignment: Alignment.topLeft,
                            child: Text(
                              StringConstant.appointmentHistory,
                              style: TextStyle(
                                  color: blackColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  fontFamily: ConstantFont.montserratMedium),
                            ),
                          ),

                          ///appointment history list
                          completedDataList.isEmpty
                              ? Center(
                                  child: Container(
                                    width: screenWidth,
                                    height: MediaQuery.of(context).size.height * 0.2,
                                    alignment: Alignment.center,
                                    child: ListView(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      children: <Widget>[
                                        Image.asset(
                                          DummyImage.noData,
                                          alignment: Alignment.center,
                                          width: 150,
                                          height: 100,
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            StringConstant.youHavenAnyCompletedAppointment,
                                            style: TextStyle(
                                                color: whiteA3,
                                                fontFamily: ConstantFont.montserratMedium,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: completedDataList.length,
                                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.03),
                                  itemBuilder: (BuildContext context, int index) {
                                    var parsedDate;
                                    parsedDate = DateTime.parse(completedDataList[index].date!);
                                    var df = new DateFormat('MMM dd,yyyy');
                                    parsedDate = df.format(parsedDate);

                                    completedServiceList.clear();
                                    for (int i = 0; i < completedDataList[index].services!.length; i++) {
                                      completedServiceList.add(completedDataList[index].services![i].name);
                                    }

                                    return InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => SingleAppoitmentScreen(
                                                  appoitmentId: completedDataList[index].id!,
                                                )));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: whiteF1, width: 3),
                                          borderRadius: BorderRadius.all(Radius.circular(12)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Padding(
                                                padding: const EdgeInsets.only(left: 0.0),
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: new Container(
                                                        height: 75,
                                                        width: screenWidth * .33,
                                                        alignment: Alignment.topLeft,
                                                        margin: EdgeInsets.only(left: 5),
                                                        child: CachedNetworkImage(
                                                          imageUrl: PreferenceUtils.getString(AppConstant.salonImage),
                                                          imageBuilder: (context, imageProvider) => Container(
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(10.0),
                                                              image: DecorationImage(
                                                                image: imageProvider,
                                                                fit: BoxFit.fill,
                                                                alignment: Alignment.topCenter,
                                                              ),
                                                            ),
                                                          ),
                                                          placeholder: (context, url) =>
                                                              SpinKitFadingCircle(color: pinkColor),
                                                          errorWidget: (context, url, error) =>
                                                              Image.asset(DummyImage.noImage),
                                                        ),
                                                      ),
                                                    ),
                                                    new Container(
                                                        width: screenWidth * .67,
                                                        height: 110,
                                                        margin: EdgeInsets.only(left: 5.0, top: 0.0),
                                                        alignment: Alignment.topLeft,
                                                        color: whiteColor,
                                                        child: ListView(
                                                          physics: NeverScrollableScrollPhysics(),
                                                          children: <Widget>[
                                                            Container(
                                                              margin: EdgeInsets.only(top: 25.0),
                                                              child: Text(
                                                                PreferenceUtils.getString(AppConstant.singlesalonName),
                                                                style: TextStyle(
                                                                    color: black1E,
                                                                    fontSize: 14,
                                                                    fontWeight: FontWeight.w600,
                                                                    fontFamily: ConstantFont.montserratMedium),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets.only(top: 5.0, left: 0.0),
                                                              child: Text(
                                                                PreferenceUtils.getString(AppConstant.salonAddress),
                                                                overflow: TextOverflow.ellipsis,
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    color: greyColor,
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.w600,
                                                                    fontFamily: ConstantFont.montserratMedium),
                                                              ),
                                                            ),
                                                            Row(
                                                              children: <Widget>[
                                                                Container(
                                                                  margin: EdgeInsets.only(top: 2, left: 0),
                                                                  child: SvgPicture.asset(
                                                                    DummyImage.star,
                                                                    width: 10,
                                                                    height: 10,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  child: Container(
                                                                    margin: EdgeInsets.only(top: 2, left: 2),
                                                                    child: Text(
                                                                        PreferenceUtils.getString(
                                                                                AppConstant.salonRating) +
                                                                            " Rating",
                                                                        style: TextStyle(
                                                                            color: grey99,
                                                                            fontSize: 11,
                                                                            fontWeight: FontWeight.w600,
                                                                            fontFamily: ConstantFont.montserratMedium)),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  alignment: Alignment.center,
                                                                  width: 5.0,
                                                                  height: 5.0,
                                                                  margin: EdgeInsets.only(left: 5.0, top: 5.0),
                                                                  decoration: BoxDecoration(
                                                                    shape: BoxShape.circle,
                                                                    color: greyColor,
                                                                  ),
                                                                ),
                                                                Container(
                                                                    margin:
                                                                        EdgeInsets.only(left: 0.0, top: 5.0, right: 0),
                                                                    child: RichText(
                                                                      maxLines: 2,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      textScaleFactor: 1,
                                                                      textAlign: TextAlign.center,
                                                                      text: TextSpan(
                                                                        children: [
                                                                          WidgetSpan(
                                                                            child: Icon(
                                                                              Icons.calendar_today,
                                                                              size: 14,
                                                                              color: pinkColor,
                                                                            ),
                                                                          ),
                                                                          TextSpan(
                                                                              text:
                                                                                  completedDataList[index].startTime! +
                                                                                      "-",
                                                                              style: TextStyle(
                                                                                  color: greyColor,
                                                                                  fontSize: 11,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontFamily:
                                                                                      ConstantFont.montserratMedium)),
                                                                          TextSpan(
                                                                              text: parsedDate,
                                                                              style: TextStyle(
                                                                                  color: greyColor,
                                                                                  fontSize: 11,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontFamily:
                                                                                      ConstantFont.montserratMedium))
                                                                        ],
                                                                      ),
                                                                    ))
                                                              ],
                                                            ),
                                                          ],
                                                        )),
                                                  ],
                                                )),
                                            Container(
                                              child: Container(
                                                margin: const EdgeInsets.only(top: 1.0, bottom: 1.0),
                                                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                                child: MySeparator(color: greyColor),
                                              ),
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.all(0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                        width: screenWidth * .33,
                                                        margin: EdgeInsets.only(left: 5.0, right: 10.0),
                                                        color: whiteColor,
                                                        alignment: Alignment.topLeft,
                                                        child: ListView(
                                                          shrinkWrap: true,
                                                          physics: NeverScrollableScrollPhysics(),
                                                          children: <Widget>[
                                                            Container(
                                                              transform: Matrix4.translationValues(5.0, 0.0, 0.0),
                                                              child: Text(
                                                                StringConstant.serviceType,
                                                                style: TextStyle(
                                                                    color: whiteB3,
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.w600,
                                                                    fontFamily: ConstantFont.montserratMedium),
                                                              ),
                                                            ),
                                                            Visibility(
                                                              visible: completedDataList[index].serListVisible,
                                                              child: Container(
                                                                margin: EdgeInsets.only(left: 5),
                                                                child: Text(
                                                                  completedDataList[index].services![0].name!,
                                                                  style: TextStyle(
                                                                      color: white4B,
                                                                      fontSize: 12,
                                                                      fontWeight: FontWeight.w600,
                                                                      fontFamily: ConstantFont.montserratMedium),
                                                                ),
                                                              ),
                                                            ),
                                                            completedDataList[index].services!.length == 1
                                                                ? Container(
                                                                    height: 0,
                                                                    width: 0,
                                                                  )
                                                                : Visibility(
                                                                    visible: completedDataList[index].seeAllVisible,
                                                                    child: GestureDetector(
                                                                      onTap: () {
                                                                        setState(() {
                                                                          completedDataList[index].seeAllVisible =
                                                                              false;
                                                                          completedDataList[index].serListVisible =
                                                                              false;
                                                                          completedDataList[index].newListVisible =
                                                                              true;
                                                                        });
                                                                      },
                                                                      child: Container(
                                                                        margin: EdgeInsets.only(left: 5, top: 5),
                                                                        child: Text(
                                                                          StringConstant.seeAll,
                                                                          style: TextStyle(
                                                                              color: blue4a,
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontFamily:
                                                                                  ConstantFont.montserratMedium),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                            Visibility(
                                                              visible: completedDataList[index].newListVisible,
                                                              child: GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    print("SeeAllTapData");
                                                                    completedDataList[index].seeAllVisible = true;
                                                                    completedDataList[index].serListVisible = true;
                                                                    completedDataList[index].newListVisible = false;
                                                                  });
                                                                },
                                                                child: ListView(
                                                                  shrinkWrap: true,
                                                                  physics: NeverScrollableScrollPhysics(),
                                                                  children: <Widget>[
                                                                    Container(
                                                                      margin: EdgeInsets.only(left: 5, top: 5),
                                                                      child: Text(
                                                                        completedServiceList.join(" , "),
                                                                        maxLines: 5,
                                                                        overflow: TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            color: white4B,
                                                                            fontSize: 12,
                                                                            fontWeight: FontWeight.w600,
                                                                            fontFamily: ConstantFont.montserratMedium),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.4,
                                                      height: 50,
                                                      alignment: Alignment.topRight,
                                                      margin: EdgeInsets.only(top: 20, right: 10),
                                                      child: GestureDetector(
                                                          onTap: () {},
                                                          child: RichText(
                                                            text: TextSpan(
                                                              children: [
                                                                WidgetSpan(
                                                                  child: Container(
                                                                    margin: EdgeInsets.only(top: 5),
                                                                    child: SvgPicture.asset(
                                                                      DummyImage.correct,
                                                                    ),
                                                                  ),
                                                                ),
                                                                WidgetSpan(
                                                                  child: Container(
                                                                    margin: EdgeInsets.only(top: 5, left: 5),
                                                                    child: Text(StringConstant.completed,
                                                                        style: TextStyle(
                                                                            color: green00,
                                                                            fontSize: 12,
                                                                            fontWeight: FontWeight.w500,
                                                                            fontFamily: ConstantFont.montserratMedium)),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )),
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  void showCancelDialog(BuildContext context, int? id) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          Widget cancelButton = TextButton(
            child: Text(
              StringConstant.no,
              style: TextStyle(color: greyColor, fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Montserrat'),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          );
          Widget continueButton = TextButton(
            child: Text(
              StringConstant.yes,
              style: TextStyle(color: pinkColor, fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Montserrat'),
            ),
            onPressed: () {
              print("BookingId:$id");

              AppConstant.checkNetwork().whenComplete(() => callApiForCancelBooking(id!));
              Navigator.pop(context);
            },
          );

          return AlertDialog(
            actions: [
              cancelButton,
              continueButton,
            ],
            title: Align(
              alignment: Alignment.center,
              child: Text(
                StringConstant.cancelAppointment,
                style:
                    TextStyle(color: blackColor, fontSize: 20, fontWeight: FontWeight.w600, fontFamily: 'Montserrat'),
                textAlign: TextAlign.center,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      StringConstant.areYouSureYouWantToCancelYourAppointment,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: greyColor, fontWeight: FontWeight.w600, fontSize: 18, fontFamily: 'Montserrat'),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<bool> _onWillPop() async {
    Navigator.pop(context);

    return (await Navigator.of(context).push(MaterialPageRoute(builder: (context) => new HomeScreen(0)))) ?? false;
  }

  void fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
