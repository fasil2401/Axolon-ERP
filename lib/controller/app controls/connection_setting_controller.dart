import 'package:axolon_container/utils/Routes/route_manger.dart';
import 'package:axolon_container/utils/shared_preferences/shared_preferneces.dart';
import 'package:get/get.dart';

class ConnectionSettingController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }
  var serverIp = ''.obs;
  var webPort = ''.obs;
  var databaseName = ''.obs;
  var httpPort = ''.obs;
  var erpPort = ''.obs;

  getServerIp(String serverIp) {
    this.serverIp.value = serverIp;
  }

  getWebPort(String webPort) {
    this.webPort.value = webPort;
  }

  getDatabaseName(String databaseName) {
    this.databaseName.value = databaseName;
  }

  getHttpPort(String httpPort) {
    this.httpPort.value = httpPort;
  }

  getErpPort(String erpPort) {
    this.erpPort.value = erpPort;
  }

  saveSettings() async {
    await UserSimplePreferences.setServerIp(serverIp.value);
    await UserSimplePreferences.setWebPort(webPort.value);
    await UserSimplePreferences.setDatabase(databaseName.value);
    await UserSimplePreferences.setHttpPort(httpPort.value);
    await UserSimplePreferences.setErpPort(erpPort.value);
    await UserSimplePreferences.setConnection('true');
    goToLogin();
  }

  goToLogin() {
    Get.offNamed(RouteManager().routes[1].name);
  }
}
