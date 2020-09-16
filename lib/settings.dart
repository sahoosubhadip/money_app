import 'package:flutter/material.dart';
import 'package:money_app/expensescategory.dart';
import 'package:money_app/incomecategory.dart';
import 'package:money_app/login.dart';

class settings extends StatefulWidget {


  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.red,
                child: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
                onPressed: () async {
                  Scaffold.of(context).showSnackBar(SnackBar(content:Text("Successfilly Logout !"),duration: Duration(seconds:3),));
                  await Future.delayed(Duration(seconds: 3), (){
                    Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => Login()),
                         );

                  }
                  );

                }),
            appBar: AppBar(
              title: Text("Settings & Manage"),
              backgroundColor: Colors.red,
              centerTitle: true,
              elevation: 5.0,
            ),
            body: ListView(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => incomecategory()),
                    );
                  },
                  child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 8.0),
                      child: Text(
                        'Manage Income Category',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => expensescategory()),
                    );
                  },
                  child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 8.0),
                      child: Text(
                        'Manage Expence Category',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ],
            )
        )
    );
  }
}

