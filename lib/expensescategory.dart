import 'package:flutter/material.dart';
import 'package:money_app/add_expenses_category.dart';
import 'libary/SQlite.dart';


class expensescategory extends StatefulWidget {
  @override
  _expensescategoryState createState() => _expensescategoryState();
}

class _expensescategoryState extends State<expensescategory> {
  List expensescategory = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getexpensescategoryList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Expenses Categorys'),
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
                    Route route =
                    MaterialPageRoute(builder: (context) => add_expenses_category());
                    var returnBack = await Navigator.push(context, route);
                     _getexpensescategoryList();
                  })
            ]
        ),

        body: ListView.builder(
    itemCount: expensescategory.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child: ListTile(
                title: Text(expensescategory[index]['category_name'].toString()),
              ));
        }
    )

    );
  }
  _getexpensescategoryList() async {
    final result = await SQlite().getexpensescategoryList();
    setState(() {
      expensescategory = result;
    });
  }


}

