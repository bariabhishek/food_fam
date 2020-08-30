
import 'dart:convert';

import 'package:food_fam/services/service_http.dart';
import 'package:http/http.dart';

class API {
  static HttpService _httpService = HttpService.getInstance();
  //static String token;
  //static String session_id;

  static String DOMAIN_NAME = "";
  static String GOOGLE_API = "AIzaSyB4BfDrt-mCQCC1pzrGUAjW_2PRrGNKh_U";
  //https://foodfam.in/api/login.php
  static String BASE_URL = "https://foodfam.in/api/";
  static String LoginAPi = BASE_URL+"login.php";
  static String OrderList = BASE_URL+"orderslist.php";
  static String categoryItem = BASE_URL+"menu.php";
  static String addCategory = BASE_URL+"addcategory.php";
  static String addSubCategory = BASE_URL+"addsubcategory.php";


  static Future<Response> post(String api, Map<String, String> args,String token) {
    print(args.toString());
    return _httpService.post(api, args,token);
  }

  static Future<Response> postblanck(String api, Map<String, dynamic> args) {
    print(args.toString());
    return _httpService.postblanck(api, json.encode(args));
  }

  static Future<Response> get(String api,String token) {
    return _httpService.get(api,token);
  }
}
