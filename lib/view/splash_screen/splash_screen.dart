
import 'package:axolon_container/utils/constants/asset_paths.dart';
import 'package:axolon_container/utils/constants/colors.dart';
import 'package:axolon_container/controller/ui%20controls/package_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final packageInfoCOntroller = Get.put(PackageInfoController());

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: width * 0.9,
              child: Image.asset(
                Images.logo_gif,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Obx(
                () => Text(
                  'version :${packageInfoCOntroller.version.value}',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.mutedColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

   enterApp() async {
    await Future.delayed(Duration(seconds: 3), () {
      Get.offAllNamed('/login');
    });
  }
}
