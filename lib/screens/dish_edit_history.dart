import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_fam/theme/theme.dart';
import 'package:food_fam/utils/size_config.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

class DishEdit extends StatefulWidget {
  @override
  _DishEditState createState() => _DishEditState();
}

class _DishEditState extends State<DishEdit> {
  bool isSwitched =true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: Text('Add Dish',
          style: AppTheme.textStyle.lightHeading.copyWith(
              color: Colors.white
          ),),

      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: SizeConfig.heightMultiplier*1,),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(8),
                  width: SizeConfig.widthMultiplier*80,
                  height: SizeConfig.heightMultiplier * 7,
                  child: TextField(
                    autocorrect: false,
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
                    margin: EdgeInsets.only(left: 10),
                    child: Icon(Icons.star_border)),

              ],
            ),
            SizedBox(height: SizeConfig.heightMultiplier*2,),
            Container(
              width: SizeConfig.widthMultiplier*100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left:4),
                    child: Text('Price'
                    ),
                  ),
                  Container(
                    width: SizeConfig.widthMultiplier*80,
                    height: SizeConfig.heightMultiplier * 7,
                    child: TextField(
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

                margin:EdgeInsets.only(left: 10),
                child: Text('Description')),
            SizedBox(
              height: SizeConfig.heightMultiplier * 1,
            ),
            Container(
              margin: EdgeInsets.only(left: 10,right: 10),
              height: SizeConfig.heightMultiplier * 15,
              child: TextField(
                maxLines: 7,
                keyboardType: TextInputType.multiline,
                autocorrect: false,
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
                 Radio(),
                 Text('Veg',style: AppTheme.textStyle.lightHeading.copyWith(
                     fontSize: AppFontSize.s18
                 ),),
                 Radio(),
                 Text('Non-Veg',style: AppTheme.textStyle.lightHeading.copyWith(
                     fontSize: AppFontSize.s18
                 ),),
                 Radio(),
                 Text('Egg',style: AppTheme.textStyle.lightHeading.copyWith(
                   fontSize: AppFontSize.s18
                 ),),
               ],
             ),
           ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 2,
            ),
            Container(
              margin: EdgeInsets.only(left: 10,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Customizable'),
                  Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
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
            Container(
              margin: EdgeInsets.only(left: 10,right: 10),
              height: SizeConfig.heightMultiplier * 20,
              child: TextField(
                maxLines: 7,
                keyboardType: TextInputType.multiline,
                autocorrect: false,
                decoration: InputDecoration(
               //   hintText: 'Description',
                  labelText:'Add Option' ,
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
              height: SizeConfig.heightMultiplier * 2,
            ),

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(50)
                        )
                    ),
                    width: 100,
                    height: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.filter,color: Colors.white,),
                      Text('Save',style: AppTheme.textStyle.lightHeading.copyWith(
                        color: Colors.white
                      ),),
                    ],
                  ),),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(50)
                        )
                    ),
                    width: 100,
                    height: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.delete_forever,color: Colors.white,),
                        Text('Delete',style: AppTheme.textStyle.lightHeading.copyWith(
                            color: Colors.white
                        ),),
                      ],
                    ),)
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 1,
            ),
          ],
        ),
      ),
    );
  }
}
