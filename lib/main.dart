import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tracking/routes/approutes.dart';
import 'controllers/trackingController/binding.dart';
import 'needs.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final initialRoute = await getInitialRoute();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(TrackActivity(
    initialRoute: initialRoute,
  ));
}

class TrackActivity extends StatelessWidget {
  const TrackActivity({required this.initialRoute, Key? key}) : super(key: key);
  final String initialRoute;

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    debugPrint('The initial route is $initialRoute');
    return ScreenUtilInit(
      builder: (BuildContext context, child) => GetMaterialApp(
        navigatorKey: navigatorKey,
        title: 'TrackActivity',
        debugShowCheckedModeBanner: false,
        initialBinding: TrackingBinding(),
        theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
            checkboxTheme: CheckboxThemeData(
                fillColor: MaterialStateProperty.all(Colors.white))),
        initialRoute: initialRoute,
        getPages: AppPages.routes,
      ),
      designSize: const Size(428, 926),
      minTextAdapt: true,
    );
  }
}
