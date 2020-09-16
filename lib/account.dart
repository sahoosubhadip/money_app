import 'package:flutter/material.dart';
import 'Account/Addaccount.dart';
import 'libary/SQlite.dart';

class account extends StatefulWidget {
  @override
  _accountState createState() => _accountState();
}

class _accountState extends State<account> {
  List accounts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAccountList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Accounts'),
          backgroundColor: Colors.red,
          centerTitle: true,
          elevation: 5.0,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.edit, color: Colors.white), onPressed: () {}),
            IconButton(
                icon: Icon(Icons.add, color: Colors.white),
                onPressed: () async {
                  Route route =
                      MaterialPageRoute(builder: (context) => Addaccount());
                  var returnBack = await Navigator.push(context, route);
                  await _getAccountList();
                })
          ]),
      body: ListView.builder(
          itemCount: accounts.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                title: Text(accounts[index]['account_name'].toString()),
                trailing:
                    Text("Rs." + accounts[index]['account_balence'].toString()),
              ),
            );
          }),
    );
  }

  _getAccountList() async {
    final result = await SQlite().getAccountList();
    setState(() {
      accounts = result;
    });
  }
}
