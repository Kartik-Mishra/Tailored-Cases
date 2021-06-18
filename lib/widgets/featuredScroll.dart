import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

Widget popularScroll(BuildContext context) {
  return CarouselSlider(
      autoPlay: true,
      viewportFraction: 0.92,
      aspectRatio: 2,
      enlargeCenterPage: true,
      items: [1,2,3,4,5]  .map(
        (i) {
        return InkWell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/home.jpg"), fit: BoxFit.cover, ),
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(
                          width: 1,
                          color: Color.fromARGB(200, 20, 20, 20)),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset.fromDirection(1.6),
                            blurRadius: 3,
                            spreadRadius: 1,
                            color: Color.fromARGB(255, 230, 230, 230))
                      ]),
                ),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   children: <Widget>[
                //     Container(
                //       decoration: BoxDecoration(
                //           color: Color.fromARGB(240, 170, 170, 170),
                //           borderRadius: BorderRadius.only(
                //               bottomLeft: Radius.circular(10),
                //               bottomRight: Radius.circular(10))),
                //       height: 40,
                //       child: Center(
                //           child: Text(
                //         "pl.name",
                //         style: new TextStyle(
                //             color: Color.fromARGB(255, 255, 255, 255),
                //             fontFamily: "OpenSans",
                //             // fontWeight: FontWeight.bold
                //             ),
                //       )),
                //     ),
                //   ],
                // )
              ],
            ),
          ),
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => DetailPage(
            //             object: pl,
            //           )),
            // );
          },
        );
      }).toList());
}
