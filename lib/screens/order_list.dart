import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_fam/api/API.dart';
import 'package:food_fam/model/aproved_order_list.dart';
import 'package:food_fam/model/orderList.dart';
import 'package:food_fam/model/order_details.dart';
import 'package:food_fam/model/toppings_model.dart';
import 'package:food_fam/screens/drawer.dart';
import 'package:food_fam/screens/order_details.dart';
import 'package:food_fam/theme/theme.dart';
import 'package:food_fam/utils/ShareManager.dart';
import 'package:food_fam/utils/app_routes.dart';
import 'package:food_fam/utils/display_alert_widget.dart';
import 'package:food_fam/utils/size_config.dart';

import 'history_order_details.dart';

class OrderListScreen extends StatefulWidget {
  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<OrderListScreen> {
  bool isLoading = false;
  String Rname='';
  String id='';
  List<OrderList> list = new List();
  List<AproverdOrders> list2 = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ShareMananer.getUserDetails().then((data){
      Rname=data["rname"].toString();
      id=data["token"].toString();
      print(Rname);
      orderList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar( backgroundColor: AppTheme.primaryColor,
      title: Text('ORDERS HISTORY'),),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            SizedBox(height: SizeConfig.heightMultiplier*1,),
            Container(
                margin: EdgeInsets.only(left: 20,top: 10),
                child: Text("Today's order list",style: AppTheme.textStyle.heading1.copyWith(
                  fontSize: AppFontSize.s16,color: Colors.grey
                ),)),
            SizedBox(height: SizeConfig.heightMultiplier*1,),
            ListView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, int index) {
                return UiSearch(context,index,list[index].id,list[index].name,list[index].status,list[index].mobile
                );
              },
            ),
          ],),
        ),
      ),
    );
  }

  Widget UiSearch(BuildContext context, int index, String id, String name, String status, String mobile) {
    return Card(
      child: Container(
        width: SizeConfig.widthMultiplier * 100,
        padding: EdgeInsets.only(top: 8, bottom: 8, left: 8),
        child: ListTile(
          onTap: (){

            AppRoutes.goto(context, HistoryOrderDetails("pending", id, name, mobile, status,
                list[index].orderDetails));
          },
          title: Text(name),
          trailing:  Text(status),
          subtitle: Text(
            mobile,
          ),
        ),
      ),
    );
  }

  orderList(){
    loadProgress();
    Map<String, String> args = new Map();
    args["restaurantid"]=id;
    //  var body = json.encode(args);

    API.post(API.OrderList, args,'').then((response){
      loadProgress();
      print(response.statusCode.toString());
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
            String mobile = dlist[i]["mobile"].toString();
            String status = dlist[i]["status"].toString();

            List order = dlist[i]['order'];
            List<OrderDetails> orderDetails = new List();

            for (var data in order) {
              var order_id = data['id'].toString();
              var orderName = data['name'].toString();
              var orderPrice = data['price'].toString();
              var orderQuantity = data['quantity'].toString();
              var orderConditions = data['conditions'].toString();
              var orderassociatedModel = data['associatedModel'].toString();


              List toping = data['attributes']["toppings"];
              List <ToppingsDishModel> topingMainList = new List();

              toping.forEach((element) {

                topingMainList.add(new ToppingsDishModel(element["name"],int.parse(element["price"])));

              });

              orderDetails.add(new OrderDetails(
                  order_id,
                  orderName,
                  orderPrice,
                  orderQuantity,
                  orderConditions,
                  orderassociatedModel,topingMainList));
            }

            list.add(new OrderList(id,name,mobile,status,orderDetails));
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
}
