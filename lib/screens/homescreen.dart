import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vaccinefinder/screens/eighteen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime currentDate = DateTime.now();
  String dateFormatter = "select date";

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
        dateFormatter = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(children: [
        FlareActor("assets/backgroundFlow.flr",
            alignment: Alignment.center,
            fit: BoxFit.fill,
            animation: "Background Loop"),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Vaccine Finder ",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blue[300]),
          ),
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                      width: 160,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            dateFormatter,
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    if (dateFormatter != "select date") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Eighteen(date: dateFormatter)),
                      );
                      print(dateFormatter);
                    } else {
                      _showSnackBar("Choose Date");
                    }
                  },
                  child: Container(
                    width: 120,
                    decoration: BoxDecoration(
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.black38,
                          blurRadius: 3.0,
                        ),
                      ],
                      color: Colors.blue[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Text(
                          "Continue",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 19),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ]),
      ]),
    );
  }

  void _showSnackBar(message) {
    final snackBar = new SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 16.0,
      duration: const Duration(seconds: 1),
      content: new Text(message),
    );

    // ignore: deprecated_member_use
    _scaffoldKey.currentState!.showSnackBar(snackBar);
  }
}
