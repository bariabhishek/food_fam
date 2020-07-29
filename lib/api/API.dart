
import 'package:food_fam/services/service_http.dart';
import 'package:http/http.dart';

class API {
  static HttpService _httpService = HttpService.getInstance();
  //static String token;
  //static String session_id;

  static String DOMAIN_NAME = "";
  static String GOOGLE_API = "AIzaSyB4BfDrt-mCQCC1pzrGUAjW_2PRrGNKh_U";
  static String BASE_URL = "http://10.0.2.2:3000/users/";
  static String BASE_URL_VEHICLE = "http://10.0.2.2:3000/vehicles/";
  static String LoginAPi = BASE_URL+"login";
  static String RegistrationAPi = BASE_URL+"account/register";
  static String UserListApi = BASE_URL+"getAllUser";
  static String ADDVehicle = BASE_URL_VEHICLE+"addVehicle";
  static String EditVehicle = BASE_URL_VEHICLE+"updateVehcile";
  static String getVehicle = BASE_URL_VEHICLE+"getAllVehcileData";
  static String getVehicleDelete = BASE_URL_VEHICLE+"deleteVehicle";
  static String RegistrationAPIManager = BASE_URL+"registerManager";
  static String RegistrationAPICustomer = BASE_URL+"registerCustomer";

  static Future<Response> post(String api, String  args,String token) {
    print(args.toString());
    return _httpService.post(api, args,token);
  }

  static Future<Response> get(String api,String token) {
    return _httpService.get(api,token);
  }
}
