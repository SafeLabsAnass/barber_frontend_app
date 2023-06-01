
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SizeUtils {
  static Size _size = Get.size;

  static double get width => _size.width;

  static double get height => _size.height;
}