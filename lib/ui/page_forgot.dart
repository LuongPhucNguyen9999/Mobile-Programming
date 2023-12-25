import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/forgotviewmodel.dart';
import 'package:flutter_application_2/ui/AppConstant.dart';
import 'package:flutter_application_2/ui/custom_control.dart';
import 'package:provider/provider.dart';

import 'page_login.dart';

class PageForgot extends StatelessWidget {
  PageForgot({Key? key}) : super(key: key);
  static String routename = "/forgot";
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<ForgotViewModel>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: viewmodel.status == 3
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage('assets/welcome.gif'),
                        width: 300,
                        height: 200,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Send request successful. Access your",
                        style: TextStyle(
                            color: Color(0xFFC8132B),
                            fontSize: 21,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "email and complete the process",
                        style: TextStyle(
                            color: Color(0xFFC8132B),
                            fontSize: 21,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.popAndPushNamed(
                                context, PageLogin.routename),
                            child: Text(
                              "Already has an account? ",
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.popAndPushNamed(
                                context, PageLogin.routename),
                            child: Text("Click here to ",
                                style: TextStyle(color: Color(0xFFEEB60F))),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.popAndPushNamed(
                                context, PageLogin.routename),
                            child: Text("Login",
                                style: TextStyle(color: Color(0xFFC8132B))),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/Emblem_of_Vietnam.png',
                            width: 100,
                            height: 100,
                            // Additional parameters can be used here
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text("Enter your email to recover your password"),
                          SizedBox(height: 20),
                          CustomTextField(
                              textController: _emailController,
                              hintText: "Input your Email",
                              obscureText: false),
                          SizedBox(height: 10),
                          Text(
                            viewmodel.errormessage,
                            style: AppConstant.texterror,
                          ),
                          GestureDetector(
                            onTap: () {
                              final email = _emailController.text.trim();
                              viewmodel.forgotPassword(email);
                            },
                            child: CustomButton(textButton: "Send Email"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context)
                                .popAndPushNamed(PageLogin.routename),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Already has an account ? "),
                                Text(
                                  "Login Now",
                                  style: AppConstant.textlink,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    viewmodel.status == 1
                        ? CustomSpinner(size: size)
                        : Container(),
                  ],
                ),
        ),
      ),
    );
  }
}
