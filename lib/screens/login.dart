import 'package:flutter/material.dart';
import 'package:food_fam/screens/searchScreen.dart';
import 'package:food_fam/theme/theme.dart';
import 'package:food_fam/utils/app_assets.dart';
import 'package:food_fam/utils/app_routes.dart';
import 'package:food_fam/utils/size_config.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
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
                AppRoutes.makeFirst(context, SearchScreen());
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
}
