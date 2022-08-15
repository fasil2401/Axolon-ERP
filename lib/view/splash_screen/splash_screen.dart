import 'package:axolon_container/utils/constants/asset_paths.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: SizedBox(
            width: width * 0.5,
            child: Image.asset(
              Images.logo,
              fit: BoxFit.contain,
            )),
      ),
    );
  }
}
