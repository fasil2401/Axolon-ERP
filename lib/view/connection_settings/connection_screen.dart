import 'package:axolon_container/controller/app%20controls/connection_setting_controller.dart';
import 'package:axolon_container/controller/app%20controls/local_settings_controller.dart';
import 'package:axolon_container/controller/ui%20controls/password_controller.dart';
import 'package:axolon_container/model/connection_setting_model.dart';
import 'package:axolon_container/utils/constants/asset_paths.dart';
import 'package:axolon_container/utils/constants/colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectionScreen extends StatefulWidget {
  ConnectionScreen({Key? key}) : super(key: key);

  @override
  State<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  final passwordController = Get.put(PasswordController());

  final connectionSettingController = Get.put(ConnectionSettingController());

  final localSettingsController = Get.put(LocalSettingsController());

  final _serverIpController = TextEditingController();
  final _webPortController = TextEditingController();
  final _databaseNameController = TextEditingController();
  final _httpPortController = TextEditingController();
  final _erpPortController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getLocalSettings();
  }

  var settingsList = [
    ConnectionModel(
        serverIp: 'Select Settings',
        webPort: '',
        httpPort: '',
        erpPort: '',
        databaseName: '')
  ];

  getLocalSettings() async {
    await localSettingsController.getLocalSettings();
    List<dynamic> settings = localSettingsController.connectionSettings;
    settings.forEach((element) {
      setState(() {
        settingsList.add(element);
      });
    });

    print(settings);
  }

  selectSettings(ConnectionModel settings) async {
    setState(() {
      _serverIpController.text = settings.serverIp!;
      _webPortController.text = settings.webPort!;
      _databaseNameController.text = settings.databaseName!;
      _httpPortController.text = settings.httpPort!;
      _erpPortController.text = settings.erpPort!;
    });
    await connectionSettingController.getServerIp(settings.serverIp!);
    await connectionSettingController.getWebPort(settings.webPort!);
    await connectionSettingController.getDatabaseName(settings.databaseName!);
    await connectionSettingController.getHttpPort(settings.httpPort!);
    await connectionSettingController.getErpPort(settings.erpPort!);
  }

  @override
  Widget build(BuildContext context) {
    print(settingsList);
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary,
              AppColors.secondary,
              // AppColors.primary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          children: [
            /// Login & Welcome back
            Container(
              height: 210,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  /// LOGIN TEXT
                  Text('Connection',
                      style: TextStyle(color: Colors.white, fontSize: 32.5)),
                  SizedBox(height: 7.5),

                  /// WELCOME
                  Text('Set your connection settings',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 50),

                      Center(
                        child: SizedBox(
                          width: width * 0.5,
                          child: Image.asset(Images.logo, fit: BoxFit.contain),
                        ),
                      ),
                      const SizedBox(height: 50),

                      /// Text Fields
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        height: height * 0.35,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  blurRadius: 20,
                                  spreadRadius: 10,
                                  offset: const Offset(0, 10)),
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            DropdownButtonFormField2(
                              isDense: true,
                              dropdownFullScreen: true,
                              value: settingsList[0],
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 18,
                              ),
                              decoration: InputDecoration(
                                isCollapsed: true,
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 15),
                              ),
                              isExpanded: true,
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: AppColors.primary,
                              ),
                              iconSize: 20,
                              // buttonHeight: 37,
                              buttonPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              items: settingsList
                                  .map(
                                    (item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        item.serverIp!,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) async {
                                await connectionSettingController
                                    .checkIsLocalSettings();
                                var settings = value as ConnectionModel;
                                selectSettings(settings);
                              },
                              onSaved: (value) {},
                            ),
                            TextField(
                              controller: _serverIpController,
                              style: TextStyle(fontSize: 15),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                border: InputBorder.none,
                                label: Text(
                                  'Server Ip',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                  ),
                                ),
                                isCollapsed: false,
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              onChanged: (value) {
                                connectionSettingController.getServerIp(value);
                              },
                            ),
                            Divider(color: Colors.black54, height: 1),
                            TextField(
                              controller: _webPortController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontSize: 15),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                border: InputBorder.none,
                                label: Text(
                                  'Web Service Port',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                  ),
                                ),
                                isCollapsed: false,
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              onChanged: (value) async {
                                await connectionSettingController
                                    .checkIsLocal();
                                await connectionSettingController
                                    .getWebPort(value);
                              },
                            ),
                            Divider(color: Colors.black54, height: 1),
                            TextField(
                              controller: _databaseNameController,
                              style: TextStyle(fontSize: 15),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                border: InputBorder.none,
                                label: Text(
                                  'Database Name',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                  ),
                                ),
                                isCollapsed: false,
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              onChanged: (value) async {
                                await connectionSettingController
                                    .checkIsLocal();
                                await connectionSettingController
                                    .getDatabaseName(value);
                              },
                            ),
                            Divider(color: Colors.black54, height: 1),
                            Row(
                              children: [
                                Flexible(
                                  child: TextField(
                                    controller: _erpPortController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      border: InputBorder.none,
                                      label: Text(
                                        'ERP Port',
                                        style: TextStyle(
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      isCollapsed: false,
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    onChanged: (value) async {
                                      await connectionSettingController
                                          .checkIsLocal();
                                      await connectionSettingController
                                          .getErpPort(value);
                                    },
                                  ),
                                ),
                                Flexible(
                                  child: TextField(
                                    controller: _httpPortController,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(fontSize: 15),
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      border: InputBorder.none,
                                      label: Text(
                                        'Http Port',
                                        style: TextStyle(
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      isCollapsed: false,
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    onChanged: (value) async {
                                      await connectionSettingController
                                          .checkIsLocal();
                                      await connectionSettingController
                                          .getHttpPort(value);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: height * 0.05,
                      ),
                      // Container(
                      //   margin: const EdgeInsets.symmetric(horizontal: 25),
                      //   height: height * 0.055,
                      //   width: MediaQuery.of(context).size.width,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(20),
                      //   ),
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //       connectionSettingController.saveSettings();
                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //       primary: AppColors.primary,
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius:
                      //             BorderRadius.circular(10), // <-- Radius
                      //       ),
                      //     ),
                      //     child: Text('Continue',
                      //         style: TextStyle(color: Colors.white)),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: height * 0.01,
                      // ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              height: height * 0.055,
                              // width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: AppColors.mutedBlueColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10), // <-- Radius
                                  ),
                                ),
                                child: Text('Cancel',
                                    style: TextStyle(color: AppColors.primary)),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              height: height * 0.055,
                              // width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  connectionSettingController.saveSettings();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: AppColors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10), // <-- Radius
                                  ),
                                ),
                                child: Text('Continue',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: Row(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   // crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     Text(
      //       'Connection Settings',
      //       style: TextStyle(
      //           fontWeight: FontWeight.w400, color: AppColors.mutedColor),
      //     ),
      //     SizedBox(
      //       width: 10,
      //     ),
      //     FloatingActionButton(
      //       onPressed: () {},
      //       elevation: 2,
      //       backgroundColor: AppColors.primary,
      //       child: Icon(
      //         Icons.settings,
      //         color: Colors.white,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
