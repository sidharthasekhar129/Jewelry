import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dot_pagination_swiper/dot_pagination_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kf_drawer/kf_drawer.dart';

import 'package:snehal_gems/screens/ProductDetailsPage.dart';

import 'ProductsList.dart';
import 'cart_screen.dart';

 class MainPage extends KFDrawerContent {
   final mail;
   MainPage({
    Key key,this.mail
  });

  @override
  _MainPageState createState() => _MainPageState(mail);
}

class _MainPageState extends State<MainPage> {
  PageController _pageController;
  int currentpage=0;
String mailx;
  _MainPageState(String mail){
    mailx=mail;
  }

  @override
  void initState() {
     _pageController=PageController(
       initialPage: currentpage,

       keepPage: false,
       viewportFraction: 0.5,
     );
  }



  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage("assets/emptyorder.png");
    Image image = Image(
      image: assetImage,
    );
    return  Scaffold(
      body:  SafeArea(
        child: SingleChildScrollView(
          child: Container(
             child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              color: Colors.black,
                            ),
                            onPressed: widget.onMenuPressed,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child:  RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: 's',
                            style: GoogleFonts.portLligatSans(
                              textStyle: Theme.of(context).textTheme.display1,
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Color(0xffe46b10),
                            ),
                            children: [
                              TextSpan(
                                text: 'ge',
                                style: TextStyle(color: Colors.black, fontSize: 25),
                              ),
                              TextSpan(
                                text: 'ms',
                                style: TextStyle(color: Color(0xffe46b10), fontSize: 25),
                              ),
                            ]),
                      ),
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          child: Material(
                            shadowColor: Colors.transparent,
                            color: Colors.transparent,
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: IconButton(
                                icon: Icon(
                                  Icons.notifications,
                                  color: Colors.black,
                                ),
                                onPressed: (){

                                },
                              ),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          child: Material(
                            shadowColor: Colors.transparent,
                            color: Colors.transparent,
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: IconButton(
                                icon: Icon(
                                  Icons.shopping_cart,
                                  color: Colors.black,
                                ),
                                onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CartScreen(username: mailx,)));
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
                Column(
                 // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Container(
                      height: 35,
                       alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 10),
                      child: Text("Take a gift for", style: TextStyle(fontWeight: FontWeight.w600,
                          fontFamily: "Spectral",fontSize: 25,color: Colors.black),
                      ),
                    ),
                    Container(
                      height: 45,

                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 35,),
                      child: Text("your loved one..", style: TextStyle(fontWeight: FontWeight.w600,
                          fontFamily: "Spectral",fontSize: 35,color: Color(0xffe46b10)),
                      ),
                    ),
                    Container(

                      height: 50,
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black26,

                      ),
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.only(left: 6),

                      child:  TextField(

                        // controller: mail,

                        style: TextStyle(fontWeight: FontWeight.w600,fontFamily: "Spectral",fontSize: 18,color: Colors.white),
                        decoration: InputDecoration(border: InputBorder.none,hintText: "Search products"),
                        //readOnly: true,
                      ),
                    ),
                     SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      padding: EdgeInsets.only(left: 5),
                      child:  Row(children: <Widget>[
                        Expanded(child: Text("On Offer",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,
                            fontFamily: "Spectral",color: Color(0xff0f4c81)),),),
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => OfferAndTrend(path: "onOffer",
                              mailx: mailx,header: "OnOffer",) ));

                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("More",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,
                                  fontFamily: "Spectral",color: Color(0xff0f4c81)),),
                              Icon(Icons.navigate_next, color: Color(0xff0f4c81),size: 30,),
                            ],
                          ),
                        ),

                      ],),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                       height: 290,

                      width: MediaQuery.of(context).size.width-10,
                      child: PageView.builder(
                        itemCount: 10,
                            itemBuilder: (context,index)  {
                              return GestureDetector(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailsPage(path1: "Homepage",
                                    path2: "SubHomepage",path3: "onOffer",path4: index.toString(),mail: mailx,) ));
                                },
                                child: AnimatedBuilder(
                                  animation: _pageController,
                                  builder: (context,child){
                                    double value =1;
                                    if(_pageController.position.haveDimensions){
                                      value=_pageController.page-index;
                                      value=(1-(value.abs()*0.45)).clamp(0.0, 1.0);
                                    }
                                    return Center(
                                      child: SizedBox(

                                        height: Curves.easeOut.transform(value)*290,
                                        width: Curves.easeOut.transform(value)*170,
                                        child: child,
                                      ),
                                    );
                                  },
                                  child:  StreamBuilder(
                                      stream: Firestore.instance.collection("Homepage").document('SubHomepage').collection("onOffer").snapshots(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Text("Loading");
                                        }
                                        DocumentSnapshot products = snapshot.data.documents[index];

                                        // var userDocument = snapshot.data;
                                        // picture1[index] = userDocument["pic1"];
                                        return   Container(
                                          decoration: BoxDecoration(
                                              color: Colors.black45,
                                              borderRadius: new BorderRadius.circular(10)
                                          ),
                                          height: 290,
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: 320,
                                              ),
                                              Positioned(

                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: Container(
                                                      height: 220,
                                                      width: 176,
                                                      //margin: const EdgeInsets.all(5.0),
                                                      child: Image.network(products["pic1"],fit: BoxFit.cover,),
                                                   ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 10,
                                                bottom: 40,
                                                child: Container(
                                                  child: Text(products["name1"],style: TextStyle(fontFamily: "Spectral",fontSize: 20,color: Colors.white),),
                                                ),
                                              ),
                                              Positioned(
                                                left: 10,
                                                bottom: 23,
                                                child: Container(
                                                  child: Text(products["offer"]+"% off",style: TextStyle(fontFamily: "Spectral",fontSize: 18,color: Colors.white),),
                                                ),
                                              ),
                                              Positioned(
                                                left: 10,
                                                bottom: 2,
                                                child: Container(
                                                  child: Text("Limited offer",style: TextStyle(fontFamily: "Spectral",fontSize: 18,color: Colors.white),),
                                                ),
                                              ),
                                            ],

                                          ),
                                        );
                                      }
                                   ),
                                ),
                              );
                            },
                        onPageChanged: (value){
                          setState(() {
                            currentpage=value;
                            print(currentpage);

                          });
                        },
                        controller: _pageController,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(thickness: 2,
                      indent: 70,
                      height: 2,
                      endIndent: 70,
                      color: Color(0xff0f4c81)),
                    SizedBox(
                      height: 15,
                    ),
                    Swipperlayout(),
                    SizedBox(
                      height: 15,
                    ),

                    Container(
                      height: 40,
                      padding: EdgeInsets.only(left: 5),

                      child:  Row(children: <Widget>[
                        Expanded(child: Text("On Trend",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,
                            fontFamily: "Spectral",color: Color(0xff0f4c81)),),),
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => OfferAndTrend(path: "onTrend",
                              mailx: mailx,header: "OnTrend",) ));

                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("More",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,
                                  fontFamily: "Spectral",color: Color(0xff0f4c81)),),
                              Icon(Icons.navigate_next, color: Color(0xff0f4c81),size: 30,),
                            ],
                          ),
                        ),

                      ],),
                    ),
                    listhorizontal("onTrend",mailx),
                    SizedBox(
                      height: 15,
                    ),

                    Divider(thickness: 2,
                      indent: 70,
                      height: 2,
                      endIndent: 70,
                      color: Color(0xff0f4c81)),
                    Container(
                      height: 40,
                      padding: EdgeInsets.only(left: 5),

                      child:  Row(children: <Widget>[
                        Expanded(child: Text("In Cart",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,
                            fontFamily: "Spectral",color: Color(0xff0f4c81)),),),
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CartScreen(username: mailx,)));


                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("see all",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,
                                  fontFamily: "Spectral",color: Color(0xff0f4c81)),),
                              Icon(Icons.navigate_next, color: Color(0xff0f4c81),size: 30,),
                            ],
                          ),
                        ),

                      ],),
                    ),
                    StreamBuilder(
                        stream: Firestore.instance.collection(mailx).document("Cartinfo").collection("Cartx").document("max").snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return new Text("Loading");
                          }
                          var userDocument2 = snapshot.data;

                          int x = int.parse(userDocument2["length"].toString());

                          if(x==0){
                            return Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 20,bottom: 20),
                                  alignment: Alignment.center,
                                  height: 150,
                                  width: 150,
                                  child: image,
                                ),
                                Text("OOPS \nLooks like your cart is empty",textAlign: TextAlign.center,style: TextStyle(
                                  fontFamily: "Spectral",fontSize: 20,fontWeight: FontWeight.w600,
                                ),),

                                // Container(
                                //   width: 300.0,
                                //   height: 50.0,
                                //   margin: EdgeInsets.only(top: 30.0, bottom: 15),
                                //   child: RaisedButton(
                                //     color: Color(0xff0f4c81),
                                //     shape: RoundedRectangleBorder(
                                //         borderRadius: new BorderRadius.circular(15),
                                //         side: BorderSide(color: Color(0xFFceced8))),
                                //     onPressed: () {
                                //       Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainWidget(username: username,)));
                                //     },
                                //     child: Text('Continue shopping', style: TextStyle(
                                //         color: Colors.white,
                                //         fontFamily: "Raleway",
                                //         fontWeight: FontWeight.w600),
                                //     ),
                                //   ),
                                // ),
                              ],
                            );

                          }
                          else {

                            return  Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topLeft,
                                  //height: 320,
                                  margin: EdgeInsets.all(6),
                                  child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: int.parse(userDocument2["length"].toString()),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (BuildContext context, int index) {
                                        return Container(
                                          width: 100.0,
                                          height: 120.0,
                                          decoration: BoxDecoration(
                                              color: Colors.black26,
                                              borderRadius: new BorderRadius.circular(10)),
                                          margin: EdgeInsets.all(2),
                                          child: Column(
                                            children: <Widget>[
                                              StreamBuilder(

                                                  stream: Firestore.instance.collection(mailx).document("Cartinfo").collection("Cartx").snapshots(),
                                                  builder: (context, snapshot) {
                                                    if (!snapshot.hasData) {
                                                      return new Text("Loading");
                                                    }
                                                    DocumentSnapshot products = snapshot.data.documents[index];
                                                    path1 = products["path1"];
                                                    path2 = products["path2"];
                                                    path3 = products["path3"];
                                                    path4 = products["path4"];
                                                    //  var userDocument = snapshot.data;
                                                    // picture1[index] = userDocument["pic1"];
                                                    return StreamBuilder(
                                                        stream: Firestore.instance.collection(products["path1"]).document(products["path2"]).
                                                        collection(products["path3"]).snapshots(),
                                                        builder: (context, snapshot) {
                                                          if (!snapshot.hasData) {
                                                            return new Text("Loading");
                                                          }




                                                          DocumentSnapshot productsx = snapshot.data.documents[int.parse(products["path4"])];

                                                          //var userDocument = snapshot.data;
                                                          var price = int.parse(productsx["price"]);
                                                          assert(price is int);
                                                          var offer = int.parse(productsx["offer"]);

                                                          var finalprice = (price * offer) / 100;
                                                          var finalpricexx = price - finalprice;
                                                          var finalpricexxx = finalpricexx.round();

                                                       //   total=total+finalpricexxx;



                                                          //pricex=(pricex+finalprice).round();
                                                          return Container(
                                                            height: 120.0,
                                                            child: Row(
                                                              children: <Widget>[
                                                                Container(
                                                                  width: 120,
                                                                  child: ClipRRect(
                                                                    borderRadius: BorderRadius.circular(10),
                                                                    child: Image.network(
                                                                      productsx["pic1"],
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Column(
                                                                  children: <Widget>[
                                                                    Container(
                                                                      width: 200,
                                                                      margin: EdgeInsets.only(left: 8, top: 4),
                                                                      child: Text(
                                                                        productsx["name1"],
                                                                        style: TextStyle(fontFamily: "Spectral", fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width: 200,
                                                                      margin: EdgeInsets.only(left: 8,  ),
                                                                      child: Text(
                                                                        productsx["name2"],
                                                                        style: TextStyle(fontFamily: "Spectral", fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                                                                      ),
                                                                    ),
                                                                    Container(

                                                                      width: 200,
                                                                      margin:
                                                                      EdgeInsets.only(left: 8, ),
                                                                      child: Text(products["size"] + "/" + products["qty"],
                                                                        style: TextStyle(fontFamily: "Spectral", fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                      children: <Widget>[
                                                                        Container(
                                                                          height: 25,
                                                                          width: 100,
                                                                          margin: EdgeInsets.only(left: 8,),
                                                                          child: Text(
                                                                            "₹"+ finalpricexxx.toString(),
                                                                            style: TextStyle(fontFamily: "Spectral", fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width: 100,
                                                                          height: 35,
                                                                          child: RaisedButton(
                                                                            color: Color(0xFFceced8),
                                                                            shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10),
                                                                                side: BorderSide(color: Color(0xFFceced8))),
                                                                            onPressed: () {},
                                                                            child: Text('Remove',
                                                                              style: TextStyle(color: Colors.white, fontFamily: "Spectral",fontWeight: FontWeight.w600),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                  }
                                              ),

                                            ],
                                          ),
                                        );

                                      }),
                                ),

                              ],
                            );

                          }


                        }),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(thickness: 2,
                        indent: 70,
                        height: 2,
                        endIndent: 70,
                        color: Color(0xff0f4c81)),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 5,left: 10),
                      height: 25,
                      child: Text("Others", style: TextStyle(fontWeight: FontWeight.w600,
                          fontFamily: "Spectral",fontSize: 18,color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),

                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      height: 139,
                       child: offerlist(),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }


}


class offerlist extends StatelessWidget{

  @override
  Widget build(BuildContext context) {



     // TODO: implement build
    return  Container(
      height: 139,
      // margin: EdgeInsets.only(bottom: 50),
      child: ListView.builder(
          itemCount: 3,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext ctxt, int index) {
            return   StreamBuilder(
                stream: Firestore.instance.collection("Homepage").document('SubHomepage').collection("offerCards").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return new Text("Loading");
                  }
                  DocumentSnapshot products = snapshot.data.documents[index];

                  //  var userDocument = snapshot.data;
                  // picture1[index] = userDocument["pic1"];
                  return   Container(
                    height: 139,
                    width: 280,
                    child:  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(products["pic1"],

                        fit: BoxFit.contain,
                      ) ,
                    ),
                  );
                }
            );
          }
      ),
    );
  }

}

 class Swipperlayout extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(

      height: 180,
      child: DotPaginationSwiper(
        children: <Widget>[
          StreamBuilder(
              stream: Firestore.instance.collection("Homepage").document('SubHomepage').collection("scrollingimage").document("a").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child:  Container(
                        color: Colors.black45,
                          child: Text("Loading")));
                }
                var userDocument = snapshot.data;
                // picture1[index] = userDocument["pic1"];
                return   Container(
                  height: 250,
                  width: 176,
                  child:  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(userDocument["pic1"],

                      fit: BoxFit.cover,
                    ) ,
                  ),
                );
              }
          ),
          StreamBuilder(
              stream: Firestore.instance.collection("Homepage").document('SubHomepage').collection("scrollingimage").document("a").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return new Text("Loading");
                }
                var userDocument = snapshot.data;
                // picture1[index] = userDocument["pic1"];
                return   Container(
                  height: 250,
                  width: 176,
                  child:  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(userDocument["pic2"],

                      fit: BoxFit.cover,
                    ) ,
                  ),
                );
              }
          ),
          StreamBuilder(
              stream: Firestore.instance.collection("Homepage").document('SubHomepage').collection("scrollingimage").document("a").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return new Text("Loading");
                }
                var userDocument = snapshot.data;
                // picture1[index] = userDocument["pic1"];
                return   Container(
                  height: 250,
                  width: 176,
                  child:  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(userDocument["pic3"],

                      fit: BoxFit.cover,
                    ) ,
                  ),
                );
              }
          ),
          StreamBuilder(
              stream: Firestore.instance.collection("Homepage").document('SubHomepage').collection("scrollingimage").document("a").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return new Text("Loading");
                }
                var userDocument = snapshot.data;
                // picture1[index] = userDocument["pic1"];
                return   Container(
                  height: 250,
                  width: 176,
                  child:  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(userDocument["pic4"],

                      fit: BoxFit.cover,
                    ) ,
                  ),
                );
              }
          ),
          StreamBuilder(
              stream: Firestore.instance.collection("Homepage").document('SubHomepage').collection("scrollingimage").document("a").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return new Text("Loading");
                }
                var userDocument = snapshot.data;
                // picture1[index] = userDocument["pic1"];
                return   Container(
                  height: 250,
                  width: 176,
                  child:  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(userDocument["pic4"],

                      fit: BoxFit.cover,
                    ) ,
                  ),
                );
              }
          ),
        ],
      ),
    );
  }
}
class listhorizontal extends StatelessWidget{
  String path1,usernamexx;


  listhorizontal(String s ,String username){
    path1 = s;
    usernamexx=username;

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return  Container(
      height: 280,
      // margin: EdgeInsets.only(bottom: 50),
      child: ListView.builder(
          itemCount: 9,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext ctxt, int index) {
            return GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailsPage(path1: "Homepage",
                  path2: "SubHomepage",path3: path1,path4: index.toString(),mail: usernamexx,) ));


              },
              child: Container(
                height: 280,
                width: 176,
                decoration: BoxDecoration(
                    color: Color(0xff0f4c81),
                    borderRadius: new BorderRadius.circular(10)
                ),
                margin: EdgeInsets.all(2),
                child: Column(
                  children: <Widget>[
                    StreamBuilder(
                        stream: Firestore.instance.collection("Homepage").document('SubHomepage').collection(path1).snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return new Text("Loading");
                          }
                          DocumentSnapshot products = snapshot.data.documents[index];

                          // var userDocument = snapshot.data;
                          // picture1[index] = userDocument["pic1"];
                          return   Container(
                            height: 210,
                            width: 176,
                            child:  ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(products["pic1"],

                                fit: BoxFit.cover,
                              ) ,
                            ),
                          );
                        }
                    ),
                    StreamBuilder(
                        stream: Firestore.instance.collection("Homepage").document('SubHomepage').collection(path1).snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return new Text("Loading");
                          }
                          DocumentSnapshot products = snapshot.data.documents[index];

                          // var userDocument = snapshot.data;
                          // picture1[index] = userDocument["pic1"];
                          return   Container(
                            padding: EdgeInsets.only(left: 5),

                            child:  Text(products["name1"],maxLines: 1,style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.w700,
                              color: Colors.white,

                            ),
                            ),
                          );
                        }
                    ),
                    StreamBuilder(
                        stream: Firestore.instance.collection("Homepage").document('SubHomepage').collection(path1).snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return new Text("Loading");
                          }
                          DocumentSnapshot products = snapshot.data.documents[index];

                          //var userDocument = snapshot.data;
                          // picture1[index] = userDocument["pic1"];
                          return Container(
                            padding: EdgeInsets.only(left: 5),

                            child: Text(products["name2"],maxLines: 1,style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600 ,
                                fontFamily: "Raleway",
                                color: Colors.white
                            ),
                            ) ,
                          );
                        }
                    ),

                    Row(
                      children: <Widget>[
                        StreamBuilder(
                            stream: Firestore.instance.collection("Homepage").document('SubHomepage').collection(path1).snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return new Text("Loading");
                              }
                              DocumentSnapshot products = snapshot.data.documents[index];

                              //  var userDocument = snapshot.data;
                              // picture1[index] = userDocument["pic1"];

                              var price =  int.parse(products["price"]);
                              assert(price is int);
                              var offer = int.parse(products["offer"]);
                              assert(offer is int);
                              var finalprice = (price*offer)/100;
                              var finalpricexx = price-finalprice;
                              var finalpricexxx=  finalpricexx.round();

                              return   Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text("₹"+finalpricexxx.toString(),style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,

                                ),
                                ),
                              );
                            }
                        ),
                        StreamBuilder(
                            stream: Firestore.instance.collection("Homepage").document('SubHomepage').collection(path1).snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return new Text("Loading");
                              }
                              DocumentSnapshot products = snapshot.data.documents[index];

                              // var userDocument = snapshot.data;

                              return     Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(products["price"],style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Colors.white,
                                    decorationThickness: 2
                                ),
                                ),
                              );
                            }
                        ),
                        StreamBuilder(
                            stream: Firestore.instance.collection("Homepage").document('SubHomepage').collection(path1).snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return new Text("Loading");
                              }
                              DocumentSnapshot products = snapshot.data.documents[index];

                              //var userDocument = snapshot.data;
                              // picture1[index] = userDocument["pic1"];
                              return   Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(products["offer"]+"%off",style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,

                                ),
                                ),
                              );
                            }
                        ),



                      ],
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
class OfferAndTrend extends StatelessWidget{

  final path,mailx,header;

  const OfferAndTrend({Key key, this.path, this.mailx,this.header}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(header), backgroundColor: Color(0xff0f4c81)
        ),
        body: Container(
          color: Colors.black12,
          child: GridView.count(

            // crossAxisCount is the number of columns
            crossAxisCount: 2,
            //   childAspectRatio: (itemWidth / itemHeight),
            childAspectRatio: (100 / 180),
            // This creates two columns with two items in each column
            children: List.generate(8, (index) {
              return GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailsPage(path1: "Homepage",
                    path2: "SubHomepage",path3: path,path4: index.toString(),mail: mailx,) ));


                },
                child: Container(
                    height: 200,
                    margin: EdgeInsets.all(2),
                    padding: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: new BorderRadius.circular(10)),

                    child:
                    Column(
                      children: <Widget>[
                        StreamBuilder(

                            stream: Firestore.instance.collection('Homepage').document('SubHomepage').collection(path).snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return new Text("Loading");
                              }
                              DocumentSnapshot products = snapshot.data.documents[index];

                              //  var userDocument = snapshot.data;
                              // picture1[index] = userDocument["pic1"];
                              return   Container(
                                height: MediaQuery.of(context).size.width*0.7,
                                width: MediaQuery.of(context).size.width*0.5,

                                child:  ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(products["pic1"],

                                    fit: BoxFit.cover,
                                  ) ,
                                ),
                              );
                            }
                        ),
                        StreamBuilder(
                            stream: Firestore.instance.collection('Homepage').document('SubHomepage').collection(path).snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return new Text("Loading");
                              }
                              DocumentSnapshot products = snapshot.data.documents[index];

                              //var userDocument = snapshot.data;
                              // picture1[index] = userDocument["pic1"];
                              return     Container(
                                padding: EdgeInsets.only(left: 5),

                                child:  Text(products["name1"],maxLines: 1,style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "Raleway",
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,

                                ),
                                ),
                              );
                            }
                        ),
                        StreamBuilder(
                            stream: Firestore.instance.collection('Homepage').document('SubHomepage').collection(path).snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return new Text("Loading");
                              }
                              DocumentSnapshot products = snapshot.data.documents[index];

                              //  var userDocument = snapshot.data;
                              // picture1[index] = userDocument["pic1"];
                              return Container(
                                padding: EdgeInsets.only(left: 5),

                                child: Text(products["name2"],maxLines: 1,style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600 ,
                                    fontFamily: "Raleway",
                                    color: Colors.white
                                ),
                                ) ,
                              );
                            }
                        ),
                        Container(
                          color: Colors.black54,
                          alignment: Alignment.center,
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              StreamBuilder(
                                  stream: Firestore.instance.collection('Homepage').document('SubHomepage').collection(path).snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return new Text("Loading");
                                    }
                                    DocumentSnapshot products = snapshot.data.documents[index];

                                    // var userDocument = snapshot.data;
                                    // picture1[index] = userDocument["pic1"];

                                    var price =  int.parse(products["price"]);
                                    assert(price is int);
                                    var offer = int.parse(products["offer"]);
                                    assert(offer is int);
                                    var finalprice = (price*offer)/100;
                                    var finalpricexx = price-finalprice;
                                    var finalpricexxx=  finalpricexx.round();

                                    return   Container(
                                      //padding: EdgeInsets.only(left: 10),
                                      child: Text("₹"+finalpricexxx.toString(),style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,

                                      ),
                                      ),
                                    );
                                  }
                              ),
                              StreamBuilder(
                                  stream: Firestore.instance.collection('Homepage').document('SubHomepage').collection(path).snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return new Text("Loading");
                                    }
                                    DocumentSnapshot products = snapshot.data.documents[index];

                                    //    var userDocument = snapshot.data;

                                    return     Container(
                                      //padding: EdgeInsets.only(left: 10),
                                      child: Text(products["price"],style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          decoration: TextDecoration.lineThrough,
                                          decorationColor: Colors.white,
                                          decorationThickness: 2
                                      ),
                                      ),
                                    );
                                  }
                              ),

                              StreamBuilder(
                                  stream: Firestore.instance.collection('Homepage').document('SubHomepage').collection(path).snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return new Text("Loading");
                                    }
                                    DocumentSnapshot products = snapshot.data.documents[index];

                                    //   var userDocument = snapshot.data;
                                    // picture1[index] = userDocument["pic1"];
                                    return   Container(

                                      //padding: EdgeInsets.only(left: 10),
                                      child: Text(products["offer"]+"%off",style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,

                                      ),
                                      ),
                                    );
                                  }
                              ),



                            ],
                          ),
                        ),

                      ],
                    )


                ),

              );
            }
            ),
          ),
        )
    );
  }

}
