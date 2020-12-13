 import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
 import 'package:xlive_switch/xlive_switch.dart';
 class SettingPage extends KFDrawerContent{
   _SettingPageState createState() => _SettingPageState();

}

class  _SettingPageState extends State<SettingPage>{

  bool value1 = true;
  bool value2 = true;
  bool value3 = true;
  bool value4 = true;
  bool value5 = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement buildj
    return Scaffold(
       body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    child: Material(
                      shadowColor: Colors.transparent,
                      color: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: IconButton(
                          icon: Icon(
                            Icons.menu,
                            size: 24,
                            color: Colors.black,
                          ),
                          onPressed: widget.onMenuPressed,
                        ),
                      ),
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width-110,
                      alignment: Alignment.center,
                      child:  Text("Settings", style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Spectral",
                      ),)
                  ),
                ],
              ),
           Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 10,top: 10),

                child:  Text("Account and Security", style: TextStyle(color: Colors.green,fontFamily: "Raleway",fontWeight: FontWeight.w600,fontSize: 20,),),
              ),

              Container(
                margin: EdgeInsets.all(15),
                height: 40,
                child:  Row(children: <Widget>[
                  Expanded(child: Text("OTP verification",style: TextStyle(fontStyle:FontStyle.normal,fontSize: 20,fontWeight: FontWeight.w700,fontFamily: "Raleway",color: Colors.black38),),),
                  XlivSwitch(value: value1, onChanged: _changeValue1,),
                ],
                ),
              ),

              Container(
                margin: EdgeInsets.all(15),
                height: 40,
                child:  Row(children: <Widget>[
                  Expanded(child: Text("Order update by Text",style: TextStyle(fontStyle:FontStyle.normal,fontSize: 20,fontWeight: FontWeight.w700,fontFamily: "Raleway",color: Colors.black38),),),
                  XlivSwitch(value: value2, onChanged: _changeValue2,),
                ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(15),
                height: 40,
                child:  Row(children: <Widget>[
                  Expanded(child: Text("Order update by Gmail",style: TextStyle(fontStyle:FontStyle.normal,fontSize: 20,fontWeight: FontWeight.w700,fontFamily: "Raleway",color: Colors.black38),),),
                  XlivSwitch(value: value3, onChanged: _changeValue3,),
                ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 10,top: 10),

                child:  Text("Optimized Experience", style: TextStyle(color: Colors.green,fontFamily: "Raleway",fontWeight: FontWeight.w600,fontSize: 20,),),
              ),
              Container(
                margin: EdgeInsets.all(15),
                height: 40,
                child:  Row(children: <Widget>[
                  Expanded(child: Text("Optimized image quality",style: TextStyle(fontStyle:FontStyle.normal,fontSize: 20,fontWeight: FontWeight.w700,fontFamily: "Raleway",color: Colors.black38),),),
                  XlivSwitch(value: value4, onChanged: _changeValue4,),
                ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(15),
                height: 40,
                child:  Row(children: <Widget>[
                  Expanded(child: Text("Optimized checkout flow",style: TextStyle(fontStyle:FontStyle.normal,fontSize: 20,fontWeight: FontWeight.w700,fontFamily: "Raleway",color: Colors.black38),),),
                  XlivSwitch(value: value5, onChanged: _changeValue5,),
                ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 10,top: 10),

                child:  Text("Note: Optimized Experience for internet connection quality only", style: TextStyle( fontFamily: "Raleway",
                                      color: Color(0xff0f4c81),fontWeight: FontWeight.w600,fontSize: 17,),),
              ),
            ],
          ),
        ),
      )
    );
  }

  void _changeValue1(bool value) {
    setState(() {
      value1 = value;
    });
  }
  void _changeValue2(bool value) {
    setState(() {
      value2 = value;
    });
  }
  void _changeValue3(bool value) {
    setState(() {
      value3 = value;
    });
  }
  void _changeValue4(bool value) {
    setState(() {
      value4 = value;
    });
  }
  void _changeValue5(bool value) {
    setState(() {
      value5 = value;
    });
  }

}