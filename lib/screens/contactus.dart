
import 'package:flutter/material.dart';
import 'package:food_fam/theme/theme.dart';
import 'package:food_fam/utils/app_assets.dart';
import 'package:food_fam/utils/size_config.dart';


class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
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
                        child: Text('8005615976',style: AppTheme.textStyle.lightHeading.copyWith(color: Colors.blue,
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
                  child: Text('foodfam@gmail.com',style: AppTheme.textStyle.lightHeading.copyWith(color: Colors.blue),),
                ),
              ),
            ],
          ),
         // isLoading?showProgress(context):SizedBox(height: 0.0,)
        ],),
      ),
    );
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
