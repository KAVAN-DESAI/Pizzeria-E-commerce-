import 'package:ecommerce_app/helper/constants.dart';
import 'package:ecommerce_app/model/user.dart';
import 'package:ecommerce_app/views/homeCustomer.dart';
import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:ecommerce_app/helper/auth.dart';
import 'package:ecommerce_app/helper/constants.dart';
import 'package:ecommerce_app/helper/helperfunction.dart';
import 'package:ecommerce_app/model/user.dart';
import 'package:ecommerce_app/services/database.dart';
import 'package:ecommerce_app/views/productDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class cart extends StatefulWidget {
  @override
  _cartState createState() => _cartState();
}

class _cartState extends State<cart> {
  @override
  AuthMethods authMethods = new AuthMethods();

  DatabaseMethods databaseMethods = new DatabaseMethods();

  Helperfunctions helperfunctions = new Helperfunctions();

  Stream productStream;

  Widget cartProductList() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection("users").document(Info.user_Name).collection("cart")
          .snapshots(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
            itemCount: snapshot.data.documents.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            reverse: true,
            itemBuilder: (context, index) {
              bool isAddedToCart=false;
              List<dynamic> cartList= snapshot.data.documents[index].data["cartList"];
              final index1 = cartList.indexWhere((element) => element == Info.user_Name);
              if(index1>=0){
                isAddedToCart=true;
              }
              return cartProductBlock(
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
    Future<bool> _onBackPressed() {
        return Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => homeCustomer(Info.customer)));
    }
    return WillPopScope(
        onWillPop: _onBackPressed,
      child:Scaffold(
        appBar: AppBar(
          title: Text("Cart",style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.white,
        ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30,0,30,0),
        child: cartProductList(),
      ),
    ));
  }
}

class cartProductBlock extends StatelessWidget {
  final String details;
  final String imageUrl;
  final String title;
  final String price;
  final bool isAddedToCart;
  final List cartList;
  final String rating;
  cartProductBlock({ this.details,this.imageUrl,this.title,this.price,this.isAddedToCart,this.cartList,this.rating});
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
            border: Border.all(color: Colors.grey.withOpacity(0.5) , width: .8)),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 8.0,
            ),
            Container(
              child: Image.network(
                imageUrl,
                height: MediaQuery.of(context).size.height/4,
                width: MediaQuery.of(context).size.width,
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
                      databaseMethods.updateCart(productMap,title,cartList,Info.user_Name);
                      Fluttertoast.showToast(msg: "Added to Cart");
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
