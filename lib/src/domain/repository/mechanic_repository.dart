import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:ngbuka/src/config/locator/app_locator.dart';
import 'package:ngbuka/src/config/services/api/api_client.dart';
import 'package:ngbuka/src/config/services/api/endpoints.dart';
import 'package:ngbuka/src/config/services/storage_service.dart';
import 'package:ngbuka/src/domain/data/city_lga.dart';
import 'package:ngbuka/src/domain/data/inspection_booking_model.dart';
import 'package:ngbuka/src/domain/data/quote_model.dart';
import 'package:ngbuka/src/domain/data/services_model.dart';
import 'package:ngbuka/src/domain/data/statistics_model.dart';

import '../../config/keys/app_keys.dart';

class MechanicRepo {
  Future<bool> acceptOrRejectBooking(Map<String, String> body, id) async {
    final response = await ApiClient.patch('${Endpoints.getAllBooking}/$id',
        body: body, useToken: true);
    if (response.status == 200) {
      return true;
    }
    return false;
  }

  Future<bool> acceptOrRejectQuote(Map<String, String> body, id) async {
    final response = await ApiClient.patch('${Endpoints.getAllQuotes}/$id',
        body: body, useToken: true);
    if (response.status == 200) {
      return true;
    }
    return false;
  }

  Future<bool> addPersonalizedService(Map<dynamic, dynamic> body) async {
    final response = await ApiClient.post(Endpoints.addPersonalizedService,
        body: body, useToken: true);
    if (response.status == 200) {
      return true;
    }
    return false;
  }

  Future<List<BookingModel>> getAllBooking(String status) async {
    final response = await ApiClient.get(
        '${Endpoints.getAllBooking}?status=$status',
        useToken: true);
    List<BookingModel> booking = [];
    if (response.status == 200) {
      for (var bookingModel in response.entity['rows']) {
        booking.add(BookingModel.fromJson(bookingModel));
      }
      return booking;
    } else if (response.status == 404) {
      return [];
    }
    return booking;
  }

  Future<List<QuotesModel>> getAllQuotes() async {
    final response =
        await ApiClient.get(Endpoints.getAllQuotes, useToken: true);
    List<QuotesModel> quote = [];
    if (response.status == 200) {
      for (var quoteModel in response.entity['rows']) {
        quote.add(QuotesModel.fromJson(quoteModel));
      }
      return quote;
    } else if (response.status == 404) {
      return [];
    }
    return quote;
  }

  Future<MechanicServicesModel> getMechanicProfile() async {
    final response =
        await ApiClient.get(Endpoints.getMechanicServices, useToken: true);
    if (response.status == 200) {
      return MechanicServicesModel.fromJson(response.entity);
    }
    return MechanicServicesModel();
  }

  Future<BookingModel> getoneBooking(id) async {
    final response =
        await ApiClient.get('${Endpoints.getAllBooking}/$id', useToken: true);
    if (response.status == 200) {
      log(response.entity.toString());
      return BookingModel.fromJson(response.entity);
    }
    return BookingModel();
  }

  Future<QuotesModel> getoneQuote(id) async {
    final response =
        await ApiClient.get('${Endpoints.getAllQuotes}/$id', useToken: true);
    if (response.status == 200) {
      log(response.entity.toString());
      return QuotesModel.fromJson(response.entity);
    }
    return QuotesModel();
  }

  Future<CityLGA> getState(String state) async {
    String endpoint = "${Endpoints.getLocation}?slug=$state";
    final response = await ApiClient.get(endpoint, useToken: true);
    if (response.status == 200) {
      return CityLGA.fromJson(response.entity);
    }
    return CityLGA();
  }

  Future<StatisticsModel> getStatisticsInfo() async {
    final response =
        await ApiClient.get(Endpoints.getStatisticsInfo, useToken: true);
    if (response.status == 200) {
      return StatisticsModel.fromJson(response.entity);
    }
    return StatisticsModel();
  }

  Future<bool> markInspection(Map<String, String> body, id) async {
    final response = await ApiClient.patch(
        '${Endpoints.getAllBooking}/$id/finish',
        body: body,
        useToken: true);
    if (response.status == 200) {
      return true;
    }
    return false;
  }

  Future<bool> markInspectionAsCompleted(Map<String, String> body, id) async {
    final response = await ApiClient.patch(
        '${Endpoints.getAllBooking}/$id/complete',
        body: body,
        useToken: true);
    if (response.status == 200) {
      return true;
    }
    return false;
  }

  Future<bool> markQuoteAsCompleted(Map<String, String> body, id) async {
    final response = await ApiClient.patch(
        '${Endpoints.getAllQuotes}/$id/complete',
        body: body,
        useToken: true);
    if (response.status == 200) {
      return true;
    }
    return false;
  }

  Future<bool> saveProfileImage(Map<String, dynamic> data) async {
    final response =
        await ApiClient.put(Endpoints.userProfileImage, body: data);
    if (response.status == 200) {
      return true;
    }
    return false;
  }

  Future<bool> sendQuoteForBooking(Map<dynamic, dynamic> body, id) async {
    final response = await ApiClient.post(
        '${Endpoints.getAllBooking}/$id/quote',
        body: body,
        useToken: false);
    if (response.status == 200) {
      locator<LocalStorageService>()
          .saveDataToDisk(AppKeys.token, json.encode(response.entity["token"]));
      return true;
    }
    return false;
  }

  Future<bool> sendQuoteForQuotes(Map<String, String> body, id) async {
    final response = await ApiClient.post('${Endpoints.getAllQuotes}/$id/quote',
        body: body, useToken: false);
    if (response.status == 200) {
      locator<LocalStorageService>()
          .saveDataToDisk(AppKeys.token, json.encode(response.entity["token"]));
      return true;
    }
    return false;
  }

  Future<bool> updateBusinessInfo(Map<String, dynamic> data) async {
    final response = await ApiClient.put(Endpoints.updateBusiness, body: data);
    if (response.status == 200) {
      return true;
    }
    return false;
  }
}
