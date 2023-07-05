import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../router/app_router.dart';

GetIt locator = GetIt.instance;

Future setUplocator() async {
  locator.registerSingleton<GoRouter>(router());
}
