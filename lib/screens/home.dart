import 'dart:async';

import 'package:tailored_cases/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:tailored_cases/widgets/featuredScroll.dart';
import 'package:tailored_cases/widgets/category.dart';
import '../widgets/product_tile.dart';
import './shops.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:tailored_cases/screens/product_details.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

List<DocumentSnapshot> products, shops, categories;

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  StreamSubscription<QuerySnapshot> subscription;
  final CollectionReference productCollectionReference =
      Firestore.instance.collection("Products");
  final CollectionReference shopCollectionReference =
      Firestore.instance.collection("shops");
  final CollectionReference categoryCollectionReference =
      Firestore.instance.collection("Categories");
  @override
  void initState() {
    super.initState();
    subscription = productCollectionReference.snapshots().listen((documentSnapshot) {
      setState(() {
        products = documentSnapshot.documents;
      });
    });
    subscription = shopCollectionReference.snapshots().listen((documentSnapshot) {
      setState(() {
        shops = documentSnapshot.documents;
      });
    });
    subscription = categoryCollectionReference.snapshots().listen((documentSnapshot) {
      setState(() {
        categories = documentSnapshot.documents;
      });
    });
  }

  ScrollController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: new Drawer(),
      backgroundColor: Color.fromRGBO(255, 255, 253, 1),
      body: NestedScrollView(
        controller: controller,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            customAppBar(context),
          ];
        },
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("\nCategory"),
                categories != null ?categoryScroll(context): CircularProgressIndicator(),
                Text("Featured"),
                popularScroll(context),
                // Text("\nOffers...later"),
                // Text("\nA Product tile"),
              //  productTile(context),
              //  shopTile(context, name: "shop"),
              ],
            )),
      ),
    );
  }
}
