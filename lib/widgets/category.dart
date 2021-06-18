import 'package:flutter/material.dart';
import '../screens/shops.dart';
import '../screens/home.dart';
import 'package:shimmer/shimmer.dart';

List shimmerCount = [1, 2, 3, 4];

Widget categoryScroll(BuildContext context) {
  final scroll = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Row(
        children:
        //  categories != null ? 
            categories
                .map((i) => categoryTile(context, name: i.documentID))
                .toList()
            // : shimmerCount
            //     .map((e) => Shimmer.fromColors(
            //           child: categoryTile(context, name: ""),
            //           baseColor: Colors.grey[700],
            //           highlightColor: Colors.grey[100],
            //         ))
            //     .toList(),
      ));
  return scroll;
}

//future changes here
double size = 90;

Widget categoryTile(BuildContext context, {String name}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
    child: GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Shops(
                      categoryId: name,
                    )));
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
                border: Border.all(color: Colors.white),
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
                ]),
          ),
          //  ),
          Container(
            width: 90,
            height: 20,
            margin: EdgeInsets.only(top: 5),
            child: Text(
              name,
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

// List shimmerCategory(BuildContext context, int i) {
//   return Shimmer.fromColors(
//     baseColor: Colors.grey[700],
// highlightColor: Colors.grey[100],
//     child: categoryTile(context, name: ""),
//   );
// }
