import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_fam/api/API.dart';
import 'package:food_fam/screens/searchScreen.dart';
import 'package:food_fam/theme/theme.dart';
import 'package:food_fam/utils/ShareManager.dart';
import 'package:food_fam/utils/app_assets.dart';
import 'package:food_fam/utils/app_routes.dart';
import 'package:food_fam/utils/display_alert_widget.dart';
import 'package:food_fam/utils/size_config.dart';

import 'order_list.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Image.asset(Assets.background,width: SizeConfig.heightMultiplier*100,height: SizeConfig.heightMultiplier*100,
          fit: BoxFit.fill,),
        Container(
          height: SizeConfig.heightMultiplier*100,
          margin: EdgeInsets.all(16.0),
          child:
          Column(children: <Widget>[
            SizedBox(height: SizeConfig.heightMultiplier*10,),
            Image.asset(Assets.logo),
            SizedBox(height: SizeConfig.heightMultiplier*4,),
            Text('Welcome',style: AppTheme.textStyle.lightHeading.copyWith(
                color: Colors.black,fontSize: 36
            ),),
            SizedBox(height: SizeConfig.heightMultiplier*10,),
            Container(
              width: SizeConfig.widthMultiplier*80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Login ID :',style: AppTheme.textStyle.lightHeading.copyWith(
                      fontSize: AppFontSize.s18
                  ),),
                  Container(
                    width: SizeConfig.widthMultiplier*55,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: ''
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: SizeConfig.heightMultiplier*5,),
            Container(
              width: SizeConfig.widthMultiplier*80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Password :',style: AppTheme.textStyle.lightHeading.copyWith(
                      fontSize: AppFontSize.s18
                  ),),
                  Container(
                    width: SizeConfig.widthMultiplier*55,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: ''
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: SizeConfig.heightMultiplier*10,),
            GestureDetector(
              onTap: (){
                login();
              //  AppRoutes.makeFirst(context, SearchScreen());
              },
              child: Container(
                padding: EdgeInsets.only(top: 12,bottom: 12,left: 16,right: 16),
                width: SizeConfig.widthMultiplier*70,

                decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: Text('CONTINUE',textAlign: TextAlign.center,style: AppTheme.textStyle.lightHeading.copyWith(
                    fontWeight: FontWeight.w400,fontSize: AppFontSize.s18,color: Colors.white
                ),),
              ),
            ),
            SizedBox(height: SizeConfig.heightMultiplier*2,),
            Text('Forgot Password',style: AppTheme.textStyle.lightHeading.copyWith(
                fontWeight: FontWeight.w500,fontSize: AppFontSize.s16,color: Colors.black
            ),)
          ],),)
      ],)
    );
  }
  login() async {
    loadProgress();
 /*   Response response;
    Dio dio = new Dio();
    response = await  dio.post(API.LoginAPi, data: {"restaurantid": "FOODFAM0006", "password": "1"});
    print(response.data.toString());

    print(response.data.toString());
*/



      Map<String, String> args = new Map();
    args["restaurantid"]="FOODFAM0006";
    args["password"]="1";


   // var body = json.encode(args);

    API.post(API.LoginAPi,args,"").then((response){
      loadProgress();
      print(response.statusCode.toString());
      print(response.body.toString());

      if(response.statusCode==200)
      {
        final data = json.decode(response.body);

       // ShareMananer.setDetails(data['token'], true);
        print(data['success']);

        if(data['success']==1){

          String id = data['detail']['id'].toString();
          String restaurantid = data['detail']['restaurantid'].toString();
          String Rname = data['detail']['Rname'].toString();
          String ownername = data['detail']['ownername'].toString();
          String ownermobile = data['detail']['ownermobile'].toString();

          ShareMananer.setDetails(id,true,restaurantid,Rname,ownermobile,ownername );
          print(id);
          Future.delayed(Duration(seconds: 2), () {

              AppRoutes.makeFirst(context, OrderListScreen());
          });
        }else{
          showDisplayAllert(context: context,isSucces: false,message: data['message']);
        }

      }
      else{
        showDisplayAllert(context: context,isSucces: false,message: "Server error");
      }

    });
  }
  loadProgress(){
    isLoading=!isLoading;
    setState(() {

    });
  }
}
