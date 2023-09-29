import 'dart:convert';
import 'dart:developer';

import 'package:ngbuka/src/config/keys/app_keys.dart';
import 'package:ngbuka/src/config/locator/app_locator.dart';
import 'package:ngbuka/src/config/services/api/api_client.dart';
import 'package:ngbuka/src/config/services/api/endpoints.dart';
import 'package:ngbuka/src/config/services/storage_service.dart';
import 'package:ngbuka/src/domain/data/login_model.dart';
import 'package:ngbuka/src/domain/data/user_model.dart';

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

  Future<UserModel> getMechanicProfile() async {
    final response =
        await ApiClient.get(Endpoints.getProfileMechanic, useToken: true);
    if (response.status == 200) {
      // log(response.entity);
      return UserModel.fromJson(response.entity);
    }
    return UserModel();
  }

  Future<LoginModel> loginEmail(Map<String, dynamic> body) async {
    final response =
        await ApiClient.post(Endpoints.login, body: body, useToken: false);
    if (response.status == 200) {
      locator<LocalStorageService>()
          .saveDataToDisk(AppKeys.token, json.encode(response.entity["token"]));
      return LoginModel.fromJson(response.entity);
    }
    return LoginModel();
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

  Future<bool> signOut() async {
    final response =
        await ApiClient.patch(Endpoints.logout, body: null, useToken: true);
    if (response.status == 200) {
      return true;
    }
    return false;
  }

  Future<bool> updateInfo(Map<String, dynamic> body) async {
    final response = await ApiClient.put(Endpoints.getProfileMechanic,
        body: body, useToken: false);
    if (response.status == 200) {
      return true;
    }
    return false;
  }

  Future<UserModel> updateMechanicProfile() async {
    final response =
        await ApiClient.get(Endpoints.getProfileMechanic, useToken: true);
    if (response.status == 200) {
      return UserModel.fromJson(response.entity);
    }
    return UserModel();
  }

  Future<bool> verifyOTP(Map<String, String> body) async {
    final response =
        await ApiClient.patch(Endpoints.verifyOTP, body: body, useToken: true);
    if (response.status == 200) {
      return true;
    }
    return false;
  }

  Future<bool> verifyPasswordOTP(Map<String, String> body) async {
    final response = await ApiClient.post(Endpoints.resetOTPVerify,
        body: body, useToken: true);
    if (response.status == 200) {
      log(response.entity["token"].toString());
      locator<LocalStorageService>()
          .saveDataToDisk(AppKeys.token, json.encode(response.entity["token"]));
      return true;
    }
    return false;
  }
}
