import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tailored_cases/widgets/category.dart';
import './products.dart';
import '../screens/home.dart';

class Shops extends StatefulWidget {

  String categoryId;

Shops({this.categoryId});
  @override
  _ShopsState createState() => _ShopsState();
}

class _ShopsState extends State<Shops> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shops in this category'),
      ),
      body: Container(child: shopScroll(context, widget.categoryId)),
    );
  }
}




Widget shopScroll(BuildContext context, String id) {

//this logic to be changed later on

List<DocumentSnapshot> availableShops = products.where((i){return i.data["category"]==id?? true; }).toList();

  final scroll = SingleChildScrollView(
    scrollDirection: Axis.vertical,
    physics: BouncingScrollPhysics(),
    child: Column(
      children: availableShops.map((i) => shopTile(context , i: i)).toList(),
    ),
  );
  return scroll;
}

//future changes here
double size = 90;

Widget shopTile(BuildContext context ,{DocumentSnapshot i}) {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Products( shop: i.data["shop"], category: i.data["category"])));
        },
              child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
           // Hero(
            //  tag: image,
             // child:
               Container(
                height: size,
                width: size,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white
                  ),
                  image: DecorationImage(
                    image: AssetImage("images/tc.jpg"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                            offset: Offset(0.2, 1.0),
                            blurRadius: 2,
                            color: Colors.black.withOpacity(0.9))
                      ]
                ),
              ),
          //  ),
            Container(
              width: 80,
              height: 20,
              margin: EdgeInsets.only(top: 5),
              child: Text(
                i.data["shop"],
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 13,
                    //fontFamily: "OpenSans",
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.9)),
              ),
            ),
          ],
        ),
      ),
    );}