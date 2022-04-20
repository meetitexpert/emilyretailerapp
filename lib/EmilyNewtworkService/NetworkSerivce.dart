// ignore_for_file: unrelated_type_equality_checks

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:emilyretailerapp/Utils/ConstTools.dart';

import '../Utils/AppTools.dart';
import '../Utils/DeviceTools.dart';
import 'package:date_format/date_format.dart';

import '../Utils/DialogTools.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

enum HttpErrorType {
  httpTimeout,

  httpException,

  unknowmHost,

  parserException,

  noConnections,

  other,
}

class HttpService {
  late Dio dio;

  HttpService() {
    dio = Dio(BaseOptions(baseUrl: ConstTools.hostURL));

    initilizerInterceptors();
  }

  Future isInternetAvailable() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      return true;
    }

    return false;
  }

  //GET Request
  Future<Response> getRequest(String endPoint, BuildContext context) async {
    Response response;

    try {
      response = await dio.get(endPoint);
    } on DioError catch (error) {
      debugPrint(error.message);

      DioErrorHanlding(context, error);

      throw Exception(error);
    }

    return response;
  }

  //POST Request
  Future<Response> postRequest(String endPoint,
      Map<String, dynamic>? parameters, BuildContext context) async {
    Response response;
    Options option = Options(headers: getRequestHeaders(endPoint));

    try {
      parameters = getRequestParameters(endPoint, parameters);

      response = await dio.post(endPoint, data: parameters, options: option);
    } on DioError catch (error) {
      debugPrint(error.message);

      DioErrorHanlding(context, error);

      throw Exception(error);
    }

    return response;
  }

  //Headers handling
  Map<String, String> getRequestHeaders(String api) {
    Map<String, String> headers = {
      "client_class": AppTools.clientClass,
      "app_version": AppTools.appVersion,
      "platform": DeviceTools.devicePlatform,
      "make": DeviceTools.deviceMake,
      "model": DeviceTools.deviceModel,
      "device_pin": DeviceTools.devicePin,
      "os_version": DeviceTools.osVersion,
      "Content-Type": "application/x-www-form-urlencoded",
      "Connection": "keep-alive",
      "Accept": "*/*"
    };

    String? tracnkingId = ConstTools.prefs?.getString(ConstTools.spTrackingId);
    if (tracnkingId != null && !api.contains(ConstTools.apiGetTrackingId)) {
      headers["tracking_id"] = tracnkingId;
    }

    if (api.contains(ConstTools.apiUserLogin)) {
      String date = formatDate(
          DateTime.now(), [yyyy, '-', mm, '-', dd, HH, ':', nn, ':', ss, am]);
      headers["date_time"] = date;
    }

    return headers;
  }

  //Parameters handling
  Map<String, dynamic> getRequestParameters(
      String api, Map<String, dynamic>? parameters) {
    //if params are null then initiate the map
    parameters ??= <String, String>{};

    parameters["access_token"] = AppTools.accessToken;
    if (!api.contains(ConstTools.apiGetRetailerLocationsDetail)) {
      parameters["clientClass"] = AppTools.clientClass;
    }

    String? tracnkingId = ConstTools.prefs?.getString(ConstTools.spTrackingId);
    if (tracnkingId != null &&
        !api.contains(ConstTools.apiGetTrackingId) &&
        !api.contains(ConstTools.apiGetRetailerLocationsDetail)) {
      parameters["trackingId"] = tracnkingId;
    }

    return parameters;
  }

  //interceptor handling response
  initilizerInterceptors() {
    dio.interceptors.add(InterceptorsWrapper(onError: (error, handler) {
      debugPrint(error.message);

      handler.next(error);
    }, onRequest: (request, handler) {
      debugPrint('${request.method} ${request.path}');
      handler.next(request);
    }, onResponse: (response, handler) {
      handler.next(response);
    }));
  }

  //Errors hanlding
  // ignore: non_constant_identifier_names
  void DioErrorHanlding(BuildContext context, DioError error) {
    if (isInternetAvailable() == false) {
      checkHttpError(context, HttpErrorType.noConnections, null);
    } else if (error.type == DioErrorType.connectTimeout ||
        error.type == DioErrorType.sendTimeout ||
        error.type == DioErrorType.receiveTimeout) {
      checkHttpError(context, HttpErrorType.httpTimeout, null);
    } else if (error.type == DioErrorType.response) {
      checkHttpError(
          context, HttpErrorType.httpException, error.response!.statusCode);
    } else if (error.type == DioErrorType.other) {
      checkHttpError(context, HttpErrorType.other, null);
    }
  }

  //Errors handling
  void checkHttpError(
      BuildContext context, HttpErrorType? error, dynamic result) {
    if (error != null) {
      if (error == HttpErrorType.noConnections) {
        DialogTools.alertDialg(
            "OK",
            "",
            "You don’t seem to be connected to the Internet. Please try again later.\nError Code: 100",
            context);
      } else if (error == HttpErrorType.unknowmHost) {
        DialogTools.alertDialg(
            "OK",
            "",
            "Sorry, we are experiencing network problem. Please try again later.\nError Code: 101",
            context);
      } else if (error == HttpErrorType.httpTimeout) {
        DialogTools.alertDialg(
            "OK",
            "",
            "Sorry, we are experiencing request time out at this time. Please try again later.\nError Code: 102",
            context);
      } else if (error == HttpErrorType.parserException) {
        DialogTools.alertDialg(
            "OK",
            "",
            "Sorry, we are experiencing technical difficulty. Please try again later.\nError Code: 103",
            context);
      } else if (error == HttpErrorType.httpException) {
        DialogTools.alertDialg(
            "OK",
            "",
            "Sorry, we are experiencing http ${result} issue at this time. Please try again later.\nError Code: 104",
            context);
      } else if (error == HttpErrorType.other) {
        DialogTools.alertDialg(
            "OK",
            "",
            "Sorry, we are experiencing technical difficulty. Please try again later.\nError Code: 103",
            context);
      }
    }
  }
}
