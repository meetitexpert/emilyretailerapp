import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HttpService {
  late Dio dio;
  final baseUrl = 'https://services.emilyrewards.com/RLP-Service/';

  HttpService() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));

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

  Future<Response> postRequest(
      String endPoint, Map<String, dynamic>? parameters) async {
    Response response;
    Options option = Options(headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Connection": "keep-alive",
      "Accept": "application/json"
    });
    try {
      response = await dio.post(endPoint, data: parameters, options: option);
    } on DioError catch (e) {
      debugPrint(e.message);
      throw Exception(e);
    }

    return response;
  }

  initilizerInterceptors() {
    dio.interceptors.add(InterceptorsWrapper(onError: (error, handler) {
      debugPrint(error.message);
      handler.next(error);
    }, onRequest: (request, handler) {
      debugPrint('${request.method} ${request.path}');
      handler.next(request);
    }, onResponse: (response, handler) {
      if (response.statusCode == 200){
          debugPrint(response.data["status"]);
      }
      
      handler.next(response);
    }));
  }
}
