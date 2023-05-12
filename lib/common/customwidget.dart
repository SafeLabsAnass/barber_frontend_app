import 'package:barber_app/constant/color_constant.dart';
import 'package:flutter/material.dart';

class CustomWidget extends StatefulWidget {
  final String category;
  final int? index;
  final bool? isSelected;
  final VoidCallback? onSelect;

  const CustomWidget({
    required this.category,
    Key? key,
    required this.index,
    required this.isSelected,
    required this.onSelect,
  }) : super(key: key);

  @override
  _CustomWidgetState createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  @override
  Widget build(BuildContext context) {
    var color = widget.isSelected! ? pinkColor : greyA5;
    return GestureDetector(
      onTap: widget.onSelect,
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: TextButton(
          onPressed: null,
          style: TextButton.styleFrom(
            backgroundColor: whiteColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: color)),
          ),
          child: Text(
            widget.category,
            style: TextStyle(
                color: widget.isSelected! ? whiteColor : greyA5,
                fontSize: 14,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        decoration: widget.isSelected!
            ? BoxDecoration(
                color: pinkColor,
                border: Border.all(
                  color: pinkColor,
                ),
                borderRadius: BorderRadius.circular(8),
              )
            : BoxDecoration(),
      ),
    );
  }
}
