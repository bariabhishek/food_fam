import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_fam/api/API.dart';
import 'package:food_fam/theme/theme.dart';
import 'package:food_fam/utils/ShareManager.dart';
import 'package:food_fam/utils/app_assets.dart';
import 'package:food_fam/utils/app_routes.dart';
import 'package:food_fam/utils/display_alert_widget.dart';
import 'package:food_fam/utils/size_config.dart';

class foodfamProfile extends StatefulWidget {
  @override
  _foodfamState createState() => _foodfamState();
}


class _foodfamState extends State<foodfamProfile> {
  String Rname='';
  String id='';
  String ownermobile='';
  String logo='';
  String landmark='';
//  String Rname='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ShareMananer.getUserDetails().then((data){
      id=data["token"].toString();
      print(Rname);
      profile();
    });


  }
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
                    child:ClipRRect(

                      borderRadius: BorderRadius.circular(100.0),
                      /*  decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100.0),
      ),*/
                      child:  FadeInImage.assetNetwork(
                        width: 60.0,
                        height: 60.0,
                        placeholder: Assets.logo,image: logo,fit: BoxFit.cover,),
                    )
                  ),
                  Text(
                    Rname.toString(),
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
                child: Row(
                  children: [
                    Text(
                      "Owner/Contact Person",
                      style: AppTheme.textStyle.lightHeading.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: AppFontSize.s18),
                    ),
                    SizedBox(width: 10,),

                  ],
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
                        hintText: ownermobile,
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
                        hintText: landmark,
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

  profile() async {
   // loadProgress();
    /*   Response response;
    Dio dio = new Dio();
    response = await  dio.post(API.LoginAPi, data: {"restaurantid": "FOODFAM0006", "password": "1"});
    print(response.data.toString());

    print(response.data.toString());
*/



    Map<String, String> args = new Map();
    args["restaurantid"]=id;



    // var body = json.encode(args);

    API.post(API.ProfileAPi,args,"").then((response){
    //  loadProgress();
      print(response.statusCode.toString());
      print(response.body.toString());

      if(response.statusCode==200)
      {
        final data = json.decode(response.body);

        print(data['success']);

        if(data['success']==1){

          String id = data['id'].toString();
          String restaurantid = data['restaurantid'].toString();
          Rname = data['Rname'].toString();
          String ownername = data['ownername'].toString();
          ownermobile = data['ownermobile'].toString();
          logo = data['logo'].toString();
          landmark = data['landmark'].toString();
          print("Restorent name"+Rname.toString());
      //    ShareMananer.setDetails(id,true,restaurantid,Rname,ownermobile,ownername );

          Future.delayed(Duration(seconds: 2), () {

            //AppRoutes.makeFirst(context, OrderListScreen());
          });
        }else{
          showDisplayAllert(context: context,isSucces: false,message: data['message']);
        }

      }
      else{
        showDisplayAllert(context: context,isSucces: false,message: "Server error");
      }
      setState(() {

      });

    });
  }
}
