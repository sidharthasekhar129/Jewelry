import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
 import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snehal_gems/main.dart';
import 'package:snehal_gems/screens/auth/signup.dart';
import 'package:snehal_gems/screens/main_page.dart';


 import 'PasswordResetPage.dart';
import 'Widget/bezierContainer.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

// Async function that calls getSharedPreferences
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  final databaseReference = Firestore.instance;
  ProgressDialog pr;


  Widget _entryField1(String title, String hint) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15,
               fontFamily: "Spectral"),
          ),

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

             // controller: mail,

              style: TextStyle(fontWeight: FontWeight.w600,fontFamily: "Spectral",fontSize: 18,color: Colors.white),
              decoration: InputDecoration(border: InputBorder.none,hintText: hint),
              //readOnly: true,
            ),
          ),
        ],
      ),
    );
  }
  Widget _entryField2(String title, String hint) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15,
                fontFamily: "Spectral"),
          ),

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
              obscureText: true,
              // controller: mail,

              style: TextStyle(fontWeight: FontWeight.w600,fontFamily: "Spectral",fontSize: 18,color: Colors.white),
              decoration: InputDecoration(border: InputBorder.none,hintText: hint),
              //readOnly: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _facebookButton() {
    return Container(
      height: 50,
      width: 250,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(

            alignment: Alignment.center,
            child: Image(
              width: 40,
                  height: 40,
                  image: AssetImage("assets/facebook.png"),
            ),
          ),
          Container(

            alignment: Alignment.center,
            child: Image(
              width: 40,
              height: 40,
              image: AssetImage("assets/google.png"),
            ),
          ),

        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
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
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'ge',
              style: TextStyle(color: Colors.black, fontSize: 40),
            ),
            TextSpan(
              text: 'ms',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 40),
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

    final height=MediaQuery.of(context).size.height;
     return Scaffold(
        body: SingleChildScrollView(
          child: Container(
           height: height,
           child: Stack(
            children: <Widget>[
            Positioned(
                top: -height * .15,
                right: -MediaQuery.of(context).size.width * .4,
                child: BezierContainer()),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Gmail id",
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15,
                                fontFamily: "Spectral"),
                          ),

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
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Password",
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15,
                                fontFamily: "Spectral"),
                          ),

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
                              obscureText: true,
                              // controller: mail,
                              controller: _passwordController,

                              style: TextStyle(fontWeight: FontWeight.w600,fontFamily: "Spectral",fontSize: 18,color: Colors.white),
                              decoration: InputDecoration(border: InputBorder.none,hintText: "a!v@23S"),
                              //readOnly: true,
                            ),
                          ),
                        ],
                      ),
                    ),                    SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      _signInWithEmailAndPassword();

                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 13),
                      alignment: Alignment.center,

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
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
                        'Login',
                        style: TextStyle(fontSize: 20, color: Colors.white,fontFamily: "Spectral",fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => PassReset(),));
                      },
                      child: Container(

                        padding: EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.centerRight,
                        child: Text('Forgot Password ?',

                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                      ),
                    ),
                    _divider(),
                    _facebookButton(),
                  //  SizedBox(height: 5),
                    _createAccountLabel(),
                  ],
                ),
              ),
            ),
           ],
      ),
    ),
        ));
  }
  void _signInWithEmailAndPassword() async {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    String date = dateFormat.format(DateTime.now());
    try {
      await pr.show();
      pr =  ProgressDialog(context,type: ProgressDialogType.Download, isDismissible: false, showLogs: false);
      final FirebaseUser user = (await _auth.signInWithEmailAndPassword(email: _emailController.text.trim(),
        password: _passwordController.text.trim(),)).user;
      if (user.isEmailVerified) {
        Fluttertoast.showToast(msg: "Login successfully",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.teal,textColor: Colors.white);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', user.email);
        await pr.hide();

        databaseReference.collection(user.email).document("PersonalInfo").updateData({
          'lastlogin': date,
        }
        );

        Navigator.of(context).pop();
         Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainWidget(username: user.email,)),);
      }
      else if(!user.isEmailVerified){
        await pr.hide();
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text("OOPS!",style: TextStyle(color: Colors.white,fontSize: 20),),
                content: Text("Looks like you didn't confirm your mail yet",style: TextStyle(color: Colors.white,fontSize: 17),),
                actions: <Widget>[
                  FlatButton( onPressed: (){
                    Navigator.pop(context);
                  },
                    child: Text("Dismiss",style: TextStyle(color: Colors.white,fontSize: 17),),),
                  FlatButton(onPressed: () async {
                    Navigator.pop(context);
                    await user.sendEmailVerification();
                    Fluttertoast.showToast(msg: "Verification email send succesfully", gravity: ToastGravity.BOTTOM, toastLength: Toast.LENGTH_SHORT);
                  },child: Text("Confirm Now",style: TextStyle(color: Colors.white,fontSize: 17),),),
                ],
                elevation: 24.0,
                backgroundColor: Colors.blue,
              );
            }
        );
      }
      else {
        await pr.hide();
        Fluttertoast.showToast(msg: "Some error occurd",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.teal,textColor: Colors.white);

      }
    } catch (e) {
      await pr.hide();
      Fluttertoast.showToast(msg: e.toString(),gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.teal,textColor: Colors.white);
    }

  }
}
