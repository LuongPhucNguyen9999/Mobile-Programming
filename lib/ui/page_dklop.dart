import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/profile.dart';
import 'package:flutter_application_2/repositories/student_repository.dart';
import 'package:flutter_application_2/repositories/user_repository.dart';
import 'package:flutter_application_2/ui/AppConstant.dart';
import 'package:flutter_application_2/ui/custom_control.dart';
import 'package:flutter_application_2/ui/page_main.dart';

import '../models/lop.dart';
import '../repositories/lop_repository.dart';

class PageDangKyLop extends StatefulWidget {
  PageDangKyLop({super.key});

  @override
  State<PageDangKyLop> createState() => _PageDangKyLopState();
}

class _PageDangKyLopState extends State<PageDangKyLop> {
  List<Lop>? listlop = [];
  Profile profile = Profile();
  String mssv = '';
  String ten = '';
  int idlop = 0;
  String tenlop = '';

  @override
  void initState() {
    // TODO: implement initState
    mssv = profile.student.mssv;
    ten = profile.user.first_name;
    idlop = profile.student.idlop;
    tenlop = profile.student.tenlop;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Input your information'),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "You can't return this page after leaving. Let's check carefully !",
                  style: AppConstant.texterror,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomInputTextFormField(
                  title: "Input your name",
                  value: ten,
                  width: size.width,
                  callback: (output) {
                    ten = output;
                  },
                ),
                CustomInputTextFormField(
                  title: "Input your student's id",
                  value: mssv,
                  width: size.width,
                  callback: (output) {
                    mssv = output;
                  },
                ),
                listlop!.isEmpty
                    ? FutureBuilder(
                        future: LopRepository().getDsLop(),
                        builder: (context, AsyncSnapshot<List<Lop>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasData) {
                            listlop = snapshot.data;
                            return CustomInputDropDown(
                              width: size.width,
                              list: listlop!,
                              title: "Lop",
                              valueId: idlop,
                              valueName: tenlop,
                              callback: (outputId, outputName) {
                                idlop = outputId;
                                tenlop = outputName;
                              },
                            );
                          } else {
                            return Text('Error!');
                          }
                        },
                      )
                    : CustomInputDropDown(
                        width: size.width,
                        list: listlop!,
                        title: "Lop",
                        valueId: idlop,
                        valueName: tenlop,
                        callback: (outputId, outputName) {
                          idlop = outputId;
                          tenlop = outputName;
                        },
                      ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                    onTap: () async {
                      profile.student.mssv = mssv;
                      profile.student.idlop = idlop;
                      profile.student.tenlop = tenlop;
                      profile.user.first_name = ten;
                      await UserRepository().UpdateProfile();
                      await StudentRepository().dangkyLop();
                    },
                    child: CustomButton(textButton: "Save your information")),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.popAndPushNamed(context, PageMain.routename);
                  },
                  child: Text(
                    "Quit this page",
                    style: AppConstant.textlink,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
