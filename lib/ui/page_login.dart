import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/AppConstant.dart';
import 'package:flutter_application_2/ui/page_forgot.dart';
import 'package:flutter_application_2/ui/page_register.dart';
import 'package:provider/provider.dart';
import '../providers/loginviewmodel.dart';
import 'custom_control.dart';
import 'page_main.dart';

class PageLogin extends StatelessWidget {
  PageLogin({super.key});
  static String routename = '/login';
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<LoginViewModel>(context);
    final size = MediaQuery.of(context).size;
    if (viewmodel.status == 3) {
      Future.delayed(
        Duration.zero,
        () {
          Navigator.popAndPushNamed(context, PageMain.routename);
          // Navigator.pop(context);
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => PageMain(),
          //     ));
        },
      );
    }
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Center(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/Emblem_of_Vietnam.png',
                        width: 100,
                        height: 100,
                        // Additional parameters can be used here
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          "What's up commander ",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFC8132B)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Long time no see !",
                        style: TextStyle(
                          fontSize: 25,
                          fontStyle: FontStyle.italic,
                          color: Color(0xFFCCCCCC),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                          hintText: "Input your username",
                          textController: _emailController,
                          obscureText: false),
                      const SizedBox(height: 18),
                      CustomTextField(
                        hintText: "Input your password",
                        textController: _passwordController,
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      viewmodel.status == 2
                          ? Text(viewmodel.errorMessage,
                              style: const TextStyle(color: Color(0xFFC8132B)))
                          : const Text(""),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          String username = _emailController.text.trim();
                          String password = _passwordController.text.trim();
                          viewmodel.login(username, password);
                        },
                        child: const CustomButton(
                          textButton: "Login",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("New Commander? "),
                          GestureDetector(
                            onTap: () => Navigator.of(context)
                                .popAndPushNamed(PageRegister.routename),
                            child: Text(
                              "Register ",
                              style: TextStyle(color: Color(0xFFEEB60F)),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context)
                                .popAndPushNamed(PageRegister.routename),
                            child: Text(
                              "Now",
                              style: TextStyle(color: Color(0xFFC8132B)),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context)
                            .popAndPushNamed(PageForgot.routename),
                        child: Text(
                          "Forgot Password ?",
                          style: AppConstant.textlink,
                        ),
                      ),
                    ],
                  ),
                ),
                viewmodel.status == 1 ? CustomSpinner(size: size) : Container(),
              ],
            ),
          ),
        )));
  }
}
