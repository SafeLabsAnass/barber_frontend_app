import 'package:barber_app/ResponseModel/salonDetailResponse.dart';
import 'package:barber_app/constant/color_constant.dart';
import 'package:barber_app/constant/constant_font.dart';
import 'package:barber_app/constant/dymmyimages.dart';
import 'package:barber_app/constant/string_constant.dart';
import 'package:barber_app/screens/full_image_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class GalleryView extends StatefulWidget {
  final List<SalonGallery> galleyDataList;

  GalleryView(this.galleyDataList);

  @override
  _GalleryView createState() => _GalleryView();
}

class _GalleryView extends State<GalleryView> {
  List<SalonGallery> galleyDataList = <SalonGallery>[];
  List<String> imageList = <String>[];

  bool dataVisible = false;
  bool noDataVisible = true;

  @override
  void initState() {
    super.initState();

    galleyDataList = widget.galleyDataList;

    if (widget.galleyDataList.length > 0) {
      dataVisible = true;
      noDataVisible = false;

      print(galleyDataList[0].imagePath);

      for (int i = 0; i < galleyDataList.length; i++) {
        imageList.add(galleyDataList[i].imagePath! + galleyDataList[i].image!);
      }
    } else {
      dataVisible = false;
      noDataVisible = true;
    }
    int imageLength = imageList.length;
    print("imageLength:$imageLength");
  }

  int? currentSelectedIndex;
  String? categoryName;

  @override
  Widget build(BuildContext context) {
    dynamic screenHeight = MediaQuery.of(context).size.height;
    dynamic screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 45),
          color: whiteColor,
          height: double.infinity,
          width: double.infinity,
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            children: <Widget>[
              Visibility(
                visible: dataVisible,
                child: SizedBox(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.8,
                  child: Container(
                    color: Colors.transparent,
                    child: StaggeredGridView.countBuilder(
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 4,
                      itemCount: imageList.length,
                      itemBuilder: (BuildContext context, int index) => GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FullImagePage(
                                    image: imageList[index],
                                  )));
                        },
                        child: new Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: new Container(
                              child: CachedNetworkImage(
                                imageUrl: imageList[index],
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
                            )),
                      ),
                      staggeredTileBuilder: (int index) => new StaggeredTile.count(2, index.isEven ? 2 : 1),
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: noDataVisible,
                child: SizedBox(
                  width: screenWidth,
                  height: screenHeight * 0.5,
                  child: Container(
                    child: Center(
                      child: Container(
                          width: screenWidth,
                          height: screenHeight,
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
                                  StringConstant.noImagesAvailable,
                                  style: TextStyle(
                                      color: whiteA3,
                                      fontFamily: ConstantFont.montserratMedium,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
