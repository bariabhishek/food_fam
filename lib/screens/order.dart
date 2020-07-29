import 'package:flutter/material.dart';
import 'package:food_fam/theme/theme.dart';
import 'package:food_fam/utils/size_config.dart';

class order_history extends StatefulWidget {
  @override
  _order_historyState createState() => _order_historyState();
}

class _order_historyState extends State<order_history> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:   AppTheme.primaryColor,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        title: Text(
          "ORDER HISTORY",
          style: AppTheme.textStyle.lightHeading.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: AppFontSize.s18),
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: SizeConfig.heightMultiplier * 2,
          ),
          Container(
            
            width: SizeConfig.widthMultiplier * 100,
            padding: EdgeInsets.only(top: 12, bottom: 12, left: 10),
          
            child: Text(
              'Today order list',
              style: AppTheme.textStyle.lightHeading.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                  fontSize: AppFontSize.s16),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, int index) {
              return UiSearch();
            },
          ),
        ],
      ),
    );
  }
}

Widget UiSearch() {
  return Padding(
    padding: const EdgeInsets.all(6.0),
    child: Container(
       width: SizeConfig.widthMultiplier * 100,
        padding: EdgeInsets.only(top:5 ,right: 10, bottom: 5, left: 5),
      

      child: Card(
        child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('NAME'),
                Text('S.NO'),
              ],
            ),
            subtitle: Text("CONTACT NO."),
            
          
          
        ),
      ),
    ),
  );
  
}
