
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_fam/api/API.dart';
import 'package:food_fam/theme/theme.dart';
import 'package:food_fam/utils/ShareManager.dart';
import 'package:food_fam/utils/app_assets.dart';
import 'package:food_fam/utils/app_routes.dart';
import 'package:food_fam/utils/display_alert_widget.dart';
import 'package:food_fam/utils/size_config.dart';


class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

  String email='';
  String mobile='';
  String address='';
  var diloagContext;


    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      this. contactus();
    });

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(title: Text("Contact Us"),
        backgroundColor: AppTheme.primaryColor,elevation: 0,),
        body: Stack(children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: SizeConfig.heightMultiplier * 45,
                width: double.maxFinite,
                decoration: BoxDecoration(color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(

                          MediaQuery.of(context).size.width, 100.0)),
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 15,
                    ),
                    Image(
                      height: 100,
                        width: SizeConfig.widthMultiplier*48,
                        fit: BoxFit.fill,
                        image: AssetImage(Assets.logo)),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.heightMultiplier*3,),
              GestureDetector(
                onTap: (){

                },
                child: Container(

                  padding: EdgeInsets.all(12.0),
                  child: Text('Contact Us',
                    textAlign: TextAlign.center,
                    style: AppTheme.textStyle.heading1.copyWith(
                        fontWeight: FontWeight.bold,fontSize: AppFontSize.s17,color: Colors.black
                    ),),
                ),
              ),
              SizedBox(height: SizeConfig.heightMultiplier*2,),
              Container(
              /*  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(50.0))
                ),*/
               /* height: SizeConfig.heightMultiplier*6,
                width: SizeConfig.widthMultiplier*70,*/
                margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier*5),

                child: Column(
                  children: <Widget>[
                    Text('Abhishek baari',style: AppTheme.textStyle.lightHeading.copyWith(color: Colors.black,
                    fontSize: AppFontSize.s14),),
                    SizedBox(height: SizeConfig.heightMultiplier*1,),
                    GestureDetector(
                        onTap: (){
                         // launchURL();
                        },
                        child: Text(mobile,style: AppTheme.textStyle.lightHeading.copyWith(color: Colors.blue,
                        fontSize: AppFontSize.s18),)),
                  ],
                ),
              ),
              Container(

                child: Text('Email',
                  textAlign: TextAlign.center,
                  style: AppTheme.textStyle.heading1.copyWith(
                      fontWeight: FontWeight.bold,fontSize: AppFontSize.s17,color: Colors.black
                  ),),
              ),
              GestureDetector(
                onTap: (){
                 // sendEmail();
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier*5),
                  child: Text(email,style: AppTheme.textStyle.lightHeading.copyWith(color: Colors.blue),),
                ),
              ),

              Container(

                child: Text('Address',
                  textAlign: TextAlign.center,
                  style: AppTheme.textStyle.heading1.copyWith(
                      fontWeight: FontWeight.bold,fontSize: AppFontSize.s17,color: Colors.black
                  ),),
              ),
              GestureDetector(
                onTap: (){
                  // sendEmail();
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier*5),
                  child: Text(address,style: AppTheme.textStyle.lightHeading.copyWith(color: Colors.blue),),
                ),
              ),
            ],
          ),
         // isLoading?showProgress(context):SizedBox(height: 0.0,)
        ],),
      ),
    );

  }
    contactus()
    {
      _dialog();

      Map<String, String> args = new Map();

      API.post(API.contactus, args, "").then((response) {

        print(response.statusCode.toString());
        print(response.body.toString());

        if (response.statusCode == 200) {
          final data = json.decode(response.body);

          // ShareMananer.setDetails(data['token'], true);
          print(data['success']);

          if (data['success'] == 1) {
            String id = data['detail']['id'].toString();
             address = data['detail']['address'].toString();
             email = data['detail']['email'].toString();
             mobile = data['detail']['mobile'].toString();
            String facebooklink = data['detail']['facebooklink'].toString();

            Navigator.of(context).pop(diloagContext);
            setState(() {

            });
            print(id);
            Future.delayed(Duration(seconds: 1), () {
              //  AppRoutes.makeFirst(context, SearchScreen());
            });
          } else {
            showDisplayAllert(
                context: context, isSucces: false, message: data['message']);
            Navigator.of(context).pop(diloagContext);
          }
        } else {
          showDisplayAllert(
              context: context, isSucces: false, message: "Server error");
          Navigator.of(context).pop(diloagContext);
        }
      });
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
/*
  sendEmail() async {
    print('click');
    final Email email = Email(
      body: '',
      subject: '',
      recipients: ['schoolian.official@gmail.com'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }
  launchURL() async {
    var url = "tel://+91"+'8005615976';
    await launch(url);
  }*/
}
