import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/keys/app_keys.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/config/locator/app_locator.dart';
import 'package:ngbuka/src/config/services/api/endpoints.dart';
import 'package:ngbuka/src/config/services/api/payment_response.dart';
import 'package:ngbuka/src/config/services/storage_service.dart';

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

  static const  _token = 'sk_live_f0e0cbbfe396d49e74ed6c06c0692e0d6b9c4f72';


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
        if(locator<LocalStorageService>().getDataFromDisk(AppKeys.userType) == 'mechanic'){
          locator<GoRouter>().push(AppRoutes.login);
          log(locator<LocalStorageService>().getDataFromDisk(AppKeys.userType));
        }else if(locator<LocalStorageService>().getDataFromDisk(AppKeys.userType) == 'dealer'){
          locator<GoRouter>().push(AppRoutes.dealerLogin);
          log(locator<LocalStorageService>().getDataFromDisk(AppKeys.userType));


        }
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