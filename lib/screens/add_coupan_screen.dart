import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_fam/api/API.dart';
import 'package:food_fam/model/coupan_list.dart';
import 'package:food_fam/theme/theme.dart';
import 'package:food_fam/utils/ShareManager.dart';
import 'package:food_fam/utils/app_routes.dart';
import 'package:food_fam/utils/display_alert_widget.dart';
import 'package:food_fam/utils/size_config.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddCouponScreen extends StatefulWidget {
  @override
  _AddCouponScreenState createState() => _AddCouponScreenState();
}

class _AddCouponScreenState extends State<AddCouponScreen> {
  bool isLoading = false;
  String Rname='';
  String id='';
  var category_add_controller = new TextEditingController();
  var category_dis_controller = new TextEditingController();
  var category_price_controller = new TextEditingController();
 // var category_amt_controller = new TextEditingController();
  List<CoupanList> list = new List();
  var diloagContext;
  var resId;
  var type = "Percentage";
  int instId = 1;
  File _cameraImage;
  String base64Image;

  var Expiry_Date = '';

  String startDate = '';
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
      addcoupan();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.primaryColor,
          title: Text('Add Coupon'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(SizeConfig.widthMultiplier*4),
            child: Column(
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



                SizedBox(height: SizeConfig.heightMultiplier*2,),
                GestureDetector(
                  onTap: (){_selectDate(context);},
                  child: Container(
                      alignment: Alignment.centerLeft,
                     // margin: EdgeInsets.only(left: SizeConfig.widthMultiplier*15,right:SizeConfig.widthMultiplier*15 ),
                      padding: EdgeInsets.only(bottom: 8),
                      width: SizeConfig.widthMultiplier*50,
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.black54))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                         startDate==''? Text('Expiry Date' ,style: AppTheme.textStyle.lightHeading.copyWith(
                              color: Colors.black54,fontSize: AppFontSize.s16
                          ),):Text(startDate ,style: AppTheme.textStyle.lightHeading.copyWith(
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
                    width: SizeConfig.widthMultiplier*50,
                      alignment: Alignment.centerLeft,
                    //  margin: EdgeInsets.only(left: SizeConfig.widthMultiplier*15,right:SizeConfig.widthMultiplier*15 ),
                      padding: EdgeInsets.only(bottom: 8),

                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.black54))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                SizedBox(height: SizeConfig.heightMultiplier*1,),
                Container(
                  child: Row(
                    children: <Widget>[
                      Radio(
                        value: 1,
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
                        value: 2,
                        groupValue: instId,
                        onChanged: (value) {
                          instId = value;
                          type = "Fixed";
                          setState(() {});
                        },
                      ),
                      Text(
                        'Non-Veg',
                        style: AppTheme.textStyle.lightHeading
                            .copyWith(fontSize: AppFontSize.s18),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.heightMultiplier*10,),
                GestureDetector(
                  onTap: (){
                    addcoupan();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: SizeConfig.heightMultiplier*7,
                    width: SizeConfig.widthMultiplier*100,
                    margin: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier*10),
                    decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(30))
                    ),
                    child: Text('Add Coupon',style: AppTheme.textStyle.lightHeading.copyWith(
                        color: Colors.white,fontSize: AppFontSize.s18
                    ),),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
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

    setState(() {
    });

  }

  addcoupan() async {
    if(category_add_controller.text.toString().isNotEmpty && category_dis_controller.text.toString().isNotEmpty &&
    category_price_controller.text.toString().isNotEmpty)
    {
  //    loadProgress();
      _dialog();

      Map<String, String> args = new Map();
      args["restaurantid"] = id;
      args["name"] = category_add_controller.text.toString();
      args["description"] = category_dis_controller.text.toString();
      args["amount"] = category_price_controller.text.toString();
      args["amount_type"] = type;
      args["expiry_date"] = startDate;
      args["image"] = "idididi";

      API.post(API.coupanAdd, args, "").then((response) {
       // loadProgress();
        print(response.statusCode.toString());
        print(response.body.toString());

        if (response.statusCode == 200) {
          final data = json.decode(response.body);

          // ShareMananer.setDetails(data['token'], true);
          print(data['success']);

          if (data['success'] == 1) {
            Navigator.of(context).pop(diloagContext);

            String id = data['detail']['id'].toString();
            String restaurantid = data['detail']['restaurantid'].toString();
            String Rname = data['detail']['Rname'].toString();
            String ownername = data['detail']['ownername'].toString();
            String ownermobile = data['detail']['ownermobile'].toString();

            ShareMananer.setDetails(id, true, restaurantid, Rname, ownermobile, ownername);
            print(id);

            Future.delayed(Duration(seconds: 1), () {
              showDisplayAllert(
                  context: context, isSucces: true, message: data['message']);

                  AppRoutes.dismiss(context);
            });

          } else {
            showDisplayAllert(
                context: context, isSucces: false, message: data['message']);
            Navigator.of(context).pop(diloagContext);

          }
        } else {
          showDisplayAllert(
              context: context, isSucces: false, message: "Server error");
          Navigator.of(context).pop(diloagContext);

        }
      });
    }else{
      showDisplayAllert(context: context,isSucces: false,message: "Please fill inputs");
    }
  }

  _dialog(){
    diloagContext=Dialog(
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
        context: this.context,
        barrierDismissible: true,
        builder: (context) {
          return diloagContext;
        });
  }
}
