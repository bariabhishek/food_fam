import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_fam/theme/theme.dart';
import 'package:food_fam/utils/app_assets.dart';
import 'package:food_fam/utils/app_routes.dart';
import 'package:food_fam/utils/size_config.dart';

import 'drawer.dart';
import 'order.dart';

class SearchScreen extends StatefulWidget {
  @override
  _foodfamState createState() => _foodfamState();
}

class _foodfamState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AllDrawerScreen(),
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        actions: <Widget>[
          Image.asset(Assets.logo,width: 100,height: 50,)
        ],

      ),

      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: SizeConfig.heightMultiplier*1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'ORDERS',
                    style: AppTheme.textStyle.lightHeading.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: AppFontSize.s16),
                  ),
                  Container(
                    height: SizeConfig.heightMultiplier * 6,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),

                    child: Row(
                      children: <Widget>[
                        /////////////////row of search bar////////////
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(
                                Icons.search,
                                color: Colors.grey[400],
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                width: SizeConfig.widthMultiplier * 50,
                                child: TextField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Search',
                                        hintStyle: TextStyle(fontSize: 18))),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.heightMultiplier*2,),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  'Pending for approval: ',
                  style: AppTheme.textStyle.lightHeading.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: AppFontSize.s16),
                ),
              ),
              SizedBox(height: SizeConfig.heightMultiplier*1,),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (context, int index) {
                  return UiSearch(context);
                },
              ),
              Container(
                margin: EdgeInsets.only(left: 10,top: 20,bottom: 10),

                child: Text(
                  'Approved Orders ',
                  style: AppTheme.textStyle.lightHeading.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: AppFontSize.s16),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, int index) {
                  return suggested();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget UiSearch(BuildContext context) {
  return Card(
    child: Container(
      width: SizeConfig.widthMultiplier * 100,
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 8),

      child: ListTile(
        onTap: (){
          AppRoutes.goto(context, order_history());
        },
        title: Text('Shivam Vishwas'),
        trailing:  Text("S No. 501234"),
        subtitle: Text(
          "9784958598",

        ),
      ),
    ),
  );
}

Widget suggested() {
  return Card(
    child: Container(
      width: SizeConfig.widthMultiplier * 100,
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 8),

      child: ListTile(
        title: Text('Nirmal Vishwas'),
        trailing:  Text("S No. 501234"),
        subtitle: Text(
          "9784958598",

        ),
      ),
    ),
  );
}
