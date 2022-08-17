import 'dart:convert';
import 'package:axolon_container/services/login_services.dart';
import 'package:axolon_container/utils/Routes/route_manger.dart';
import 'package:axolon_container/utils/shared_preferences/shared_preferneces.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  var userName = ''.obs;
  var password = ''.obs;
  var res = 0.obs;
  var message = ''.obs;
  var token = ''.obs;
  var webUrl = ''.obs;
  String url = '';
  String data = '';

  getUserName(String userName) {
    this.userName.value = userName;
  }

  getPassword(String password) {
    this.password.value = password;
  }

  saveCredentials() async {
    await UserSimplePreferences.setUsername(userName.value);
    await UserSimplePreferences.setUserPassword(password.value);
    getLogin();
  }

  genearateApi() async {
    final String serverIp = await UserSimplePreferences.getServerIp() ?? '';
    final String databaseName = await UserSimplePreferences.getDatabase() ?? '';
    final String erpPort = await UserSimplePreferences.getErpPort() ?? '';
    final String httpPort = await UserSimplePreferences.getHttpPort() ?? '';
    final String username = await UserSimplePreferences.getUsername() ?? '';
    final String password = await UserSimplePreferences.getUserPassword() ?? '';
    url = 'http://${serverIp}/V1/Api/Gettoken';
    data = jsonEncode({
      "instance": serverIp,
      "userId": username,
      "Password": password,
      "passwordhash": "",
      "dbName": databaseName,
      "port": httpPort,
      "servername": ""
    });
  }

  getLogin() async {
    await genearateApi();
    try {
      Get.defaultDialog(
        title: "Please Wait",
        content: Center(
          child: CircularProgressIndicator(),
        ),
      );
      var feedback = await RemoteServicesLogin().getLogin(url, data);
      if (feedback != null) {
        res.value = feedback.res;
        message.value = feedback.msg;
        token.value = feedback.loginToken!;
      } else {
        message.value = 'failure';
      }
    } finally {
      if (res.value == 1) {
        getWebView();
      } else {
        Get.back();
        Get.snackbar('Error', 'No User Found');
      }
    }
  }

  getWebView() async {
    await generateWebUrl();
    print(webUrl.value);
    Get.offAllNamed(RouteManager().routes[3].name);
  }

  generateWebUrl() {
    final String serverIp = UserSimplePreferences.getServerIp() ?? '';
    final String databaseName = UserSimplePreferences.getDatabase() ?? '';
    final String erpPort = UserSimplePreferences.getErpPort() ?? '';
    final String username = UserSimplePreferences.getUsername() ?? '';
    final String password = UserSimplePreferences.getUserPassword() ?? '';
    final String webPort = UserSimplePreferences.getWebPort() ?? '';
    final String httpPort = UserSimplePreferences.getHttpPort() ?? '';
    webUrl.value =
        '${serverIp}/User/mobilelogin?userid=${username}&passwordhash=${password}&dbName=${databaseName}&port=${httpPort}&iscall=1';
  }
}
