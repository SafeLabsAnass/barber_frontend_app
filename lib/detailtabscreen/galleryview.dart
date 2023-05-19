import 'package:barber_app/ResponseModel/salonDetailResponse.dart';
import 'package:barber_app/constant/color_constant.dart';
import 'package:barber_app/constant/constant_font.dart';
import 'package:barber_app/constant/dymmyimages.dart';
import 'package:barber_app/constant/string_constant.dart';
import 'package:barber_app/screens/full_image_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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

      print(galleyDataList.length);

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
      primary: true,
      extendBody: true,
      resizeToAvoidBottomInset: true,
      body: Container(
        margin: EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 5),
        color: whiteColor,
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (dataVisible)
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    mainAxisExtent: screenHeight * 0.27,
                  ),
                  itemCount: imageList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FullImagePage(
                            image: imageList[index],
                          ),
                        ));
                      },
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          child: CachedNetworkImage(
                            imageUrl: imageList[index],
                            imageBuilder: (context, imageProvider) => Container(
                              width: screenWidth,
                              height: screenHeight,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fill,
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              if (noDataVisible)
                SizedBox(
                  width: screenWidth,
                  height: screenHeight * 0.8,
                  child: Container(
                    child: Center(
                      child: Container(
                        width: screenWidth,
                        height: screenHeight,
                        alignment: Alignment.center,
                        child: Column(
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
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    ),
  );
}
}