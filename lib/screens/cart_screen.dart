
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:snehal_gems/main.dart';
 var length=0;
var path1,path2,path3,path4;

class CartScreen extends KFDrawerContent {
  String username = "";

  CartScreen({Key key, this.username})  ;
  @override
  _CartScreenState createState() => _CartScreenState(username);
}

class _CartScreenState extends State<CartScreen> {

  ProgressDialog pr;

  String username;
  _CartScreenState(String usernamex){
    username=usernamex;
  }
  int total=0;
  bool isready=false;
   @override
  Widget build(BuildContext context) {
     AssetImage assetImage = AssetImage("assets/emptyorder.png");
     Image image = Image(
       image: assetImage,
     );

    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            StreamBuilder(
                stream: Firestore.instance.collection(username).document("Cartinfo").collection("Cartx").document("max").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return new Text("Loading");
                  }
                  var userDocument = snapshot.data;
                  length = userDocument["length"];
                  return   IconButton(
                    icon: Icon(Icons.delete_forever),
                    onPressed: (){
                      deleteData(username,length);
                      Fluttertoast.showToast(msg:"Item(s) deleted",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
                          backgroundColor: Colors.teal,textColor: Colors.white);

                    },
                  );
                }
            ),

          ],
          title: Text("Cart"),backgroundColor: Color(0xff0f4c81),
        ),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Container(
            child: Column(
              children: <Widget>[
                StreamBuilder(
                    stream: Firestore.instance.collection(username).document("Cartinfo").collection("Cartx").document("max").snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return new Text("Loading");
                      }
                      var userDocument = snapshot.data;
                      length = userDocument["length"];
                      return Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.all(7),
                        child: Text(
                          "You have " + userDocument["length"].toString() + " items in your Cart", maxLines: 1,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }
                ),

                StreamBuilder(
                    stream: Firestore.instance.collection(username).document("Cartinfo").collection("Cartx").document("max").snapshots(),
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
                              fontFamily: "Raleway",fontSize: 20,fontWeight: FontWeight.w600,
                            ),),

                            Container(
                              width: 300.0,
                              height: 50.0,
                              margin: EdgeInsets.only(top: 30.0, bottom: 15),
                              child: RaisedButton(
                                color: Color(0xff0f4c81),
                                shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(15),
                                    side: BorderSide(color: Color(0xFFceced8))),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainWidget(username: username,)));
                                },
                                child: Text('Continue shopping', style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Raleway",
                                    fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
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

                                              stream: Firestore.instance.collection(username).document("Cartinfo").collection("Cartx").snapshots(),
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

                                                      total=total+finalpricexxx;



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
                            Container(
                              width: 300.0,
                              height: 50.0,
                              margin: EdgeInsets.only(top: 30.0, bottom: 15),
                              child: RaisedButton(
                                color: Color(0xff0f4c81),
                                shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(15),
                                    side: BorderSide(color: Color(0xFFceced8))),
                                onPressed: () {
                                  //Navigator.of(context).pop();
                                  //Pricecal(totalx: total,);
                                  if(!isready){
                                    setState(() {
                                      isready=true;
                                    });
                                  }
                                  else{
                                    Fluttertoast.showToast(msg: "Already in updated state",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
                                  }


                                },
                                child: Text('Calculate  total', style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Raleway",
                                    fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            isready ? Pricecal(totalx: total,) :Container(),


                          ],
                        );

                      }


                    }),

              ],
            ),
          ),
        ),
     // bottomNavigationBar: CheckoutCard(total),
    );
  }
  void deleteData(String mail, int length) {

    try {
      for(int i=0;i<=length-1;i++){

        Firestore.instance.collection(mail).document("Cartinfo").collection("Cartx").document("a"+i.toString()).delete();


      }


      Firestore.instance.collection(mail).document("Cartinfo").collection("Cartx").document("max").setData({
        'length': 0,

      });

      setState(() {

      });

    } catch (e) {
      print(e.toString());
    }
  }
}



class CheckoutCard extends StatelessWidget {
  int pay;
   CheckoutCard(int total) {
    pay=total;
  }


  @override
  Widget build(BuildContext context) {

    Widget _submitButton() {
      return GestureDetector(
        onTap: () {

        },
        child: Container(

        width: 150,
          height: 45,
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
                  colors: [Color(0xfffbb448), Color(0xfff7892b)])
          ),
          child: Text(
            'Proceed to pay',
            style: TextStyle(fontSize: 20, color: Colors.white,fontFamily: "Spectral",fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
    return Container(
      padding: EdgeInsets.all(10),
        height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child:  Image.asset("assets/emptyorder.png",height: 35,width: 35,),

                  //SvgPicture.asset("assets/icons/receipt.svg"),
                ),
                Spacer(),
                Text("Add voucher code",style: TextStyle(color: Colors.blue[900]),),
                const SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color:  Colors.blue[900],
                )
              ],
            ),
            SizedBox(height:15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total:\n",style: TextStyle(fontFamily: "Spectral",fontWeight: FontWeight.w500),
                    children: [
                      TextSpan(
                        text: "\₹"+pay.toString(),
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 190,
                  child: _submitButton()
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class Pricecal extends StatelessWidget{

  final totalx;

  const Pricecal({Key key, this.totalx}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      height: 280,
      width: 350,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black38,
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(7),
            alignment: Alignment.topLeft,
            child: Text("Price Details",
              style: TextStyle(
                  fontFamily: "Raleway",
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(7),
                child: Text("Price: " + length.toString()+ " items",
                  style: TextStyle(
                      fontFamily: "Raleway",
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                padding: EdgeInsets.all(7),
                child: Text((totalx/2).toString(),
                  style: TextStyle(
                      fontFamily: "Raleway",
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(7),
                child: Text("Delivery charge ",
                  style: TextStyle(
                      fontFamily: "Raleway",
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                padding: EdgeInsets.all(7),
                child: Text("+00",
                  style: TextStyle(
                      fontFamily: "Raleway",
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Divider(
            height: 20,
            thickness: 1,
            color: Colors.white,
            endIndent: 20,
            indent: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(7),
                child: Text("Grand Total ",
                  style: TextStyle(
                      fontFamily: "Raleway",
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                padding: EdgeInsets.all(7),
                child: Text((totalx/2).toString(),
                  style: TextStyle(
                      fontFamily: "Raleway",
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Container(
            width: 300.0,
            height: 50.0,
            margin: EdgeInsets.only(top: 30.0, bottom: 15),
            child: RaisedButton(
              color: Color(0xff0f4c81),
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15),
                  side: BorderSide(color: Colors.white)),
              onPressed: () {
//                Fluttertoast.showToast(msg:"Payment gateway is not implemented",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
//                    backgroundColor: Colors.teal,textColor: Colors.white);

              //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentScreen(amount: (totalx/2).toString(),)));

              },
              child: Text('Proceed to pay',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );

  }

}
 