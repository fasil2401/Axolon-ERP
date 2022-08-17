import 'package:axolon_container/utils/Routes/route_manger.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    enterApp();
  }

  enterApp() async {
    await Future.delayed(Duration(seconds: 4), () {
      Get.offAllNamed(RouteManager().routes[1].name);
    });
  }
}
