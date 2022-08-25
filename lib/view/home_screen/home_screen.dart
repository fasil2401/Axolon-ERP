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
  bool isLoading = true;
  WebViewController? _webViewController;
  final _key = UniqueKey();
  @override
  void initState() {
    super.initState();
    generateUrl();
  }

  String serverIp = '';
  String databaseName = '';
  String erpPort = '';
  String username = '';
  String password = '';
  String webPort = '';
  String httpPort = '';

  String webUrl = '';
  generateUrl() async {
    setState(() {
      serverIp = UserSimplePreferences.getServerIp() ?? '';
      databaseName = UserSimplePreferences.getDatabase() ?? '';
      erpPort = UserSimplePreferences.getErpPort() ?? '';
      username = UserSimplePreferences.getUsername() ?? '';
      password = UserSimplePreferences.getUserPassword() ?? '';
      webPort = UserSimplePreferences.getWebPort() ?? '';
      httpPort = UserSimplePreferences.getHttpPort() ?? '';
    });
  }

  DateTime? currentBackPressTime;
  Future<bool> onWillPop() {
    _webViewController!.goBack();
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    print('webUrlissssss $webUrl');
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
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
              onPressed: () async {
                await UserSimplePreferences.setLogin('false');
                Get.offAllNamed(RouteManager().routes[1].name);
              },
            ),
          ],
        ),
        body: Stack(
          children: <Widget>[
            WebView(
              key: _key,
              initialUrl:
                  'http://${serverIp}:${erpPort}/User/mobilelogin?userid=${username}&passwordhash=${password}&dbName=${databaseName}&port=${httpPort}&iscall=1',
              javascriptMode: JavascriptMode.unrestricted,
              zoomEnabled: true,
              debuggingEnabled: true,
              onWebViewCreated: (WebViewController webViewController) {
                _webViewController = webViewController;
              },
              onPageFinished: (finish) {
                setState(() {
                  print(webUrl);
                  isLoading = false;
                });
              },
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  )
                : Stack(),
          ],
        ),
      ),
    );
  }
}
