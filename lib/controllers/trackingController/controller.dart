import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/activity/repository.dart';
import '../../model/activity/activity.dart';
import '../../needs.dart';

class TrackingController extends GetxController {
  final repo = ActivityRepository();
  final success = true.obs;

  var networkStatus = ''.obs;
  var grant = false.obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var onlineLocationList = <Activity>[].obs;
  var offlineLocationList = <Activity>[].obs;

  late Timer timer1;
  late Position current;

  String address= '';
  DateTime currentTime = DateTime.now();

  @override
  Future<void> onInit() async {
    super.onInit();

    onlineLocationList.value = [];
    offlineLocationList.value = [];
    previousData();
    Future.delayed(const Duration(seconds: 5), () async{await getLocation();});
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint('dispose');
    timer1.cancel();
  }

  void sendData() async{
    String id= await getDeviceId();
    debugPrint('id:$id');
    timer1 = Timer.periodic(const Duration(seconds: 5), (Timer t1) async {

      final activityData = Activity(
        userId:'7',
        userStatusType:'0',
        securityAssignmentId:'',
        isAssignmentStarted:'0',
        authToken:'dbb237c9f8605355a8d6077df487ba9ffc1261c0',
        userRoleId:'3',
        timestamp:currentTime.toString(),
        deviceId:id,
        distance:0,
        latitude:latitude.value.toString(),
        longitude:longitude.value.toString(),
        accuracy:'3.691',
        floorId: 1,
      );
      String status = await checkConnectivity();

      if(status =='online' && offlineLocationList.isNotEmpty){
        int length = offlineLocationList.length;
        for (int i = 0; i < length; i++) {
          hitTheAPI(offlineLocationList.removeAt(0));
        }
      }
      if(status=='online'){
        hitTheAPI(activityData);
      }
      if(status=='offline'){
        offlineLocationList.add(activityData);
        saveofflineList(offlineLocationList);
      }
    });
  }

  void hitTheAPI(Activity activityData) async{
    //final result = await repo.sendActivity(activityData);
    if(success.value){
      onlineLocationList.add(activityData);
      saveList(onlineLocationList);
      if(onlineLocationList.length%3==0){
          success.value=!success.value;
      }
    }
    else if(!success.value){
      hitTheAPI2(activityData);
    }
  }

  void hitTheAPI2(Activity activityData) async{
    //final result = await repo.sendActivity(activityData);
    if(success.value){
      onlineLocationList.add(activityData);
      saveList(onlineLocationList);
    }
    else if(!success.value){
     offlineLocationList.add(activityData);
     saveofflineList(offlineLocationList);
     if(offlineLocationList.length%1==0){
         success.value=!success.value;
     }
    }
  }

  void previousData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //await getOnlineList();
    await getOfflineList();
    String status = await checkConnectivity();

    if(status =='online' && offlineLocationList.isNotEmpty){
      int length = offlineLocationList.length;
      for (int i = 0; i < length; i++) {
        hitTheAPI(offlineLocationList.removeAt(0));
      }
      prefs.remove('Offline-Data');
      saveList(onlineLocationList);
    }
  }

  getLocation() async{
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      debugPrint('service disabled');
      await Geolocator.requestPermission();
    }
    else {
      LocationPermission permission = await Geolocator.checkPermission();
      if(permission == LocationPermission.denied){
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar('', 'Location Permission Denied');
          return Future.error('Location permissions are denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        debugPrint('denied forever');
        await Geolocator.openAppSettings();
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
      if(permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
        Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
      current = position;
      latitude.value = current.latitude;
      longitude.value = current.longitude;
      if(latitude.value!=0.0 && longitude.value!=0.0) {
        sendData();
      }
  }).catchError((e){
   debugPrint(e);
  });
      }
    }
  }

  Future<void> saveList(List<Activity> myList) async {
    final prefs = await SharedPreferences.getInstance();
    final myListData = myList.map((item) => item.toMap()).toList();

    await prefs.setStringList(
        'Online-Data', myListData.map((item) => jsonEncode(item)).toList());
  }

  Future<void> saveofflineList(List<Activity> myList) async {
    final prefs = await SharedPreferences.getInstance();
    final myListData = myList.map((item) => item.toMap()).toList();

    await prefs.setStringList(
        'Offline-Data', myListData.map((item) => jsonEncode(item)).toList());
  }

  Future<List<Activity>> getOnlineList() async {
    final prefs = await SharedPreferences.getInstance();
    final myListData = prefs.getStringList('Online-Data') ?? [];

    if (myListData.isEmpty) {
      onlineLocationList.value = [];
    }
    else {
      onlineLocationList.value =
          myListData.map((item) => Activity.fromMap(jsonDecode(item)))
              .toList();
    }
    debugPrint(onlineLocationList.length.toString());
    return onlineLocationList;
  }

  Future<List<Activity>> getOfflineList() async {
    final prefs = await SharedPreferences.getInstance();
    final myListData = prefs.getStringList('Offline-Data') ?? [];

    if (myListData.isEmpty) {
      offlineLocationList.value = [];
    }
    else {
      offlineLocationList.value =
          myListData.map((item) => Activity.fromMap(jsonDecode(item)))
              .toList();
    }
    return offlineLocationList;
  }

  Future<String> checkConnectivity() async {
    final connectivityResult =
    await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      networkStatus.value = 'offline';
    } else if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      networkStatus.value = 'online';
    }
    return networkStatus.value;
  }
}

