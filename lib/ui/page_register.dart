import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/profile.dart';
import 'package:flutter_application_2/providers/registerviewmodel.dart';
import 'package:flutter_application_2/ui/AppConstant.dart';
import 'package:flutter_application_2/ui/custom_control.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/profile.dart';
import 'page_login.dart';
import 'page_main.dart';

class PageRegister extends StatelessWidget {
  PageRegister({super.key});
  static String routename = '/register';
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _pass1Controller = TextEditingController();
  final _pass2Controller = TextEditingController();
  bool agree = true;

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<RegisterViewModel>(context);
    final size = MediaQuery.of(context).size;
    final profile = Profile();
    if (profile.token != "") {
      Future.delayed(
        Duration.zero,
        () {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PageMain(),
              ));
        },
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: viewmodel.status == 3 || viewmodel.status == 4
                ? Column(
                    children: [
                      const Image(
                        image: AssetImage('assets/welcome.gif'),
                        width: 100,
                        height: 200,
                      ),
                      Text("Registration successful"),
                      viewmodel.status == 3
                          ? const Text("Your Email is required !")
                          : const Text(""),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already has an account? Click here to "),
                          GestureDetector(
                            onTap: () => Navigator.popAndPushNamed(
                                context, PageLogin.routename),
                            child: Text("Login"),
                          ),
                        ],
                      ),
                    ],
                  )
                : Stack(
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
                            Text(
                              'Welcome new commander',
                              style: AppConstant.textfancyheader,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              textController: _emailController,
                              hintText: 'Input your Email',
                              obscureText: false,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              textController: _usernameController,
                              hintText: 'Input your Username',
                              obscureText: false,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              textController: _pass1Controller,
                              hintText: 'Input your Password',
                              obscureText: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              textController: _pass2Controller,
                              hintText: 'Confirm your Password',
                              obscureText: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              viewmodel.errormessage,
                              style: AppConstant.texterror,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: viewmodel.agree,
                                  onChanged: (value) {
                                    viewmodel.setAgree(value!);
                                  },
                                ),
                                const Text("Agree with our "),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text(
                                          "Terms and Policies",
                                          style: TextStyle(
                                            color: Color(0xFFC8132B),
                                            // Add other text style properties if needed
                                          ),
                                        ),
                                        content: SingleChildScrollView(
                                          child: Text(viewmodel.terms),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Terms and Policies .",
                                    style: AppConstant.textlink,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                final email = _emailController.text.trim();
                                final username =
                                    _usernameController.text.trim();
                                final pass1 = _pass1Controller.text.trim();
                                final pass2 = _pass2Controller.text.trim();
                                viewmodel.register(
                                    email, username, pass1, pass2);
                              },
                              child: const CustomButton(textButton: "Register"),
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
      ),
    );
  }
}
