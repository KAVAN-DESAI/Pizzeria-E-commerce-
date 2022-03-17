import 'dart:ffi';

import 'package:ecommerce_app/helper/auth.dart';
import 'package:ecommerce_app/helper/constants.dart';
import 'package:ecommerce_app/helper/helperfunction.dart';
import 'package:ecommerce_app/model/user.dart';
import 'package:ecommerce_app/services/database.dart';
import 'package:ecommerce_app/views/productDetails.dart';
import 'package:ecommerce_app/views/productList.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hover_effect/hover_effect.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  AuthMethods authMethods = new AuthMethods();

  DatabaseMethods databaseMethods = new DatabaseMethods();

  Helperfunctions helperfunctions = new Helperfunctions();

  Stream productStream;

  Widget productList() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection("products")
          .snapshots(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
            shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  bool isAddedToCart=false;
                  List<dynamic> cartList= snapshot.data.documents[index].data["cartList"];
                  final index1 = cartList.indexWhere((element) => element == Info.user_Name);
                  if(index1>=0){
                    isAddedToCart=true;
                  }
                  return productBlock(
                    details: snapshot.data.documents[index].data["details"],
                    imageUrl: snapshot.data.documents[index].data["imageUrl"],
                    title: snapshot.data.documents[index].data["title"],
                    price: snapshot.data.documents[index].data["price"],
                    rating: snapshot.data.documents[index].data["rating"],
                    isAddedToCart: isAddedToCart,
                    cartList: snapshot.data.documents[index].data["cartList"],
                  );
                })
            : Container();
      },
    );
  }

  Widget build(BuildContext context) {
    PageController page = PageController();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 10,right: 10),
        child: Column(
          children: [
            Divider(),
            CircleAvatar(
              radius: 130,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image:     AssetImage("assets/images/discount1.jpeg"),fit: BoxFit.fill),
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
            Divider(),
            Align(
                alignment: Alignment.centerLeft,
                child: Text("Explore Menu", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
            Divider(),
            GridView.count(
              childAspectRatio: 2/1.5,
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(4,//this is the total number of cards
                      (index){
                    if(index==1){
                      return Container(
                        child: HoverCard(
                          builder: (context, hovering) {
                            return Card(
                              color: Colors.red[100],
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(image:     AssetImage("assets/images/sides.jpeg"),fit: BoxFit.fill),
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("Sides's",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                                      // Divider(),
                                      // Text("PIZZA"),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                          depth: 10,
                          depthColor: Colors.blueGrey[100],
                          onTap: () {
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (context) => productListView()));
                          },
                          shadow: BoxShadow(color: Colors.red[200], blurRadius: 30, spreadRadius: -20, offset: Offset(100, 40)),
                        ),
                      );
                    }
                    else if (index==2){
                      return Container(
                        child: HoverCard(
                          builder: (context, hovering) {
                            return Card(
                              color: Colors.green[100],
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(image:     AssetImage("assets/images/pizzamania.jpeg"),fit: BoxFit.fill),
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("Pizza Mania",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                                      // Divider(),
                                      // Text("PIZZA"),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                          depth: 10,
                          depthColor: Colors.blueGrey[100],
                          onTap: () {
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (context) => productListView()));
                          },
                          shadow: BoxShadow(color: Colors.red[200], blurRadius: 30, spreadRadius: -20, offset: Offset(100, 40)),
                        ),
                      );
                    }
                    else if (index==3){
                      return Container(
                        child: HoverCard(
                          builder: (context, hovering) {
                            return Card(
                              color: Colors.blue[100],
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(image:     AssetImage("assets/images/desert.jpeg"),fit: BoxFit.fill),
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("Dessert's",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                                      // Divider(),
                                      // Text("PIZZA"),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                          depth: 10,
                          depthColor: Colors.blueGrey[100],
                          onTap: () {
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (context) => productListView()));
                          },
                          shadow: BoxShadow(color: Colors.red[200], blurRadius: 30, spreadRadius: -20, offset: Offset(100, 40)),
                        ),
                      );
                    }
                    else if (index==0){
                      return Container(
                        child: HoverCard(
                          builder: (context, hovering) {
                            return Card(
                                  color: Colors.yellow[100],
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 50,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(image:     AssetImage("assets/images/pizza.jpeg"),fit: BoxFit.fill),
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text("Pizza's",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                                          // Divider(),
                                          // Text("PIZZA"),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                          },
                          depth: 10,
                          depthColor: Colors.blueGrey[100],
                          onTap: () {
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (context) => productListView()));
                          },
                          shadow: BoxShadow(color: Colors.red[200], blurRadius: 30, spreadRadius: -20, offset: Offset(100, 40)),
                        ),
                      );
                    }
                  }
              ),
            ),
            // Expanded(
            //   child: Padding(
            //       padding: EdgeInsets.fromLTRB(30,0,30,0),
            //       child: discounts,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class productBlock extends StatelessWidget {
  final String details;
  final String imageUrl;
  final String title;
  final String price;
  final bool isAddedToCart;
  final List cartList;
  final String rating;
  productBlock({this.details,this.imageUrl,this.title,this.price,this.isAddedToCart,this.cartList,this.rating});
  @override
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => productDetails(details,imageUrl,title,price, rating,cartList)));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.purpleAccent[50],
            borderRadius: BorderRadius.circular(40.0),
            border: Border.all(color: Colors.blue.withOpacity(1) , width: .8)),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 8.0,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                imageUrl,
                height: MediaQuery.of(context).size.height/4,
                fit: BoxFit.contain,
              ),
            ),
            Text(title, style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: [
                      Text("Rating"),
                      SizedBox(
                        width: 80,
                        child: RatingBar.builder(
                          initialRating: double.parse(  rating),
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 10.0,
                          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            // rating=
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 12.0,
                      ),
                      Text(price.toString(),
                          style:
                          TextStyle(fontSize: 28.0, fontFamily: "Helvetica")),
                    ],
                  ),
                  IconButton(
                    icon: isAddedToCart? Icon(Icons.add_shopping_cart,color: Colors.orange,): Icon(Icons.add_shopping_cart),
                    onPressed: () {
                      if(!isAddedToCart) {
                        Info.newItem = true;
                        Map<String, dynamic> productMap =
                        new Map<String, dynamic>();
                        productMap = {
                          "title": title,
                          "details": details,
                          "price": price,
                          "imageUrl": imageUrl,
                          "cartList": cartList,
                          "rating": rating,
                        };
                        cartList.add(Info.user_Name);
                        databaseMethods.updateCart(productMap, title, cartList,Info.user_Name);
                        Fluttertoast.showToast(msg: "Added to Cart");
                      }
                      else{
                        Fluttertoast.showToast(msg: "Already Added to Cart");
                      }
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}


class _IconTile extends StatelessWidget {
  final double width;
  final double height;
  final IconData iconData;

  const _IconTile(
      {key, this.width,
        this.height,
        this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Color(0xff645478),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Icon(
        iconData,
        color: Color(0xffAEA6B6),
      ),
    );
  }
}

class _ItemPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipOval(
            child: Container(
              width: 60,
              height: 60,
              color: Color(0xff9783A9),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: Color(0xff6D528D),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: _RowPlaceholder(color: 0xffA597B4),
                      width: MediaQuery.of(context).size.width * 2 / 5,
                    ),
                    _RowPlaceholder(color: 0xff846CA1),
                    _RowPlaceholder(color: 0xff846CA1),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _RowPlaceholder extends StatelessWidget {
  final int color;

  const _RowPlaceholder({ key,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15,
      decoration: BoxDecoration(
        color: Color(color),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    );
  }
}