import 'package:get/get.dart';

import 'controller.dart';

class TrackingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrackingController>(
          () => TrackingController(),
    );
  }
}