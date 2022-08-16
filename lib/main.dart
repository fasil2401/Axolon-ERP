import 'package:axolon_container/utils/Routes/route_manger.dart';
import 'package:axolon_container/utils/Theme/theme_provider.dart';
import 'package:axolon_container/view/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Axolon ERP',
      debugShowCheckedModeBanner: false,
      theme: ThemeProvider().theme,
      // home: SplashScreen(),
      initialRoute: RouteManager().routes[0].name,
      getPages: RouteManager().routes,
    );
  }
}
