import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  List _data = await getJson();

//  print(_data[1]['title']); // just a string
//
//  String _body = "";
//
//  for (int i = 0; i < _data.length; i++) {
//    print("Title ${_data[i]['title']}");
//  }
//
//  _body = _data[0]['body'];

  runApp(new MaterialApp(
    home: new Scaffold(
      appBar: new AppBar(
        title: new Text('JSON Pars'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: new Center(
        child: new ListView.builder(
            itemCount: _data.length,
            padding: const EdgeInsets.all(15.0),
            itemBuilder: (BuildContext context, int position) {
              return Column(
                children: <Widget>[
                  new Divider(
                    height: 5.0,
                  ),
                  new ListTile(
                    title: Text(
                      "${_data[position]['title']}",
                      style: new TextStyle(fontSize: 18.0),
                    ),
                    subtitle: Text(
                      "${_data[position]['body']}",
                      style: new TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic),
                    ),
                    leading: new CircleAvatar(
                      backgroundColor: Colors.greenAccent,
                      child: Text(
                        "${_data[position]['body'][0]}".toUpperCase(),
                        style: new TextStyle(
                          fontSize: 18.5,
                          color: Colors.orangeAccent,
                        ),
                      ),
                    ),
                    onTap: () =>
                        _showonTapMessage(context, _data[position]['body']),
                  )
                ],
              );
            }),
      ),
    ),
  ));
}

void _showonTapMessage(BuildContext context, String message) {
  var alert = new AlertDialog(
    title: Text("My App"),
    content: Text(message),
    actions: <Widget>[
      FlatButton(
        child: Text("ok"),
        onPressed: () {
          Navigator.pop(context);
        },
      )
    ],
  );

  //showDialog(context: context, child: alert);
  showDialog(context: context, builder: (context) => alert);
}

Future<List> getJson() async {
  String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

  http.Response response = await http.get(apiUrl);

  return json.decode(response.body);
}
