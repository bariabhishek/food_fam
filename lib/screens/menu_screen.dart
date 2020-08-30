import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_fam/api/API.dart';
import 'package:food_fam/screens/model/dish_model.dart';
import 'package:food_fam/screens/model/subcategory_model.dart';
import 'package:food_fam/theme/theme.dart';
import 'package:food_fam/utils/ShareManager.dart';
import 'package:food_fam/utils/display_alert_widget.dart';
import 'package:food_fam/utils/size_config.dart';

import 'category_expanse_list_item.dart';
import 'model/category_model.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  var isSwitched = true;
  var category_add_controller = new TextEditingController();
  var resId, tempResponse;
  bool haveData = true;
  Dialog diloagContext;

  List<CategoryModel> _categoryList = List();

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
        backgroundColor: AppTheme.primaryColor,
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
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Categories',
                              style: AppTheme.textStyle.lightHeading.copyWith(
                                  fontSize: AppFontSize.s20,
                                  color: Colors.black),
                            )),
                        Container(
                          height: 40,
                          width: SizeConfig.widthMultiplier * 50,
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                              border: Border.all(color: Colors.grey, width: 1)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  InkWell(
                    onTap: () {
                      _addCategoryDialog();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      margin: EdgeInsets.only(left: 20),
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Add Category',
                        style: AppTheme.textStyle.lightHeading.copyWith(
                            color: Colors.white, fontSize: AppFontSize.s16),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  _categoryList.isEmpty && !haveData
                      ? Container(
                    height: SizeConfig.heightMultiplier * 10,
                    child: Center(
                      child: Text("You haven't add any category"),
                    ),
                  )
                      : Container(
                    height: SizeConfig.heightMultiplier * 70,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return CategoryExpanseListItem(
                            _categoryList[index].id,
                            _categoryList[index].restaurantid,
                            _categoryList[index].name,
                            _categoryList[index].createat,
                            _categoryList[index].blockstatus,
                            _categoryList[index].subcategory_list,
                            addSubcategory: () {
                              _addSubCategoryDialog( _categoryList[index].id,);
                            }, addDish: () {
                          print("ok");
                        });
                      },
                      physics: BouncingScrollPhysics(),
                      itemCount: _categoryList.length,
                    ),
                  ),
                ],
              ),
              tempResponse != null
                  ? SizedBox(width: 0)
                  : Container(
                height: SizeConfig.heightMultiplier * 100,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        AppTheme.primaryColor),
                  ),
                ),
              ),
            ],
          ),
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
              hintText: "Example: Italian",
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
                Navigator.pop(context);
                _addCategoryToServer();
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
        tempResponse = "1";
        if (data['success'] == 1) {
          List list = data["detail"];
          if (list.isEmpty) {
            haveData = false;
          }
          for (int i = 0; i < list.length; i++) {
            var id = list[i]["id"].toString();
            var restaurantid = list[i]["restaurantid"].toString();
            var name = list[i]["name"].toString();
            var createat = list[i]["createat"].toString();
            var blockstatus = list[i]["blockstatus"].toString();

            List<SubategoryModel> _subCategoryList = List();

            List subcategory = list[i]["subcategory"];
            // print(list[i]["subcategory"].toString());

            for (int j = 0; j < subcategory.length; j++) {
              var id = subcategory[j]["id"].toString();
              var restaurantid = subcategory[j]["restaurantid"].toString();
              var name = subcategory[j]["name"].toString();
              var category_id = subcategory[j]["category"].toString();
              var createat = subcategory[j]["createat"].toString();
              var blockstatus = subcategory[j]["blockstatus"].toString();
              print(subcategory[j]["name"]);

              List<DishModel> _dishList = List();
              List dishes = subcategory[j]["dishes"];

              for (int k = 0; k < dishes.length; k++) {
                var id = dishes[k]["id"].toString();
                var restaurantid = dishes[k]["restaurantid"].toString();
                var name = dishes[k]["name"].toString();
                var category_id = dishes[k]["category"].toString();
                var subcategory_id = dishes[k]["subcategory"].toString();
                var price = dishes[k]["price"].toString();
                var description = dishes[k]["description"].toString();
                var createat = dishes[k]["createat"].toString();
                var blockstatus = dishes[k]["blockstatus"].toString();

                //  print(dishes[k]["name"]);

                _dishList.add(new DishModel(
                    id,
                    restaurantid,
                    name,
                    createat,
                    blockstatus,
                    category_id,
                    subcategory_id,
                    price,
                    description));
              }

              //print("dish - - - -"+dishes);
              _subCategoryList.add(new SubategoryModel(
                  id,
                  restaurantid,
                  name,
                  createat,
                  blockstatus,
                  category_id,
                  _dishList));
            }

            _categoryList.add(new CategoryModel(id, restaurantid, name,
                createat, blockstatus, _subCategoryList));
          }

          setState(() {});
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

  void _addCategoryToServer() {
    Map<String, String> args = new Map();
    args["restaurantid"] = resId;
    _dialog();
    args["name"] = category_add_controller.text.toString();
    API.post(API.addCategory, args, "").then((response) {
      print(response.body.toString());

      if (response.statusCode == 200) {
        category_add_controller.text="";
        final data = json.decode(response.body);
        tempResponse = "1";
        if (data['success'] == 1) {
          if(_categoryList.isNotEmpty){
            Navigator.of(context).pop(diloagContext);
            _categoryList.clear();
            fetchData(resId);
          }
          showDisplayAllert(context: context, isSucces: true, message: data['message']);
        }else{
            Navigator.of(context).pop(diloagContext);
            showDisplayAllert(context: context, isSucces: false, message: data['message']);

        }
      }
    });
  }

  _dialog(){
    diloagContext= Dialog(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Container(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                    AppTheme.primaryColor),
              ),
            ),
            SizedBox(width: SizeConfig.widthMultiplier*2,),
            Text('Please Wait...', style: TextStyle()),
          ],
        ),
      ),
    );
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return diloagContext;
          });

  }

  void _addSubCategoryDialog(id) {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add SubCategory'),
          content: TextField(
            controller: category_add_controller,
            decoration: InputDecoration(
              hintText: "Example: Pizza",
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
                Navigator.pop(context);
                _addSubCategoryToServer(id);
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }
  void _addSubCategoryToServer(id) {
    Map<String, String> args = new Map();
    _dialog();
    args["categoryid"] = id;
    args["restaurantid"] = resId;
    args["name"] = category_add_controller.text.toString();
    API.post(API.addSubCategory, args, "").then((response) {
      print(response.body.toString());
      if (response.statusCode == 200) {
        category_add_controller.text="";
        final data = json.decode(response.body);
        tempResponse = "1";
        if (data['success'] == 1) {
          if(_categoryList.isNotEmpty){
            Navigator.of(context).pop(diloagContext);
            _categoryList.clear();
            fetchData(resId);
          }
          showDisplayAllert(context: context, isSucces: true, message: data['message']);
        }else{
          Navigator.of(context).pop(diloagContext);
          showDisplayAllert(context: context, isSucces: false, message: data['message']);

        }
      }
    });
  }
}
