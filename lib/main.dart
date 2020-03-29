import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './components/videoCell.dart';

void main() => runApp(FollowingApp());

class FollowingApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomeListView();
  }
}

class HomeListView extends State<StatefulWidget> {
  var _isLoading = false;
  var userInfo, videos;

  _fetchData() async {
    final url = "https://api.letsbuildthatapp.com/youtube/home_feed";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final map = json.decode(response.body); 
      final videosJson = map["videos"];
      final userJson = map["user"];
      setState(() {
        videos = videosJson;
        userInfo = userJson;
       _isLoading = false; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {  
    // TODO: implement build
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Welcome Shadow"),
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.refresh),
            onPressed: () {
              print("Refresh button Pressedss...");
              setState(() {
                _isLoading = true;
              });
              _fetchData();
            },)
          ],
        ),
        body: new Center(
          child: _isLoading ? new CircularProgressIndicator() :
            new ListView.builder(
              itemCount: this.videos != null ? this.videos.length : 0,
              itemBuilder: (context, index) {
                final video = this.videos[index];
                return new FlatButton(
                  padding: new EdgeInsets.all(0.0),
                  child: new VideoCell(video),
                  onPressed: () {
                    print("Ready to next page...");
                    Navigator.push(context,
                      new MaterialPageRoute(
                        builder: (context) {
                          return new DetailPage();
                        }
                      )
                    );
                  },
                );
              },
            )
        )
      )
    );
  }
}

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Detail Page")
      ),
      body: new Center(
        child: new Text("Welcome to Detail Page")
      ),
    );
  }
}