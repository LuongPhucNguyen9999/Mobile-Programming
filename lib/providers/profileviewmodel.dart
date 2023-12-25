import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/profile.dart';
import 'package:flutter_application_2/repositories/user_repository.dart';
import 'package:image_picker/image_picker.dart';

import '../models/user.dart';

class ProfileViewModel with ChangeNotifier {
  int status = 0;
  int modified = 0;
  int updatedavatar = 0;

  void updatescreen() {
    status = 0;
    notifyListeners();
  }

  void displayspinner() {
    status = 1;
    notifyListeners();
  }

  void setUpdateavatar() {
    updatedavatar = 1;
    notifyListeners();
  }

  void setModified() {
    if (modified == 0) {
      modified = 1;
      notifyListeners();
    }
  }

  void hidespinner() {
    status = 0;
    notifyListeners();
  }

  Future<void> updateProfile() async {
    status = 1;
    notifyListeners();
    await UserRepository().UpdateProfile();
    status = 0;
    modified = 0;
    notifyListeners();
  }

  Future<void> uploadAvatar(XFile image) async {
    status = 1;
    notifyListeners();
    await UserRepository().uploadAvatar(image);
    var user = await UserRepository().getUserInfo();
    Profile().user = User.fromUser(user);
    updatedavatar = 0;
    status = 0;
    notifyListeners();
  }
}
