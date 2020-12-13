import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snehal_gems/main.dart';
import 'package:snehal_gems/screens/main_page.dart';

import 'Widget/bezierContainer.dart';
import 'loginPage.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
 final TextEditingController _phoneController = TextEditingController();
final TextEditingController _nameController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  ProgressDialog pr;
  final databaseReference = Firestore.instance;
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField1(String title,) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15,
                  fontFamily: "Spectral") ),

          Container(

            height: 50,
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black26,

            ),
            margin: EdgeInsets.all(6),
            padding: EdgeInsets.only(left: 6),

            child:  TextField(
              controller: _emailController,

              style: TextStyle(fontWeight: FontWeight.w600,fontFamily: "Spectral",fontSize: 18,color: Colors.white),
              decoration: InputDecoration(border: InputBorder.none,hintText: "abc@gmail.com"),
              //readOnly: true,
            ),
          ),
        ],
      ),
    );
  }
  Widget _entryField2(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15,
                  fontFamily: "Spectral") ),

          Container(

            height: 50,
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black26,

            ),
            margin: EdgeInsets.all(6),
            padding: EdgeInsets.only(left: 6),

            child:  TextField(
              controller: _passwordController,

              style: TextStyle(fontWeight: FontWeight.w600,fontFamily: "Spectral",fontSize: 18,color: Colors.white),
              decoration: InputDecoration(border: InputBorder.none,hintText: "a!v@23S"),
              //readOnly: true,
            ),
          ),
        ],
      ),
    );
  }
  Widget _entryField3(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15,
                  fontFamily: "Spectral") ),

          Container(

            height: 50,
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black26,

            ),
            margin: EdgeInsets.all(6),
            padding: EdgeInsets.only(left: 6),

            child:  TextField(
              controller: _nameController,


              style: TextStyle(fontWeight: FontWeight.w600,fontFamily: "Spectral",fontSize: 18,color: Colors.white),
              decoration: InputDecoration(border: InputBorder.none,hintText: "Alek kernrl"),
              //readOnly: true,
            ),
          ),
        ],
      ),
    );
  }
  Widget _entryField4(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15,
                  fontFamily: "Spectral") ),

          Container(

            height: 50,
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black26,

            ),
            margin: EdgeInsets.all(6),
            padding: EdgeInsets.only(left: 6),

            child:  TextField(
              controller: _phoneController,

              style: TextStyle(fontWeight: FontWeight.w600,fontFamily: "Spectral",fontSize: 18,color: Colors.white),
              decoration: InputDecoration(border: InputBorder.none,hintText: "10 digits"),
              //readOnly: true,
            ),
          ),
        ],
      ),
    );
  }
  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField1("Username"),
        _entryField2("Password"),
        _entryField3("Name",),
        _entryField4("Phone",),
      ],
    );
  }



  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 's',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'ge',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'ms',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }


  @override
  Widget build(BuildContext context) {

    pr = new ProgressDialog(context);
    pr.style(
        message: 'Signing User...', borderRadius: 10.0, backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(), elevation: 10.0, insetAnimCurve: Curves.easeInOut,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600)
    );

    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    SizedBox(
                      height: 50,
                    ),
                    _emailPasswordWidget(),
                    SizedBox(
                      height: 20,
                    ),
                  GestureDetector(
                    onTap: (){
                      _register();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.shade200,
                                offset: Offset(2, 4),
                                blurRadius: 5,
                                spreadRadius: 2)
                          ],
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Color(0xfffbb448), Color(0xfff7892b)])),
                      child: Text(
                        'Register Now',
                        style: TextStyle(fontSize: 20, color: Colors.white,fontFamily: "Spectral"),
                      ),
                    ),
                  ),
                    SizedBox(height: 30),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
  void _register() async {
    await pr.show();
    pr =  ProgressDialog(context,type: ProgressDialogType.Download, isDismissible: false, showLogs: false);
    var gmail= _emailController.text;
    var pass= _passwordController.text;
    var name= _nameController.text;
    var phone= _phoneController.text;

    try {
      final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      )).user;

      if (user!=null) {

        DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
        String date = dateFormat.format(DateTime.now());

        var rand=new Random();
        int cvv1=rand.nextInt(10000);
        int cvv2=rand.nextInt(1000);

        Fluttertoast.showToast(msg:"Registered successfully",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.white,textColor: Colors.teal);

        databaseReference.collection(user.email).document("PersonalInfo").setData({
          'email': gmail,
          'password': pass,
          "name": name,
          "phone": phone,
          "usercreated":date,
          "lastlogin":date,
          "cvv1":cvv1,
          "cvv2":cvv2,
          "dob": "",
          "gender":"",
          "address1":"",
          "address2":"",

          "profilePic":""
        });
        databaseReference.collection(user.email).document("Cartinfo").collection("Cartx").document("max").setData({
          'length': 0,

        });
        databaseReference.collection(user.email).document("Orderinfo").collection("Orderx").document("max").setData({
          'length': 0,

        });
        databaseReference.collection(user.email).document("Orderinfo").collection("Points").document("max").setData({
          'length': 1,
          "total":20,

        });
        databaseReference.collection(user.email).document("Orderinfo").collection("Points").document("a0").setData({
          'date': date,
          "value":"20",
          "msg":"WCBonus",

        });


        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', user.email);
        await pr.hide();
        Navigator.of(context).pop();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => MainWidget(username: gmail,),),);

      }
      else {
        await pr.hide();
        Fluttertoast.showToast(msg:"Some error occurd",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.white,textColor: Colors.teal);
      }



    }
    catch(e) {
      await pr.hide();
      Fluttertoast.showToast(msg: e.toString(),gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.white,textColor: Colors.teal);
    }

  }
}
