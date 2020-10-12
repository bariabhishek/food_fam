import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_fam/api/API.dart';
import 'package:food_fam/model/aproved_order_list.dart';
import 'package:food_fam/model/order_details.dart';
import 'package:food_fam/model/toppings_model.dart';
import 'package:food_fam/screens/searchScreen.dart';
import 'package:food_fam/theme/theme.dart';
import 'package:food_fam/utils/app_assets.dart';
import 'package:food_fam/utils/app_routes.dart';
import 'package:food_fam/utils/display_alert_widget.dart';
import 'package:food_fam/utils/size_config.dart';

class OrderDetailsPic extends StatefulWidget {
  String type;
  AproverdOrders data;
  String id;
  String name;
  String mobile;
  String status;
  List<OrderDetails> orderDetails;
  OrderDetailsPic(@required this.type,  this.id,
      this.name,this.mobile,this.status,this.orderDetails);


  @override
  _OrderDetailsPicState createState() => _OrderDetailsPicState();
}

class _OrderDetailsPicState extends State<OrderDetailsPic> {

  var _reason_controller = TextEditingController();
  var diloagContext;
  var resId, tempResponse;
  bool haveData = true;


  String name='';
  String price='';
  String quantity='';
  int grandTotel=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    widget.orderDetails.forEach((element) {
     int topingAmount=0;
      grandTotel=grandTotel+ int.parse(element.orderPrice);

      element.topingMainList.forEach((elementToping) {
        topingAmount=topingAmount+ elementToping.price;

      });

      grandTotel=grandTotel+topingAmount;

    });
    setState(() {

    });


    Future.delayed(Duration(seconds: 1), () {

    });


   // dataUncode(widget)
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ORDERS'),
      actions: [
        IconButton(icon: Icon(Icons.app_blocking), onPressed: (){
          _addSpam(widget.mobile);
        })
      ],
      backgroundColor: AppTheme.primaryColor,),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          Container(

            padding: EdgeInsets.all(16),
            color: Colors.grey[400],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                Text(widget.name,style: AppTheme.textStyle.lightHeading.copyWith(
                  color: Colors.white
                ),),
                SizedBox(height: SizeConfig.heightMultiplier*1,),
                Text(widget.mobile,style: AppTheme.textStyle.lightHeading.copyWith(
                    color: Colors.white
                ),),
              ],),
              Text("SN./"+widget.id,style: AppTheme.textStyle.lightHeading.copyWith(
                  color: Colors.white
              ),),
            ],),
          ),
            SizedBox(height: SizeConfig.heightMultiplier*2,),
          Text('Totel Items ( '+widget.orderDetails.length.toString()+" )",style: AppTheme.textStyle.lightHeading.copyWith(
              color: Colors.black,fontSize: AppFontSize.s18,
          ),),

            Expanded(
              flex: 2,
              child: ListView.builder(itemCount: widget.orderDetails.length ,
              shrinkWrap: true,
              itemBuilder: (context,int index){
                return orderList(widget.orderDetails[index]);
              },),
            ),
            SizedBox(height: SizeConfig.heightMultiplier*2,),
            Text('Instructions',style: AppTheme.textStyle.lightHeading.copyWith(
              color: Colors.black,fontSize: AppFontSize.s18,
            ),),
            SizedBox(height: SizeConfig.heightMultiplier*2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Grand Total',style: AppTheme.textStyle.lightHeading.copyWith(
                  color: Colors.black,fontSize: AppFontSize.s18,
                ),),
                Text('₹'+grandTotel.toString()),
              ],
            ),
            SizedBox(height: SizeConfig.heightMultiplier*4,),
            widget.type=="pending"?Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
              ),
              padding: EdgeInsets.all(12),

              width: SizeConfig.widthMultiplier*100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('Accept/Reject',style: AppTheme.textStyle.heading1.copyWith(
                    color: Colors.black,fontSize: AppFontSize.s18,
                  ),),
                  Container(
                    width: SizeConfig.widthMultiplier*40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                          ),
                          child: GestureDetector(
                              onTap: (){
                                updateorder('A','');
                              },
                              child: Icon(Icons.done)),
                        ),
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                          ),
                          child: GestureDetector(
                              onTap: (){
                                _addSubCategoryDialog();
                              },
                              child: Icon(Icons.delete_outline)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ):Container()
        ],),
      ),
    );
  }

  void _addSubCategoryDialog() {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Reason for reject'),
          content: TextField(
            controller: _reason_controller,
            decoration: InputDecoration(
              hintText: "",
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
                updateorder("R",_reason_controller.text.toString());
              },
              child: Text("Reject"),
            ),
          ],
        );
      },
    );
  }

  _dialog(){
    showDialog(
        context: this.context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
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
        });
  }
  updateorder(String status, String reason) {
    _dialog();

    Map<String, String> args = new Map();
    args["orderid"]=widget.id.toString();
    args["status"]=status.toString();
    args["reason"]=reason.toString();

    API.post(API.updateorder, args, "").then((response) {

      print(response.statusCode.toString());
      print(response.body.toString());

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // ShareMananer.setDetails(data['token'], true);


        if (data['success'] == 1) {


          Navigator.of(context).pop(diloagContext);


          Future.delayed(Duration(seconds: 1), () {
            showDisplayAllert(
                context: context, isSucces: true, message: data['message']);
             AppRoutes.makeFirst(context, SearchScreen());
          });
        } else {
          Navigator.of(context).pop(diloagContext);
          showDisplayAllert(
              context: context, isSucces: false, message: data['message']);

        }
      } else {
        Navigator.of(context).pop(diloagContext);
        showDisplayAllert(
            context: context, isSucces: false, message: "Server error");

      }
    });
  }

  Widget orderList(OrderDetails orderDetails) {


    return Column(
      children: [
        ListTile(
          leading: Image.asset(Assets.veg,height: 16,width: 16,),
          title: Text(orderDetails.orderName),
          subtitle: Text(orderDetails.orderQuantity),
          trailing: Text('₹'+orderDetails.orderPrice),
        ),
        ListView.builder(
          itemCount: orderDetails.topingMainList.length ,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context,int index){
          ToppingsDishModel toppings = orderDetails.topingMainList[index];
            return  ListTile(
              leading: Spacer(),
              title: Text(toppings.name,),
              trailing: Text('₹'+toppings.price.toString()),
            );
          },),

      ],
    );
  }



  void _addSpam(mobile) {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add SubCategory'),
          content:Text('Are you sure to spam this user ?'),
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
                _spamUser(mobile);
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _spamUser(mobile) {
    Map<String, String> args = new Map();
    _dialog();
    args["reason"] = "not allow";
    args["restaurantid"] = resId;
    args["mobile"] = mobile;
    API.post(API.addSubCategory, args, "").then((response) {
      print(response.body.toString());
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == 1) {
          showDisplayAllert(context: context, isSucces: true, message: data['message']);
            Navigator.of(context).pop(diloagContext);
            Navigator.pop(context);

        }else{
          Navigator.of(context).pop(diloagContext);
          showDisplayAllert(context: context, isSucces: false, message: data['message']);

        }
      }
    });
  }
}
