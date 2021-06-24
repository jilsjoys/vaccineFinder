import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Favour extends StatefulWidget {
  String url;
  Favour({
    required this.url,
  });

  @override
  _FavourState createState() => _FavourState();
}

class _FavourState extends State<Favour> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Favourite').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.data.toString() == 'null') return Text('');
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          if (snapshot.data!.docs.length < 1) return SizedBox.shrink();
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: new CircularProgressIndicator());
            default:
              return new ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  return Text(
                    document['id'].toString(),
                    style: TextStyle(color: Colors.black),
                  );
                }).toList(),
              );
          }
        },
      ),
    );
  }
}
