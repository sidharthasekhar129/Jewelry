
import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:intl/intl.dart';
TextEditingController address=new TextEditingController();
TextEditingController newaddress=new TextEditingController();



class CheckoutPage extends StatefulWidget{
  final pic1,pic2,pic3,pic4,name1,name2,oprice,fprice,offer,username,size,qty;


  CheckoutPage({Key key, this.pic1,this.pic2,this.pic3,this.pic4,this.name1,this.name2,this.oprice,this.fprice,this.offer,
    this.username,this.size,this.qty}) : super(key: key);

  @override
    _CheckoutPageState createState() => _CheckoutPageState(pic1,pic2,pic3,pic4,name1,name2,oprice,fprice,offer,username,size,qty);
}
class _CheckoutPageState extends State<CheckoutPage>{
  ProgressDialog pr;
  String pic1x,pic2x,pic3x,pic4x,name1x,name2x,opricex,fpricex,offerx,sizex,qtyx,usernamex;



  _CheckoutPageState(String pic1,String pic2,String pic3,String pic4,String name1,String name2,
      String oprice,String fprice,String offer,String mail,size,qty){
    pic1x=pic1;
    pic2x=pic2;
    pic3x=pic3;
    pic4x=pic4;
    name1x=name1;
    name2x=name2;
    opricex=oprice;
    fpricex=fprice;
    offerx=offer;
    usernamex=mail;
    sizex=size;
    qtyx=qty;
  }

  int group =0;
  int group2 =0;
  bool a=false,b=false;

  bool isok=false;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    pr = new ProgressDialog(context);
    pr.style(
        message: 'Processing..', borderRadius: 10.0, backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(), elevation: 10.0, insetAnimCurve: Curves.easeInOut,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600)
    );

    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    String date = dateFormat.format(DateTime.now());
    return Scaffold(
      appBar: AppBar(title: Text("Checkout"),backgroundColor: Color(0xff0f4c81),),
      body: SingleChildScrollView(
        child: Container(
           padding: EdgeInsets.only(left: 8,top: 7,right: 8),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: Text("Select A Delivery A ddress",style: TextStyle(fontFamily: "Raleway",fontSize: 20,fontWeight: FontWeight.w700,color: Colors.black87),),
              ),
              Row(
                children: <Widget>[
                  Radio(value: 1, groupValue: group, onChanged:(T){a=true;b=false;setState(() {group=T;});},),
                  Text("Use Primary/Home Address",style: TextStyle(fontFamily: "Raleway",fontSize: 17,fontWeight: FontWeight.w700,color: Colors.black87),),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(value: 2, groupValue: group, onChanged:(T){b=true;a=false;isok=true;setState(() {group=T;});},),
                  Text("Use A New Address",style: TextStyle(fontFamily: "Raleway",fontSize: 17,fontWeight: FontWeight.w700,color: Colors.black87),),
                ],
              ),

               a ? StreamBuilder(
                   stream: Firestore.instance.collection(usernamex).document('PersonalInfo').snapshots(),
                   builder: (context, snapshot) {
                     if (!snapshot.hasData) {
                       return new Text("Loading");
                     }
                     var userDocument = snapshot.data;
                     String addressx=userDocument["address1"];
                     // picture1[index] = userDocument["pic1"];

                     if(addressx.length!=0){
                       address.text=addressx;
                       isok=true;
                       return  Container(
                         height: 220,
                         padding: EdgeInsets.all(7),
                         decoration: BoxDecoration(
                           border:Border.all(color: Colors.black54) ,
                           borderRadius: BorderRadius.all(Radius.circular(20)),
                         ),
                         width: MediaQuery.of(context).size.width,
                         child:  TextField(
                           controller: address,
                           maxLines: 10,
                           readOnly: true,
                           maxLength: 300,
                           style: TextStyle(fontWeight: FontWeight.w600,fontFamily: "Raleway",fontSize: 18,color: Colors.black54),
                           decoration: InputDecoration(border: InputBorder.none,),
                           //readOnly: true,
                         ),
                       );
                     }
                     else{
                       Fluttertoast.showToast(msg: "Address not found",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
                       backgroundColor: Colors.teal,textColor: Colors.white);

                       isok=false;
                       return Container(
                         padding: EdgeInsets.all(10),
                         decoration: BoxDecoration(
                           border:Border.all(color: Colors.black54) ,
                           borderRadius: BorderRadius.all(Radius.circular(20)),
                         ),
                         child: Text("Address not Found"),
                       );
                     }

                   }
               ):Container(),
              b ? Container(
                height: 220,
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                  border:Border.all(color: Colors.black54) ,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                width: MediaQuery.of(context).size.width,
                child:  TextField(
                  controller: newaddress,
                  maxLines: 10,
                  readOnly: false,

                  maxLength: 300,
                  style: TextStyle(fontWeight: FontWeight.w600,fontFamily: "Raleway",fontSize: 18,color: Colors.black54),
                  decoration: InputDecoration(border: InputBorder.none,hintText: "Give the address as accurate as possible",hintStyle:
                  TextStyle(color: Colors.black38)),
                  //readOnly: true,
                ),
              ):Container(),
              Container(
                alignment: Alignment.topLeft,
                child: Text("Select A Payment Type",style: TextStyle(fontFamily: "Raleway",fontSize: 20,fontWeight: FontWeight.w700,color: Colors.black),),
              ),
              Row(
                children: <Widget>[
                  Radio(value: 1, groupValue: group2, onChanged:(T){
                    setState(() {
                      group2=T;
                    });
                    },),
                  Text("UPI",style: TextStyle(fontFamily: "Raleway",fontSize: 17,fontWeight: FontWeight.w700,color: Colors.black87),),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(value: 2, groupValue: group2, onChanged:(T){setState(() {group2=T;});},),
                  Text("Debit/Credit Card",style: TextStyle(fontFamily: "Raleway",fontSize: 17,fontWeight: FontWeight.w700,color: Colors.black87),),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(value: 3, groupValue: group2, onChanged:(T){setState(() {group2=T;});},),
                  Text("Net Banking",style: TextStyle(fontFamily: "Raleway",fontSize: 17,fontWeight: FontWeight.w700,color: Colors.black87),),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(value: 4, groupValue: group2, onChanged:(T){setState(() {group2=T;});},),
                  Text("Pay on Delivery",style: TextStyle(fontFamily: "Raleway",fontSize: 17,fontWeight: FontWeight.w700,color: Colors.black87),),
                ],
              ),
              Text("Note: We use RazorPay payment Gateway for online payment services.",style: TextStyle(fontFamily: "Raleway",fontSize: 15,fontWeight: FontWeight.w700,color: Colors.black87),),

              StreamBuilder(
                  stream: Firestore.instance.collection(usernamex).document('Orderinfo').collection("Points").document("max").snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return new Text("Loading");
                    }
                    var userDocumentx = snapshot.data;
                    // picture1[index] = userDocumentx["pic1"];
                    return  Container(
                      width: 300.0,
                      height: 50.0,
                      margin: EdgeInsets.only(top: 30.0, bottom: 15),
                      child: RaisedButton(
                        color: Color(0xff0f4c81),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15),
                            side: BorderSide(color: Color(0xFFceced8))),
                        onPressed: () async {

                          if(!a & !b){
                            Fluttertoast.showToast(msg: "Select an Address",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
                                backgroundColor: Colors.teal,textColor: Colors.white);
                          }
                          else  if(group2==0){
                            Fluttertoast.showToast(msg: "Select a Payment",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
                                backgroundColor: Colors.teal,textColor: Colors.white);
                          }
                          else if(!isok){
                            Fluttertoast.showToast(msg: "Give an Address",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT,
                                backgroundColor: Colors.teal,textColor: Colors.white);
                          }
                          else {
                            //openCheckout();



                            await pr.show();
                            pr =  ProgressDialog(context,type: ProgressDialogType.Download, isDismissible: false, showLogs: false);
                            // Do something when payment succeeds
                            //  Fluttertoast.showToast(msg: "Paymet was successful", backgroundColor: Colors.deepPurpleAccent,textColor: Colors.white,toastLength: Toast.LENGTH_SHORT);


                            if(sizex.isEmpty || qtyx.isEmpty){
                              Fluttertoast.showToast(msg:"Session expired",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_LONG);
                              await pr.hide();
                            }
                            else{

                              for(int i=0;i<16;i++){

                                final snapShot =  await Firestore.instance.collection(usernamex).document("Orderinfo").collection("Orderx").document("a"+i.toString()).get();

                                if (snapShot.exists){
                                  //it exists
                                }
                                else if(i==15){
                                  await pr.hide();
                                  Fluttertoast.showToast(msg:"Your Orderlist is full",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_LONG);
                                  break;
                                }
                                else{

                                  //DateTime dateTime = dateFormat.parse("2019-07-19 8:40:23");
                                  await Firestore.instance.collection(usernamex).document("Orderinfo").collection("Orderx").document("a"+i.toString()).setData({
                                    "pic1":pic1x,
                                    "pic2":pic2x,
                                    "pic3":pic3x,
                                    "pic4":pic4x,
                                    "name1":name1x,
                                    "name2":name2x,
                                    "oprice":opricex,
                                    "fprice":fpricex,
                                    "offer":offerx,
                                    "size":sizex,
                                    "qty":qtyx,
                                    "orderid":"ajiirazor1334",
                                    "paymentid":"dartok45we4r",
                                    "date": date,
                                    "status":"not yet delivered"

                                  });
                                  await Firestore.instance.collection(usernamex).document("Orderinfo").collection("Orderx").document("max").setData({
                                    'length': i+1,

                                  });
                                  await Firestore.instance.collection(usernamex).document("Orderinfo").collection("Points").document("max").setData({
                                    'length': i+1+1,
                                    "total": userDocumentx["total"]+20,

                                  });
                                  await Firestore.instance.collection(usernamex).document("Orderinfo").collection("Points").document("a"+(i+1).toString()).setData({
                                    'date': date,
                                    "value": "20",
                                    "msg":"purchase",

                                  });

                                  await pr.hide();
                                  //Fluttertoast.showToast(msg:"Order placed successfully",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_LONG);
//                                  showDialog(
//                                      barrierDismissible: false,
//                                      context: context,
//                                      builder: (context){
//                                        return AlertDialog(
//                                          title: Text("Congrats",style: TextStyle(color: Colors.white,fontSize: 20),),
//                                          content: Text("Your Order is placed ",style: TextStyle(color: Colors.white,fontSize: 17),),
//                                          actions: <Widget>[
//                                            FlatButton( onPressed: (){
//                                              Navigator.pop(context);
//                                            },
//                                              child: Text("Cancel",style: TextStyle(color: Colors.white,fontSize: 17),),),
//                                            FlatButton(onPressed: () async {
//                                              Navigator.pop(context);
//                                              //Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyOrdersPage()));
//
//                                            },child: Text("Ok",style: TextStyle(color: Colors.white,fontSize: 17),),),
//                                          ],
//                                          elevation: 24.0,
//                                          backgroundColor: Colors.blue,
//                                        );
//                                      }
//                                  );
                                  Fluttertoast.showToast(msg:"Order placed Sucessfully",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_LONG);

                                  break;
                                }

                              }
                              Navigator.of(context).pop();
                            }


                          }
                        },
                        child: Text('Proceed to pay', style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.w600),
                        ),
                      ),
                    );
                  }
              ),

            ],
          ),
        ),
      )
    );
  }


}




//Razorpay _razorpay;





//  @override
//  void initState() {
//    _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//
//  }
//
//
//@override
//  void dispose() {
//    //  implement dispose
//  _razorpay.clear();
//    super.dispose();
//  }
//  void openCheckout() async{
//
//    var options = {
//      'key': 'rzp_test_xOKKY8ZzGKJIFR',
//      'amount': 10000, //in the smallest currency sub-unit.
//      'name': 'Cornerstore.Inc',
//     // 'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
//      'description': 'Fine T-Shirt',
//      'prefill': {
//        'contact': '811461397',
//        'email': 'tina.sekhar@example.com'
//      }
//    };
//
//    try{
//      _razorpay.open(options);
//    }
//    catch(e){
//      debugPrint(e);
//    }
//
//  }
//
//  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
//
//
//  }
//
//  void _handlePaymentError(PaymentFailureResponse response) {
//    // Do something when payment fails
//    Fluttertoast.showToast(msg: "Some error occurd",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
//
//  }
//
//  void _handleExternalWallet(ExternalWalletResponse response) {
//   // Fluttertoast.showToast(msg: "Paymet was successful",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
//
//  }