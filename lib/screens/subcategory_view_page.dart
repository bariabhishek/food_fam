import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_fam/api/API.dart';
import 'package:food_fam/screens/model/category_model.dart';
import 'package:food_fam/screens/model/subcategory_model.dart';
import 'package:food_fam/theme/theme.dart';
import 'package:food_fam/utils/ShareManager.dart';
import 'package:food_fam/utils/app_routes.dart';
import 'package:food_fam/utils/display_alert_widget.dart';
import 'package:food_fam/utils/size_config.dart';

import 'add_dish.dart';
import 'dish_view_page.dart';
import 'menu_screen.dart';
import 'model/dish_model.dart';

class subCategoryViewScreen extends StatefulWidget {
  var itemName, itemId,cateId;

  subCategoryViewScreen(this.itemName, this.itemId, this.cateId);

  @override
  _MenuViewScreenState createState() => _MenuViewScreenState();
}

class _MenuViewScreenState extends State<subCategoryViewScreen> {
  List<DishModel> itemList = List();

  var resId,tempResponse,categoryId;
  var _categoryName = TextEditingController();
  var category_add_controller = TextEditingController();
  var diloagContext;
  bool haveData=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ShareMananer.getUserDetails().then((userDetails) {
      resId = userDetails['token'];
      print(resId);
      _categoryName.text = widget.itemName;
      _fetchData(resId);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: Text("Sub Category"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {_deleteCategoryDialog();},
            tooltip: "Delete This SubCategory",
          )
        ],
      ),
      bottomNavigationBar: InkWell(
        child: Container(
          height: SizeConfig.heightMultiplier * 7,
          color: AppTheme.primaryColor,
          child: Center(
              child: Text('Update subcategory',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18))),
        ),
        onTap: () {
          _updateCtegoryToServer();
        },
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child:  tempResponse != null
            ? _categoryType()
            : Container(
          height: SizeConfig.heightMultiplier * 100,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(
                  AppTheme.primaryColor),
            ),
          ),
        ),
      ),
    );
  }

  void _updateCtegoryToServer() {
    Map<String, String> args = new Map();
    args["restaurantid"] = resId;
    args["subcategoryid"] = widget.itemId;
    args["name"] = _categoryName.text;
    _dialog();
    API.post(API.editSubcategory, args, "").then((response) {
      print(response.body.toString());
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == 1) {
          Navigator.of(context).pop(diloagContext);
          showDisplayAllert(context: context, isSucces: true, message: data['message']);
        }else{
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

  void _deleteCategoryfromServer() {
    Map<String, String> args = new Map();
    args["restaurantid"] = resId;
    args["subcategoryid"] = widget.itemId;
    _dialog();
    API.post(API.deleteSubcategory, args, "").then((response) {
      print(response.body.toString());
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == 1) {
          Navigator.of(context).pop(diloagContext);
          Future.delayed(Duration(seconds: 1), () {
            AppRoutes.replace(context,MenuScreen());
          });
          // showDisplayAllert(context: context, isSucces: true, message: data['message']);

        }
        else{
          Navigator.of(context).pop(diloagContext);
          Future.delayed(Duration(seconds: 1), () {
            Navigator.pop(context);
          });
          //showDisplayAllert(context: context, isSucces: false, message: data['message']);

        }
      }
    });
  }


  _deleteCategoryDialog() {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Subcategory'),
          content: Text('Are you sure want to delete this Subcategory'),
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
                _deleteCategoryfromServer();
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }


  void _fetchData(resId) async {
    Map<String, String> args = new Map();
    args["restaurantid"] = resId;
    args["subcategoryid"] = widget.itemId;

    API.post(API.subcatmenu, args, "").then((response) {
      print(response.body.toString());

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        tempResponse = "1";
        if (data['success'] == 1) {
          List subcat = data["detail"];

          for (int i = 0; i < subcat.length; i++) {

            List dishes = subcat[i]["dishes"];

            print("dasdasdasda"+dishes.toString());

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
              itemList.add(new DishModel(
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
            setState(() {});
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


  _categoryType(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Category Name :',
                      style: AppTheme.textStyle.lightHeading.copyWith(
                          fontSize: AppFontSize.s18, color: Colors.black),
                    )),
              ),
              Expanded(
                flex: 3,
                child: TextField(
                  autocorrect: false,
                  controller: _categoryName,
                  decoration: InputDecoration(
                    hintText: 'Category name',
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      //  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    fillColor: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier * 1,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Dishes : ',
                style: AppTheme.textStyle.lightHeading.copyWith(
                    fontSize: AppFontSize.s18, color: Colors.black),
              ),
              Container(
                height: SizeConfig.heightMultiplier * 5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                        color: AppTheme.primaryColor, width: 2)),
                child: FlatButton(
                  onPressed: () {
                    AddDish(
                        widget.cateId,
                        widget.itemId
                    );
                  },
                  child: Text("Add Dish"),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier * 1,
        ),
        Expanded(child:  ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[300],
                  ), borderRadius: BorderRadius.all(Radius.circular(5))),
              child: ListTile(
                trailing:FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 1, horizontal: 6),
                //  minWidth: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  color: AppTheme.accentColor,
                  onPressed: () {
                    _deleteSubCategoryDialog(index,itemList[index].id);
                  },
                  child: Tooltip(
                    message: "Delete Dish",
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                onTap: ()=> AppRoutes.goto(context, DishViewScreen(widget.cateId, widget.itemId,itemList[index].id)),
                title: Text(itemList[index].name.toString()),
              ),
            );
          },
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount:itemList.length,
        ), )
      ],
    );
  }

  void deleteDish(int index, dishId) {
    print(dishId);
    Map<String, String> args = new Map();
   // args["restaurantid"] = resId;
    args["dishid"]=dishId;
    _dialog();
    API.post(API.deleteDish, args, "").then((response) {
      print(response.body.toString());
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == 1) {
          Navigator.of(context).pop(diloagContext);
          itemList.removeAt(index);
          setState(() {
          });
          showDisplayAllert(context: context, isSucces: true, message: data['message']);

        }
        else{
          Navigator.of(context).pop(diloagContext);

          showDisplayAllert(context: context, isSucces: false, message: data['message']);

        }
      }
    });
  }
  void _deleteSubCategoryDialog(index,dishId) {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Dish'),
          content: Text('Are you sure want to delete this dish'),
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
                deleteDish(index,dishId);
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }


}
