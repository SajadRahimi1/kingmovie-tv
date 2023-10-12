import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:king_movie/core/constants/color_constants.dart';
import 'package:king_movie/core/widgets/app_bar.dart';
import 'package:king_movie/viewmodels/login_viewmodel.dart';
import 'package:king_movie/views/login/screens/forget_screen.dart';
import 'package:king_movie/views/menu/widgets/profile_text_input.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginViewModel());

    return Scaffold(
      appBar: menuAppBar(context: context, title: "« ورود »"),
      backgroundColor: darkBlue,
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () => controller.emailFocusNode.requestFocus(),
                child: ProfileTextInput(
                  label: "ایمیل",
                  focusNode: controller.emailFocusNode,
                  onSubmit: (_) => controller.passworFocusNode.requestFocus(),
                  onChanged: (value) => controller.email = value,
                ),
              )),
          Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () => controller.passworFocusNode.requestFocus(),
                child: ProfileTextInput(
                  obscureText: true,
                  focusNode: controller.passworFocusNode,
                  onSubmit: (_) => controller.loginFocusNode.requestFocus(),
                  label: "رمز عبور",
                  onChanged: (value) => controller.password = value,
                ),
              )),
          SizedBox(
            height: MediaQuery.sizeOf(context).height / 20,
          ),
          InkWell(
            onTap: () => Get.to(() => const ForgetScreen()),
            child: const Text(
              "اگر رمز عبور خود را فراموش کرده اید اینجا کلیک نمایید",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const Spacer(),
          InkWell(
            focusNode: controller.loginFocusNode,
            onTap: controller.login,
            focusColor: Colors.cyan,
            child: Container(
              width: MediaQuery.sizeOf(context).width / 2,
              height: MediaQuery.sizeOf(context).height / 13,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  color: redColor),
              alignment: Alignment.center,
              child: const Text(
                "ورود",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
