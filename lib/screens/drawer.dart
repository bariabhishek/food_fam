import 'package:flutter/material.dart';
import 'package:food_fam/screens/menu_screen.dart';
import 'package:food_fam/screens/order_details.dart';
import 'package:food_fam/screens/order_list.dart';
import 'package:food_fam/screens/profile_screen.dart';
import 'package:food_fam/theme/theme.dart';
import 'package:food_fam/utils/app_assets.dart';
import 'package:food_fam/utils/app_routes.dart';
import 'package:food_fam/utils/size_config.dart';

class AllDrawerScreen extends StatefulWidget {
  @override
  _AllDrawerScreenState createState() => _AllDrawerScreenState();
}

class _AllDrawerScreenState extends State<AllDrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20,left: 20),
              alignment: Alignment.centerLeft,
              child: Image.asset(Assets.logo,height: 30,)),
          SizedBox(height: SizeConfig.heightMultiplier*2,),
          Divider(
            thickness: 2,
            color: Colors.grey,),
          SizedBox(height: SizeConfig.heightMultiplier*2,),
          GestureDetector(
            onTap: (){
            //  AppRoutes.goto(context, HotelList());
            },
            child: Container(
                padding: EdgeInsets.only(left: 18),
                height: 50,
                color: AppTheme.primaryColor,
                child: Row(
                  children: <Widget>[
                  //  SvgPicture.asset(Assets.buildsvg,color: Colors.white,width: 20,height: 20,),
                    GestureDetector(
                      onTap: (){
                        AppRoutes.goto(context, foodfamProfile());
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 36),
                        child: Text('RESTAURANT PROFILE',style: AppTheme.textStyle.lightText.copyWith(
                            color: Colors.white,fontSize: AppFontSize.s20
                        ),),
                      ),
                    ),
                  ],
                )),
          ),
          SizedBox(height: SizeConfig.heightMultiplier*2,),
          Divider(
            thickness: 2,
            color: Colors.grey,),
          SizedBox(height: SizeConfig.heightMultiplier*2,),
          ListTile(
            onTap: (){
              AppRoutes.goto(context, OrderListScreen());
            },
       //     leading: Icon(Icons.bookmark_border,color: Colors.black),
            title: Text('Order History',style: AppTheme.textStyle.lightHeading.copyWith(
              fontSize: AppFontSize.s20
            ),),
          ),
          ListTile(
            onTap: (){
                 AppRoutes.goto(context, MenuScreen());
            },
            //     leading: Icon(Icons.bookmark_border,color: Colors.black),
            title: Text('Menu',style: AppTheme.textStyle.lightHeading.copyWith(
                fontSize: AppFontSize.s20
            ),),
          ),
          ListTile(
            onTap: (){
              AppRoutes.goto(context, OrderDetailsPic());
            },
         //   leading: Icon(Icons.notifications_none,color: Colors.black),
            title: Text('Insights',style: AppTheme.textStyle.lightHeading.copyWith(
                fontSize: AppFontSize.s20
            ),),
          ),
          SizedBox(height: SizeConfig.heightMultiplier*2,),
          Divider(
            thickness: 2,
            color: Colors.grey,),
          SizedBox(height: SizeConfig.heightMultiplier*2,),
          ListTile(
            onTap: (){
          //    AppRoutes.goto(context,SettingScreen());
            },
        //    leading: Icon(Icons.settings,color: Colors.black,),
            title: Text('Promotion',style: AppTheme.textStyle.lightHeading.copyWith(
                fontSize: AppFontSize.s20
            ),),
          ),
          ListTile(
            onTap: (){
          //    AppRoutes.goto(context, About_Screen());
            },
         //   leading: Container(margin:EdgeInsets.only(left: 2),child: Image.asset(Assets.logo,width: 20,height: 20,)),
            title: Text('Contact Us',style: AppTheme.textStyle.lightHeading.copyWith(
                fontSize: AppFontSize.s20
            ),),
        //    trailing: Icon(Icons.arrow_forward_ios,size: 18,),
          ),
        ],
      ),
    );
  }
}
