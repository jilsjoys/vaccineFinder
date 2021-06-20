import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class Eighteen extends StatefulWidget {
  String date;
  Eighteen({
    required this.date,
  });

  @override
  _EighteenState createState() => _EighteenState();
}

class _EighteenState extends State<Eighteen> {
  final String aUrl =
      "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByDistrict?district_id=303&date=";

  Future<List<dynamic>> fetchUsers() async {
    print(aUrl + widget.date);
    var result = await http.get(Uri.parse(aUrl + widget.date));
    return json.decode(result.body)['centers'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.black54,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: FutureBuilder<List<dynamic>>(
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
        ));
  }
}
