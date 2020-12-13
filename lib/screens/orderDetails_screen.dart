
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:slimy_card/slimy_card.dart';
class OrderDetailsPage extends StatelessWidget{

  String username;
  int indexno;

  OrderDetailsPage({Key key, this.username,this.indexno}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement buildj
    return Scaffold(
        appBar: AppBar(title: Text("Order Details") ,backgroundColor: Color(0xff0f4c81)
        ,),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 5,top: 8),
                  child: Text("Order Details",style: TextStyle(fontFamily: "Raleway",fontWeight: FontWeight.w700,fontSize: 20,color: Colors.black),),
                ),
                orderdetails(username,indexno),

                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 5,top: 8),
                  child: Text("Shipment Details ",style: TextStyle(fontFamily: "Raleway",fontWeight: FontWeight.w700,fontSize: 20,color: Colors.black),),
                ),
                ShipmentDetails(username,indexno),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 5,top: 8),
                  child: Text("Shipment Address",style: TextStyle(fontFamily: "Raleway",fontWeight: FontWeight.w700,fontSize: 20,color: Colors.black),),
                ),
                ShipmentAddress(username ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 5,top: 8),
                  child: Text("Order Summary",style: TextStyle(fontFamily: "Raleway",fontWeight: FontWeight.w700,fontSize: 20,color: Colors.black),),
                ),
                OrderSummary(username,indexno),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 5,top: 8),
                  child: Text("Reward on this order",style: TextStyle(fontFamily: "Raleway",fontWeight: FontWeight.w700,fontSize: 20,color: Colors.black),),
                ),
                Container(
                  width: 330,
                  height: 30,
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.teal,)
                  ),
                  padding: EdgeInsets.only(left: 5, ),
                  child: Text("20 points",style: TextStyle(fontFamily: "Raleway" ,fontSize: 18 ),),
                ),
              ],
            ),
          ),
        )
    );
  }

}

class orderdetails extends StatelessWidget{
  var usernamex;
  int indexz;
  orderdetails(String username,int index){
    usernamex=username;
    indexz=index;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 130,
      width: 330,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(

        border: Border.all(color: Colors.teal),
        color: Colors.black,
      ),
      child: Column(
        children: <Widget>[
          StreamBuilder(
              stream: Firestore.instance.collection(usernamex).document("Orderinfo").collection("Orderx").document("a"+indexz.toString()).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return new Text("Loading");
                }
                var userDocument = snapshot.data;
                // picture1[index] = userDocument["pic1"];


                return   Container(
                  margin: EdgeInsets.only(top: 15),
                  height: 35,
                  child: Text("Date:"+userDocument["date"],style: TextStyle(fontFamily: "Raleway",fontWeight: FontWeight.w700,fontSize: 18,color: Colors.white),),

                );
              }
          ),
          StreamBuilder(
              stream: Firestore.instance.collection(usernamex).document("Orderinfo").collection("Orderx").document("a"+indexz.toString()).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return new Text("Loading");
                }
                var userDocument = snapshot.data;
                // picture1[index] = userDocument["pic1"];


                return Container(
                  height: 35,
                  child: Text("PaymentID:"+userDocument["paymentid"],style: TextStyle(fontFamily: "Raleway",fontWeight: FontWeight.w700,fontSize: 16,color: Colors.white),),
                );
              }
          ),
          StreamBuilder(
              stream: Firestore.instance.collection(usernamex).document("Orderinfo").collection("Orderx").document("a"+indexz.toString()).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return new Text("Loading");
                }
                var userDocument = snapshot.data;
                // picture1[index] = userDocument["pic1"];


                return Container(
                  height: 35,
                  child: Text("OrderID:"+userDocument["orderid"],style: TextStyle(fontFamily: "Raleway",fontWeight: FontWeight.w700,fontSize: 16,color: Colors.white),),


                );
              }
          ),



        ],
      ),
    );
  }

}
class ShipmentDetails extends StatelessWidget{
  var usernamex;
  int indexz;
  ShipmentDetails(String username,int index){
    usernamex=username;
    indexz=index;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return    StreamBuilder(
        stream: Firestore.instance.collection(usernamex).document("Orderinfo").collection("Orderx").document("a"+indexz.toString()).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          }
          var userDocument = snapshot.data;
          // picture1[index] = userDocument["pic1"];


          return Container(
            height: 270,
            width: 330,
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              //         gradient: LinearGradient(
//          begin: Alignment.topLeft,
//          end: Alignment.bottomRight,
//          colors: [
//            Colors.black38,
//            Colors.white,
//            Colors.black26
//          ]
//        ),
                border: Border.all(color: Colors.teal)
            ),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 7,top: 5),

                  alignment: Alignment.topLeft,
                  child:  Text("Shipped:",
                    style: TextStyle(fontFamily: "Raleway", fontSize: 18, fontWeight: FontWeight.w700, ),),
                ),
                Container(
                  margin: EdgeInsets.only(left: 7,top: 5,bottom: 10),
                  alignment: Alignment.topLeft,

                  child:  Text(userDocument["date"],
                    style: TextStyle(fontFamily: "Raleway", fontSize: 18, fontWeight: FontWeight.w700 ),
                  ),
                ),
                Divider(
                  thickness: 1,
                  height: 1,
                  color: Colors.teal,
                ),
                Container(
                  margin: EdgeInsets.all( 1),
                  color: Colors.black,
                  height: 110.0,
                  child: Row(
                    children: <Widget>[
                      ClipRRect(

                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(userDocument["pic1"],width: 100,height: 100,),
                      ),

                      Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            height: 25,
                            width: 200,
                            margin: EdgeInsets.only( top: 8),
                            child: Text(userDocument["name1"],
                              style: TextStyle(fontFamily: "Raleway", fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 25,
                            width: 220,
                            margin: EdgeInsets.only(top: 8),
                            child: Text("₹"+userDocument["fprice"],
                              style: TextStyle(fontFamily: "Raleway", fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,

                            height: 25,
                            width: 200,
                            margin:
                            EdgeInsets.only(top: 8),
                            child: Text("Sold: Corner Store",
                              style: TextStyle(fontFamily: "Raleway", fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 7,top: 5, ),
                  alignment: Alignment.topLeft,

                  child:  Text("Color: Default",
                    style: TextStyle(fontFamily: "Raleway", fontSize: 18, fontWeight: FontWeight.w700, ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 7,top: 5 ),
                  alignment: Alignment.topLeft,

                  child:  Text("QTY:"+userDocument["qty"],
                    style: TextStyle(fontFamily: "Raleway", fontSize: 18, fontWeight: FontWeight.w700,  ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 7,top: 5,bottom: 10),
                  alignment: Alignment.topLeft,

                  child:  Text("Size:"+userDocument["size"],
                    style: TextStyle(fontFamily: "Raleway", fontSize: 18, fontWeight: FontWeight.w700, ),
                  ),
                ),
              ],
            ),
          );
        }
    );

  }

}
class ShipmentAddress extends StatelessWidget{
  var usernamex;
  ShipmentAddress(String username ){
    usernamex=username;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
        stream: Firestore.instance.collection(usernamex).document("PersonalInfo").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          }
          var userDocument = snapshot.data;
          // picture1[index] = userDocument["pic1"];


          return Container(
            height: 180,
            width: 330,
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(

                border: Border.all(color: Colors.teal)
            ),
            child: Text(userDocument["address1"],maxLines: 10,style: TextStyle(fontFamily: "Raleway",fontSize: 18,fontWeight: FontWeight.w600),),
          );
        }
    );

  }

}
class OrderSummary extends StatelessWidget{
  var usernamex;
  int indexz;
  OrderSummary(String username,int index){
    usernamex=username;
    indexz=index;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return   StreamBuilder(
        stream: Firestore.instance.collection(usernamex).document("Orderinfo").collection("Orderx").document("a"+indexz.toString()).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          }
          var userDocument = snapshot.data;
          var a= userDocument["fprice"];
          int b=int.parse(a);
          int c=b-30;
          return Container(
            height: 200,
            width: 330,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.teal)
            ),
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Items:",style: TextStyle(fontSize: 18,fontFamily: "Raleway", ),),
                    Text(c.toString(),style: TextStyle(fontSize: 18,fontFamily: "Raleway", )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Postage and Packaging:",style: TextStyle(fontSize: 18,fontFamily: "Raleway", ),),
                    Text("+30",style: TextStyle(fontSize: 18,fontFamily: "Raleway", )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Tax:",style: TextStyle(fontSize: 18,fontFamily: "Raleway", ),),
                    Text("--",style: TextStyle(fontSize: 18,fontFamily: "Raleway", )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Total:",style: TextStyle(fontSize: 18,fontFamily: "Raleway", ),),
                    Text("+"+a.toString(),style: TextStyle(fontSize: 18,fontFamily: "Raleway", )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Promotion:",style: TextStyle(fontSize: 18,fontFamily: "Raleway", ),),
                    Text("+00",style: TextStyle(fontSize: 18,fontFamily: "Raleway", )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Delivery charge:",style: TextStyle(fontSize: 18,fontFamily: "Raleway", ),),
                    Text("+00",style: TextStyle(fontSize: 18,fontFamily: "Raleway", )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Grand Total:",style: TextStyle(fontSize: 18,fontFamily: "Raleway",fontWeight: FontWeight.w600 ),),
                    Text("+"+a.toString(),style: TextStyle(fontSize: 18,fontFamily: "Raleway",fontWeight: FontWeight.w600 )),
                  ],
                ),
              ],
            ),
          );
        }
    );

  }

}