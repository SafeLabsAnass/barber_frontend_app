import 'dart:convert';
import 'dart:io';
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
import 'package:cached_network_image/cached_network_image.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EditProfile extends StatefulWidget {
  final ShowProfileData? showProfile;

  EditProfile(this.showProfile);

  @override
  _EditProfile createState() => new _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  final GlobalKey<ScaffoldState> _drawerScaffoldKey = new GlobalKey<ScaffoldState>();

  List<AddressList>? addressDataList = <AddressList>[];
  ShowProfileData? showProfile1;
  String? _selectedCountryCode;
  bool _loading = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      PreferenceUtils.init();

      showProfile1 = widget.showProfile;
      addressDataList = widget.showProfile!.address;
    });
  }

  void fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void callApiForRemoveLocation(int index) {
    setState(() {
      int? addressId = addressDataList![index].addressId;
      print("addressId:$addressId");

      AppConstant.checkNetwork().whenComplete(() => callAddressRemoveApi(addressDataList![index].addressId));
      addressDataList!.removeAt(index);
    });
  }

  void callAddressRemoveApi(int? addressId) {
    setState(() {
      _loading = true;
    });
    print(addressId);
    RestClient(RetroApi().dioData()).removeadd(addressId).then((response) {
      setState(() {
        _loading = false;
        if (response.success = true) {
          ToastMessage.toastMessage(response.msg!);
        } else {}
      });
    }).catchError((Object obj) {
      setState(() {
        _loading = false;
      });
      print("error:$obj");
      print(obj.runtimeType);
    });
  }

  void callApiForEditProfile(String imageB64) {
    print("imageB64:$imageB64");
    setState(() {
      _loading = true;
    });
    RestClient(RetroApi().dioData())
        .editprofile(imageB64, _email, _phoneNo, _username, showProfile1!.code!)
        .then((response) {
      setState(() {
        _loading = false;
        if (response.success = true) {
          print(response.msg);

          Navigator.of(context).push(MaterialPageRoute(builder: (context) => new HomeScreen(3)));
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

  final _formKey = GlobalKey<FormState>();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _usernameFocusNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();
  String? _username, _email, _phoneNo = "";
  String? oldPassword, newpassword, confirmPassword = "";
  List appoinmentDataList = [
    {
      "discount": "10%",
      "dark_color": const Color(0xFFffb5cc),
      "light_color": const Color(0xFFffc8de),
    },
  ];

  List appoinmentDataList1 = [
    {
      "discount": "10%",
      "dark_color": const Color(0xFFffb5cc),
      "light_color": const Color(0xFFffc8de),
    },
    {"discount": "50%", "dark_color": const Color(0xFFb5b8ff), "light_color": const Color(0xFFc8caff)},
    {"discount": "30%", "dark_color": const Color(0xFFffb5b5), "light_color": const Color(0xFFffc8c8)},
  ];
  File? _image;
  final picker = ImagePicker();
  bool isTextEnable = false;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    dynamic screenWidth = MediaQuery.of(context).size.width;
    print("_selectedCountryCode123:$_selectedCountryCode");

    return ModalProgressHUD(
      inAsyncCall: _loading,
      opacity: 1.0,
      color: Colors.transparent.withOpacity(0.2),
      progressIndicator: SpinKitFadingCircle(color: pinkColor),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: whiteColor,
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
              StringConstant.editProfile,
              style: TextStyle(
                  color: blackColor,
                  fontFamily: ConstantFont.montserratBold,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            backgroundColor: whiteColor,
            elevation: 0.0,
            actions: <Widget>[],
          ),
          key: _drawerScaffoldKey,
          body: Form(
            key: _formKey,
            child: new ListView(physics: ClampingScrollPhysics(), children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: whiteF1, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            child: Row(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    selectImage(context);
                                  },
                                  child: Stack(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.transparent,
                                          child: Container(
                                            height: 90,
                                            width: 90,
                                            child: GestureDetector(
                                              onTap: () async {
                                                selectImage(context);
                                              },
                                              child: _image == null
                                                  ? CachedNetworkImage(
                                                      imageUrl: showProfile1!.imagePath! + showProfile1!.image!,
                                                      imageBuilder: (context, imageProvider) => ClipOval(
                                                        child: Image(
                                                          image: imageProvider,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                      placeholder: (context, url) =>
                                                          SpinKitFadingCircle(color: pinkColor),
                                                      errorWidget: (context, url, error) =>
                                                          Image.asset(DummyImage.noImage),
                                                    )
                                                  : ClipOval(
                                                      child: Image.file(
                                                        _image!,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(left: 50, top: 35, bottom: 10),
                                          child: GestureDetector(
                                            onTap: () async {
                                              selectImage(context);
                                            },
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              child: SvgPicture.asset(DummyImage.camera),
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Center(
                              child: Text(
                                showProfile1!.name!,
                                style: TextStyle(
                                    color: blackColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    fontFamily: ConstantFont.montserratBold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 11, top: 25),
                      alignment: Alignment.topLeft,
                      child: Text(
                        StringConstant.personalInfo,
                        style: TextStyle(
                            color: blackColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            fontFamily: ConstantFont.montserratBold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 10),
                      alignment: Alignment.topLeft,
                      child: Text(
                        StringConstant.editYourName,
                        style: TextStyle(
                            color: grey99,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            fontFamily: ConstantFont.montserratMedium),
                      ),
                    ),
                    Container(
                      height: 45,
                      margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                      child: TextFormField(
                        autofocus: false,
                        initialValue: showProfile1!.name,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        validator: (name) {
                          Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                          RegExp regex = new RegExp(pattern as String);
                          if (!regex.hasMatch(name!))
                            return 'Invalid name';
                          else
                            return null;
                        },
                        onSaved: (name) => _username = name,
                        onFieldSubmitted: (_) {
                          fieldFocusChange(context, _usernameFocusNode, _emailFocusNode);
                        },
                        style: TextStyle(
                            fontSize: 14.0,
                            color: blackColor,
                            fontFamily: ConstantFont.montserratMedium,
                            fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: whiteF1,
                          hintText: 'Enter your Name',
                          contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: whiteF1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: whiteF1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 10),
                      alignment: Alignment.topLeft,
                      child: Text(
                        StringConstant.editYourEmailId,
                        style: TextStyle(
                            color: grey99,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            fontFamily: ConstantFont.montserratMedium),
                      ),
                    ),
                    Container(
                      height: 45,
                      margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                      child: TextFormField(
                        autofocus: false,
                        enabled: isTextEnable,
                        initialValue: showProfile1!.email,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        focusNode: _emailFocusNode,
                        validator: (email) => EmailValidator.validate(email!) ? null : "Invalid email address",
                        onSaved: (email) => _email = email,
                        onFieldSubmitted: (_) {
                          fieldFocusChange(context, _emailFocusNode, _phoneFocusNode);
                        },
                        style: TextStyle(
                            fontSize: 14.0,
                            color: blackColor,
                            fontFamily: ConstantFont.montserratMedium,
                            fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: whiteF1,
                          hintText: 'Enter your EmailId',
                          contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: whiteF1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: whiteF1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 10),
                      alignment: Alignment.topLeft,
                      child: Text(
                        StringConstant.editYourContactNumber,
                        style: TextStyle(
                            color: grey99,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                            fontFamily: ConstantFont.montserratMedium),
                      ),
                    ),
                    Row(
                      children: [],
                    ),
                    Container(
                      height: 45,
                      margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                      child: TextFormField(
                        initialValue: showProfile1!.phone,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        focusNode: _phoneFocusNode,
                        enabled: isTextEnable,
                        validator: (phone) {
                          Pattern pattern = r'^[0-9]*$';
                          RegExp regex = new RegExp(pattern as String);
                          if (!regex.hasMatch(phone!))
                            return 'Invalid Phone number';
                          else
                            return null;
                        },
                        onSaved: (phone) => _phoneNo = phone,
                        style: TextStyle(
                            fontSize: 16.0,
                            color: blackColor,
                            fontFamily: ConstantFont.montserratMedium,
                            fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                          prefix: Container(
                            width: MediaQuery.of(context).size.width * 0.12,
                            child: Row(
                              children: [
                                Text(
                                  showProfile1!.code!,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: blackColor,
                                      fontFamily: ConstantFont.montserratMedium,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                    height: 25,
                                    child: VerticalDivider(
                                      color: Colors.grey.withAlpha(200),
                                    )),
                              ],
                            ),
                          ),
                          prefixIconConstraints: BoxConstraints(minWidth: 20, maxHeight: 20),
                          filled: true,
                          fillColor: whiteF1,
                          hintText: 'Enter your Contact Number',
                          contentPadding: const EdgeInsets.only(
                            left: 14.0,
                            bottom: 8.0,
                            top: 8.0,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: whiteF1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: whiteF1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: addressDataList!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 60,
                            width: double.infinity,
                            margin: EdgeInsets.only(left: 1, top: 00),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: screenWidth * .1,
                                  alignment: FractionalOffset.topCenter,
                                  margin: EdgeInsets.only(top: 10),
                                  child: SvgPicture.asset(
                                    DummyImage.locationBlack,
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                                Container(
                                  alignment: FractionalOffset.topLeft,
                                  width: screenWidth * .5,
                                  transform: Matrix4.translationValues(0.0, 5.0, 0.0),
                                  child: ListView(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    children: [
                                      Text(
                                        addressDataList![index].street!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: blackColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            fontFamily: ConstantFont.montserratMedium),
                                      ),
                                      Text(
                                        addressDataList![index].city! +
                                            ", " +
                                            addressDataList![index].state! +
                                            ", " +
                                            addressDataList![index].country!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: greyColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11,
                                            fontFamily: ConstantFont.montserratMedium),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showRemoveLocationDialog(context, index);
                                  },
                                  child: Container(
                                      width: screenWidth * .25,
                                      margin: EdgeInsets.only(right: 5),
                                      transform: Matrix4.translationValues(5.0, -10.0, 0.0),
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
                                                margin: EdgeInsets.only(top: 5, left: 5),
                                                child: Text(StringConstant.remove,
                                                    style: TextStyle(
                                                        color: redFF,
                                                        fontSize: 12,
                                                        fontFamily: ConstantFont.montserratMedium,
                                                        fontWeight: FontWeight.w500)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      height: 45,
                      margin: EdgeInsets.only(top: 20, bottom: 10),
                      color: whiteColor,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            if (_image == null) {
                              String imageB64 = "";
                              print("imageB64123:$imageB64");

                              AppConstant.checkNetwork().whenComplete(() => callApiForEditProfile(imageB64));
                            } else {
                              List<int> imageBytes = _image!.readAsBytesSync();
                              String imageB64 = base64Encode(imageBytes);

                              AppConstant.checkNetwork().whenComplete(() => callApiForEditProfile(imageB64));
                            }
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            StringConstant.changeThis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600, fontFamily: ConstantFont.montserratMedium),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: blue4a,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void showRemoveLocationDialog(BuildContext context, int index) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          Widget cancelButton = TextButton(
            child: Text(
              StringConstant.no,
              style: TextStyle(
                  color: greyColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: ConstantFont.montserratMedium),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          );
          Widget continueButton = TextButton(
            child: Text(
              StringConstant.yes,
              style: TextStyle(
                  color: pinkColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: ConstantFont.montserratMedium),
            ),
            onPressed: () {
              callApiForRemoveLocation(index);
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
                StringConstant.removeLocation,
                style: TextStyle(
                    color: blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: ConstantFont.montserratMedium),
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
                      StringConstant.areYouSureYouWantToRemoveYourLocation,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: greyColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                          fontFamily: ConstantFont.montserratMedium),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _imgFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void selectImage(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text(
                      StringConstant.photoLibrary,
                      style: TextStyle(fontFamily: ConstantFont.montserratMedium),
                    ),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text(
                    StringConstant.camera,
                    style: TextStyle(fontFamily: ConstantFont.montserratMedium),
                  ),
                  onTap: () {
                    getImage();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(),
    );
  }
}
