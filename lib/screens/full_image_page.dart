import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
class FullImagePage extends StatefulWidget {
  final String? image;
  FullImagePage({Key? key,this.image}) : super(key: key);

  @override
  _FullImagePageState createState() => _FullImagePageState();
}

class _FullImagePageState extends State<FullImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: CachedNetworkImage(
          imageUrl:widget.image!,
        ),
      ),
    );
  }
}
