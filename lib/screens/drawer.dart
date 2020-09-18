import 'package:flutter/material.dart';
import 'package:food_fam/screens/menu_screen.dart';
import 'package:food_fam/screens/order_details.dart';
import 'package:food_fam/screens/order_list.dart';
import 'package:food_fam/screens/profile_screen.dart';
import 'package:food_fam/theme/theme.dart';
import 'package:food_fam/utils/ShareManager.dart';
import 'package:food_fam/utils/app_assets.dart';
import 'package:food_fam/utils/app_routes.dart';
import 'package:food_fam/utils/size_config.dart';
import 'contactus.dart';
import 'coupon.dart';
import 'dish_view_page.dart';
import 'login.dart';

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

             Container(

              child: ExpansionTile(
                title: Text('Insights',style: AppTheme.textStyle.lightHeading.copyWith(
                    fontSize: AppFontSize.s20
                ),),
                children: <Widget>[
                  Container(

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        SizedBox(
                          height: SizeConfig.heightMultiplier * 1,
                        ),
                        GestureDetector(
                          onTap: (){

                          },
                          child: Container(

                            child: Text('Sales Report',style: AppTheme.textStyle.lightHeading.copyWith(
                                fontSize: AppFontSize.s20
                            ),),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 2,
                        ),
                        GestureDetector(
                          onTap: (){

                          },
                          child: Container(

                            child: Text('Dish Performance',style: AppTheme.textStyle.lightHeading.copyWith(
                                fontSize: AppFontSize.s20
                            ),),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),




          ListTile(
            onTap: (){
             AppRoutes.goto(context,CouponScreen());
            },
        //    leading: Icon(Icons.settings,color: Colors.black,),
            title: Text('Coupon',style: AppTheme.textStyle.lightHeading.copyWith(
                fontSize: AppFontSize.s20
            ),),
          ),
          ListTile(
            onTap: (){
              AppRoutes.goto(context, ContactUs());
            },
         //   leading: Container(margin:EdgeInsets.only(left: 2),child: Image.asset(Assets.logo,width: 20,height: 20,)),
            title: Text('Contact Us',style: AppTheme.textStyle.lightHeading.copyWith(
                fontSize: AppFontSize.s20
            ),),
        //    trailing: Icon(Icons.arrow_forward_ios,size: 18,),
          ),
          ListTile(
            onTap: (){

             _deleteSubCategoryDialog();
            },
         //   leading: Container(margin:EdgeInsets.only(left: 2),child: Image.asset(Assets.logo,width: 20,height: 20,)),
            title: Text('Log Out',style: AppTheme.textStyle.lightHeading.copyWith(
                fontSize: AppFontSize.s20
            ),),
        //    trailing: Icon(Icons.arrow_forward_ios,size: 18,),
          ),
        ],
      ),
    );

  }
  void _deleteSubCategoryDialog() {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure want to logout'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              //  _deleteSubCategoryfromServer(index,id);
                ShareMananer.logOut(context);
                AppRoutes.makeFirst(context, LogInScreen());
              },
              child: Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  Widget tabdraw() {
    return Container(
      padding: EdgeInsets.only(left: 5),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Catogery 3'),
            Container(
              decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              margin: EdgeInsets.only(left: 20),

              padding: EdgeInsets.only(left: 12,right: 12,top: 8,bottom: 8),
              child: Text('Add DISH',style: AppTheme.textStyle.lightHeading.copyWith(
                  color: Colors.white,fontSize: AppFontSize.s16
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
