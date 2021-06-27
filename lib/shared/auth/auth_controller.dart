
import 'package:bills_checking/modules/home/home_page.dart';
import 'package:bills_checking/modules/login/login_page.dart';
import 'package:bills_checking/shared/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  UserModel? _user;

UserModel get user => _user!; // user pode sr nulo o ! indica isso, null safety

  void setUser(BuildContext context, UserModel? user) {

    if (user != null) {

      saveUser(user);
    
      _user = user;
      Navigator.pushReplacementNamed(context, "/home");
      return;
    }

    Navigator.pushReplacementNamed(context, "/login");
  }

  Future <void> saveUser(UserModel user) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString("user", user.toJson());
    return;
  }

  Future<void> currentUser(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();

    await Future.delayed(const Duration(seconds: 2));

    if (instance.containsKey("user")) {
      final userJson = instance.get("user") as String;
      setUser(context, UserModel.fromJson(userJson));
      return;
    }
  
    setUser(context, null);

  }

}