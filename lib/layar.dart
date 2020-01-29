import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class Layar extends StatefulWidget {
  Layar({this.username});
  final String username;
  @override
  _LayarState createState() => _LayarState();
}

class _LayarState extends State<Layar> {  //list untuk menampung data
  List newsData = [];
  Map data;

  Future getDataNews() async {
    http.Response response = await http.get(
        "https://newsapi.org/v2/everything?q=bitcoin&from=2019-12-29&sortBy=publishedAt&apiKey=f5c1764013444cbdacd29bdbf3b14b9a");
    data = jsonDecode(response.body);
    print(data);
    if (response.statusCode == 200) {
      setState(() {
        newsData = data['articles']; //nama array json
        print(newsData);
      });
    }
  }

  //proses get data di background
  @override
  void initState() {
    super.initState();
    getDataNews();
  }

  @override
  Widget build(BuildContext context) {
    var image_carousel = new Container(
      height: 200.0,
      child: newsData.isEmpty
          ? CircularProgressIndicator(
              strokeWidth: 20,
            )
          : Carousel(
              boxFit: BoxFit.cover,
              images: [
                NetworkImage("${newsData[0]['urlToImage']}"),
                NetworkImage("${newsData[1]['urlToImage']}"),
                NetworkImage("${newsData[2]['urlToImage']}"),
                NetworkImage("${newsData[3]['urlToImage']}"),
              ],
              autoplay: true,
              animationCurve: Curves.fastOutSlowIn,
              animationDuration: Duration(milliseconds: 1000),
              dotSize: 4.0,
              dotBgColor: Colors.transparent,
              indicatorBgPadding: 2.0,
            ),
    );

    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.blue,
        title: Text('General'),
        actions: <Widget>[
          // new IconButton(
          //     icon: Icon(
          //       Icons.search,
          //       color: Colors.white,
          //     ),
          //     onPressed: () {}),
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            // header
            new UserAccountsDrawerHeader(
              accountName: Text(''),
              accountEmail: Text(''),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: new BoxDecoration(color: Colors.blue[800]),
            ),

            // body
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Home Page'),
                leading: Icon(Icons.home),
              ),
            ),

            InkWell(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => new HomeScreen()));
              },
              child: ListTile(
                title: Text('Problem List'),
                leading: Icon(Icons.report),
              ),
            ),

            InkWell(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => new FormAddScreen()));
              },
              child: ListTile(
                title: Text('Quality List'),
                leading: Icon(Icons.layers),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Productivity'),
                leading: Icon(Icons.multiline_chart),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('SHE Area'),
                leading: Icon(Icons.build),
              ),
            ),

            Divider(),

            InkWell(
              child: ListTile(
                title: Text('IKAN (Ide PerbaiKAN)'),
                leading: Icon(Icons.thumb_up, color: Colors.green),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('About'),
                leading: Icon(Icons.help, color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
      body: new Column(
        children: <Widget>[
          //image carousel

          //pedding widget
          // new Padding(padding: const EdgeInsets.all(8.0),
          // child: Container(
          //   alignment: Alignment.centerLeft,
          //   body:SingleChildScrollView(
          //   Navigator.push(context, MaterialPageRoute(builder: (context) => ));
          //   scrollDirection: Axis.vertical,
          //   child: new Text('Report Department')),),
          // //Horizontal list view Begins here
          // HorizontalList(),
          //Padding Widget
          new Expanded(
              child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              image_carousel,
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: new Text('Report Press'),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: new Text('Report Welding')),
              ),
              //Grid View
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: new Text('Report Logistic')),
              ),
              //
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    alignment: Alignment.centerLeft, child: new Text('Other')),
              ),
              Container(
                child: Text(""),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
