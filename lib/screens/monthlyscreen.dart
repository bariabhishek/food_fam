import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_fam/api/API.dart';
import 'package:food_fam/model/order_details.dart';
import 'package:food_fam/model/salesreport.dart';
import 'package:food_fam/theme/theme.dart';
import 'package:food_fam/utils/ShareManager.dart';
import 'package:food_fam/utils/app_assets.dart';
import 'package:food_fam/utils/display_alert_widget.dart';
import 'package:food_fam/utils/size_config.dart';

class MonthlyScreen extends StatefulWidget {
  @override
  _MonthlyScreenState createState() => _MonthlyScreenState();
}

class _MonthlyScreenState extends State<MonthlyScreen> {
  var diloagContext;
  String resId='';

  String name = '';
  String mobile = '';
  String status = '';

  List<SalesReport> listreport = new List();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ShareMananer.getUserDetails().then((data){
      resId=data["token"].toString();
      // print(Rname);
      Future.delayed(Duration(seconds: 1), () {
        report();
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: listreport.length,
            shrinkWrap: true,
            itemBuilder: (context , int index){
              return salesReport(
                index,
                listreport[index].name,
                listreport[index].mobile,
                listreport[index].status,
              );
            },)
      ),
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

  report() {
    _dialog();

    Map<String, String> args = new Map();
    args["retaurantid"]=resId.toString();
    args["reportmode"]='monthly';


    API.post(API.report, args, "").then((response) {

      print(response.statusCode.toString());
      print(response.body.toString());

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] == 1) {

          List report =  data['detail'];

          for(int ok = 0 ; ok<report.length ; ok++){
            name = report[ok]['name'].toString();
            mobile = report[ok]['mobile'].toString();
            status = report[ok]['status'].toString();

            List order = report[ok]['order'];
            List<OrderDetails> orderDetails =new List();
            for(var data in order ){
              var order_id=data['id'].toString();
              var orderName=data['name'].toString();
              var orderPrice=data['price'].toString();
              var orderQuantity=data['quantity'].toString();
              var orderAttributes=data['attributes'].toString();
              var orderConditions=data['conditions'].toString();
              var  orderassociatedModel=data['associatedModel'].toString();

              orderDetails.add(new OrderDetails(order_id, orderName, orderPrice, orderQuantity, orderAttributes, orderConditions, orderassociatedModel));

            }

            print("report data"+name.toString());
            print("report data"+report.length.toString());

            listreport.add(new SalesReport(name , mobile ,status, orderDetails));
          }
          setState(() {

          });


          Navigator.of(context).pop(diloagContext);


          Future.delayed(Duration(seconds: 1), () {
            showDisplayAllert(
                context: context, isSucces: true, message: data['message']);
            // AppRoutes.makeFirst(context, SearchScreen());
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

  Widget salesReport( int index,String name, String mobile ,String status) {
    return ExpansionTile(
      title: Text(name),
      subtitle: Text(mobile),
      trailing: Text(status),
      children: [

        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: listreport[index].orderDetailList.length,
          itemBuilder: (context , int index2 ){
            return orderUI(
              listreport[index].orderDetailList[index2].orderName,
              listreport[index].orderDetailList[index2].orderPrice,
              listreport[index].orderDetailList[index2].orderQuantity,
            );
          },)
      ],
    );
  }

  Widget orderUI(String orderName, String orderPrice, String orderQuantity) {
    return ListTile(
      leading: Image.asset(Assets.veg,height: 16,width: 16,),
      title: Text(orderName),
      subtitle: Text(orderQuantity),
      trailing: Text('₹'+orderPrice),
    );
  }
}

