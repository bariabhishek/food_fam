import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_fam/screens/drawer.dart';
import 'package:food_fam/screens/order_details.dart';
import 'package:food_fam/theme/theme.dart';
import 'package:food_fam/utils/app_routes.dart';

import 'package:food_fam/utils/size_config.dart';

class OrderListScreen extends StatefulWidget {
  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<OrderListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  //    drawer: AllDrawerScreen(),
      appBar: AppBar( backgroundColor: AppTheme.primaryColor,
      title: Text('ORDERS HISTORY'),),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          SizedBox(height: SizeConfig.heightMultiplier*1,),
          Container(
              margin: EdgeInsets.only(left: 20,top: 10),
              child: Text("Today's order list",style: AppTheme.textStyle.heading1.copyWith(
                fontSize: AppFontSize.s16,color: Colors.grey
              ),)),
          SizedBox(height: SizeConfig.heightMultiplier*1,),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, int index) {
              return UiSearch(context);
            },
          ),
        ],),
      ),
    );
  }
  Widget UiSearch(BuildContext context) {
    return Card(
      child: Container(
        width: SizeConfig.widthMultiplier * 100,
        padding: EdgeInsets.only(top: 8, bottom: 8, left: 8),

        child: ListTile(
          onTap: (){
            AppRoutes.goto(context, OrderDetailsPic("approverd"));
          },
          title: Text('Nirmal Vishwas'),
          trailing:  Text("S No. 501234"),
          subtitle: Text(
            "9784958598",

          ),
        ),
      ),
    );

  }
}
