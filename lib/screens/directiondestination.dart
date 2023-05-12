import 'package:barber_app/ResponseModel/salonDetailResponse.dart';
import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/color_constant.dart';
import 'package:barber_app/constant/constant_font.dart';
import 'package:barber_app/constant/dymmyimages.dart';
import 'package:barber_app/constant/preferenceutils.dart';
import 'package:barber_app/constant/string_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class DirectionDest extends StatefulWidget {
  final SalonDetails salonData;
  DirectionDest(this.salonData);

  @override
  _DirectionDest createState() => new _DirectionDest();
}

class _DirectionDest extends State<DirectionDest> {
  final GlobalKey<ScaffoldState> _drawerScaffoldKey = new GlobalKey<ScaffoldState>();

  late BitmapDescriptor pinLocationIcon;
  Map<MarkerId, Marker> markers = {};
  List<Marker> allMarkers = [];

  String name = "User";
  var salonData1;
  String mondayTime = "";
  String tuesdayTime = "";
  String wednesdayTime = "";
  String thursdayTime = "";
  String fridayTime = "";
  String saturdayTime = "";
  String sundayTime = "";
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  GoogleMapController? mapController;

  double? salonLat;
  double? salonLong;
  String distance = " ";
  var day;
  var salonTime;
  LatLng? origin;

  PolylinePoints polylinePoints = PolylinePoints();

  @override
  void initState() {
    super.initState();

    origin = new LatLng(AppConstant.currentlat, AppConstant.currentlong);
    salonLat = double.parse(widget.salonData.latitude!);
    salonLong = double.parse(widget.salonData.longitude!);
    assert(salonLat is double);
    assert(salonLong is double);

    double distanceInMeters =
        Geolocator.distanceBetween(AppConstant.currentlat, AppConstant.currentlong, salonLat!, salonLong!);
    double distanceinkm = distanceInMeters / 1000;
    print("current_distanceInMeters:$distanceInMeters");
    print("current_distanceinkm:$distanceinkm");
    String str = distanceinkm.toString();
    var distance12 = str.split('.');
    distance = distance12[0];
    print("AppConst_salon_distance:$distance");

    print("AppConst_salon_lat:$salonLat");
    print("AppConst_salon_long:$salonLong");

    print("AppConst_lat:${AppConstant.currentlat}");
    print("AppConst_long:${AppConstant.currentlong}");
    day = DateFormat('EEEE').format(DateTime.now());
    print("Today is:$day");
    BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'images/location_black.png').then((onValue) {
      pinLocationIcon = onValue;
    });

    setState(() {
      AppConstant.currentlatlong().whenComplete(() => AppConstant.currentlatlong().then((value) {
            origin = value;
            print("origin123:$origin");

            if (origin != null && salonLat != null && salonLong != null) {
              print("origin123 not null");

              _getPolyline(origin!, salonLat!, salonLong!);
            } else {
              print("origin123 null");
            }
          }));
    });

    PreferenceUtils.init();
    name = PreferenceUtils.getString(AppConstant.username);
    salonData1 = widget.salonData;
    PreferenceUtils.init();
    if (day == "Sunday") {
      if (widget.salonData.sunday!.open == null && widget.salonData.sunday!.close == null) {
        salonTime = "Close";
        print(salonTime);
      } else {
        DateTime tempStartTime = DateFormat("hh:mm").parse(widget.salonData.sunday!.open!);
        DateTime tempEndTime = DateFormat("hh:mm").parse(widget.salonData.sunday!.close!);
        var startTimeFormat = DateFormat("h:mm a");
        salonTime = startTimeFormat.format(tempStartTime) + " to " + startTimeFormat.format(tempEndTime);
      }
    }
    day = DateFormat('EEEE').format(DateTime.now());
    if (day == "Saturday") {
      if (widget.salonData.saturday!.open == null && widget.salonData.saturday!.close == null) {
        salonTime = "Close";
        print(salonTime);
      } else {
        DateTime tempStartTime = DateFormat("hh:mm").parse(widget.salonData.saturday!.open!);
        DateTime tempEndTime = DateFormat("hh:mm").parse(widget.salonData.saturday!.close!);
        var startTimeFormat = DateFormat("h:mm a");
        salonTime = startTimeFormat.format(tempStartTime) + " to " + startTimeFormat.format(tempEndTime);
        print(salonTime);
      }
    }

    if (day == "Friday") {
      if (widget.salonData.friday!.open == null && widget.salonData.friday!.close == null) {
        salonTime = "Close";
        print(salonTime);
      } else {
        DateTime tempStartTime = DateFormat("hh:mm").parse(widget.salonData.friday!.open!);
        DateTime tempEndTime = DateFormat("hh:mm").parse(widget.salonData.friday!.close!);
        var startTimeFormat = DateFormat("h:mm a");
        salonTime = startTimeFormat.format(tempStartTime) + " to " + startTimeFormat.format(tempEndTime);
        print(salonTime);
      }
    }

    if (day == "Thursday") {
      if (widget.salonData.thursday!.open == null && widget.salonData.thursday!.close == null) {
        salonTime = "Close";
        print(salonTime);
      } else {
        DateTime tempStartTime = DateFormat("hh:mm").parse(widget.salonData.thursday!.open!);
        DateTime tempEndTime = DateFormat("hh:mm").parse(widget.salonData.thursday!.close!);
        var startTimeFormat = DateFormat("h:mm a");
        salonTime = startTimeFormat.format(tempStartTime) + " to " + startTimeFormat.format(tempEndTime);
        print(salonTime);
      }
    }

    if (day == "Wednesday") {
      if (widget.salonData.wednesday!.open == null && widget.salonData.wednesday!.close == null) {
        salonTime = "Close";
        print(salonTime);
      } else {
        DateTime tempStartTime = DateFormat("hh:mm").parse(widget.salonData.wednesday!.open!);
        DateTime tempEndTime = DateFormat("hh:mm").parse(widget.salonData.wednesday!.close!);
        var startTimeFormat = DateFormat("h:mm a");
        salonTime = startTimeFormat.format(tempStartTime) + " to " + startTimeFormat.format(tempEndTime);
        print(salonTime);
      }
    }

    if (day == "Tuesday") {
      if (widget.salonData.tuesday!.open == null && widget.salonData.tuesday!.close == null) {
        salonTime = "Close";
        print(salonTime);
      } else {
        DateTime tempStartTime = DateFormat("hh:mm").parse(widget.salonData.tuesday!.open!);
        DateTime tempEndTime = DateFormat("hh:mm").parse(widget.salonData.tuesday!.close!);
        var startTimeFormat = DateFormat("h:mm a");
        salonTime = startTimeFormat.format(tempStartTime) + " to " + startTimeFormat.format(tempEndTime);
        print(salonTime);
      }
    }
    if (day == "Monday") {
      if (widget.salonData.monday!.open == null && widget.salonData.monday!.close == null) {
        salonTime = "Close";
        print(salonTime);
      } else {
        DateTime tempStartTime = DateFormat("hh:mm").parse(widget.salonData.monday!.open!);
        DateTime tempEndTime = DateFormat("hh:mm").parse(widget.salonData.monday!.close!);
        var startTimeFormat = DateFormat("h:mm a");
        salonTime = startTimeFormat.format(tempStartTime) + " to " + startTimeFormat.format(tempEndTime);
        print(salonTime);
      }
    }
  }

  void setCustomMapPin() async {
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(48, 48)), DummyImage.marker).then((onValue) {
      pinLocationIcon = onValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    dynamic screenHeight = MediaQuery.of(context).size.height;
    dynamic screenWidth = MediaQuery.of(context).size.width;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return new SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: Container(
            margin: EdgeInsets.only(left: 0),
            child: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_left,
                color: blackColor,
                size: 30,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              StringConstant.destinationDirection,
              style: TextStyle(color: blackColor, fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
          centerTitle: true,
          backgroundColor: whiteColor,
          elevation: 0.0,
        ),
        resizeToAvoidBottomInset: false,
        key: _drawerScaffoldKey,
        body: Container(
            child: ListView(
          children: <Widget>[
            Container(
                height: screenHeight * 0.62,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(target: LatLng(origin!.latitude, origin!.longitude), zoom: 1),
                  myLocationEnabled: true,
                  tiltGesturesEnabled: true,
                  compassEnabled: true,
                  scrollGesturesEnabled: true,
                  zoomGesturesEnabled: true,
                  onMapCreated: _onMapCreated,
                  markers: Set.from(allMarkers),
                  polylines: Set<Polyline>.of(polylines.values),
                )),
            Container(
              height: screenHeight * 0.07,
              color: whiteColor,
              child: Container(
                margin: EdgeInsets.only(left: 15, top: 15, bottom: 5),
                child: Text(
                  StringConstant.yourDestination,
                  style: TextStyle(
                      color: grey99,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      fontFamily: ConstantFont.montserratSemiBold),
                ),
              ),
            ),
            Container(
              height: screenHeight * 0.17,
              color: Colors.transparent,
              margin: EdgeInsets.only(top: 1, left: 1, right: 10, bottom: 15),
              child: Container(
                  child: Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 10),
                child: Container(
                  alignment: Alignment.topCenter,
                  height: 150,
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(color: whiteF1, width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Row(
                    children: <Widget>[
                      new Container(
                        height: 80,
                        width: screenWidth * .20,
                        margin: EdgeInsets.only(left: 10),
                        alignment: Alignment.topLeft,
                        child: CachedNetworkImage(
                          imageUrl: widget.salonData.imagePath! + widget.salonData.image!,
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
                          placeholder: (context, url) => SpinKitFadingCircle(color: pinkColor),
                          errorWidget: (context, url, error) => Image.asset(DummyImage.noImage),
                        ),
                      ),
                      IntrinsicWidth(
                          child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 9,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                                  width: screenWidth * .65,
                                  child: ListView(
                                    physics: NeverScrollableScrollPhysics(),
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(top: 15.0, left: 5),
                                        child: Text(
                                          widget.salonData.name!,
                                          style: TextStyle(
                                              color: blackColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: ConstantFont.montserratSemiBold),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5.0, left: 5),
                                        child: Text(
                                          widget.salonData.address!,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: TextStyle(
                                              color: white9B,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: ConstantFont.montserratMedium),
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(top: 1),
                                              child: Container(
                                                margin: EdgeInsets.only(top: 2, left: 5),
                                                child: SvgPicture.asset(
                                                  DummyImage.star,
                                                  width: 10,
                                                  height: 10,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Container(
                                                margin: EdgeInsets.only(top: 2, left: 2),
                                                child: Text(widget.salonData.rate.toString(),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: yellowColor,
                                                        fontSize: 11,
                                                        fontWeight: FontWeight.w600,
                                                        fontFamily: ConstantFont.montserratMedium)),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 5, top: 2),
                                              child: Text(
                                                salonTime,
                                                style: TextStyle(
                                                    color: greenColor,
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: ConstantFont.montserratMedium),
                                              ),
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(top: 5, left: 5),
                                                child: RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      WidgetSpan(
                                                        child: Container(
                                                            margin: EdgeInsets.only(right: 2),
                                                            child: SvgPicture.asset(
                                                              DummyImage.distance,
                                                              width: 14,
                                                              height: 14,
                                                            )),
                                                      ),
                                                      TextSpan(
                                                          text: distance + "km",
                                                          style: TextStyle(
                                                              color: greyColor,
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w600,
                                                              fontFamily: ConstantFont.montserratMedium)),
                                                    ],
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              )),
            )
          ],
        )),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    setState(() {
      if (origin != null) {
        allMarkers.add(
          Marker(
            markerId: MarkerId('marker'),
            position: LatLng(origin!.latitude, origin!.longitude),
            icon: pinLocationIcon,
            infoWindow: InfoWindow(
              title: StringConstant.yourLocation,
            ),
          ),
        );
      } else {
        print("origin null");
      }

      if (salonLong != null && salonLat != null) {
        allMarkers.add(
          Marker(
            markerId: MarkerId("your location"),
            position: LatLng(salonLat!, salonLong!),
            icon: pinLocationIcon,
            infoWindow: InfoWindow(
              title: StringConstant.barber,
            ),
          ),
        );
      } else {
        print("salon lat null");
      }
    });
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(polylineId: id, color: blackColor, points: polylineCoordinates, width: 10);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline(LatLng origin, double salonLat, double salonLong) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates("AIzaSyDvivYcq13YuQqAde0UKwtnVflecI-7XEk",
        PointLatLng(origin.latitude, origin.longitude), PointLatLng(salonLat, salonLong));
    print(result.points);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }
}
