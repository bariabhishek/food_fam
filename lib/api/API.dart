
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
  static String ProfileAPi = BASE_URL+"profile.php";
  static String OrderList = BASE_URL+"orderslist.php";
  static String categoryItem = BASE_URL+"menu.php";
  static String subcatmenu = BASE_URL+"subcatmenu.php";
  static String catmenu = BASE_URL+"catmenu.php";
  static String dishmenu = BASE_URL+"dishmenu.php";
  static String addCategory = BASE_URL+"addcategory.php";
  static String addDish = BASE_URL+"adddishes.php";
  static String deleteCategory = BASE_URL+"deletecategory.php";
  static String deleteSubcategory = BASE_URL+"deletesubcategory.php";
  static String deleteDish = BASE_URL+"deletedish.php";
  static String editCategory = BASE_URL+"editcategory.php";
  static String editSubcategory = BASE_URL+"editsubcategory.php";
  static String addSubCategory = BASE_URL+"addsubcategory.php";
  static String coupanList = BASE_URL+"coupon.php";
  static String coupanAdd = BASE_URL+"addcoupon.php";
  static String coupanDelete= BASE_URL+"deletecoupon.php";
  static String orderdetail= BASE_URL+"orderdetail.php";


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
