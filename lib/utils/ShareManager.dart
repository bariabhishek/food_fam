
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
    user["rname"] = prefs.get("rname");
    user["ownermobile"] = prefs.get("ownermobile");
    user["ownername"] = prefs.get("ownername");
    user["resId"] = prefs.get("resId");
    return user;
  }


  static void setDetails(
      String token,bool islogin, String resId,String rname, String ownermobile, String ownername) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('rname', rname);
    await prefs.setString('ownermobile', ownermobile);
    await prefs.setString('ownername', ownername);
    await prefs.setString('resId', resId);
    await prefs.setBool('login', islogin);
  }



}
