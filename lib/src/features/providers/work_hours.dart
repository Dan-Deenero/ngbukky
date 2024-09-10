import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ngbuka/src/domain/data/city_lga.dart';
import 'package:ngbuka/src/domain/data/services_model.dart';
import 'package:ngbuka/src/domain/data/user_model.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';

final address = TextEditingController();
final businessEmail = TextEditingController();
final businessName = TextEditingController();
final businessPhone = TextEditingController();
final cac = TextEditingController();
final carsFamiliar = TextEditingController();
final city = StateProvider<List<Cities>>((ref) => []);
final town = StateProvider<List<Towns>>((ref) => []);
final states = StateProvider<List<States>>((ref) => []);
final storeName = TextEditingController();
final cityController = TextEditingController();
final endTime = StateProvider<TimeOfDay>((ref) => TimeOfDay.now());
final isLoading = StateProvider<bool>((ref) => true);
final isLoading2 = StateProvider<bool>((ref) => false);
final isFromBackend = StateProvider<bool>((ref) => true);
final availability = StateProvider<List<Availability>>((ref) => []);
final lgaController = TextEditingController();
final listofServices = TextEditingController();
final locationofBusiness = TextEditingController();
final MechanicRepo mechanicRepo = MechanicRepo();
final serviceController = TextEditingController();
final services = StateProvider<MechanicServicesModel?>((ref) => null);

List<String> state = [
  "Select",
  'Abia',
  'Adamawa',
  'Akwa',
  'Anambra',
  'Bauchi',
  'Bayelsa',
  'Benue',
  'Borno',
  'Cross River',
  'Delta',
  'Ebonyi',
  'Edo',
  'Ekiti',
  'Enugu',
  'Gombe',
  'Imo',
  'Jigawa',
  'Kaduna',
  'Kano',
  'Katsina',
  'Kebbi',
  'Kogi',
  'Kwara',
  'Lagos',
  'Nasarawa',
  'Niger',
  'Ogun',
  'Ondo',
  'Osun',
  'Oyo',
  'Plateau',
  'Rivers',
  'Sokoto',
  'Taraba',
  'Yobe',
  'Zamfara'
];
final stateController = TextEditingController();
final stateWorkingHours = StateProvider<List<Map<String, dynamic>>>((ref) {
  return [
    {
      "isChecked": false,
      "day": "Monday",
      "from": "9AM",
      "to": "9PM",
    },
    {
      "isChecked": false,
      "day": "Tuesday",
      "from": "9AM",
      "to": "9PM",
    },
    {
      "isChecked": false,
      "day": "Wednesday",
      "from": "9AM",
      "to": "9PM",
    },
    {
      "isChecked": false,
      "day": "Thursday",
      "from": "9AM",
      "to": "9PM",
    },
    {
      "isChecked": false,
      "day": "Friday",
      "from": "9AM",
      "to": "9PM",
    },
    {
      "isChecked": false,
      "day": "Saturday",
      "from": "9AM",
      "to": "9PM",
    },
    {
      "isChecked": false,
      "day": "Sunday",
      "from": "9AM",
      "to": "9PM",
    }
  ];
});
final workingHourController = TextEditingController();  


