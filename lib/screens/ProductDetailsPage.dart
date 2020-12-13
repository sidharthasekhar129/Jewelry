
 import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:dot_pagination_swiper/dot_pagination_swiper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:snehal_gems/screens/CheckoutPage.dart';

import 'cart_screen.dart';
 TextEditingController size=new TextEditingController();
TextEditingController qty=new TextEditingController();
final databaseReference = Firestore.instance;


class ProductDetailsPage extends StatefulWidget {

  final path1,path2,path3,path4,mail;

  const ProductDetailsPage({Key key, this.path1, this.path2, this.path3, this.path4, this.mail}) : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState(mail,path1,path2,path3,path4);
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  ProgressDialog pr;

  String mailx,path1x,path2x,path3x,path4x;

  _ProductDetailsPageState(mail,path1,path2,path3,path4){
    mailx=mail;path1x=path1;path2x=path2;path3x=path3;path4x=path4;
  }
   String pic1,pic2,pic3,pic4,name1,name2,originalpricez,finalpricez,offer;

  @override
  Widget build(BuildContext context) {


    pr = new ProgressDialog(context);
    pr.style(
        message: 'Adding to Cart..', borderRadius: 10.0, backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(), elevation: 10.0, insetAnimCurve: Curves.easeInOut,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600)
    );

    return Scaffold(

        appBar: AppBar(title: Text("Details"), backgroundColor: Color(0xff0f4c81),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CartScreen(username: mailx,)));
              },
            ),
          ],),
        body: SingleChildScrollView(
          child:  Container(
            color: Colors.black38,
            child: Column(
              children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(5),

                      height: MediaQuery.of(context).size.height*0.7,
                      width: MediaQuery.of(context).size.height,
                      child: DotPaginationSwiper(
                       children: <Widget>[
                        StreamBuilder(
                            stream: Firestore.instance.collection(path1x).document(path2x).collection(path3x).snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return new Text("Loading");
                              }
                            //  var userDocument = snapshot.data;
                              DocumentSnapshot products = snapshot.data.documents[int.parse(path4x)];

                              pic1=products["pic1"];
                              pic2=products["pic2"];
                              pic3=products["pic3"];
                              pic4=products["pic4"];
                              name1=products["name1"];
                              name2=products["name2"];
                              offer=products["offer"];

                              print(products["pic1"]);
                              print(products["pic2"]);
                              print(products["pic3"]);
                              print(products["pic4"]);
                              print(products["name1"]);
                              print(products["name2"]);
                              print(products["offer"]);




                              // picture1[index] = userDocument["pic1"];
                              return   Container(
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
                            stream: Firestore.instance.collection(path1x).document(path2x).collection(path3x).snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return new Text("Loading");
                              }
                              DocumentSnapshot products = snapshot.data.documents[int.parse(path4x)];

                              // var userDocument = snapshot.data;

                              // picture1[index] = userDocument["pic1"];
                              return   Container(

                                child:  ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(products["pic2"],

                                    fit: BoxFit.cover,
                                  ) ,
                                ),
                              );
                            }
                        ),
                        StreamBuilder(
                            stream: Firestore.instance.collection(path1x).document(path2x).collection(path3x).snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return new Text("Loading");
                              }
                              DocumentSnapshot products = snapshot.data.documents[int.parse(path4x)];


                              // var userDocument = snapshot.data;

                              // picture1[index] = userDocument["pic1"];
                              return   Container(

                                child:  ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(products["pic3"],

                                    fit: BoxFit.cover,
                                  ) ,
                                ),
                              );
                            }
                        ),
                        StreamBuilder(
                            stream: Firestore.instance.collection(path1x).document(path2x).collection(path3x).snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return new Text("Loading");
                              }
                              DocumentSnapshot products = snapshot.data.documents[int.parse(path4x)];

                              // var userDocument = snapshot.data;

                              // picture1[index] = userDocument["pic1"];
                              return   Container(

                                child:  ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(products["pic4"],

                                    fit: BoxFit.cover,
                                  ) ,
                                ),
                              );
                            }
                        ),

                      ],
                    ),
                  ),
            Container(
                margin: EdgeInsets.only(top: 2,left: 5,right: 5),
                padding: EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: new BorderRadius.circular(10)),
                child:
                Column(
                  children: <Widget>[
                    StreamBuilder(
                        stream: Firestore.instance.collection(path1x).document(path2x).collection(path3x).snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return new Text("Loading");
                          }
                          DocumentSnapshot products = snapshot.data.documents[int.parse(path4x)];

                          //var userDocument = snapshot.data;

                          // picture1[index] = userDocument["pic1"];
                          return     Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(7),

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
                        stream: Firestore.instance.collection(path1x).document(path2x).collection(path3x).snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return new Text("Loading");
                          }
                          DocumentSnapshot products = snapshot.data.documents[int.parse(path4x)];

                          // var userDocument = snapshot.data;

                          // picture1[index] = userDocument["pic1"];
                          return Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(7),

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
                            stream: Firestore.instance.collection(path1x).document(path2x).collection(path3x).snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return new Text("Loading");
                              }
                              DocumentSnapshot products = snapshot.data.documents[int.parse(path4x)];

                              //  var userDocument = snapshot.data;
                              // picture1[index] = userDocument["pic1"];

                              var price =  int.parse(products["price"]);
                              assert(price is int);
                              var offer = int.parse(products["offer"]);
                              assert(offer is int);
                              var finalprice = (price*offer)/100;
                              var finalpricexx = price-finalprice;
                              var finalpricexxx=  finalpricexx.round();

                              finalpricez=finalpricexxx.toString();

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
                            stream: Firestore.instance.collection(path1x).document(path2x).collection(path3x).snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return new Text("Loading");
                              }
                              DocumentSnapshot products = snapshot.data.documents[int.parse(path4x)];

                              // var userDocument = snapshot.data;
                              originalpricez=products["price"];
                              return  Container(
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
                            stream: Firestore.instance.collection(path1x).document(path2x).collection(path3x).snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return new Text("Loading");
                              }
                              DocumentSnapshot products = snapshot.data.documents[int.parse(path4x)];

                              //  var userDocument = snapshot.data;
                              // picture1[index] = userDocument["pic1"];
                              return   Container(
                                padding: EdgeInsets.only(left: 10),
                                margin: EdgeInsets.only(right: 25),

                                child: Text(products["offer"]+"%off",style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,

                                ),
                                ),
                              );
                            }
                        ),
                        Icon(Icons.star,color: Colors.green,),
                        Text("4.5",style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,

                        ),
                        ),


                      ],
                    ),
                  ],
                )


            ),



                SizeQtyColorCard(path3),

                Center(
                  child: Container(
                    width: 300.0,
                    height: 50.0,
                    margin: EdgeInsets.only(top: 30.0, bottom: 15),
                    child: RaisedButton(
                      color: Color(0xFFceced8),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15),
                          side: BorderSide(color: Color(0xFFceced8))),
                      onPressed: () {
                        var sizex=size.text;
                        var qtyx=qty.text;
                        if(sizex.isEmpty || qtyx.isEmpty){
                          Fluttertoast.showToast(msg:"Select a size and qty",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Colors.teal,textColor: Colors.white);
                        }
                        else if(pic1==null || pic2==null || pic3==null || pic4==null){
                          Fluttertoast.showToast(msg:"Rendering. wait",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_LONG,
                              backgroundColor: Colors.teal,textColor: Colors.white);
                        }
                        else{
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => CheckoutPage(pic1: pic1,pic2: pic2,pic3: pic3,pic4: pic4,name1: name1,
                            name2: name2,oprice: originalpricez,fprice: finalpricez,offer: offer,username: mailx,size: sizex,qty: qtyx,)));
                        }

                      },
                      child: Text('Buy Now', style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),

            Center(
              child: Container(
                width: 300.0,
                height: 50.0,
                margin: EdgeInsets.only(top: 15.0, bottom: 20),
                child: RaisedButton(
                  color: Color(0xFFceced8),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15),
                      side: BorderSide(color: Color(0xFFceced8))),
                  onPressed: () async {
                    await pr.show();
                    pr =  ProgressDialog(context,type: ProgressDialogType.Download, isDismissible: false, showLogs: true);
                    var sizex=size.text;
                    var qtyx=qty.text;
                    if(sizex.isEmpty || qtyx.isEmpty){
                      Fluttertoast.showToast(msg: "Select a size and qty",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
                          backgroundColor: Colors.teal,textColor: Colors.white);

                    }
                    else{
                      for(int i=0;i<11;i++){

                        final snapShot =  await Firestore.instance.collection(mailx).document("Cartinfo").collection("Cartx").document("a"+i.toString()).get();

                        if (snapShot.exists){
                          //it exists
                        }
                        else if(i==10){
                          Fluttertoast.showToast(msg: "Cart is full",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Colors.teal,textColor: Colors.white);
                          break;
                        }
                        else{
                          databaseReference.collection(mailx).document("Cartinfo").collection("Cartx").document("max").setData({
                            'length': i+1,

                          });
                          databaseReference.collection(mailx).document("Cartinfo").collection("Cartx").document("a"+i.toString()).setData({
                            "path1":path1x,
                            "path2":path2x,
                            "path3":path3x,
                            "path4":path4x,
                            "size":sizex,
                            "qty":qtyx,
                          });

                          Fluttertoast.showToast(msg: "Item Added successfully",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Colors.teal,textColor: Colors.white);

                          break;
                        }

                      }
                    }
//            Navigator.of(context)
//                .push(MaterialPageRoute(builder: (context) => CheckoutPage()));
                    await pr.hide();

                  },
                  child: Text('Add to Cart', style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),

                AboutThisItem(),
              ],
            ),
          ),
        )
    );
  }

}




class SizeQtyColorCard extends StatelessWidget{
  var catgory;
  SizeQtyColorCard(String path3){
    catgory=path3;
    if(path3=="Shoes"){
      catgory="Shoes";
    }
    else if(path3=="Watches"){
      catgory="Watches";

    }
    else{
      catgory="Watches";
    }

  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 160,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: new BorderRadius.circular(10)),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10),
            width: 125,
             child: Column(

              //size column
              children: <Widget>[
                Text("size",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w700,fontFamily: "Raleway"),),
                Container(
                  height:35,width:80,
                  decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: new BorderRadius.circular(10)),
                  margin: EdgeInsets.only(top: 15,bottom: 10),
                  alignment: Alignment.center,
                  child:   TextField(
                    controller: size,
                    textAlign: TextAlign.center,
                    readOnly: true,
                    style: TextStyle(fontWeight: FontWeight.w700,fontFamily: "Raleway",fontSize: 20,color: Colors.white),
                    decoration: InputDecoration(border: InputBorder.none,),
                    //readOnly: true,
                  ),
                 // Text("S",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w700,fontFamily: "Raleway"),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        size.text="6";
                      },
                      child: Container(
                        width: 30,
                        height: 25,
                        alignment: Alignment.center ,
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: new BorderRadius.circular(10)),
                        child: Text("6",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w700,fontFamily: "Raleway"),),),
                    ),
                    GestureDetector(
                      onTap: (){
                        size.text="7";
                      },
                      child: Container(
                        width: 30,
                        height: 25,
                        alignment: Alignment.center ,
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: new BorderRadius.circular(10)),
                        child: Text("7",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w700,fontFamily: "Raleway"),
                        ),),
                    ),


                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        size.text="8";
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        width: 30,
                        height: 25,
                        alignment: Alignment.center ,
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: new BorderRadius.circular(10)),
                        child:  Text("8",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w700,fontFamily: "Raleway"),
                        ),),
                    ),
                    GestureDetector(
                      onTap: (){
                        size.text="9";
                      },
                      child: Container(
                        width: 30,
                        height: 25,
                        margin: EdgeInsets.only(top: 10),
                        alignment: Alignment.center ,
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: new BorderRadius.circular(10)),
                        child:   Text("9",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w700,fontFamily: "Raleway"),
                        ),),
                    ),


                  ],
                ),

              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
             child: Column(

              //size column
              children: <Widget>[
                Text("color",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w700,fontFamily: "Raleway"),),
                Container(height:70,width:90,
                  decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: new BorderRadius.circular(15)),
                  margin: EdgeInsets.only(top: 15,bottom: 10),
                  alignment: Alignment.center,
                  child: Text("default",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w700,fontFamily: "Raleway"),
                  ),),
                Text(" other colors",style: TextStyle(decoration:TextDecoration.underline,fontSize: 15,color: Colors.blueAccent,fontWeight: FontWeight.w700,fontFamily: "Raleway"),),


              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            width: 125,
            child: Column(

              //size column
              children: <Widget>[
                Text("qty",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w700,fontFamily: "Raleway"),),
                Container(height:35,width:80,
                  decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: new BorderRadius.circular(15)),
                  margin: EdgeInsets.only(top: 15,bottom: 10),
                  alignment: Alignment.center,
                  child:  TextField(
                    controller: qty,
                    textAlign: TextAlign.center,
                    readOnly: true,
                    style: TextStyle(fontWeight: FontWeight.w700,fontFamily: "Raleway",fontSize: 20,color: Colors.white),
                    decoration: InputDecoration(border: InputBorder.none,),
                    //readOnly: true,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                    GestureDetector(
                      onTap: (){
                        qty.text="1";
                      },
                      child:  Container(
                        width: 30,
                        height: 25,
                        alignment: Alignment.center ,
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: new BorderRadius.circular(10)),
                        child:  Text("1",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w700,fontFamily: "Raleway"),
                        ),),
                    ),
                    GestureDetector(
                        onTap: (){
                          qty.text="2";
                        },
                      child:     Container(
                        width: 30,
                        height: 25,
                        alignment: Alignment.center ,
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: new BorderRadius.circular(10)),
                        child: Text("2",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w700,fontFamily: "Raleway"),
                        ),),

                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: <Widget>[
                    GestureDetector(
                        onTap: (){
                          qty.text="3";
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          width: 30,
                          height: 25,
                          alignment: Alignment.center ,
                          decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: new BorderRadius.circular(10)),
                          child:  Text("3",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w700,fontFamily: "Raleway"),
                          ),),
                    ),
                    GestureDetector(
                        onTap: (){
                          qty.text="4";
                        },
                        child:  Container(
                          width: 30,
                          height: 25,
                          margin: EdgeInsets.only(top: 10),
                          alignment: Alignment.center ,
                          decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: new BorderRadius.circular(10)),
                          child:   Text("4",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w700,fontFamily: "Raleway"),
                          ),),
                    ),


                  ],
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }

}



class AboutThisItem extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 200 ,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: new BorderRadius.circular(10)),

      child: Text("About this Item",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
    );
  }

}