import 'dart:convert';

import 'package:ngbuka/src/config/keys/app_keys.dart';
import 'package:ngbuka/src/config/locator/app_locator.dart';
import 'package:ngbuka/src/config/services/api/api_client.dart';
import 'package:ngbuka/src/config/services/api/endpoints.dart';
import 'package:ngbuka/src/config/services/storage_service.dart';

class AuthRepo {
  Future<bool> createNewPassword(Map<String, String> body) async {
    final response =
        await ApiClient.patch(Endpoints.newPasword, body: body, useToken: true);
    if (response.status == 200) {
      return true;
    }
    return false;
  }

  Future<bool> forgotEmail(Map<String, String> body) async {
    final response = await ApiClient.patch(Endpoints.resetPassword,
        body: body, useToken: true);
    if (response.status == 200) {
      return true;
    }
    return false;
  }

  Future<bool> loginEmail(Map<String, dynamic> body) async {
    final response =
        await ApiClient.post(Endpoints.login, body: body, useToken: true);
    if (response.status == 200) {
      return true;
    }
    return false;
  }

  Future<bool> register(Map<String, String> body) async {
    final response =
        await ApiClient.post(Endpoints.register, body: body, useToken: false);
    if (response.status == 200) {
      locator<LocalStorageService>()
          .saveDataToDisk(AppKeys.token, json.encode(response.entity["token"]));
      return true;
    }
    return false;
  }

  Future<bool> resendOTP() async {
    final response =
        await ApiClient.patch(Endpoints.resendOTP, body: null, useToken: true);
    if (response.status == 200) {
      return true;
    }
    return false;
  }

  Future<bool> verifyOTP(String body) async {
    final response =
        await ApiClient.post(Endpoints.verifyOTP, body: body, useToken: true);
    if (response.status == 200) {
      return true;
    }
    return false;
  }

  Future<bool> verifyPasswordOTP(Map<String, String> body) async {
    final response = await ApiClient.post(Endpoints.resetOTPVerify,
        body: body, useToken: true);
    if (response.status == 200) {
      return true;
    }
    return false;
  }
}
