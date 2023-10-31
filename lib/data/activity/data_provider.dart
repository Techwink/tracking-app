import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../model/activity/activity.dart';

class ActivityProvider {
  final http.Client httpClient = http.Client();

  Future<dynamic> activity(Activity activityData) async {
    try {
      debugPrint('Device Activity:${jsonEncode(activityData.toJson())}');
      final res = await httpClient.post(
        Uri.parse(''),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${activityData.authToken}',
          HttpHeaders.contentTypeHeader: 'application/json'
        },
        body: jsonEncode(
          activityData.toJson(),
        ),
      );
      debugPrint('The response is ${res.statusCode.toString()}' '${res.body}');
      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        throw Exception(res.body);
      }
    } on SocketException {
      throw const SocketException('Check your internet connection');
    } on TimeoutException {
      throw TimeoutException('Connection timeout, try again');
    } catch (e) {
      debugPrint('The error is ${e.toString()}');
      throw Exception(e.toString());
    }
  }
}
