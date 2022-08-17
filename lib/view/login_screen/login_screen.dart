import 'package:axolon_container/controller/app%20controls/login_controller.dart';
import 'package:axolon_container/controller/ui%20controls/password_controller.dart';
import 'package:axolon_container/utils/Routes/route_manger.dart';
import 'package:axolon_container/utils/constants/asset_paths.dart';
import 'package:axolon_container/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final passwordController = Get.put(PasswordController());
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
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
                  Text('Login',
                      style: TextStyle(color: Colors.white, fontSize: 32.5)),
                  SizedBox(height: 7.5),

                  /// WELCOME
                  Text('Welcome Back',
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
                        height: 120,
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
                            /// EMAIL
                            TextField(
                              style: TextStyle(fontSize: 15),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                border: InputBorder.none,
                                label: Text(
                                  'User Name',
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
                                loginController.getUserName(value);
                              },
                            ),
                            Divider(color: Colors.black54, height: 1),

                            /// PASSWORD
                            Obx(
                              () => TextField(
                                obscureText: passwordController.status.value,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  border: InputBorder.none,
                                  label: Text(
                                    'Password',
                                    style: TextStyle(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  isCollapsed: false,
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  suffix: InkWell(
                                    onTap: () {
                                      passwordController.check();
                                    },
                                    child: Container(
                                      width: 50,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 4),
                                        child: SvgPicture.asset(
                                          passwordController.icon.value,
                                          height:
                                              passwordController.status.value ==
                                                      true
                                                  ? 10
                                                  : 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                onChanged: (value) {
                                  loginController.getPassword(value);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: height * 0.05,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        height: height * 0.055,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Obx(
                          () => ElevatedButton(
                            onPressed: () {
                              loginController.saveCredentials();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // <-- Radius
                              ),
                            ),
                            child: loginController.isLoading.value
                                ? SizedBox(
                                    width: width * 0.05,
                                    height: width * 0.05,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                    ),
                                  )
                                : Text('Login',
                                    style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Connection Settings',
            style: TextStyle(
                fontWeight: FontWeight.w400, color: AppColors.mutedColor),
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              Get.toNamed(RouteManager().routes[2].name);
            },
            elevation: 2,
            backgroundColor: AppColors.primary,
            child: Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
