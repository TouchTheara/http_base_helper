library http_base_helper;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_connect/connect.dart';

class ErrorModel {
  final int? statusCode;
  final dynamic bodyString;
  const ErrorModel({this.statusCode, this.bodyString});
}

enum METHODE {
  get,
  post,
  delete,
  update,
}

class ApiBaseHelper extends GetConnect {
  Future<dynamic> onNetworkRequesting(
      {String? fullURL,
      String token = '',
      Map<String, String>? header,
      Map<String, dynamic>? body,
      required METHODE? methode,
      required bool isAuthorize,
      bool isConvertToByte = false}) async {
    debugPrint("Full Url: $fullURL");
    Map<String, String> defaultHeader = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': isAuthorize ? 'Bearer $token' : ''
    };
    debugPrint('');
    try {
      switch (methode) {
        case METHODE.get:
          final response =
              await get(fullURL ?? '', headers: header ?? defaultHeader);
          return _returnResponse(response, isConvertToByte);
        case METHODE.post:
          if (body != null) {
            final response = await post(fullURL, json.encode(body),
                headers: header ?? defaultHeader);
            return _returnResponse(response, isConvertToByte);
          }
          return Future.error(
              const ErrorModel(bodyString: 'Body must be included'));

        case METHODE.delete:
          final response =
              await delete(fullURL ?? '', headers: header ?? defaultHeader);
          return _returnResponse(response, isConvertToByte);
        case METHODE.update:
          if (body != null) {
            final response = await put(fullURL ?? '', json.encode(body),
                headers: header ?? defaultHeader);
            return _returnResponse(response, isConvertToByte);
          }
          return Future.error(
              const ErrorModel(bodyString: 'Body must be included'));

        default:
          break;
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  dynamic _returnResponse(Response response, bool isReturnBytes) {
    switch (response.statusCode) {
      case 200:
        var responseJson = isReturnBytes
            ? response.bodyBytes
            : json.decode(response.bodyString!);
        return responseJson;
      case 201:
        var responseJson = isReturnBytes
            ? response.bodyBytes
            : json.decode(response.bodyString!);
        return responseJson;
      case 202:
        var responseJson = isReturnBytes
            ? response.bodyBytes
            : json.decode(response.bodyString!);
        return responseJson;
      case 404:
        return Future.error(
          ErrorModel(
            statusCode: response.statusCode,
            bodyString: json.decode(response.bodyString ?? ""),
          ),
        );
      case 400:
        return Future.error(
          ErrorModel(
            statusCode: response.statusCode,
            bodyString: json.decode(response.bodyString ?? ""),
          ),
        );
      case 401:
      case 403:
        return Future.error(
          ErrorModel(
            statusCode: response.statusCode,
            bodyString: json.decode(response.bodyString ?? ""),
          ),
        );
      case 500:
        break;
      default:
        return Future.error(
          ErrorModel(
            statusCode: response.statusCode,
            bodyString: json.decode(response.bodyString ?? ""),
          ),
        );
    }
  }
}
