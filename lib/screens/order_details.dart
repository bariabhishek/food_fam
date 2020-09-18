import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_fam/api/API.dart';
import 'package:food_fam/model/order_details.dart';
import 'package:food_fam/theme/theme.dart';
import 'package:food_fam/utils/app_assets.dart';
import 'package:food_fam/utils/display_alert_widget.dart';
import 'package:food_fam/utils/size_config.dart';

class OrderDetailsPic extends StatefulWidget {
  String type;
 var id;
  OrderDetailsPic(@required this.type, this.id);

  @override
  _OrderDetailsPicState createState() => _OrderDetailsPicState();
}

class _OrderDetailsPicState extends State<OrderDetailsPic> {

  var resId, tempResponse;
  bool haveData = true;
  List<OrderDetails> orderDetails = new List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

   // dataUncode(widget)
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ORDERS'),
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
                Text('Madhu panday',style: AppTheme.textStyle.lightHeading.copyWith(
                  color: Colors.white
                ),),
                SizedBox(height: SizeConfig.heightMultiplier*1,),
                Text('800987654',style: AppTheme.textStyle.lightHeading.copyWith(
                    color: Colors.white
                ),),
              ],),
              Text('S.NO/1029384',style: AppTheme.textStyle.lightHeading.copyWith(
                  color: Colors.white
              ),),
            ],),
          ),
            SizedBox(height: SizeConfig.heightMultiplier*2,),
          Text('Totel Items ( 2 )',style: AppTheme.textStyle.lightHeading.copyWith(
              color: Colors.black,fontSize: AppFontSize.s18,
          ),),

            Expanded(
              flex: 2,
              child: ListView.builder(itemCount: orderDetails.length ,
              shrinkWrap: true,
              itemBuilder: (context,int index){
                return orderList(orderDetails[index].orderName);
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
                Text('₹0000'),
              ],
            ),
            SizedBox(height: SizeConfig.heightMultiplier*4,),
            widget.type=="pendeing"?Container(
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
                          child: Icon(Icons.done),
                        ),
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                          ),
                          child: Icon(Icons.delete_outline),
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

  orderListPending(){
    print('pending data');
    // loadProgress();
    Map<String, String> args = new Map();
    args["orderid"]=widget.id;
    //  var body = json.encode(args);

    API.post(API.orderdetail, args,'').then((response){
//      loadProgress();
      print(response.statusCode.toString());
      print(response.body.toString());
      final data = json.decode(response.body);
      if(response.statusCode==200)
      {
        print(data['success']);
        if(data['success']==1){
          tempResponse="1";
          List dlist = data["detail"];
          if (dlist.isEmpty) {
            haveData = false;
          }
          print("ffff"+dlist.length.toString());

          for(int i=0;i<dlist.length;i++)
          {
            String id = dlist[i]["id"].toString();
            String name = dlist[i]["name"].toString();
            String mobile = dlist[i]["mobile"].toString();
            String status = dlist[i]["status"].toString();
            String reason = dlist[i]["reason"].toString();
            String date = dlist[i]["date"].toString();
            String instruction = dlist[i]["instruction"].toString();

            List order = dlist[i]['order'];

            for(int j = 0 ; j < order.length ; j++){
              String orderId = order[j]['id'].toString();
              String orderName = order[j]['name'].toString();
              String orderPrice = order[j]['price'].toString();
              String orderQuantity = order[j]['quantity'].toString();
              String orderAttributes = order[j]['attributes'].toString();
              String orderConditions = order[j]['conditions'].toString();
              String orderassociatedModel = order[j]['associatedModel'].toString();

              orderDetails.add(new OrderDetails(orderId,orderName,orderPrice,orderQuantity,orderAttributes,
                  orderConditions,orderassociatedModel));

            }

            //  print('getting data'+name.toString());


            /*    if(status.toString()=="A"){
              print('getting data'+name.toString());
              aprovedlist.add(new AproverdOrders(id,name,mobile,status,reason,date,instruction,order));
            }else if(status.toString()=="P"){
              pendinglist.add(new PendingOrders_(id,name,mobile,status,reason,date,instruction,order));
            }*/

            setState(() {

            });
          }


          setState(() {

          });
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

  Widget orderList(String orderName) {
    return ListTile(
      leading: Image.asset(Assets.veg,height: 16,width: 16,),
      title: Text(orderName),
      subtitle: Text('costomization details'),
      trailing: Text('₹0000'),
    );
  }
}
