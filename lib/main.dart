import 'package:flutter/material.dart';
import 'package:food_fam/screens/login.dart';
import 'package:food_fam/screens/menu_screen.dart';
import 'package:food_fam/splashScreen/splashScreen.dart';
import 'package:food_fam/utils/size_config.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MenuScreen(),
        );
      });
    });
  }
}

