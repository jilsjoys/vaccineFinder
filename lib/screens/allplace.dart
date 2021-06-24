import 'dart:convert';
import 'package:favorite_button/favorite_button.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vaccinefinder/services/database.dart';

class AllPlace extends StatefulWidget {
  String url;
  AllPlace({
    required this.url,
  });

  @override
  _AllPlaceState createState() => _AllPlaceState();
}

class _AllPlaceState extends State<AllPlace> {
  Future<List<dynamic>> fetchUsers() async {
    print(widget.url);
    var result = await http.get(Uri.parse(widget.url));
    return json.decode(result.body)['centers'];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: fetchUsers(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data[0]);
          return ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        trailing: StarButton(
                          iconSize: 35,
                          iconColor: Colors.redAccent,
                          valueChanged: (_) {
                            addProfile(snapshot.data[index]["name"])
                                .then((_) {});
                          },
                        ),
                        onTap: () {},
                      ),
                      Text(snapshot.data[index]["name"]),
                      Text(snapshot.data[index]["available_capacity_dose1"]
                          .toString()),
                      Text(snapshot.data[index]["available_capacity_dose2"]
                          .toString()),
                    ],
                  ),
                );
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
