import 'package:flutter/material.dart';

Widget searchBar = Padding(
  padding: EdgeInsets.all(0),
  child: Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.20),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: new Icon(Icons.search),
            ),
            new Text(
              "Search for Products, Brands and More",
              style: TextStyle(
                  //  fontSize: 14,
                  // fontFamily: "OpenSans",
                  color: Colors.grey),
            ),
          ],
        ),
      )),
);
