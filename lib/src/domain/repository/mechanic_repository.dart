import 'package:ngbuka/src/config/services/api/api_client.dart';
import 'package:ngbuka/src/config/services/api/endpoints.dart';
import 'package:ngbuka/src/domain/data/city_lga.dart';
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

}
