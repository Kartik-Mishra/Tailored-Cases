import 'package:flutter/material.dart';
import 'package:tailored_cases/widgets/search.dart';
import 'package:tailored_cases/screens/searchScreen.dart';
import '../screens/imgeditor.dart';


Widget customAppBar(BuildContext context) {
  return SliverAppBar(
    leading: Padding(
      padding: const EdgeInsets.only(top: 20.0),
      //child: Icon(Icons.menu, color: Colors.black),
    ),
    elevation: 3,
    backgroundColor: Colors.white,
    shape: new RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(7))),
    snap: true,
    centerTitle: true,
    title: Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Image.asset("images/new_tc.jpg", height: 60),
    ),
    expandedHeight: 115.0,
    floating: true,
    pinned: true,
    forceElevated: true,
    bottom: PreferredSize(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        child: InkWell(
          child: searchBar,
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SearchScreen()));
          },
        ),
      ),
      preferredSize: Size.square(56),
    ),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8, top: 18),
        child: Icon(Icons.favorite, color: Colors.black),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 15, top: 18),
        child: IconButton(
          icon:Icon(Icons.shopping_cart), color: Colors.black,
          onPressed: (){
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => Customizer(appBarColor: Colors.blue, bottomBarColor: Colors.blueAccent,)));
          },
          ),
      ),
    ],
  );
}
