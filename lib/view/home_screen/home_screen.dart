import 'package:axolon_container/controller/app%20controls/local_settings_controller.dart';
import 'package:axolon_container/controller/app%20controls/login_controller.dart';
import 'package:axolon_container/controller/ui%20controls/package_info_controller.dart';
import 'package:axolon_container/model/connection_setting_model.dart';
import 'package:axolon_container/utils/Routes/route_manger.dart';
import 'package:axolon_container/utils/constants/asset_paths.dart';
import 'package:axolon_container/utils/constants/colors.dart';
import 'package:axolon_container/utils/shared_preferences/shared_preferneces.dart';
import 'package:axolon_container/view/connection_settings/connection_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final packageInfoCOntroller = Get.put(PackageInfoController());

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  WebViewController? _webViewController;
  final localSettingsController = Get.put(LocalSettingsController());
  var settingsList = [];
  final _key = UniqueKey();
  @override
  void initState() {
    super.initState();
    generateUrl();
    getLocalSettings();
  }

  getLocalSettings() async {
    await localSettingsController.getLocalSettings();
    List<dynamic> settings = localSettingsController.connectionSettings;
    for (var setting in settings) {
      settingsList.add(setting);
    }
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
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    print('webUrlissssss $webUrl');
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.primary,
          centerTitle: true,
          title: SizedBox(
            width: width * 0.28,
            child: Image.asset(
              Images.logo,
              fit: BoxFit.contain,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.notifications_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                // Get.to(ConnectionScreen());
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: SafeArea(
            child: ListView(
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: width * 0.2,
                      width: width * 0.2,
                      child: Image.asset(
                        Images.user,
                        fit: BoxFit.cover,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.05,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            username,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.mutedColor),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ElevatedButton(
                              onPressed: () async {
                                await UserSimplePreferences.setLogin('false');
                                Get.offAllNamed(RouteManager().routes[1].name);
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                                primary: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(10), // <-- Radius
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Log Out',
                                    style: TextStyle(
                                      fontSize: width * 0.03,
                                      color: AppColors.mutedBlueColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.logout_rounded,
                                    size: 15,
                                    color: AppColors.mutedBlueColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Divider(
                  color: AppColors.mutedColor.withOpacity(0.5),
                  thickness: 0.5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: AppColors.mutedBlueColor,
                    child: ExpansionTile(
                      backgroundColor: Colors.white,
                      collapsedBackgroundColor: AppColors.mutedBlueColor,
                      trailing: Icon(
                        Icons.settings_suggest_outlined,
                        color: AppColors.primary,
                      ),
                      title: ListTile(
                        dense: true,
                        title: Text(
                          'Connection Settings',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        // trailing: Icon(
                        //   Icons.settings_suggest_outlined,
                        //   color: AppColors.primary,
                        // ),
                      ),
                      children: [
                        Column(
                          children: [
                            settingsList.isNotEmpty
                                ? ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: settingsList.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Get.offAll(() => ConnectionScreen(
                                                connectionModel:
                                                    settingsList[index],
                                              ));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Card(
                                            elevation: 3,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: ListTile(
                                              dense: true,
                                              title: Row(
                                                children: [
                                                  Icon(
                                                    Icons.settings_outlined,
                                                    color: AppColors.primary,
                                                    size: 18,
                                                  ),
                                                  SizedBox(
                                                    width: 6,
                                                  ),
                                                  Text(
                                                    settingsList[index]
                                                        .connectionName!,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: AppColors.primary,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                      height: 2,
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Card(
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ListTile(
                                        dense: true,
                                        title: Row(
                                          children: [
                                            SizedBox(
                                              width: width * 0.05,
                                              height: width * 0.05,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 1.5,
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                  AppColors.primary,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 6,
                                            ),
                                            Text(
                                              'Please wait...',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: AppColors.primary,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => ConnectionScreen(
                                    connectionModel: ConnectionModel(
                                        connectionName: 'New Connection',
                                        webPort: '',
                                        databaseName: '',
                                        httpPort: '',
                                        erpPort: '',
                                        serverIp: '')));
                              },
                              child: CircleAvatar(
                                backgroundColor: AppColors.primary,
                                radius: height * 0.04,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: height * 0.05,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Card(
                //     elevation: 5,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     color: AppColors.mutedBlueColor,
                //     child: ListTile(
                //       dense: true,
                //       title: Text(
                //         'Connection Settings',
                //         style: TextStyle(
                //           fontSize: 16,
                //           color: AppColors.primary,
                //           fontWeight: FontWeight.w400,
                //         ),
                //       ),
                //       trailing: Icon(
                //         Icons.settings_suggest_outlined,
                //         color: AppColors.primary,
                //       ),
                //     ),
                //   ),
                // ),
                // settingsList.isNotEmpty
                //     ? ListView.separated(
                //         shrinkWrap: true,
                //         itemCount: settingsList.length,
                //         itemBuilder: (context, index) {
                //           return GestureDetector(
                //             onTap: () {
                //               Get.offAll(() => ConnectionScreen(
                //                     connectionModel: settingsList[index],
                //                   ));
                //             },
                //             child: Padding(
                //               padding: const EdgeInsets.symmetric(horizontal: 8),
                //               child: Card(
                //                 elevation: 3,
                //                 shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(10),
                //                 ),
                //                 child: ListTile(
                //                   dense: true,
                //                   title: Row(
                //                     children: [
                //                       Icon(
                //                         Icons.settings_outlined,
                //                         color: AppColors.primary,
                //                         size: 18,
                //                       ),
                //                       SizedBox(
                //                         width: 6,
                //                       ),
                //                       Text(
                //                         settingsList[index].connectionName!,
                //                         style: TextStyle(
                //                           fontSize: 16,
                //                           color: AppColors.primary,
                //                           fontWeight: FontWeight.w400,
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           );
                //         },
                //         separatorBuilder: (context, index) => SizedBox(
                //           height: 2,
                //         ),
                //       )
                //     : Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 8),
                //         child: Card(
                //           elevation: 3,
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(10),
                //           ),
                //           child: ListTile(
                //             dense: true,
                //             title: Row(
                //               children: [
                //                 SizedBox(
                //                   width: height * 0.05,
                //                   height: height * 0.05,
                //                   child: CircularProgressIndicator(
                //                     strokeWidth: 1.5,
                //                     valueColor: AlwaysStoppedAnimation(
                //                       AppColors.primary,
                //                     ),
                //                   ),
                //                 ),
                //                 SizedBox(
                //                   width: 6,
                //                 ),
                //                 Text(
                //                   'Please wait...',
                //                   style: TextStyle(
                //                     fontSize: 16,
                //                     color: AppColors.primary,
                //                     fontWeight: FontWeight.w400,
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ),
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 10),
                //   child: Align(
                //     alignment: Alignment.bottomCenter,
                //     child: Obx(() {
                //       // print(versionControl.version);
                //       return Text(
                //         'version :${packageInfoCOntroller.version.value}',
                //         style: TextStyle(
                //           color: AppColors.mutedColor,
                //           fontSize: 12,
                //         ),
                //       );
                //     }),
                //   ),
                // ),
              ],
            ),
          ),
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
                setState(
                  () {
                    print(webUrl);
                    isLoading = false;
                  },
                );
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
