import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_fam/api/API.dart';
import 'package:food_fam/screens/menu_screen.dart';
import 'package:food_fam/screens/model/topings_model.dart';
import 'package:food_fam/theme/theme.dart';
import 'package:food_fam/utils/ShareManager.dart';
import 'package:food_fam/utils/app_routes.dart';
import 'package:food_fam/utils/display_alert_widget.dart';
import 'package:food_fam/utils/size_config.dart';

class DishViewScreen extends StatefulWidget {
  String categoryId, dishId, subcategoryId;

  DishViewScreen(
    this.categoryId,
    this.subcategoryId,
    this.dishId,
  );

  @override
  _DishEditState createState() => _DishEditState();
}

class _DishEditState extends State<DishViewScreen> {
  bool isSwitched = false;
  var instId = "VEG";
  bool isBestSeller = false;
  var topping_name_controller = TextEditingController();
  var topping_price_controller = TextEditingController();
  var _dishName = TextEditingController();
  var _price = TextEditingController();
  var _des = TextEditingController();
  var tempResponse;

  List<ToppingsModel> _toppingList = List();
  var type = "VEG", resId;
  var diloagContext;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ShareMananer.getUserDetails().then((userDetails) {
      resId = userDetails['token'];
      print(resId);
      _fetchData(resId);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: Text(
          'View Dish',
          style: AppTheme.textStyle.lightHeading.copyWith(color: Colors.white),
        ),
        actions: [
          IconButton(icon: Icon(Icons.delete), onPressed: (){_deleteDishDialog();})
        ],
      ),
      body:
    GestureDetector(
    onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: tempResponse != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(8),
                      width: SizeConfig.widthMultiplier * 80,
                      height: SizeConfig.heightMultiplier * 7,
                      child: TextField(
                        autocorrect: false,
                        controller: _dishName,
                        decoration: InputDecoration(
                          hintText: 'Dish Name',
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
                    ),
                    Container(
                        child: IconButton(
                      icon: Icon(Icons.star_border),
                      iconSize: 35,
                      color: isBestSeller ? Colors.yellow : null,
                      onPressed: () {
                        if (isBestSeller) {
                          isBestSeller = false;
                          setState(() {});
                        } else {
                          isBestSeller = true;
                          setState(() {});
                        }
                      },
                    )),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2,
                ),
                Container(
                  width: SizeConfig.widthMultiplier * 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 4),
                        child: Text('Price'),
                      ),
                      Container(
                        width: SizeConfig.widthMultiplier * 80,
                        height: SizeConfig.heightMultiplier * 7,
                        child: TextField(
                          controller: _price,
                          autocorrect: false,
                          decoration: InputDecoration(
                            hintText: '₹',
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
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2,
                ),
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text('Description')),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  height: SizeConfig.heightMultiplier * 15,
                  child: TextField(
                    maxLines: 7,
                    keyboardType: TextInputType.multiline,
                    autocorrect: false,
                    controller: _des,
                    decoration: InputDecoration(
                      hintText: 'Description',
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
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 4,
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Radio(
                        value: "VEG",
                        groupValue: instId,
                        onChanged: (value) {
                          instId = value;
                          type = "VEG";
                          setState(() {});
                        },
                      ),
                      Text(
                        'Veg',
                        style: AppTheme.textStyle.lightHeading
                            .copyWith(fontSize: AppFontSize.s18),
                      ),
                      Radio(
                        value:"NON-VEG",
                        groupValue: instId,
                        onChanged: (value) {
                          instId = value;
                          type = "NON-VEG";
                          setState(() {});
                        },
                      ),
                      Text(
                        'Non-Veg',
                        style: AppTheme.textStyle.lightHeading
                            .copyWith(fontSize: AppFontSize.s18),
                      ),
                      Radio(
                        value:"EGG",
                        groupValue: instId,
                        onChanged: (value) {
                          instId = value;
                          type = "EGG";
                          setState(() {});
                        },
                      ),
                      Text(
                        'Egg',
                        style: AppTheme.textStyle.lightHeading
                            .copyWith(fontSize: AppFontSize.s18),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Customizable'),
                      Spacer(),
                      isSwitched
                          ? Container(
                              height: SizeConfig.heightMultiplier * 4,
                              width: SizeConfig.widthMultiplier * 20,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(
                                      color: AppTheme.primaryColor, width: 2)),
                              child: FlatButton(
                                onPressed: () {
                                  _addCategoryDialog();
                                },
                                child: Text("Add"),
                              ),
                            )
                          : SizedBox(),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                            if (_toppingList.isEmpty && isSwitched) {
                              _addCategoryDialog();
                            }


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
                _toppingListContainer(),
              ],
            )
          : Container(
              height: SizeConfig.heightMultiplier * 100,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                ),
              ),
            )),
      bottomNavigationBar: InkWell(
        child: Container(
          height: SizeConfig.heightMultiplier * 7,
          color: AppTheme.primaryColor,
          child: Center(
              child: Text('Update Dish',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18))),
        ),
        onTap: () {
          _addDishToServer();
        },
      ),
    );
  }

  _toppingListContainer() {
    if (isSwitched) {
      if (_toppingList.isNotEmpty) {
        return Expanded(
          child: Container(
              margin: EdgeInsets.only(left: 16, right: 16),

              child: ListView.builder(
                  itemCount: _toppingList.length,
                  itemBuilder: (cont, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 4),
                      //tileColor: Colors.white,
                      title: Text(
                        _toppingList[index].name,
                      ),
                      trailing: Text(
                        "Rs." + _toppingList[index].price,
                      ),
                      leading: IconButton(
                        onPressed: () {
                          _deleteTopping(_toppingList[index].id,index);

                        }, icon: Icon(Icons.clear,color: Colors.black,),

                      ),
                    );
                  })),
        );
      } else {
        return SizedBox();
      }
    } else {
      return SizedBox();
    }
  }

  _addCategoryDialog() {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Toppings'),
          content: Container(
            height: 100,
            child: Column(
              children: [
                TextField(
                  controller: topping_name_controller,
                  decoration: InputDecoration(
                    hintText: "Name",
                  ),
                ),
                TextField(
                  controller: topping_price_controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Price",
                  ),
                ),
              ],
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
                _addTopping(widget.dishId, topping_name_controller.text.toString(), topping_price_controller.text.toString(),);
                topping_name_controller.text = "";
                topping_price_controller.text = "";

              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }  _deleteDishDialog() {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Dish'),
          content: Container(
            child: Text('Are you sure do you want delete Dish'),
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
                deleteDish();

              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _addDishToServer() {
    if (_price.text.isNotEmpty &&
        _dishName.text.isNotEmpty &&
        _des.text.isNotEmpty) {
      Map<String, String> args = new Map();
      args["restaurantid"] = resId;
      args["categoryid"] = widget.categoryId;
      args["subcategoryid"] = widget.subcategoryId;
      args["name"] = _dishName.text;
      args["dishid"] =widget.dishId;
      args["price"] = _price.text;
      args["description"] = _des.text;
      args["type"] = type;
      args["bestseller"] = isBestSeller.toString();
      args["isCustomizable"] = isSwitched.toString();
      args["toppings"] = json.encode(_toppingList);
      print(args.toString());
      _dialog();
      API.post(API.editDish, args, "").then((response) {
        print(response.body.toString());

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          if (data['success'] == 1) {
            Navigator.of(context).pop(diloagContext);
            showDisplayAllert(context: context, isSucces: true, message: data['message']);
          } else {
            Navigator.of(context).pop(diloagContext);
            showDisplayAllert(
                context: context, isSucces: false, message: data['message']);
          }
        } else {
          showDisplayAllert(
              context: context,
              isSucces: false,
              message: "Please fill all inputs");
        }
      });
    }
  }

  _dialog() {
    diloagContext = Dialog(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Container(
              child: CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
              ),
            ),
            SizedBox(
              width: SizeConfig.widthMultiplier * 2,
            ),
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

  void _fetchData(resId) async {
    Map<String, String> args = new Map();
   // args["restaurantid"] = resId;
    args["dishid"] = widget.dishId;
print(args);
    API.post(API.dishmenu, args, "").then((response) {
      print(response.body.toString());

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        tempResponse = "1";
        if (data['success'] == 1) {
          List dish = data["detail"];

          for (int i = 0; i < dish.length; i++) {

            isBestSeller =dish[i]['bestseller']== "true"?true:false;
            isSwitched =dish[i]['isCustomizable']== "true"?true:false;
             _dishName.text=dish[i]['name'].toString();
             _price.text=dish[i]['price'].toString();
             _des.text=dish[i]['description'].toString();
             type=dish[i]['type'].toString();
             instId=dish[i]['type'].toString();
             if(isSwitched)
            { List toppings = dish[i]["toppings"];
             for (int k = 0; k < toppings.length; k++) {
               var id = toppings[k]["id"].toString();
               var dishid = toppings[k]["dishid"].toString();
               var name = toppings[k]["name"].toString();
               var price = toppings[k]["price"].toString();
               _toppingList.add(new ToppingsModel(id,dishid,name,"",price,""));
             }
            }

             setState(() {

             });

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

  void _deleteTopping(id,index) {
    Map<String, String> args = new Map();
    args["restaurantid"] = resId;
    args["toppingid"] =id.toString();
    _dialog();
    API.post(API.deleteTopping, args, "").then((response) {
      print(response.body.toString());
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == 1) {
          Navigator.of(context).pop(diloagContext);
          showDisplayAllert(context: context, isSucces: true, message: data['message']);
          _toppingList.removeAt(index);
          setState(() {

          });
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

  void _addTopping(String dishId, String name, String price) {
    if(price.isNotEmpty && name.isNotEmpty){
    Map<String, String> args = new Map();
    args["restaurantid"] = resId;
    args["dishid"] =dishId;
    args["name"] =name;
    args["price"] =price;
    _dialog();
    API.post(API.addTopping, args, "").then((response) {
      print(response.body.toString());
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == 1) {
          Navigator.of(context).pop(diloagContext);
          showDisplayAllert(context: context, isSucces: true, message: data['message']);
          _toppingList.add(new ToppingsModel("", "", name, "", price, ""));
          setState(() {});
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
  }

  void deleteDish() {

    Map<String, String> args = new Map();
    args["restaurantid"] = resId;
    args["dishid"] =widget.dishId;
    _dialog();
    API.post(API.deleteDish, args, "").then((response) {
      print(response.body.toString());
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == 1) {
          Navigator.of(context).pop(diloagContext);
          showDisplayAllert(context: context, isSucces: true, message: data['message']);
          AppRoutes.replace(context, MenuScreen());

        }
        else{
          Navigator.of(context).pop(diloagContext);

          showDisplayAllert(context: context, isSucces: false, message: data['message']);

        }
      }
    });
  }
}
