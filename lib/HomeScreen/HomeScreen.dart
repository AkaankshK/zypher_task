
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zyphertask/Utils/constants.dart';
import 'package:zyphertask/Utils/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamController _categoryController;
  bool loading=true;
  @override
  void initState() {
    _categoryController=new StreamController();
    addData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyColor,
      drawer: Container(),
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.black),
        backgroundColor: greyColor,
        elevation: 0,
      ),
      body: getBody(),
    );
  }

  getBody() {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        SizedBox(height: MediaQuery.of(context).size.height/10,),
        getTitle(),
          getSearchBox(),
          getCategoriesTitle(),
          getCategories(),
        ],
      ),
    );
  }

  getTitle() {
    return Padding(
        padding: EdgeInsets.all(20),
        child: Text("What would\nyou read,Ariel?",style: TextStyle(fontSize: 35,fontStyle: FontStyle.italic),));
  }

  getSearchBox() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Material(

        shadowColor: greyColor,
        elevation: 15,
        borderRadius: BorderRadius.circular(30),
        child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search,color: Colors.grey,),
              hintText: "title,genre,author",
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: greyColor
                  ),
                  borderRadius: BorderRadius.circular(30)
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: greyColor
                  ),
                  borderRadius: BorderRadius.circular(30)
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: greyColor
                ),
                borderRadius: BorderRadius.circular(30)
              )
            ),
        ),
      ),
    );
  }

  getCategoriesTitle() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text("Categories",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
    );
  }

  getCategories() {
    return Container(
      color: Colors.white,
      height: 125,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<Object>(
          stream: _categoryController.stream,
          builder: (BuildContext context,AsyncSnapshot snapshot) {
            if(snapshot.hasError){
              return Text(snapshot.error);
            }
            if(loading){
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.length,
              itemBuilder:(bc,index){
                var item=snapshot.data[index];
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        backgroundColor: greyColor,
                        radius: 30,
                        backgroundImage: NetworkImage(item['categoryImageURL']),
                      ),
                      Text(item['displayName']),
                    ],
                  ),
                );
              },
            );

          }
        ),
      ),
    );
  }

  addData() async {
    getData().categoryData().then((res)async{
      _categoryController.add(res);
      setState(() {
        loading=false;
      });
      return res;
    });
}
}
