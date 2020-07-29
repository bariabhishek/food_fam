import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_fam/theme/theme.dart';
import 'package:food_fam/utils/size_config.dart';

import 'drawer.dart';

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


      ),

      body: Container(
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
                  height: SizeConfig.heightMultiplier * 7,
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
            SizedBox(height: SizeConfig.heightMultiplier*1,),
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
                return UiSearch();
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
    );
  }
}

Widget UiSearch() {
  return Card(
    child: Container(
      width: SizeConfig.widthMultiplier * 100,
      padding: EdgeInsets.only(top: 12, bottom: 12, left: 28),
      color: Colors.grey[100],
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[Text('NAME'), Text("S.NO.")],
        ),
        subtitle: Text(
          "CONTACT NO.",
          style: AppTheme.textStyle.lightHeading
              .copyWith(color: Colors.black, fontSize: AppFontSize.s14),
        ),
      ),
    ),
  );
}

Widget suggested() {
  return Card(
    child: Container(
      width: SizeConfig.widthMultiplier * 50,
      padding: EdgeInsets.only(top: 12, bottom: 12, left: 28),
      color: Colors.grey[200],
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[Text('NAME'), Text("S.NO.")],
        ),
        subtitle: Text(
          "CONTACT NO.",
          style: AppTheme.textStyle.lightHeading
              .copyWith(color: Colors.black, fontSize: AppFontSize.s14),
        ),
      ),
    ),
  );
}
