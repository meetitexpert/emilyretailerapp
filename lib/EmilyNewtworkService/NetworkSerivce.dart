import 'package:dio/dio.dart';
import 'package:emilyretailerapp/Utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:emilyretailerapp/Utils/ConstTools.dart';

import '../Utils/AppTools.dart';
import '../Utils/DeviceTools.dart';
import 'package:date_format/date_format.dart';

class HttpService {
  late Dio dio;

  HttpService() {
    dio = Dio(BaseOptions(baseUrl: ConstTools.hostURL));

    initilizerInterceptors();
  }

  Future<Response> getRequest(String endPoint) async {
    Response response;

    try {
      response = await dio.get(endPoint);
    } on DioError catch (e) {
      response =
          Response(requestOptions: RequestOptions(path: '', method: 'GET'));
      debugPrint(e.message);
    }

    return response;
  }

  Future<Response> postRequest(String endPoint,
      Map<String, dynamic>? parameters, BuildContext context) async {
    Response response;
    Options option = Options(headers: getRequestHeaders(endPoint));
    try {
      parameters = getRequestParameters(endPoint, parameters);

      response = await dio.post(endPoint, data: parameters, options: option);
    } on DioError catch (e) {
      debugPrint(e.message);
      throw Exception(e);
    }

    return response;
  }

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

    String? tracnkingId = Constants.prefs?.getString(ConstTools.spTrackingId);
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

  Map<String, dynamic> getRequestParameters(
      String api, Map<String, dynamic>? parameters) {
    //if params are null then initiate the map
    parameters ??= <String, String>{};

    parameters["access_token"] = AppTools.accessToken;

    String? tracnkingId = Constants.prefs?.getString(ConstTools.spTrackingId);
    if (tracnkingId != null && !api.contains(ConstTools.apiGetTrackingId)) {
      parameters["tracking_id"] = tracnkingId;
    }

    return parameters;
  }

  initilizerInterceptors() {
    dio.interceptors.add(InterceptorsWrapper(onError: (error, handler) {
      debugPrint(error.message);

      handler.next(error);
    }, onRequest: (request, handler) {
      debugPrint('${request.method} ${request.path}');
      handler.next(request);
    }, onResponse: (response, handler) {
      if (response.statusCode == 200) {
        debugPrint(response.data["status"]);
      }

      handler.next(response);
    }));
  }
}
