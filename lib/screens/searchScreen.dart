import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_fam/api/API.dart';
import 'package:food_fam/model/aproved_order_list.dart';
import 'package:food_fam/model/orderList.dart';
import 'package:food_fam/model/order_details.dart';
import 'package:food_fam/model/pending_order_list.dart';
import 'package:food_fam/screens/coupon.dart';
import 'package:food_fam/theme/theme.dart';
import 'package:food_fam/utils/ShareManager.dart';
import 'package:food_fam/utils/app_assets.dart';
import 'package:food_fam/utils/app_routes.dart';
import 'package:food_fam/utils/display_alert_widget.dart';
import 'package:food_fam/utils/size_config.dart';

import 'drawer.dart';
import 'order.dart';
import 'order_details.dart';

class SearchScreen extends StatefulWidget {
  @override
  _foodfamState createState() => _foodfamState();
}

class _foodfamState extends State<SearchScreen> {
  List<AproverdOrders> aprovedlist = new List();
  List<PendingOrders_> pendinglist = new List();
  List<OrderDetails> orderDetails = new List();
  String Rname='';
  var resId, tempResponse;
  bool haveData = true;
  String id='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ShareMananer.getUserDetails().then((data){
      Rname=data["rname"].toString();
      id=data["token"].toString();
      print(Rname);

      ///////////peding data///////////
   //   orderListPending();

      /////////////aproved data//////////////


      Future.delayed(Duration(seconds: 2), () {
        orderListAproved();
      });


      setState(() {
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AllDrawerScreen(),
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        actions: <Widget>[
          Image.asset(Assets.logo,width: 100,height: 50,)
        ],

      ),

      body: Stack(children: <Widget>[
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: SizeConfig.heightMultiplier*1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap:(){
                      AppRoutes.goto(context, CouponScreen());
                    },
                    child: Text(
                      'ORDERS',
                      style: AppTheme.textStyle.lightHeading.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: AppFontSize.s16),
                    ),
                  ),
                  Container(
                    height: SizeConfig.heightMultiplier * 6,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),

                    child: Row(
                      children: <Widget>[
                        /////////////////row of search bar////////////
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(
                                Icons.search,
                                color: Colors.grey[400],
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                width: SizeConfig.widthMultiplier * 50,
                                child: TextField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Search',
                                        hintStyle: TextStyle(fontSize: 18))),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.heightMultiplier*2,),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  'Pending for approval: ',
                  style: AppTheme.textStyle.lightHeading.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: AppFontSize.s16),
                ),
              ),
              SizedBox(height: SizeConfig.heightMultiplier*1,),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: pendinglist.length,
                  itemBuilder: (context, int index) {
                    return UiSearch(index, context,pendinglist[index].name,pendinglist[index].mobile,pendinglist[index]
                        .status,orderDetails,pendinglist[index].id);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10,bottom: 10),

                child: Text(
                  'Approved Orders ',
                  style: AppTheme.textStyle.lightHeading.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: AppFontSize.s16),
                ),
              ),
              aprovedlist.isEmpty && !haveData
                  ? Container(
                height: SizeConfig.heightMultiplier * 10,
                child: Center(
                  child: Text("You haven't add any category"),
                ),
              )
                  :
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: aprovedlist.length,
                  itemBuilder: (context, int index) {
                    return suggested(context,aprovedlist[index].name,aprovedlist[index].mobile
                        ,aprovedlist[index].status,aprovedlist[index].order,aprovedlist[index].id);

                  },
                ),
              )
            ],
          ),
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
    );
  }
  orderListAproved(){
    print('aproved data');
   // loadProgress();
    Map<String, String> args = new Map();
    args["restaurantid"]=id;
    //  var body = json.encode(args);

    API.post(API.OrderList, args,'').then((response){
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

          //  print('getting data'+name.toString());

            aprovedlist.add(new AproverdOrders(id,name,mobile,status,reason,date,instruction,order));
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

  Widget UiSearch(int index, BuildContext context,String name , String mobile, String status, List order, String id) {
    if(status=='P'){
      print('working');
      return Card(
        child: Container(
          width: SizeConfig.widthMultiplier * 100,
          padding: EdgeInsets.only(top: 8, bottom: 8, left: 8),
          child: ListTile(
            onTap: (){
              AppRoutes.goto(context, OrderDetailsPic("pendeing",id));
            },
            title: Text(name),
            trailing:  Text(status),
            subtitle: Text(
              mobile,

            ),
          ),
        ),
      );
      print(status.toString()+"working");
    }else{
      return SizedBox();
    }


  }

  Widget suggested(BuildContext context, String name, String mobile, String status, List order, String id) {
      print(status.toString()+"fbbfdbdfbdfbdf");
    if(status=='A'){
      return InkWell(
        onTap: (){
          AppRoutes.goto(context, OrderDetailsPic("approverd",id));
        },
        child: Card(
          child: Container(
            width: SizeConfig.widthMultiplier * 100,
            padding: EdgeInsets.only(top: 8, bottom: 8, left: 8),

            child: ListTile(
              title: Text(name),
              trailing:  Text(status),
              subtitle: Text(
                mobile,
              ),
            ),
          ),
        ),
      );
    }else{
      return SizedBox();
    }


  }

}


