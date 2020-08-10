import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_fam/theme/theme.dart';
import 'package:food_fam/utils/app_routes.dart';
import 'package:food_fam/utils/size_config.dart';

import 'dish_edit_history.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  var isSwitched = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        backgroundColor:  AppTheme.primaryColor,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
              alignment:Alignment.center,child: Text('Preview',style:
            AppTheme.textStyle.lightHeading.copyWith(fontSize: AppFontSize.s20,color: Colors.white)
            ,)),
          Container(
              margin: EdgeInsets.only(right: 50),
              alignment:Alignment.center,
              child: Text('Save')),
        ],
      ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(bottom: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10,right: 10,top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
              Container(
                  alignment:Alignment.center,
                  child: Text('Categories',style:
                  AppTheme.textStyle.lightHeading.copyWith(fontSize: AppFontSize.s20,color: Colors.black)
                    ,)),
              Container(
                height: 40,
                width: SizeConfig.widthMultiplier*50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: Colors.grey,width: 1)
                ),

                 ),
        ],
    ),
            ),
            SizedBox(height: SizeConfig.heightMultiplier*2,),
            Container(
              decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              margin: EdgeInsets.only(left: 20),

              padding: EdgeInsets.all(8),
              child: Text('Add Category',style: AppTheme.textStyle.lightHeading.copyWith(
                color: Colors.white,fontSize: AppFontSize.s16
              ),),
            ),
            SizedBox(height: SizeConfig.heightMultiplier*2,),
            
            ListView.builder(itemBuilder: (context,index){
              
              return _categoreyContainer(index);
              
            },
              shrinkWrap: true,
              itemCount: 5,)

      ],
    ),
    ),
          ),
    );
  }

   _categoreyContainer(index) {
    return Container(
      margin: EdgeInsets.only(left: 20,right: 20,bottom: 10),
      //  padding: EdgeInsets.only(left:24.0,right: 24),
      width: SizeConfig.widthMultiplier*100,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300],),
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Container(
        padding: EdgeInsets.only(left: 5),
        child: ExpansionTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Catogery '+(index+1).toString()),
              InkWell(
                onTap: (){ AppRoutes.goto(context, DishEdit());},
                child: Container(
                  decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  margin: EdgeInsets.only(left: 20),

                  padding: EdgeInsets.only(left: 12,right: 12,top: 8,bottom: 8),
                  child: Text('Add Subcategory',style: AppTheme.textStyle.lightHeading.copyWith(
                      color: Colors.white,fontSize: AppFontSize.s16
                  ),),
                ),
              ),
            ],
          ),
          children: <Widget>[
            ExpansionTile(
              title:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Sub Catogery '+(index+1).toString()),
            InkWell(
              onTap: (){ AppRoutes.goto(context, DishEdit());},
              child: Container(
                decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                margin: EdgeInsets.only(left: 20),

                padding: EdgeInsets.only(left: 12,right: 12,top: 8,bottom: 8),
                child: Text('Add dish',style: AppTheme.textStyle.lightHeading.copyWith(
                    color: Colors.white,fontSize: AppFontSize.s16
                ),),
              ),
            ),
          ],
        ),
            children: [
              Container(
                padding: EdgeInsets.only(left: 10,right: 10),
              ),
              Container(
                margin: EdgeInsets.only(left: 10,right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('DISH 1'),
                    Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                          //  updateClock(value);

                        });
                      },
                      activeTrackColor: Colors.grey,
                      activeColor: Colors.blue,
                      inactiveThumbColor: Colors.blue,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 1,
              ),
              Container(
                margin: EdgeInsets.only(left: 10,right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('DISH 2'),
                    Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                          //  updateClock(value);

                        });
                      },
                      activeTrackColor: Colors.grey,
                      activeColor: Colors.blue,
                      inactiveThumbColor: Colors.blue,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 1,
              ),
              Container(
                margin: EdgeInsets.only(left: 10,right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('DISH 3'),
                    Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                          //  updateClock(value);

                        });
                      },
                      activeTrackColor: Colors.grey,
                      activeColor: Colors.blue,
                      inactiveThumbColor: Colors.blue,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 1,
              ),

            ],
            ),
            ExpansionTile(
              title:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Sub Catogery '+(index+1).toString()),
                  InkWell(
                    onTap: (){ AppRoutes.goto(context, DishEdit());},
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      margin: EdgeInsets.only(left: 20),

                      padding: EdgeInsets.only(left: 12,right: 12,top: 8,bottom: 8),
                      child: Text('Add dish',style: AppTheme.textStyle.lightHeading.copyWith(
                          color: Colors.white,fontSize: AppFontSize.s16
                      ),),
                    ),
                  ),
                ],
              ),
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10,right: 10),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('DISH 1'),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                            //  updateClock(value);

                          });
                        },
                        activeTrackColor: Colors.grey,
                        activeColor: Colors.blue,
                        inactiveThumbColor: Colors.blue,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('DISH 2'),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                            //  updateClock(value);

                          });
                        },
                        activeTrackColor: Colors.grey,
                        activeColor: Colors.blue,
                        inactiveThumbColor: Colors.blue,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('DISH 3'),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                            //  updateClock(value);

                          });
                        },
                        activeTrackColor: Colors.grey,
                        activeColor: Colors.blue,
                        inactiveThumbColor: Colors.blue,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1,
                ),

              ],
            ),
            ExpansionTile(
              title:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Sub Catogery '+(index+1).toString()),
                  InkWell(
                    onTap: (){ AppRoutes.goto(context, DishEdit());},
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      margin: EdgeInsets.only(left: 20),

                      padding: EdgeInsets.only(left: 12,right: 12,top: 8,bottom: 8),
                      child: Text('Add dish',style: AppTheme.textStyle.lightHeading.copyWith(
                          color: Colors.white,fontSize: AppFontSize.s16
                      ),),
                    ),
                  ),
                ],
              ),
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10,right: 10),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('DISH 1'),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                            //  updateClock(value);

                          });
                        },
                        activeTrackColor: Colors.grey,
                        activeColor: Colors.blue,
                        inactiveThumbColor: Colors.blue,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('DISH 2'),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                            //  updateClock(value);

                          });
                        },
                        activeTrackColor: Colors.grey,
                        activeColor: Colors.blue,
                        inactiveThumbColor: Colors.blue,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('DISH 3'),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                            //  updateClock(value);

                          });
                        },
                        activeTrackColor: Colors.grey,
                        activeColor: Colors.blue,
                        inactiveThumbColor: Colors.blue,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1,
                ),

              ],
            ),
            ExpansionTile(
              title:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Sub Catogery '+(index+1).toString()),
                  InkWell(
                    onTap: (){ AppRoutes.goto(context, DishEdit());},
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      margin: EdgeInsets.only(left: 20),

                      padding: EdgeInsets.only(left: 12,right: 12,top: 8,bottom: 8),
                      child: Text('Add dish',style: AppTheme.textStyle.lightHeading.copyWith(
                          color: Colors.white,fontSize: AppFontSize.s16
                      ),),
                    ),
                  ),
                ],
              ),
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10,right: 10),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('DISH 1'),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                            //  updateClock(value);

                          });
                        },
                        activeTrackColor: Colors.grey,
                        activeColor: Colors.blue,
                        inactiveThumbColor: Colors.blue,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('DISH 2'),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                            //  updateClock(value);

                          });
                        },
                        activeTrackColor: Colors.grey,
                        activeColor: Colors.blue,
                        inactiveThumbColor: Colors.blue,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('DISH 3'),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                            //  updateClock(value);

                          });
                        },
                        activeTrackColor: Colors.grey,
                        activeColor: Colors.blue,
                        inactiveThumbColor: Colors.blue,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1,
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
