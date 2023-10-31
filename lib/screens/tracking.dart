import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/trackingController/controller.dart';

class TrackingPage extends GetView<TrackingController> {
  static const routeName = '/tracking';
  const TrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tracking')),
      body: WillPopScope(
        onWillPop: () async {
          Get.back();
          return true;
        },
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                (controller.onlineLocationList.isNotEmpty)
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.onlineLocationList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Container(
                              color: (index % 2 == 0)
                                  ? Colors.lightBlueAccent
                                  : Colors.lightGreenAccent,
                              child: Column(
                                children: [
                                  Text(
                                      'Latitude:${controller.onlineLocationList.elementAt(index).latitude}'),
                                  Text(
                                      'Longitude:${controller.onlineLocationList.elementAt(index).longitude}'),
                                ],
                              ),
                            ),
                          );
                        })
                    : const SizedBox(
                        child: Text('Online location list is Empty'),
                      ),
                const Divider(
                  color: Colors.black,
                ),
                (controller.offlineLocationList.isNotEmpty)
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.offlineLocationList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Container(
                              color: (index % 2 == 0)
                                  ? Colors.lightBlueAccent
                                  : Colors.lightGreenAccent,
                              child: Column(
                                children: [
                                  Text(
                                      'Latitude:${controller.offlineLocationList[index].latitude}'),
                                  Text(
                                      'Longitude:${controller.offlineLocationList[index].longitude}'),
                                ],
                              ),
                            ),
                          );
                        })
                    : const SizedBox(
                        child: Text('Offline location list is Empty'))
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        Obx(() => Text('API success: ${controller.success.value}')),
        FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.lightBlueAccent,
          foregroundColor: Colors.white,
          child:
              Obx(() => Text(controller.onlineLocationList.length.toString())),
        ),
        FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.lightGreenAccent,
          foregroundColor: Colors.red,
          child:
              Obx(() => Text(controller.offlineLocationList.length.toString())),
        ),
      ],
    );
  }
}
