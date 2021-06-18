import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../screens/product_details.dart';


//---------------------------product tile----------------------------

double l=150, b = 120;
Widget productTile(BuildContext context, DocumentSnapshot product) {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
      child: GestureDetector(
        onTap: (){
          print("clicked");
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetails(product:product)));
        },
              child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
           // Hero(
            //  tag: image,
             // child:
               Container(
                height: l,
                width: b,
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
              height: 15,
              margin: EdgeInsets.only(top: 5),
              child: Text(
                product.documentID,
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
    );
}