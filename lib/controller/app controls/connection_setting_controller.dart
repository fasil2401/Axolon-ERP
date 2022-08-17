import 'package:axolon_container/controller/app%20controls/local_settings_controller.dart';
import 'package:axolon_container/model/connection_setting_model.dart';
import 'package:axolon_container/utils/Routes/route_manger.dart';
import 'package:axolon_container/utils/constants/colors.dart';
import 'package:axolon_container/utils/shared_preferences/shared_preferneces.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectionSettingController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final localSettingsController = Get.put(LocalSettingsController());

  var serverIp = ''.obs;
  var webPort = ''.obs;
  var databaseName = ''.obs;
  var httpPort = ''.obs;
  var erpPort = ''.obs;
  var isLocalSettings = false.obs;

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

  checkIsLocal(){
    isLocalSettings.value = false;
  }
  checkIsLocalSettings() {
    isLocalSettings.value = true;
  }

  saveSettings() async {
    await UserSimplePreferences.setServerIp(serverIp.value);
    await UserSimplePreferences.setWebPort(webPort.value);
    await UserSimplePreferences.setDatabase(databaseName.value);
    await UserSimplePreferences.setHttpPort(httpPort.value);
    await UserSimplePreferences.setErpPort(erpPort.value);
    await UserSimplePreferences.setConnection('true');
    // goToLogin();
    getConfirmation();
  }

  getConfirmation() async {
    if(!isLocalSettings.value) {
      Get.defaultDialog(
      title: '',
      titlePadding: EdgeInsets.zero,
      content: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('Save This Settings For Next Time ?',
                textAlign: TextAlign.start,
                style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              child: Text('No', style: TextStyle(color: AppColors.mutedColor)),
              onPressed: () {
                // saveSettings();
                // Get.back();
                goToLogin();
              },
            ),
            TextButton(
              child: Text('Yes', style: TextStyle(color: AppColors.primary)),
              onPressed: () async {
                await localSettingsController.addLocalSettings(
                    element: ConnectionModel(
                        serverIp: serverIp.value,
                        webPort: webPort.value,
                        databaseName: databaseName.value,
                        httpPort: httpPort.value,
                        erpPort: erpPort.value
                    ));
                // Get.back();
                goToLogin();
              },
            ),
          ],
        ),
      ],
    );
    }
    else {
      goToLogin();
    }
  }

  goToLogin() {
    Get.offNamed(RouteManager().routes[1].name);
  }
}
