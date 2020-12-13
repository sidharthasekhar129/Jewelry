import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snehal_gems/screens/Account_screen.dart';
import 'package:snehal_gems/screens/Category_page.dart';
import 'package:snehal_gems/screens/SettingPage.dart';
import 'package:snehal_gems/screens/auth/loginPage.dart';
import 'package:snehal_gems/screens/category_page2.dart';

 import 'onboarding_screen.dart';
import 'screens/auth_page.dart';
import 'screens/calendar_page.dart';
import 'screens/cart_screen.dart';
import 'screens/main_page.dart';
import 'screens/orders_screen.dart';

// void main() {
//   ClassBuilder.registerClasses();
//   runApp(MyApp());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  print(email);
  runApp(
      MaterialApp(
        home: email == null ? OnboardingScreen() : MainWidget(username: email,),
        debugShowCheckedModeBanner: false,
      )
  );
}


class MainWidget extends StatefulWidget {
  final String username;

  MainWidget({Key key, this.username}) : super(key: key);

  @override
  _MainWidgetState createState() => _MainWidgetState(username);
}

class _MainWidgetState extends State<MainWidget> with TickerProviderStateMixin {
  KFDrawerController _drawerController;
  DateTime currentBackPressTime;

  String mail;
  _MainWidgetState(String username){
    mail=username;
  }
  @override
  void initState() {
    super.initState();
    _drawerController = KFDrawerController(
      initialPage: MainPage(mail: mail,),
      items: [
        KFDrawerItem.initWithPage(
          text: Text('Home', style: TextStyle(color: Colors.white)),
          icon: Icon(Icons.home, color: Colors.white),
          page: MainPage(mail: mail,),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'Men',
            style: TextStyle(color: Colors.white),
          ),
          icon: Image.asset("assets/man.png",height: 20,width: 20,color: Colors.white,),
          page: CategoryPage(menORwomen: "Men",mail: mail,),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'Woman',
            style: TextStyle(color: Colors.white),
          ),
          icon: Image.asset("assets/woman.png",height: 20,width: 20,color: Colors.white,),
          page: CategoryPage2(menORwomen: "Women",mail: mail,),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'Gift Store',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.store, color: Colors.white),
          page: SettingPage(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'Offer Zone',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.local_offer, color: Colors.white),
          page: SettingPage(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'My Account',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.person, color: Colors.white),
          page: MyAccountPage(username: mail,),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'My Orders',
            style: TextStyle(color: Colors.white),
          ),
          icon: Image.asset("assets/ordericon.png",height: 30,width: 30,color: Colors.white,),
          page: MyOrdersPage(username: mail,),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'Settings',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.settings, color: Colors.white),
          page: SettingPage(),
        ),


      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    String pic;
    AssetImage assetImage = AssetImage("assets/logo1.JPG");
    Image image = Image(
      image: assetImage,
    );
    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: KFDrawer(
//        borderRadius: 0.0,
//        shadowBorderRadius: 0.0,
//        menuPadding: EdgeInsets.all(0.0),
//        scrollable: true,
          controller: _drawerController,
          header: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(15)
              ),
              margin: EdgeInsets.only(left: 18,top: 15),
              height: 60,
              child: Row(
                children: [
                  StreamBuilder(
                      stream: Firestore.instance.collection(mail).document("PersonalInfo").snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return new Text("Loading");
                        }
                        var userDocument = snapshot.data;
                        pic = userDocument["profilePic"];
                        if(pic==""){
                          return Container(
                            child:image,
                          );
                        }
                        else{
                          return   Container(
                            height: 60,
                            width: 60,
                            child:  ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(pic,)
                            ),
                          );
                        }

                      }
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StreamBuilder(
                          stream: Firestore.instance.collection(mail).document("PersonalInfo").snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return new Text("Loading");
                            }
                            var userDocument = snapshot.data;

                            return Text(userDocument["name"],textAlign:TextAlign.center,style: TextStyle(fontSize: 18,
                                color: Colors.white,fontWeight: FontWeight.bold));


                          }
                      ),

                      SizedBox(height: 5,),
                      Text(mail,textAlign:TextAlign.center,style: TextStyle(fontSize: 10,
                          color: Colors.white)),
                    ],
                  )
                ],
              ),


            ),
          ),
          footer: KFDrawerItem(
            text: Text(
              'Log out',
              style: TextStyle(color: Colors.white),
            ),
            icon: Icon(
              Icons.power_settings_new,
              color: Colors.white,
            ),
            onPressed: () {
              //Navigator.of(context).pop();
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
              backgroundColor:   Color(0xff0f4c81)
              );
              }
              );
              // Navigator.of(context).push(CupertinoPageRoute(
              //   fullscreenDialog: true,
              //   builder: (BuildContext context) {
              //     return AuthPage();
              //   },
              // ));
            },
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color.fromRGBO(255, 255, 255, 1.0), Color.fromRGBO(44, 72, 171, 1.0)],
             // tileMode: TileMode.repeated,
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> onWillPop() {
    _drawerController.close();
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "press back again to exit");
      return Future.value(false);
    }
    return Future.value(true);
  }

}