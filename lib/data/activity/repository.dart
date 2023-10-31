import 'dart:async';
import 'dart:io';

import 'data_provider.dart';

import '../../model/activity/activity.dart';
import '../../model/activity/activity_jsonResponse.dart';

class ActivityRepository{

  final provider = ActivityProvider();

  Future<ActivityJsonResponse> sendActivity(Activity activityData) async {
   try{
     final data = await provider.activity(activityData);
     return ActivityJsonResponse.fromJson(data);
   } on SocketException catch (e) {
     throw SocketException(e.message.toString());
   } on TimeoutException catch (e) {
     throw TimeoutException(e.toString());
   } on Exception catch (e) {
     throw Exception(e.toString());
   }
  }

}