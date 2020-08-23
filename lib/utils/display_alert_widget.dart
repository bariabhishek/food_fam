
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:food_fam/utils/size_config.dart';



void showDisplayAllert({BuildContext context,bool isSucces,String message}){
  Flushbar(
    flushbarPosition: FlushbarPosition.BOTTOM,
    flushbarStyle: FlushbarStyle.FLOATING,
    backgroundColor:isSucces?Colors.green:Colors.red,
    boxShadows: [BoxShadow(color: Colors.grey, offset: Offset(0.0, 2.0), blurRadius: 10.0)],

    message:  message,
    duration:  Duration(seconds: 3),
  )..show(context);;
}



Widget showProgress(BuildContext context)
{
  return Container(
    color: Colors.black.withOpacity(0.5),
    width: double.maxFinite,
    height: SizeConfig.heightMultiplier*100,
    child: Center( child: CircularProgressIndicator()),

  );
}


