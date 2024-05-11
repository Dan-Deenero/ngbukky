import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:ngbuka/src/config/services/storage_service.dart';

import '../router/app_router.dart';

GetIt locator = GetIt.instance;

Future setUplocator() async {
  locator.registerSingleton<GoRouter>(router());
  var instance = await LocalStorageService.getInstance();
  locator.registerSingleton<LocalStorageService>(instance);
}
// 09040310284