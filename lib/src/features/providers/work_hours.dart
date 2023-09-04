import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ngbuka/src/domain/data/services_model.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';

final address = TextEditingController();
final businessEmail = TextEditingController();
final businessName = TextEditingController();
final businessPhone = TextEditingController();
final cac = TextEditingController();
final carsFamiliar = TextEditingController();
final city = StateProvider<List<String>>((ref) => ["Select"]);
final cityController = TextEditingController();
final isLoading = StateProvider<bool>((ref) => true);
final lga = StateProvider<List<String>>((ref) => ["Select"]);
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
    {"isChecked": true, "from": "9", "to": "9", "day": "Mon"},
    {"isChecked": true, "from": "9", "to": "9", "day": "Tue"},
    {"isChecked": true, "from": "9", "to": "9", "day": "Wed"},
    {"isChecked": true, "from": "9", "to": "9", "day": "Thur"},
    {"isChecked": true, "from": "9", "to": "9", "day": "Fri  "},
    {"isChecked": false, "from": "9", "to": "9", "day": "Sat"},
    {"isChecked": false, "from": "9", "to": "9", "day": "Sun"}
  ];
});
final    workingHourController = TextEditingController();
