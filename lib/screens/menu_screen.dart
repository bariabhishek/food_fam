import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_fam/theme/theme.dart';
import 'package:food_fam/utils/size_config.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  var isSwitched = true;
  String catecory1='Usa';
  String catecory2='Usa';
  String catecory3='Usa';
  String catecory4='Usa';
  String catecory5='Usa';
  String catecory6='Usa';
  String catecory7='Usa';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        backgroundColor:  AppTheme.primaryColor,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
              alignment:Alignment.center,child: Text('Preview',style:
            AppTheme.textStyle.lightHeading.copyWith(fontSize: AppFontSize.s20,color: Colors.white)
            ,)),
          Container(
              margin: EdgeInsets.only(right: 50),
              alignment:Alignment.center,
              child: Text('Save')),
        ],
      ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(bottom: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10,right: 10,top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
              Container(
                  alignment:Alignment.center,
                  child: Text('Categories',style:
                  AppTheme.textStyle.lightHeading.copyWith(fontSize: AppFontSize.s20,color: Colors.black)
                    ,)),
              Container(
                height: 40,
                width: SizeConfig.widthMultiplier*50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: Colors.grey,width: 1)
                ),

                 ),
        ],
    ),
            ),
            SizedBox(height: SizeConfig.heightMultiplier*2,),
            Container(
              decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              margin: EdgeInsets.only(left: 20),

              padding: EdgeInsets.all(8),
              child: Text('Add Category',style: AppTheme.textStyle.lightHeading.copyWith(
                color: Colors.white,fontSize: AppFontSize.s16
              ),),
            ),
            SizedBox(height: SizeConfig.heightMultiplier*2,),
            Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                padding: EdgeInsets.only(left:24.0,right: 24),
                width: SizeConfig.widthMultiplier*100,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: new DropdownButton<String>(
                  isExpanded: true,
                  items: <String>['Usa', 'China','India'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value,style: AppTheme.textStyle.lightHeading.copyWith(
                          fontSize: AppFontSize.s14)
                      ),
                    );
                  }).toList(),
                  onChanged: (String cValue) {
                    catecory1 = cValue;
                    setState(() {
                    },);
                  },value: catecory1,
                )
            ),
          SizedBox(height: SizeConfig.heightMultiplier*2,),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.grey)
              ),
              margin: EdgeInsets.only(left: 20,right: 20),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Catogery 3'),
                        Container(
                          decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          margin: EdgeInsets.only(left: 20),

                          padding: EdgeInsets.only(left: 8,right: 8,top: 4,bottom: 4),
                          child: Text('Add DISH',style: AppTheme.textStyle.lightHeading.copyWith(
                              color: Colors.white,fontSize: AppFontSize.s16
                          ),),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier*1,),
                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('DISH 1'),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('DISH 2'),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('DISH 3'),
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
                ],
              ),
            ),


            SizedBox(height: SizeConfig.heightMultiplier*2,),
            Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                padding: EdgeInsets.only(left:24.0,right: 24),
                width: SizeConfig.widthMultiplier*100,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: new DropdownButton<String>(
                  isExpanded: true,
                  items: <String>['Usa', 'China','India'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value,style: AppTheme.textStyle.lightHeading.copyWith(
                          fontSize: AppFontSize.s14)
                      ),
                    );
                  }).toList(),
                  onChanged: (String cValue) {
                    catecory1 = cValue;
                    setState(() {
                    },);
                  },value: catecory1,
                )
            ),
            SizedBox(height: SizeConfig.heightMultiplier*2,),
            Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                padding: EdgeInsets.only(left:24.0,right: 24),
                width: SizeConfig.widthMultiplier*100,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: new DropdownButton<String>(
                  isExpanded: true,
                  items: <String>['Usa', 'China','India'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value,style: AppTheme.textStyle.lightHeading.copyWith(
                          fontSize: AppFontSize.s14)
                      ),
                    );
                  }).toList(),
                  onChanged: (String cValue) {
                    catecory1 = cValue;
                    setState(() {
                    },);
                  },value: catecory1,
                )
            ),
            SizedBox(height: SizeConfig.heightMultiplier*2,),
            Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                padding: EdgeInsets.only(left:24.0,right: 24),
                width: SizeConfig.widthMultiplier*100,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: new DropdownButton<String>(
                  isExpanded: true,
                  items: <String>['Usa', 'China','India'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value,style: AppTheme.textStyle.lightHeading.copyWith(
                          fontSize: AppFontSize.s14)
                      ),
                    );
                  }).toList(),
                  onChanged: (String cValue) {
                    catecory1 = cValue;
                    setState(() {
                    },);
                  },value: catecory1,
                )
            ),
            SizedBox(height: SizeConfig.heightMultiplier*2,),
            Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                padding: EdgeInsets.only(left:24.0,right: 24),
                width: SizeConfig.widthMultiplier*100,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: new DropdownButton<String>(
                  isExpanded: true,
                  items: <String>['Usa', 'China','India'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value,style: AppTheme.textStyle.lightHeading.copyWith(
                          fontSize: AppFontSize.s14)
                      ),
                    );
                  }).toList(),
                  onChanged: (String cValue) {
                    catecory1 = cValue;
                    setState(() {
                    },);
                  },value: catecory1,
                )
            ),
            SizedBox(height: SizeConfig.heightMultiplier*2,),
            Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                padding: EdgeInsets.only(left:24.0,right: 24),
                width: SizeConfig.widthMultiplier*100,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: new DropdownButton<String>(
                  isExpanded: true,
                  items: <String>['Usa', 'China','India'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value,style: AppTheme.textStyle.lightHeading.copyWith(
                          fontSize: AppFontSize.s14)
                      ),
                    );
                  }).toList(),
                  onChanged: (String cValue) {
                    catecory1 = cValue;
                    setState(() {
                    },);
                  },value: catecory1,
                )
            ),
            SizedBox(height: SizeConfig.heightMultiplier*2,),
            Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                padding: EdgeInsets.only(left:24.0,right: 24),
                width: SizeConfig.widthMultiplier*100,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: new DropdownButton<String>(
                  isExpanded: true,
                  items: <String>['Usa', 'China','India'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value,style: AppTheme.textStyle.lightHeading.copyWith(
                          fontSize: AppFontSize.s14)
                      ),
                    );
                  }).toList(),
                  onChanged: (String cValue) {
                    catecory1 = cValue;
                    setState(() {
                    },);
                  },value: catecory1,
                )
            ),

       /*   SizedBox(height: SizeConfig.heightMultiplier*2,),
            Container(
                padding: EdgeInsets.only(left:24.0,right: 24),
                width: SizeConfig.widthMultiplier*80,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: new DropdownButton<String>(
                  isExpanded: true,
                  items: <String>['Usa', 'China','India'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value,style: AppTheme.textStyle.lightHeading.copyWith(
                          fontSize: AppFontSize.s14)
                      ),
                    );
                  }).toList(),
                  onChanged: (String cValue) {
                    catecory2 = cValue;
                    setState(() {
                    },);
                  },value: catecory2,
                )
            ),
            SizedBox(height: SizeConfig.heightMultiplier*2,),
            Container(
                padding: EdgeInsets.only(left:24.0,right: 24),
                width: SizeConfig.widthMultiplier*80,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: new DropdownButton<String>(
                  isExpanded: true,
                  items: <String>['Usa', 'China','India'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value,style: AppTheme.textStyle.lightHeading.copyWith(
                          fontSize: AppFontSize.s14)
                      ),
                    );
                  }).toList(),
                  onChanged: (String cValue) {
                    catecory3 = cValue;
                    setState(() {
                    },);
                  },value: catecory3,
                )
            ),
            SizedBox(height: SizeConfig.heightMultiplier*2,),
            Container(
                padding: EdgeInsets.only(left:24.0,right: 24),
                width: SizeConfig.widthMultiplier*80,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: new DropdownButton<String>(
                  isExpanded: true,
                  items: <String>['Usa', 'China','India'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value,style: AppTheme.textStyle.lightHeading.copyWith(
                          fontSize: AppFontSize.s14)
                      ),
                    );
                  }).toList(),
                  onChanged: (String cValue) {
                    catecory4 = cValue;
                    setState(() {
                    },);
                  },value: catecory4,
                )
            ),
            SizedBox(height: SizeConfig.heightMultiplier*2,),
            Container(
                padding: EdgeInsets.only(left:24.0,right: 24),
                width: SizeConfig.widthMultiplier*80,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: new DropdownButton<String>(
                  isExpanded: true,
                  items: <String>['Usa', 'China','India'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value,style: AppTheme.textStyle.lightHeading.copyWith(
                          fontSize: AppFontSize.s14)
                      ),
                    );
                  }).toList(),
                  onChanged: (String cValue) {
                    catecory5 = cValue;
                    setState(() {
                    },);
                  },value: catecory5,
                )
            ),
            SizedBox(height: SizeConfig.heightMultiplier*2,),
            Container(
                padding: EdgeInsets.only(left:24.0,right: 24),
                width: SizeConfig.widthMultiplier*80,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: new DropdownButton<String>(
                  isExpanded: true,
                  items: <String>['Usa', 'China','India'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value,style: AppTheme.textStyle.lightHeading.copyWith(
                          fontSize: AppFontSize.s14)
                      ),
                    );
                  }).toList(),
                  onChanged: (String cValue) {
                    catecory6 = cValue;
                    setState(() {
                    },);
                  },value: catecory6,
                )
            ),
            SizedBox(height: SizeConfig.heightMultiplier*2,),
            Container(
                padding: EdgeInsets.only(left:24.0,right: 24),
                width: SizeConfig.widthMultiplier*80,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: new DropdownButton<String>(
                  isExpanded: true,
                  items: <String>['Usa', 'China','India'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value,style: AppTheme.textStyle.lightHeading.copyWith(
                          fontSize: AppFontSize.s14)
                      ),
                    );
                  }).toList(),
                  onChanged: (String cValue) {
                    catecory7 = cValue;
                    setState(() {
                    },);
                  },value: catecory7,
                )
            ),*/

      ],
    ),
    ),
          ),
    );
  }
}
