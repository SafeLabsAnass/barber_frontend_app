import 'package:barber_app/ResponseModel/empResponse.dart';
import 'package:barber_app/constant/color_constant.dart';
import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  final EmpData _item;

  CustomCheckBox(this._item);

  @override
  _CustomCheckBox createState() => _CustomCheckBox();
}

class _CustomCheckBox extends State<CustomCheckBox> {
  bool? _value;

  @override
  void initState() {
    _value = widget._item.isSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var color = _value! ? pinkColor : greyA5;

    return Container(
        width: 15,
        height: 15,
        child: GestureDetector(
          onTap: () {
            setState(() {
              _value = !_value!;
              print(_value);
            });
          },
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: color,
              border: Border.all(
                color: whiteDD,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: _value!
                  ? Icon(
                      Icons.check,
                      size: 15.0,
                      color: whiteColor,
                    )
                  : Icon(
                      Icons.check_box_outline_blank_outlined,
                      size: 15.0,
                      color: color,
                    ),
            ),
          ),
        ));
  }
}
