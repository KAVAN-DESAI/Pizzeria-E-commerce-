import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/helper/constants.dart';
import 'package:ecommerce_app/helper/helperfunction.dart';
import 'package:ecommerce_app/model/user.dart';
import 'package:ecommerce_app/services/database.dart';
import 'package:ecommerce_app/views/home.dart';
import 'package:ecommerce_app/views/homeCustomer.dart';
import 'package:ecommerce_app/views/productDetails.dart';
import 'package:ecommerce_app/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class SearchPlatform extends StatefulWidget {
  @override
  _SearchPlatformState createState() => _SearchPlatformState();
}

class _SearchPlatformState extends State<SearchPlatform> {

  var queryResultSet=[];
  var tempSearchStore=[];

  TextEditingController searchTextEditingcontroller =
  new TextEditingController();
  Helperfunctions helperfunctions = new Helperfunctions();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  QuerySnapshot searchSnapshot;
  QuerySnapshot snapshotUserInfo;

  initaiteSearch(){
    databaseMethods
        .getProductbySearchKey(searchTextEditingcontroller.text)
        .then((val) async {
      print(val.toString());
      setState(() {
        searchSnapshot = val;
        print(searchSnapshot);
      });
    });
  }


  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
        itemCount: searchSnapshot.documents.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          bool isAddedToCart=false;
          List<dynamic> cartList= searchSnapshot.documents[index].data["cartList"];
          final index1 = cartList.indexWhere((element) => element == Info.user_Name);
          if(index1>=0){
            isAddedToCart=true;
          }
          return productBlock(
            title: searchSnapshot.documents[index].data["title"],
            imageUrl: searchSnapshot.documents[index].data["imageUrl"],
            details:searchSnapshot.documents[index].data["details"],
            price:searchSnapshot.documents[index].data["price"],
            rating:searchSnapshot.documents[index].data["rating"],
            cartList:searchSnapshot.documents[index].data["cartList"],
            isAddedToCart: isAddedToCart,
          );
        })
        : Container();
  }

  // createChatroomAndStartConversation(String userEmail, String userName,String userImage) {
  //   if (userEmail != Info.user_email) {
  //     print(Info.user_email);
  //     print(userEmail);
  //     String chatRoomId = getChatRoomId(Info.user_email, userEmail);
  //     Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => ConversationScreen(
  //               chatRoomId: chatRoomId,
  //               userEmail: userEmail,
  //               userName: userName,
  //               userImage: userImage,
  //             )));
  //   }
  //   else {
  //     Container();
  //   }
  // }

  Widget searchTile({String storeName, String details, String imageUrl,String title,String price,String rating, List cartList}) {
    String interestString="";
    // for(int i=0;i<Interests.length;i++){
    //   interestString+=Interests[i];
    //   if(i+1==Interests.length){
    //     break;
    //   }
    //   interestString+=', ';
    // }

    return Container(
      child: GestureDetector(
        onTap: () async {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => productDetails(details,imageUrl,title,price, rating,cartList)));
        },
        child: GFCard(
          boxFit: BoxFit.cover,
          imageOverlay: AssetImage('your asset image'),
          title: GFListTile(
            avatar: Container(
              width: 55,
              child: Container(
                child: CircleAvatar(
                  radius: 25,
                  child: ClipOval(
                    child: Image.network(
                      imageUrl,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            title: Text(title, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            subTitle: Text(details),
          ),
          // content: Column(
          //   children: [
          //     userProfileBio== null ? Container():Row(
          //       children: [
          //         Text("About Me: " ,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
          //         Container(
          //           width: MediaQuery.of(context).size.width-170,
          //           child: ExpandableText(
          //             userProfileBio== null? "BOoM! Gearing up": userProfileBio,
          //             expandText: 'show more',
          //             collapseText: 'show less',
          //             maxLines: 3,
          //             linkColor: Colors.blue,
          //             style: TextStyle(fontSize: 14),
          //           ),
          //         ),
          //       ],
          //     ),
          //     Divider(),
          //     Row(
          //       children: [
          //         Text("Interests: " ,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
          //         Container(
          //             width: MediaQuery.of(context).size.width-170,
          //             child: Text(interestString)),
          //       ],
          //     ),
          //     Row(
          //       children: [
          //         Text("\nBranch: " ,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
          //         Container(
          //           width: MediaQuery.of(context).size.width-180,
          //           child: Text("\n"+branch),
          //         )
          //       ],
          //     ),
          //     Row(
          //       children: [
          //         Text("\nYear of Study: " ,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
          //         Container(
          //             width: MediaQuery.of(context).size.width-200,
          //             child: Text("\n"+year + " Year")),
          //       ],
          //     ),
          //   ],
          // ),
          buttonBar: GFButtonBar(
            children: <Widget>[
              GFButton(
                onPressed: () {
                  // createChatroomAndStartConversation(userEmail,userName,imageUrl);
                },
                text: 'Message',
                color: Color(0xFF8F48F7),
              )
            ],
          ),
        ),
      ),
    );
  }

  String searchString;

  @override
  Future<bool> _onBackPressed() {
      return Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => homeCustomer(Info.customer)));
  }
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child:Scaffold(
      body: Container(
          child: Column(children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value){
                        setState(() {
                          searchString=value.toLowerCase();
                          initaiteSearch();
                        });
                      },
                      controller: searchTextEditingcontroller,
                      decoration: textFieldInputDecoration("Search Product"),
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  GestureDetector(
                    // onTap: () {
                    //   initaiteSearch();
                    // },
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Color(0xFF8F48F7),
                            borderRadius: BorderRadius.circular(40)),
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.search,color: Colors.white,),
                  ),)
                ],
              ),
            ),
            Expanded(child: searchList(),)
          ])),
    ));
  }
}
