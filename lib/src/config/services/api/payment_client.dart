import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/config/locator/app_locator.dart';
import 'package:ngbuka/src/config/services/api/endpoints.dart';
import 'package:ngbuka/src/config/services/api/payment_response.dart';

import 'package:ngbuka/src/features/presentation/widgets/app_overlay.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_toast.dart';
import 'package:overlay_support/overlay_support.dart';

void _handleDioError(PaymentResponse response) {
  // showToast(response.message!);
  OverlaySupportEntry.of(AppHelper.overlayContext!)?.dismiss();
  ToastResp.toastMsgError(resp: response.message);

  inspect(response.title);
}

class PaymentClient{
  static final _dio = Dio(
    BaseOptions(baseUrl: Endpoints.paystack),
  );

  static final _defaultHeader = {
    'Content-Type': 'application/json',
  };

  static const  _token = 'sk_test_e067628a1f0a60083e42cd51576f0f0ff0588194';


  static Future get(
    String endpoint, {
    dynamic queryParameters,
    bool useToken = true,
  }) async {
    final result = await _makeRequest(
      () async {
        final header = _defaultHeader;
        log('this is the token$_token');

        if (useToken) {
          header.addAll(
            {'Authorization': 'Bearer $_token'},
          );
        }

        final options = Options(headers: header);
        log('${_dio.options.baseUrl}/$endpoint');

        final response = await _dio.get(endpoint,
            queryParameters: queryParameters, options: options);
        return response.data;
      },
    );
    return result;
  }

  
  static void _handleSocketException(SocketException e) {
    debugPrint('Check Internet');
  }

  static Future _makeRequest(Function request) async {
    try {
      final result = await request();
      log(result.toString());

      return SuccessResponse.toApiResponse(result);
    } on DioError catch (e) {
      log(e.response.toString());
      log(e.response!.statusCode.toString());
      if (e.response?.statusCode == 401) {
        locator<GoRouter>().push(AppRoutes.login);
        // router.push(AppRoutes.login);
      }
      log(e.toString());
      log(e.response!.toString());
      _handleDioError(PaymentResponse.toApiResponse(
          e.response?.data ?? e.response?.statusMessage));

      return PaymentResponse.toApiResponse(e.response!.data);
    } on SocketException catch (e) {
      _handleSocketException(e);
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }
}