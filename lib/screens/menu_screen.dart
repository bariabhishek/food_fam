import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_fam/theme/theme.dart';
import 'package:food_fam/utils/app_routes.dart';
import 'package:food_fam/utils/display_alert_widget.dart';
import 'package:food_fam/utils/size_config.dart';
import 'package:food_fam/utils/ShareManager.dart';
import 'dish_edit_history.dart';
import 'model/category_model.dart';
import 'package:food_fam/api/API.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  var isSwitched = true;
  var category_add_controller=new TextEditingController();
  var resId;
  List<CategoryModel> _categoryCard=List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ShareMananer.getUserDetails().then((userDetails) {
      resId = userDetails['token'];
      print(resId);
      fetchData(resId);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        backgroundColor:  AppTheme.primaryColor,
        actions: <Widget>[
          /*Container(
            margin: EdgeInsets.only(right: 10),
              alignment:Alignment.center,child: Text('Preview',style:
            AppTheme.textStyle.lightHeading.copyWith(fontSize: AppFontSize.s20,color: Colors.white)
            ,)),
          Container(
              margin: EdgeInsets.only(right: 50),
              alignment:Alignment.center,
              child: Text('Save')),*/
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
            InkWell(
              onTap: (){
                _addCategoryDialog();
              },
              child: Container(
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
            ),
            SizedBox(height: SizeConfig.heightMultiplier*2,),
            ListView.builder(
              itemBuilder: (context,index){
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

  _addCategoryDialog() {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Category'),
          content: TextField(
            controller: category_add_controller,
            decoration: InputDecoration(
              hintText: "Italian",
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            FlatButton(
              onPressed: () {

              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }


  void fetchData(resId) async {
    Map<String, String> args = new Map();
    args["restaurantid"] = resId;

    API.post(API.categoryItem, args, "").then((response) {
      print(response.body.toString());

      if (response.statusCode == 200) {
        final data = json.decode(response.body);


        if (data['success'] == 1) {
          List list = data["detail"];
          for (int i = 0; i < list.length; i++) {
            var id = list[i]["id"].toString();
            var restaurantid = list[i]["restaurantid"].toString();
            var name = list[i]["name"].toString();
            var createat = list[i]["createat"].toString();
            var blockstatus = list[i]["blockstatus"].toString();
            _categoryCard.add(new CategoryModel(id, restaurantid, name, createat, blockstatus));
          }


        } else {
          showDisplayAllert(
              context: context, isSucces: false, message: data['message']);
        }
      } else {
        showDisplayAllert(
            context: context, isSucces: false, message: "Server error");
      }
    });
    // print();
  }
}
