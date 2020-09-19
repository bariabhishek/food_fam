import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_fam/api/API.dart';
import 'package:food_fam/screens/model/category_model.dart';
import 'package:food_fam/screens/model/subcategory_model.dart';
import 'package:food_fam/theme/theme.dart';
import 'package:food_fam/utils/ShareManager.dart';
import 'package:food_fam/utils/app_routes.dart';
import 'package:food_fam/utils/display_alert_widget.dart';
import 'package:food_fam/utils/size_config.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'add_dish.dart';
import 'dish_view_page.dart';
import 'model/dish_model.dart';
import 'subcategory_view_page.dart';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CategoryViewScreen extends StatefulWidget {
  var itemName, itemId;




  CategoryViewScreen(this.itemName, this.itemId);

  @override
  _MenuViewScreenState createState() => _MenuViewScreenState();
}

class _MenuViewScreenState extends State<CategoryViewScreen> {
  List<SubategoryModel> itemList = List();

  var resId,tempResponse;
  var _categoryName = TextEditingController();
  var category_add_controller = TextEditingController();
  var diloagContext;
  bool haveData=true;
  String startDate = 'StartDate';
  DateTime selectedDate = DateTime.now();
  File _cameraImage;
  File _image;
  final picker = ImagePicker();
  String base64Image;


  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        startDate = picked.toString();
        startDate = DateFormat("dd-MMM-yyyy").format(DateTime.parse(startDate));
        selectedDate = picked;
        print("StartDate" + startDate + "  " + selectedDate.toString());
      });
  }

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

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: Text("Category"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {_deleteCategoryDialog();},
            tooltip: "Delete This Category",
          )
        ],
      ),
      bottomNavigationBar: InkWell(
        child: Container(
          height: SizeConfig.heightMultiplier * 7,
          color: AppTheme.primaryColor,
          child: Center(
              child: Text('Update Category',
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
    args["categoryid"] = widget.itemId;
    args["name"] = _categoryName.text;
    _dialog();
    API.post(API.editCategory, args, "").then((response) {
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
    args["categoryid"] = widget.itemId;
    _dialog();
    API.post(API.deleteCategory, args, "").then((response) {
      print(response.body.toString());
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == 1) {
          Navigator.of(context).pop(diloagContext);
          Future.delayed(Duration(seconds: 1), () {
            Navigator.pop(context);
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
          title: Text('Detete Category'),
          content: Text('Are you sure want to delete this Category'),
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
    args["categoryid"] = widget.itemId;

    API.post(API.catmenu, args, "").then((response) {
   print(response.body.toString());

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        tempResponse = "1";
        if (data['success'] == 1) {
          List category = data['detail'];
          if (category.isEmpty) {
            haveData = false;
          }
          for(int i =0;i<category.length;i++){
            List subcategory=category[i]['subcategory'];

            for (int j = 0; j < subcategory.length; j++)
            {
              var id = subcategory[j]["id"].toString();
              var restaurantid = subcategory[j]["restaurantid"].toString();
              var name = subcategory[j]["name"].toString();
              var category_id = subcategory[j]["category"].toString();
              var createat = subcategory[j]["createat"].toString();
              var blockstatus = subcategory[j]["blockstatus"].toString();
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
              itemList.add(new SubategoryModel(
                  id,
                  restaurantid,
                  name,
                  createat,
                  blockstatus,
                  category_id,
                  _dishList));
            }

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
                'Subcategories : ',
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
                    _addSubCategoryDialog(widget.itemId);
                  },
                  child: Text("Add Subcategory"),
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
              child: ExpansionTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(child: InkWell(onTap: () {
                      AppRoutes.replace(
                          context,
                          subCategoryViewScreen(itemList[index].name,itemList[index].id,itemList[index].category_id));
                    },child: Text(itemList[index].name.toString()),),flex: 5,),

                    Expanded(
                      child: FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 1, horizontal: 6),
                       // minWidth: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        color: AppTheme.accentColor,
                        onPressed: () {
                          AppRoutes.replace(
                              context,
                              subCategoryViewScreen(itemList[index].name,itemList[index].id,itemList[index].category_id));
                        },
                        child: Tooltip(
                          message: "View subcategory",
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8,),
                    Expanded(
                      child: FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 1, horizontal: 6),
                   //   minWidth: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        color: AppTheme.accentColor,
                        onPressed: () {
                          _deleteSubCategoryDialog(index,itemList[index].id);
                             },
                        child: Tooltip(
                          message: "Delete subcategory",
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                children: [
                  ListView.builder(
                    itemBuilder: (context, ind) {
                      return InkWell(
                        onTap: (){
                          AppRoutes.goto(context, DishViewScreen(
                              widget.itemId,
                              itemList[index].id,
                              itemList[index].dish_list[ind].id
                          ));
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(itemList[index].dish_list[ind].name),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 10,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                    itemList[index].dish_list.length,
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1,
                  ),
                ],
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
          if(itemList.isNotEmpty){
            Navigator.of(context).pop(diloagContext);
            itemList.clear();
            _fetchData(resId);
          }else{
            Navigator.of(context).pop(diloagContext);
            _fetchData(resId);
          }
          showDisplayAllert(context: context, isSucces: true, message: data['message']);
        }else{
          Navigator.of(context).pop(diloagContext);
          showDisplayAllert(context: context, isSucces: false, message: data['message']);

        }
      }
    });
  }

  void _deleteSubCategoryDialog(index,subcategoryId) {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Subcategory'),
          content: Text('Are you sure want to delete this subcategory'),
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
                _deleteSubCategoryfromServer(index,subcategoryId);
      },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }
  void _deleteSubCategoryfromServer(index,subcategoryId) {
    print(index);
    Map<String, String> args = new Map();
    args["restaurantid"] = resId;
    args["subcategoryid"] =subcategoryId;
    _dialog();
    API.post(API.deleteSubcategory, args, "").then((response) {
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

}
