
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_fam/screens/login.dart';
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


    ShareMananer.isLogin().then((userDetails) {
      bool isLogin = userDetails["login"];


      if(!isLogin){
        Future.delayed(Duration(seconds: 3), () {
          AppRoutes.makeFirst(context, LogInScreen());
        });
      }
      else{
        Future.delayed(Duration(seconds: 3), () {
        //  AppRoutes.makeFirst(context, VehicalCreatedScreen());
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
          body: Container(
            width: double.maxFinite,
            color: Colors.white,
            child:    Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    // color:Colors.white,
                      width: SizeConfig.widthMultiplier * 80,
                      fit: BoxFit.contain,
                      image: new AssetImage(Assets.logo)),
                ],
              ),
            ),
          )),
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
  }
}
