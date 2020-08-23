
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_fam/screens/login.dart';
import 'package:food_fam/screens/searchScreen.dart';
import 'package:food_fam/theme/theme.dart';
import 'package:food_fam/utils/ShareManager.dart';
import 'package:food_fam/utils/app_assets.dart';
import 'package:food_fam/utils/app_routes.dart';
import 'package:food_fam/utils/size_config.dart';



class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    refreshPermission();
    // callScreen();
  }

  //Call screen based on conditions
  callScreen() async {

    ShareMananer.getUserDetails().then((userDetails) {
      bool isLogin = userDetails["login"];

      if(!isLogin){
        Future.delayed(Duration(seconds: 2), () {
          AppRoutes.makeFirst(context, LogInScreen());
        });
      }
      else{
        Future.delayed(Duration(seconds: 2), () {
          AppRoutes.makeFirst(context, SearchScreen());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    //  appSizeInit(context);
    return SafeArea(
      right: false,
      bottom: false,
      left: false,
      top: false,
      child: Scaffold(
          body: Stack(
            children: <Widget>[
              Image.asset(Assets.background,width: SizeConfig.heightMultiplier*100,height: SizeConfig.heightMultiplier*100,
              fit: BoxFit.fill,),
              Center(
                child: Container(
                  width: 250,
                  height: 120,
                  color: Colors.white,
                  child:  Image(
                      width: SizeConfig.widthMultiplier * 80,
                      fit: BoxFit.contain,
                      image: new AssetImage(Assets.logo)),
                ),
              )
            ],
          )
      ),
    );
  }


  refreshPermission() async {
//    if (await Permission.location.request().isDenied) {
//
//
//      // You can request multiple permissions at once.
//      Map<Permission, PermissionStatus> statuses = await [
//        Permission.location,
//        Permission.locationWhenInUse,
//        Permission.locationAlways
//      ].request();
//      print(statuses[Permission.location]);
//      // Either the permission was already granted before or the user just granted it.
//    }


   callScreen();
  }




  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppTheme.primaryColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light));
  }
}
