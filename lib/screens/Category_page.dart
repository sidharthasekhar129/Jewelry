import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

import 'ProductsList.dart';

class CategoryPage extends KFDrawerContent {
  final menORwomen;
  final mail;

  CategoryPage({Key key, this.menORwomen,this.mail})  ;
  @override
  _CategoryPageState createState() => _CategoryPageState(menORwomen,mail);
}

class _CategoryPageState extends State<CategoryPage> {
  List<String> category1=["Pendent","Bracelet","Chain","Rings","G/D Watch"];
  String menORwomenx;
  String username;
  _CategoryPageState(String menORwomen,String  mail){
    menORwomenx=menORwomen;
    username=mail;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.only(bottom: 20),

          child: Column(
            children: [
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
                            color: Colors.black,
                          ),
                          onPressed: widget.onMenuPressed,
                        ),
                      ),
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width-120,
                      alignment: Alignment.center,
                      child:  Text("Category", style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Spectral",
                      ),)
                  ),

                ],
              ),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  StreamBuilder(
                      stream: Firestore.instance.collection("Category").document("Icondata").collection(menORwomenx).document("a0").snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return new Text("Loading");
                        }
                        var userDocument = snapshot.data;
                     //   length = userDocument["length"];
                        return GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductsList(menORwomen: menORwomenx,
                                Categorypath: "Pendent",mail: username,)));
                            },
                            child: Shoescard(category1[0],userDocument["pic1"]));

                      }
                  ),
                  StreamBuilder(
                      stream: Firestore.instance.collection("Category").document("Icondata").collection(menORwomenx).document("a1").snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return new Text("Loading");
                        }
                        var userDocument = snapshot.data;
                        //   length = userDocument["length"];
                        return GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductsList(menORwomen: menORwomenx,
                                Categorypath: "Bracelet",mail: username,)));
                            },
                            child: Shoescard(category1[1],userDocument["pic1"]));

                      }
                  ),
                 ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  StreamBuilder(
                      stream: Firestore.instance.collection("Category").document("Icondata").collection(menORwomenx).document("a2").snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return new Text("Loading");
                        }
                        var userDocument = snapshot.data;
                        //   length = userDocument["length"];
                        return GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductsList(menORwomen: menORwomenx,
                                Categorypath: "Chain",mail: username,)));
                            },
                            child: Shoescard(category1[2],userDocument["pic1"]));

                      }
                  ),
                  StreamBuilder(
                      stream: Firestore.instance.collection("Category").document("Icondata").collection(menORwomenx).document("a3").snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return new Text("Loading");
                        }
                        var userDocument = snapshot.data;
                        //   length = userDocument["length"];
                        return GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductsList(menORwomen: menORwomenx,
                                Categorypath: "Ring",mail: username,)));
                            },
                            child: Shoescard(category1[3],userDocument["pic1"]));

                      }
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  StreamBuilder(
                      stream: Firestore.instance.collection("Category").document("Icondata").collection(menORwomenx).document("a4").snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return new Text("Loading");
                        }
                        var userDocument = snapshot.data;
                        //   length = userDocument["length"];
                        return GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductsList(menORwomen: menORwomenx,
                                Categorypath: "GDWatch",mail: username,)));
                            },
                            child: Shoescard(category1[4],userDocument["pic1"]));

                      }
                  ),

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
class Shoescard extends StatelessWidget{

 String  pic;
 String name;
  Shoescard(String category1, userDocument){
    name=category1;
    pic=userDocument;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      height: 120,
      width: 160,
       margin: EdgeInsets.only(top: 10),
     //  alignment: Alignment.topLeft,
       decoration: BoxDecoration(
          color: Colors.black45,
          borderRadius: new BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          )
      ),
      child: Stack(
        children: <Widget>[

          Positioned(
            top: 65,
              left: 20,
              child: Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                alignment: Alignment.center,
                // padding: EdgeInsets.all(10),
                child: Text(name,textDirection: TextDirection.ltr,
                  style: TextStyle(decoration: TextDecoration.none,
                    fontSize: 20,
                    color: Color(0xff0f4c81),
                    fontFamily: "Spectral",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
          ),
          Positioned(
              top: 15,
              left: 50,
              child:Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  //borderRadius: new BorderRadius.all(Radius.circular(30)),
                ),
                height: 60,
                width: 60,
                padding: EdgeInsets.all(10),
                child:   Image.network(pic),

              ),
          ),
        ],
      ),
    );
  }
}

