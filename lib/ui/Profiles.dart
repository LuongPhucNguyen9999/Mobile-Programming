import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/profile.dart';
import 'package:flutter_application_2/providers/diachimodel.dart';
import 'package:flutter_application_2/providers/profileviewmodel.dart';
import 'package:flutter_application_2/ui/AppConstant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../providers/mainviewmodel.dart';
import 'custom_control.dart';

class Profiles extends StatelessWidget {
  Profiles({super.key});
  static int idpage = 1;
  XFile? image;

  Future<void> init(DiachiModel dcmodel, ProfileViewModel viewModel) async {
    Profile profile = Profile();
    if (dcmodel.listCity.isEmpty ||
        dcmodel.curCityId != profile.user.provinceid ||
        dcmodel.curDistId != profile.user.districtid ||
        dcmodel.curWardId != profile.user.wardid) {
      viewModel.displayspinner();
      await dcmodel.initialize(profile.user.provinceid, profile.user.districtid,
          profile.user.wardid);
      viewModel.hidespinner();
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<ProfileViewModel>(context);
    final dcmodel = Provider.of<DiachiModel>(context);
    final size = MediaQuery.of(context).size;
    final profile = Profile();
    Future.delayed(Duration.zero, () => init(dcmodel, viewmodel));
    return GestureDetector(
      onTap: () => MainViewModel().closeMenu(),
      child: Container(
        child: Stack(
          children: [
            Column(
              children: [
                createHeader(size, profile, viewmodel),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomInputTextFormField(
                            title: "Phone number",
                            value: profile.user.phone,
                            width: size.width * 0.45,
                            callback: (output) {
                              profile.user.phone = output;
                              viewmodel.setModified();
                              viewmodel.updatescreen();
                            },
                            type: TextInputType.phone,
                          ),
                          CustomInputTextFormField(
                            title: "Birthday",
                            value: profile.user.birthday,
                            width: size.width * 0.45,
                            callback: (output) {
                              if (AppConstant.isDate(output)) {
                                profile.user.birthday = output;
                              }
                              viewmodel.setModified();
                              viewmodel.updatescreen();
                            },
                            type: TextInputType.datetime,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomPlaceDropDown(
                              width: size.width * 0.45,
                              title: "City",
                              valueId: profile.user.provinceid,
                              valueName: profile.user.provincename,
                              callback: (outputId, outputName) async {
                                viewmodel.displayspinner();
                                profile.user.provinceid = outputId;
                                profile.user.provincename = outputName;
                                await dcmodel.setCity(outputId);
                                profile.user.districtid = 0;
                                profile.user.wardid = 0;
                                profile.user.districtname = "";
                                profile.user.wardname = "";
                                viewmodel.setModified();
                                viewmodel.hidespinner();
                              },
                              list: dcmodel.listCity),
                          CustomPlaceDropDown(
                              width: size.width * 0.45,
                              title: "District",
                              valueId: profile.user.districtid,
                              valueName: profile.user.districtname,
                              callback: (outputId, outputName) async {
                                viewmodel.displayspinner();
                                profile.user.districtid = outputId;
                                profile.user.districtname = outputName;
                                await dcmodel.setDistrict(outputId);
                                profile.user.wardid = 0;
                                profile.user.wardname = "";
                                viewmodel.setModified();
                                viewmodel.hidespinner();
                              },
                              list: dcmodel.listDistrict),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomPlaceDropDown(
                              width: size.width * 0.45,
                              title: "Ward",
                              valueId: profile.user.wardid,
                              valueName: profile.user.wardname,
                              callback: (outputId, outputName) async {
                                viewmodel.displayspinner();
                                profile.user.wardid = outputId;
                                profile.user.wardname = outputName;
                                await dcmodel.setWard(outputId);
                                viewmodel.setModified();
                                viewmodel.hidespinner();
                              },
                              list: dcmodel.listWard),
                          CustomInputTextFormField(
                              title: "Street",
                              value: profile.user.address,
                              width: size.width * 0.45,
                              callback: (output) {
                                profile.user.address = output;
                                viewmodel.setModified();
                                viewmodel.updatescreen();
                              },
                              type: TextInputType.streetAddress),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: size.width * 0.3,
                        width: size.width * 0.3,
                        child: QrImageView(
                          data: '{userid:' + profile.user.id.toString() + '}',
                          version: QrVersions.auto,
                          gapless: false,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            viewmodel.status == 1 ? CustomSpinner(size: size) : Container(),
          ],
        ),
      ),
    );
  }

  Container createHeader(
      Size size, Profile profile, ProfileViewModel viewmodel) {
    return Container(
      height: size.height * 0.24,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xFFC8132B),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Color(0xFFEEB60F),
                  ),
                  Text(
                    profile.student.diem.toString(),
                    style: AppConstant.textbody,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: viewmodel.updatedavatar == 1 && image != null
                    ? Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: Image.file(
                                File(image!.path),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                viewmodel.uploadAvatar(image!);
                              },
                              child: Container(
                                  // color: Colors.white,
                                  child: Icon(size: 30, Icons.save)),
                            ),
                          ),
                        ],
                      )
                    : GestureDetector(
                        onTap: () async {
                          final ImagePicker _picker = ImagePicker();
                          image = await _picker.pickImage(
                              source: ImageSource.gallery);
                          viewmodel.setUpdateavatar();
                        },
                        child: CustomAvatar1(size: size)),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                profile.user.first_name,
                style: AppConstant.textfocuswhite,
              ),
              Row(
                children: [
                  Text(
                    "Student ID:  ",
                    style: AppConstant.textbody,
                  ),
                  Text(
                    profile.student.mssv,
                    style: AppConstant.textbodybold,
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    "Class:  ",
                    style: AppConstant.textbody,
                  ),
                  Text(
                    profile.student.tenlop,
                    style: AppConstant.textbodybold,
                  ),
                  profile.student.duyet == 0
                      ? Text(
                          "   Chua duyet",
                          style: AppConstant.textbody,
                        )
                      : Text(""),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Role:  ",
                    style: AppConstant.textbody,
                  ),
                  profile.user.role_id == 4
                      ? Text(
                          "Student",
                          style: AppConstant.textbodybold,
                        )
                      : Text(
                          "Lecture",
                          style: AppConstant.textbodybold,
                        ),
                ],
              ),
              SizedBox(
                width: size.width * 0.4,
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: viewmodel.modified == 1
                        ? GestureDetector(
                            onTap: () {
                              viewmodel.updateProfile();
                            },
                            child: Icon(Icons.save))
                        : Container()),
              )
            ],
          )
        ],
      ),
    );
  }
}
