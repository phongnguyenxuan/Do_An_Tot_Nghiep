import 'package:do_an_tot_nghiep/models/user_model.dart';
import 'package:do_an_tot_nghiep/services/auth_services.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier{
  UserModel? _userModel;
  final AuthServices authServices = AuthServices();

  UserModel get getUser => _userModel!;

  Future<void> refreshUser() async {
    UserModel userModel = await authServices.getUserDetails();
    _userModel = userModel;
    notifyListeners();
  }
}