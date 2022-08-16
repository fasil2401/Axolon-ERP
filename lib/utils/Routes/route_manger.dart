import 'package:axolon_container/view/login_screen/login_screen.dart';
import 'package:axolon_container/view/splash_screen/splash_screen.dart';
import 'package:get/get.dart';

class RouteManager {
  List<GetPage> _routes = [
    GetPage(
      name: '/splash',
      page: () => SplashScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: '/login',
      page: () => LoginScreen(),
      transition: Transition.cupertino,
    ),
  ];

  get routes => _routes;
}
