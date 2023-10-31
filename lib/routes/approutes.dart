
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../controllers/trackingController/binding.dart';
import '../screens/tracking.dart';

class AppPages {
  AppPages._();

  static const initialRoute = TrackingPage.routeName;
  static final routes = [
    GetPage(
      name: TrackingPage.routeName,
      page: () => const TrackingPage(),
      binding: TrackingBinding(),
    )
  ];
}