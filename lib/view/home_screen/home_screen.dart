import 'package:axolon_container/controller/app%20controls/login_controller.dart';
import 'package:axolon_container/utils/Routes/route_manger.dart';
import 'package:axolon_container/utils/constants/colors.dart';
import 'package:axolon_container/utils/shared_preferences/shared_preferneces.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    generateUrl();
  }

  String webUrl = '';
  generateUrl() async {
    final String serverIp = UserSimplePreferences.getServerIp() ?? '';
    final String databaseName = UserSimplePreferences.getDatabase() ?? '';
    final String erpPort = UserSimplePreferences.getErpPort() ?? '';
    final String username = UserSimplePreferences.getUsername() ?? '';
    final String password = UserSimplePreferences.getUserPassword() ?? '';
    final String webPort = UserSimplePreferences.getWebPort() ?? '';
    final String httpPort = UserSimplePreferences.getHttpPort() ?? '';
    setState(() {
      webUrl =
          '${serverIp}/User/mobilelogin?userid=${username}&passwordhash=${password}&dbName=${databaseName}&port=${httpPort}&iscall=1';
    });
  }

  @override
  Widget build(BuildContext context) {
    print('webUrl $webUrl');
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        title: Text(
          'Axolon',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout_rounded),
            onPressed: () async{
              await UserSimplePreferences.setLogin('false');
              Get.offAllNamed(RouteManager().routes[1].name);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: webUrl,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
