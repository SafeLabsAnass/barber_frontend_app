

import 'package:barber_app/constant/appconstant.dart';
import 'package:barber_app/constant/preferenceutils.dart';
import 'package:dio/dio.dart';

class RetroApi {

  Dio dioData()
   {
    final dio = Dio();


    dio.options.headers["Authorization"] =  "Bearer"+"  "+PreferenceUtils.getString(AppConstant.headertoken);   // config your dio headers globally
    dio.options.headers["Accept"] = "application/json";   // config your dio headers globally
    dio.options.headers["Content-Type"] = "application/x-www-form-urlencoded";
    dio.options.followRedirects = false;

    return dio;
   }
}