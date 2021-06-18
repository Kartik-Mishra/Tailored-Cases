import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tailored_cases/screens/home.dart';
import '../widgets/product_tile.dart';

class Products extends StatefulWidget {

final String category, shop;
  Products({this.category , this.shop});

  

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {

  

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Products of this shop'),
      ),
      body: new GridView.count(crossAxisCount: 2,
      children: productList(context , shop: widget.shop ,category: widget.category ),)
    );
}
}


//logic for other filters to be used
List<Widget> productList(BuildContext context, {String shop, String category})
{


  List<DocumentSnapshot> availableProducts = products.where((i){return (i.data["shop"]==shop && i.data["category"]==category)?? true; }).toList();
  return List.generate(availableProducts.length, (i){
        return productTile(context, availableProducts[i]);
      });
}