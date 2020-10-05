import 'package:flutter/material.dart';
import 'package:food_fam/screens/login.dart';
import 'package:food_fam/screens/menu_screen.dart';
import 'package:food_fam/screens/searchScreen.dart';
import 'package:food_fam/splashScreen/splashScreen.dart';
import 'package:food_fam/utils/size_config.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'api/API.dart';
import 'screens/dish_view_page.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>_MyApp();


}

class _MyApp extends State<MyApp> {


  @override
  void initState() {
    super.initState();
    oneSingalInit();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      });
    });
  }

  Future<void> oneSingalInit() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.init(
        API.oneSignalAppID,
        iOSSettings: {
          OSiOSSettings.autoPrompt: false,
          OSiOSSettings.inAppLaunchUrl: false
        }
    );

    OneSignal.shared.setInFocusDisplayType(
        OSNotificationDisplayType.notification);

    await OneSignal.shared.promptUserForPushNotificationPermission(
        fallbackToSettings: true);

    OneSignal.shared.setNotificationReceivedHandler((
        OSNotification notification) {});

    OneSignal.shared.setNotificationOpenedHandler((
        OSNotificationOpenedResult result) {

    });
  }

}