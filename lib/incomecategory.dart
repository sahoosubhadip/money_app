import 'package:flutter/material.dart';
import 'package:money_app/add_income_category.dart';
import 'libary/SQlite.dart';

class incomecategory extends StatefulWidget {
  @override
  _incomecategoryState createState() => _incomecategoryState();
}

class _incomecategoryState extends State<incomecategory> {
  List incomecategory = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getincomecategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Income Categorys'),
            backgroundColor: Colors.red,
            centerTitle: true,
            elevation: 5.0,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.edit, color: Colors.white),
                  onPressed: () {}),
              IconButton(
                  icon: Icon(Icons.add, color: Colors.white),
                  onPressed: () async {
                    Route route = MaterialPageRoute(
                        builder: (context) => add_income_category());
                    var returnBack = await Navigator.push(context, route);
                    _getincomecategoryList();
                  })
            ]),


        body: ListView.builder(
            itemCount: incomecategory.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  child: ListTile(
                title: Text(incomecategory[index]['category_tite'].toString()),
              ));
            }
            )
    );
  }

  _getincomecategoryList() async {
    final result = await SQlite().getincomecategoryList();
    setState(() {
      incomecategory = result;
    });
  }
}
