
import 'dart:io';
 import 'package:google_fonts/google_fonts.dart';
import 'package:image_ink_well/image_ink_well.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snehal_gems/main.dart';
import 'package:snehal_gems/screens/AddressPage.dart';
import 'package:snehal_gems/screens/MyPointsPage.dart';
import 'package:snehal_gems/screens/ProfileinfoPage.dart';
import 'package:snehal_gems/screens/SharePage.dart';
import 'package:snehal_gems/screens/orders_screen.dart';

import 'auth/loginPage.dart';
class MyAccountPage extends KFDrawerContent{

  String username = "";

  MyAccountPage({Key key, this.username})  ;

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  StorageReference storageReference = FirebaseStorage.instance.ref();

  ProgressDialog pr;

  Future getImage(ImgSource source,BuildContext context) async {
    var image = await ImagePickerGC.pickImage(context: context, source: source,
      cameraIcon: Icon(Icons.camera, color: Colors.red,
      ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
    );
    try {
      //CreateRefernce to path.
      StorageReference ref = storageReference.child("userProfilePic/");

      //StorageUpload task is used to put the data you want in storage
      //Make sure to get the image first before calling this method otherwise _image will be null.
      await pr.show();
      StorageUploadTask storageUploadTask = ref.child(widget.username).putFile(image);

      if (storageUploadTask.isSuccessful || storageUploadTask.isComplete) {
        final String url = await ref.getDownloadURL();
        //  print("The download URL is " + url);
      } else if (storageUploadTask.isInProgress) {
        storageUploadTask.events.listen((event) {
          double percentage = 100 * (event.snapshot.bytesTransferred.toDouble()
              / event.snapshot.totalByteCount.toDouble());

          //  print("THe percentage " + percentage.toString());
          pr = ProgressDialog(context, type: ProgressDialogType.Download,
              isDismissible: false,
              showLogs: true);
        });

        StorageTaskSnapshot storageTaskSnapshot = await storageUploadTask
            .onComplete;

        var downloadUrl1 = await storageTaskSnapshot.ref.getDownloadURL();
        Firestore.instance.collection(widget.username)
            .document("PersonalInfo")
            .updateData({
          "profilePic": downloadUrl1,

        });
        //Here you can get the download URL when the task has been completed.
        // print("Download URL " + downloadUrl1.toString());
        await pr.hide();
      } else {
        await pr.hide();

        //Catch any cases here that might come up like canceled, interrupted
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement buildj
    String pic;
    AssetImage assetImage = AssetImage("assets/logo1.JPG");
    Image image = Image(
      image: assetImage,
    );

    pr = new ProgressDialog(context);
    pr.style(
        message: 'Uploading Image...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600)
    );


    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 20),
          color: Colors.white,
          child: SingleChildScrollView(
            child:  Column(
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
                         child:  Text("Account", style: TextStyle(
                           fontSize: 20,
                           color: Colors.black,
                           fontStyle: FontStyle.normal,
                           fontWeight: FontWeight.w500,
                           fontFamily: "Spectral",
                         ),)
                     ),
                  ],
                ),
                // maincard2(username),
                Stack(
                  // alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      //margin: EdgeInsets.only(top: 80),
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Positioned(
                      top: 30,
                      left: MediaQuery.of(context).size.width*0.5-50,
                      child:   Container(
                        //margin: EdgeInsets.only(top: 80),
                        height: 100,
                        width: 100,
                        child: GestureDetector(
                          onTap: (){
                            getImage(ImgSource.Both,context);
                          },
                          child: StreamBuilder(
                              stream: Firestore.instance.collection(widget.username).document("PersonalInfo").snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return new Text("Loading");
                                }
                                var userDocument = snapshot.data;
                                pic = userDocument["profilePic"];
                                if(pic==""){
                                  return Container(

                                    child: image,
                                  );
                                }
                                else{
                                  return CircleImageInkWell(
                                    size: 100,
                                    image: NetworkImage(pic),
                                  );
                                }

                              }
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 140,
                      left: MediaQuery.of(context).size.width*.5-130,
                      child: StreamBuilder(
                          stream: Firestore.instance.collection(widget.username).document("PersonalInfo").snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return new Text("Loading");
                            }
                            var userDocument = snapshot.data;
                            return Container(
                              width: 260,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(70),
                                    bottomRight: Radius.circular(70),
                                  )
                              ),
                              margin: EdgeInsets.only(top: 15),
                              child: Text(userDocument["name"],maxLines:1,textAlign: TextAlign.center,textDirection: TextDirection.ltr,
                                style: TextStyle(decoration: TextDecoration.none,
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontFamily: "Raleway",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            );

                          }
                      ),
                    ),
                    Positioned(
                      top: 180,
                      left: MediaQuery.of(context).size.width*0.5-80,
                      child:  StreamBuilder(
                          stream: Firestore.instance.collection(widget.username).document("PersonalInfo").snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return new Text("Loading");
                            }
                            var userDocument = snapshot.data;

                            return Container(
                              width: 160,
                              margin: EdgeInsets.only(top: 15,bottom: 30),
                              child: Text("+91"+userDocument["phone"],maxLines:1,textAlign: TextAlign.center,textDirection: TextDirection.ltr,
                                style: TextStyle(decoration: TextDecoration.none,
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontFamily: "Raleway",
                                  fontWeight: FontWeight.w700,


                                ),),
                            );

                          }
                      ),
                    ),

                  ],
                ),

                GestureDetector(
                  onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => Profileinfo(username: widget.username,)));
                  },
                  child: Personalinfo(),
                ),

                Divider(
                    height: 2,
                    thickness: 1.5,
                    indent: 30,
                  endIndent: 30,
                    color: Color(0xff0f4c81)
                ),

                GestureDetector(
                  onTap: (){
                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyOrdersPage(username: widget.username,)));
                  },
                  child: Orders(),
                ),
                Divider(
                    height: 2,
                    thickness: 1.5,
                    indent: 30,
                  endIndent: 30,
                    color: Color(0xff0f4c81)
                ),

                GestureDetector(
                  onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddressPage(username: widget.username,)));
                  },
                  child: Address(),
                ),


                Divider(
                    height: 2,
                    thickness: 1.5,
                    indent: 30,
                  endIndent: 30,
                    color: Color(0xff0f4c81)                ),
                GestureDetector(
                  onTap: (){
                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyPointsPage(username: widget.username,)));
                  },
                  child: Points(),
                ),

                Divider(
                  height: 2,
                  thickness: 1.5,
                  indent: 30,
                  endIndent: 30,
                    color: Color(0xff0f4c81)                ),
                GestureDetector(
                  onTap: (){
                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => SharePage(username: widget.username,)));
                  },
                  child:   Share(),
                ),


                LogoutButton(),

              ],
            ),
          )
      ),
    );
  }
}



class Personalinfo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(

      margin: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon1(),
          Expanded(
            child:  Text1(),
          ),
          nexticon(),
        ],
      ),
    );
  }
}
class Icon1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 25,
      child: Icon(Icons.person, color: Color(0xff0f4c81)),
    );
  }
}
class Text1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 150,
      margin: EdgeInsets.only(left: 7),
      child: Text("Profile info.",textDirection: TextDirection.ltr,style: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          fontFamily: "Spectral"
      ),),
    );
  }
}

class nexticon extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        width: 25,
        child: Icon(Icons.navigate_next, color: Color(0xff0f4c81))
    );
  }
}

class Orders extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(

      margin: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon2(),
          Expanded(
            child:  Text2(),
          ),
          nexticon(),
        ],
      ),
    );
  }
}
class Icon2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 30,
       width: 30,
       child:Image.asset("assets/ordericon.png",height: 30,width: 30, color: Color(0xff0f4c81)
      ),
    );
  }
}
class Text2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 150,
      margin: EdgeInsets.only(left: 7),
      child: Text("My Orders",textDirection: TextDirection.ltr,style: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          fontFamily: "Spectral"
      ),),
    );
  }
}

class Address extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon3(),
          Expanded(
            child:  Text3(),
          ),
          nexticon(),
        ],
      ),
    );

  }
}
class Icon3 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 25,
      child: Icon(Icons.location_on, color: Color(0xff0f4c81)),
    );
  }
}
class Text3 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 150,
      margin: EdgeInsets.only(left: 7),
      child: Text("My Address",textDirection: TextDirection.ltr,style: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          fontFamily: "Spectral"
      ),
      ),
    );
  }
}

class Points extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon4(),
          Expanded(
            child:  Text4(),
          ),
          nexticon(),
        ],
      ),
    );
  }
}
class Icon4 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 25,
      child: Icon(Icons.attach_money, color: Color(0xff0f4c81)),
    );
  }
}
class Text4 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 150,
      margin: EdgeInsets.only(left: 7),
      child: Text("My Points",textDirection: TextDirection.ltr,style: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          fontFamily: "Spectral"
      ),
      ),
    );
  }
}

class Share extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(

      margin: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon5(),
          Expanded(
            child:  Text5(),
          ),
          nexticon(),
        ],
      ),
    );
  }
}
class Icon5 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 25,
      child: Icon(Icons.share, color: Color(0xff0f4c81)),
    );
  }
}
class Text5 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 150,
      margin: EdgeInsets.only(left: 7),
      child: Text("Share And Earn",textDirection: TextDirection.ltr,style: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          fontFamily: "Spectral"
      ),),
    );
  }
}



class LogoutButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(

      width: 300,
      height: 45.0,
      margin: EdgeInsets.only(left: 15.0,top: 20.0,right: 15,bottom: 20),
      child: RaisedButton(
        onPressed: () {

          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context){
                return AlertDialog(
                  title: Text("Logout!",style: TextStyle(color: Colors.white,fontSize: 20),),
                  content: Text("Are you sure?",style: TextStyle(color: Colors.white,fontSize: 17),),
                  actions: <Widget>[
                    FlatButton( onPressed: (){
                      Navigator.pop(context);
                    },
                      child: Text("No",style: TextStyle(color: Colors.white,fontSize: 17),),),
                    FlatButton(onPressed: () async {
                      Navigator.pop(context);
                      Navigator.of(context).pop(context);
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.remove('email');
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );

                    },child: Text("Yes",style: TextStyle(color: Colors.white,fontSize: 17),),),
                  ],
                  elevation: 24.0,
                  backgroundColor: Color(0xff0f4c81)   ,

                );
              }
          );
        },
        child: Text("LOG OUT"),
          color: Color(0xff0f4c81)   ,
          textColor: Color(0xFFffffff),

      ),

    );
  }

}