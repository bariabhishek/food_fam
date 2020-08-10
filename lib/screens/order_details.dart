import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_fam/theme/theme.dart';
import 'package:food_fam/utils/app_assets.dart';
import 'package:food_fam/utils/size_config.dart';

class OrderDetailsPic extends StatefulWidget {
  String type;
  OrderDetailsPic(@required this.type);

  @override
  _OrderDetailsPicState createState() => _OrderDetailsPicState();
}

class _OrderDetailsPicState extends State<OrderDetailsPic> {
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

            ListView.builder(itemCount: 2,
            shrinkWrap: true,
            itemBuilder: (context,int index){
              return orderList();
            },),
            SizedBox(height: SizeConfig.heightMultiplier*2,),
            Text('Instructions',style: AppTheme.textStyle.lightHeading.copyWith(
              color: Colors.black,fontSize: AppFontSize.s18,
            ),),
            SizedBox(height: SizeConfig.heightMultiplier*8,),
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

  Widget orderList() {
    return ListTile(
      leading: Image.asset(Assets.veg,height: 16,width: 16,),
      title: Text('Dish name'),
      subtitle: Text('costomization details'),
      trailing: Text('₹0000'),
    );
  }
}
