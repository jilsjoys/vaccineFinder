import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vaccinefinder/screens/allplace.dart';
import 'package:vaccinefinder/screens/favour.dart';

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
  List<dynamic> centers = [];

  final String aUrl =
      "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByDistrict?district_id=303&date=";

  Future<String> fetchUsers() async {
    print(aUrl + widget.date);
    var result = await http.get(Uri.parse(aUrl + widget.date));
    var fetchdata = jsonDecode(result.body);

    setState(() {
      centers = fetchdata["centers"];
      // ignore: unnecessary_null_comparison

      //  print(data);
    });
    return "success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.date,
            style: TextStyle(color: Colors.black54),
          ),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: Colors.black54,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Favour(
                            url: aUrl + widget.date,
                          )),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 10),
              child: IconButton(
                icon: Icon(
                  Icons.place,
                  color: Colors.black54,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AllPlace(
                              url: aUrl + widget.date,
                            )),
                  );
                },
              ),
            ),
          ],
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
        body: FutureBuilder<String>(
          future: fetchUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data[0]);
              return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: centers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Column(
                        children: <Widget>[
                          Text(centers[index]["name"]),
                          Text(centers[index]["fee_type"]),
                          Text(centers[index]["sessions"][0]["vaccine"]),
                          Text(centers[index]["sessions"][0]
                                  ["available_capacity_dose1"]
                              .toString()),
                          Text(centers[index]["sessions"][0]
                                  ["available_capacity_dose2"]
                              .toString()),
                          Text(centers[index]["sessions"][0]["min_age_limit"]
                              .toString()),
                          Text(centers[index]["sessions"][0]["vaccine"]
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
