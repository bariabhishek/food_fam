import 'package:flutter/material.dart';
import 'package:food_fam/theme/theme.dart';
import 'package:food_fam/utils/size_config.dart';

class foodfamProfile extends StatefulWidget {
  @override
  _foodfamState createState() => _foodfamState();
}

class _foodfamState extends State<foodfamProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.primaryColor,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        title: Text(
          "PROFILE",
        
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(2))),

              child: Column(
                children: <Widget>[
                  Center(
                    child: Icon(
                      Icons.account_circle,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Restaurant Name",
                    style: AppTheme.textStyle.lightHeading.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: AppFontSize.s22),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 4,
            ),
            Container(
                 padding: EdgeInsets.only(left:10,right:10),
              width: SizeConfig.heightMultiplier * 90,
              height: SizeConfig.heightMultiplier * 7,
              //  width: SizeConfig.heightMultiplier*30,

              child: Container(

                decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(2))),
                padding: EdgeInsets.all(12),
                child: Text(
                  "Owner/Contact Person",
                  style: AppTheme.textStyle.lightHeading.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: AppFontSize.s18),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 2,
            ),
            Container(
              width: SizeConfig.widthMultiplier*100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                       padding: EdgeInsets.only(left:4),
                    child: Icon(
                      Icons.phone,
                      size: 25,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    width: SizeConfig.widthMultiplier*80,
                    height: SizeConfig.heightMultiplier * 7,
                    child: TextField(
                      minLines: 10,
                      maxLines: 15,
                      autocorrect: false,
                      decoration: InputDecoration(
                        hintText: '0000000',
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
              width: SizeConfig.widthMultiplier*100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                       padding: EdgeInsets.only(left:4),
                    child: Icon(
                      Icons.email,
                      size: 25,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                     padding: EdgeInsets.only(right: 10),
                    width: SizeConfig.widthMultiplier*80,
                    height: SizeConfig.heightMultiplier * 7,
                    child: TextField(
                      minLines: 10,
                      maxLines: 15,
                      autocorrect: false,
                      decoration: InputDecoration(
                        hintText: 'Restaurant@gmail.com',
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                       padding: EdgeInsets.only(left:4),
                    child: Icon(
                      Icons.location_on,
                      size: 25,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                     padding: EdgeInsets.only(right: 10),
                    width: SizeConfig.widthMultiplier*80,
                    height: SizeConfig.heightMultiplier * 13,
                    child: TextField(
                      minLines: 10,
                      maxLines: 15,
                      autocorrect: false,
                      decoration: InputDecoration(
                        hintText: 'Address',
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                       padding: EdgeInsets.only(left:4),
                    child: Icon(
                      Icons.announcement,
                      size: 25,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                     padding: EdgeInsets.only(right: 10),
                    width: SizeConfig.widthMultiplier*80,
                    height: SizeConfig.heightMultiplier * 20,
                    child: TextField(
                      minLines: 10,
                      maxLines: 15,
                      autocorrect: false,
                      decoration: InputDecoration(
                        hintText: 'Description',
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
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
              margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.only(
                  right: 230,
                ),
                child: Text(
                  "Change Password",
                  style: TextStyle(),
                ))
          ],
        ),
      ),
    );
  }
}
