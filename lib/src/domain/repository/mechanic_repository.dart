import 'dart:async';
import 'dart:developer';

import 'package:ngbuka/src/config/services/api/api_client.dart';
import 'package:ngbuka/src/config/services/api/endpoints.dart';
import 'package:ngbuka/src/domain/data/city_lga.dart';
import 'package:ngbuka/src/domain/data/inspection_booking_model.dart';
import 'package:ngbuka/src/domain/data/services_model.dart';
import 'package:ngbuka/src/domain/data/statistics_model.dart';

class MechanicRepo {
  Future<MechanicServicesModel> getMechanicProfile() async {
    final response =
        await ApiClient.get(Endpoints.getMechanicServices, useToken: true);
    if (response.status == 200) {
      return MechanicServicesModel.fromJson(response.entity);
    }
    return MechanicServicesModel();
  }

  Future<CityLGA> getState(String state) async {
    String endpoint = "${Endpoints.getLocation}?slug=$state";
    final response = await ApiClient.get(endpoint, useToken: true);
    if (response.status == 200) {
      return CityLGA.fromJson(response.entity);
    }
    return CityLGA();
  }

  Future<bool> updateBusinessInfo(Map<String, dynamic> data) async {
    final response = await ApiClient.put(Endpoints.updateBusiness, body: data);
    if (response.status == 200) {
      return true;
    }
    return false;
  }

  Future<StatisticsModel> getStatisticsInfo() async {
    final response =
        await ApiClient.get(Endpoints.getStatisticsInfo, useToken: true);
    if (response.status == 200) {
      return StatisticsModel.fromJson(response.entity);
    }
    return StatisticsModel();
  }

  // Future<List<BookingModel>> getAllBooking() async {
  //   final response =
  //       await ApiClient.get(Endpoints.getAllBooking, useToken: true);
  //   if (response.status == 200) {
  //     var jsonResponse = jsonDecode(response.entity);
  //     List<BookingModel> bookings = [];
  //     for (var b in jsonResponse){
  //       BookingModel books = BookingModel(
  //         id: b['id'],
  //         status: b['status'],
  //         date: b['date'],
  //         brand: b['brand'],
  //         model: b['model'],
  //         year: b['year'],
  //         user: b['user']
  //       );

  //       bookings.add(books);
  //     }
  //     return bookings;
  //   }else{
  //     throw Exception('Failed to load Post');
  //   }
  // }

  Future<List<BookingModel>> getAllBooking(String status) async {
    final response =
        await ApiClient.get('${Endpoints.getAllBooking}?status=$status', useToken: true);
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

  Future<BookingModel> getoneBooking(id) async {
    final response =
        await ApiClient.get('${Endpoints.getAllBooking}/$id', useToken: true);
    if (response.status == 200) {
      log(response.entity.toString());
      return BookingModel.fromJson(response.entity);
    }
    return BookingModel();
  }

  Future<bool> acceptOrReject(Map<String, String> body, id) async {
    final response = await ApiClient.patch('${Endpoints.getAllBooking}/$id',
        body: body, useToken: true);
    if (response.status == 200) {
      return true;
    }
    return false;
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
}
