import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_fam/api/API.dart';
import 'package:food_fam/model/coupan_list.dart';
import 'package:food_fam/model/orderList.dart';
import 'package:food_fam/screens/subcategory_view_page.dart';
import 'package:food_fam/theme/theme.dart';
import 'package:food_fam/utils/ShareManager.dart';
import 'package:food_fam/utils/app_routes.dart';
import 'package:food_fam/utils/display_alert_widget.dart';
import 'package:food_fam/utils/size_config.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CouponScreen extends StatefulWidget {
  @override
  _CouponScreenState createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  bool isLoading = false;
  String Rname='';
  String id='';
  var category_add_controller = new TextEditingController();
  var category_dis_controller = new TextEditingController();
  var category_price_controller = new TextEditingController();
  var category_amt_controller = new TextEditingController();
  List<CoupanList> list = new List();
  var diloagContext;
  var resId;

  File _cameraImage;
  String base64Image;

  String startDate = 'StartDate';
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ShareMananer.getUserDetails().then((data){
      Rname=data["rname"].toString();
      resId=data["token"].toString();
      id=data["token"].toString();
      print(Rname);
      coupanList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coupan'),
        centerTitle: true,
        backgroundColor: AppTheme.primaryColor,
      ),
      body: Container(
        width: SizeConfig.widthMultiplier*100,
        margin: EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            ListView.builder(
              shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context,int index){
                  return couponUi(index,list[index].name,list[index].id);
                }),
          ],
        ),
      ),
    );
  }

  Widget couponUi(int index, String name , String id ) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      //  padding: EdgeInsets.only(left:24.0,right: 24),
      width: SizeConfig.widthMultiplier * 100,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[300],
          ),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.only(left: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                // AppRoutes.goto(context, CategoryViewScreen(widget.category_name, widget.id,));
              },
              child: Container(
                width: SizeConfig.heightMultiplier * 26,
                child: Text(name,
                    textAlign: TextAlign.left,
                    style: AppTheme.textStyle.lightHeading.copyWith(
                        color: Colors.black, fontSize: AppFontSize.s18)),
              ),
            ),
            Container(
              width: SizeConfig.widthMultiplier*10,
              height: SizeConfig.widthMultiplier*10,
              child: FlatButton(
                padding: EdgeInsets.symmetric(vertical: 1, horizontal: 6),
                // minWidth: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                color: AppTheme.primaryColor,
                onPressed: () {
                  //  widget.addSubcategory();
                },
                child: Tooltip(
                  message: "Add SubCategory",
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
            Container(
              width: SizeConfig.widthMultiplier*10,
              height: SizeConfig.widthMultiplier*10,
              child: FlatButton(
                padding: EdgeInsets.symmetric(vertical: 1, horizontal: 3),
                // minWidth: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                color: AppTheme.accentColor,
                onPressed: () {
                  _deleteSubCategoryDialog(index,id);
                },
                child: Tooltip(
                  message: "View category",
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
      ),
    );
  }

  _addCategoryDialog() {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(8),
          title: Text('Add Category'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: category_add_controller,
                decoration: InputDecoration(
                  hintText: "Example: Name",
                ),
              ),
              TextField(
                controller: category_price_controller,
                decoration: InputDecoration(
                  hintText: "Example: Price",
                ),
              ),
              TextField(
                controller: category_dis_controller,
                decoration: InputDecoration(
                  hintText: "Example: Disciption",
                ),
              ),
              TextField(
                controller: category_amt_controller,
                decoration: InputDecoration(
                  hintText: "Example: Amount Type",
                ),
              ),
              SizedBox(height: SizeConfig.heightMultiplier*2,),
              GestureDetector(
                onTap: (){_selectDate(context);},
                child: Container(
                  alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: SizeConfig.widthMultiplier*15,right:SizeConfig.widthMultiplier*15 ),
                    padding: EdgeInsets.only(bottom: 8),
                    width: SizeConfig.widthMultiplier*30,
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.black54))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('dd/mm/yy',style: AppTheme.textStyle.lightHeading.copyWith(
                            color: Colors.black54,fontSize: AppFontSize.s16
                        ),),
                        SizedBox(width: SizeConfig.widthMultiplier*5,),
                        GestureDetector(
                            onTap: (){
                              _selectDate(context);
                            },
                            child: Icon(Icons.calendar_today,color: Colors.black54,size: 14,)),
                      ],)
                ),
              ),
              SizedBox(height: SizeConfig.heightMultiplier*2,),
              GestureDetector(
                onTap: (){imagePicker();},
                child: Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: SizeConfig.widthMultiplier*15,right:SizeConfig.widthMultiplier*15 ),
                    padding: EdgeInsets.only(bottom: 8),

                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.black54))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Pic Coupan',style: AppTheme.textStyle.lightHeading.copyWith(
                            color: Colors.black54,fontSize: AppFontSize.s16
                        ),),
                        SizedBox(width: SizeConfig.widthMultiplier*5,),
                        GestureDetector(
                            onTap: (){
                              imagePicker();
                            },
                            child: Icon(Icons.image,color: Colors.black54,size: 14,)),
                      ],)
                ),
              ),


            ],
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
                coupanAddApi();
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }
  
  
  coupanAddApi(){
    loadProgress();
    Map<String, String> args = new Map();
    args["restaurantid"]=id;
    args["name"]=category_add_controller.text.toString();
    args["amount"]=category_price_controller.text.toString();
    args["description"]=category_dis_controller.text.toString();
    args["amount_type"]=category_dis_controller.text.toString();
    args["expiry_date"]=category_dis_controller.text.toString();
    args["image"]=category_dis_controller.text.toString();
    //  var body = json.encode(args);

    API.post(API.coupanAdd, args,'').then((response){
      loadProgress();
      print("coupanAdd"+response.statusCode.toString());
      print(response.body.toString());
      final data = json.decode(response.body);
      if(response.statusCode==200)
      {
        print(data['success']);

        if(data['success']==1){

          List dlist = data["detail"];
          print("ffff"+dlist.length.toString());
          for(int i=0;i<dlist.length;i++)
          {
            String id = dlist[i]["id"].toString();
            String name = dlist[i]["name"].toString();
            String rid = dlist[i]["rid"].toString();
            String description = dlist[i]["status"].toString();
            String amount = dlist[i]["amount"].toString();
            String amount_type = dlist[i]["amount_type"].toString();
            String expiry_date = dlist[i]["expiry_date"].toString();
            String created_at = dlist[i]["created_at"].toString();
            String updated_at = dlist[i]["updated_at"].toString();
            String blockstatus = dlist[i]["blockstatus"].toString();
            String image = dlist[i]["image"].toString();

            list.add(new CoupanList(id,name,rid,description,amount,amount_type,expiry_date,created_at,updated_at,
                blockstatus,image));
          }

/*
          Future.delayed(Duration(seconds: 2), () {

            //AppRoutes.makeFirst(context, OrderListScreen());
          });*/
        }else{
          showDisplayAllert(context: context,isSucces: false,message: data['message']);
        }

      }
      else{
        showDisplayAllert(context: context,isSucces: false,message: "Server error");
      }
    });
  }



  void _deleteSubCategoryDialog(index,id) {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Coupon'),
          content: Text('Are you sure want to delete this Coupon'),
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
                _deleteSubCategoryfromServer(index,id);
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
    API.post(API.coupanDelete, args, "").then((response) {
      print(response.body.toString());
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == 1) {
          Navigator.of(context).pop(diloagContext);
          list.removeAt(index);
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

  coupanList(){
    loadProgress();
    Map<String, String> args = new Map();
    args["restaurantid"]=id;
    //  var body = json.encode(args);

    API.post(API.coupanList, args,'').then((response){
      loadProgress();
      print("coupan"+response.statusCode.toString());
      print(response.body.toString());
      final data = json.decode(response.body);
      if(response.statusCode==200)
      {
        print(data['success']);

        if(data['success']==1){

          List dlist = data["detail"];
          print("ffff"+dlist.length.toString());
          for(int i=0;i<dlist.length;i++)
          {
            String id = dlist[i]["id"].toString();
            String name = dlist[i]["name"].toString();
            String rid = dlist[i]["rid"].toString();
            String description = dlist[i]["status"].toString();
            String amount = dlist[i]["amount"].toString();
            String amount_type = dlist[i]["amount_type"].toString();
            String expiry_date = dlist[i]["expiry_date"].toString();
            String created_at = dlist[i]["created_at"].toString();
            String updated_at = dlist[i]["updated_at"].toString();
            String blockstatus = dlist[i]["blockstatus"].toString();
            String image = dlist[i]["image"].toString();

            list.add(new CoupanList(id,name,rid,description,amount,amount_type,expiry_date,created_at,updated_at,
            blockstatus,image));
          }

/*
          Future.delayed(Duration(seconds: 2), () {

            //AppRoutes.makeFirst(context, OrderListScreen());
          });*/
        }else{
          showDisplayAllert(context: context,isSucces: false,message: data['message']);
        }

      }
      else{
        showDisplayAllert(context: context,isSucces: false,message: "Server error");
      }
    });
  }
  loadProgress(){
    isLoading=!isLoading;
    setState(() {
    });
  }
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
  imagePicker() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _cameraImage = image;
      try {
        base64Image = image.path.split("/").last;
      } catch (e) {
        print("Catch Error " + e);
      }
    });
  }
}
