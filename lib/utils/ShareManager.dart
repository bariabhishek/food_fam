
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_routes.dart';

class ShareMananer {


  static Future<Map<String,bool>> isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool loginState = prefs.get("login") ?? false;
    bool isFirst = prefs.get("isFirst") ?? true;

    Map<String, bool> user = new Map<String, bool>();
    user["login"] = loginState;
    user["isFirst"] = isFirst;

    return  user;
  }

  static logOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
   // AppRoutes.makeFirst(context, LoginScreen());
  }

  static Future<Map<String, String>> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> user = new Map<String, String>();
    user["token"] = prefs.get("token");
    return user;
  }


  static void setDetails(
      String token,bool islogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setBool('login', islogin);
  }



}
