import 'package:flutter/material.dart';
import '../libary/SQlite.dart';

class Addaccount extends StatefulWidget {
  @override
  _AddaccountState createState() => _AddaccountState();
}

class _AddaccountState extends State<Addaccount> {
  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();

  String account_name = '';
  String account_balence = '';
  int users_id = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffolkey,
      appBar: AppBar(
        title: Text("Add New Account".toUpperCase()),
        backgroundColor: Colors.red,
        centerTitle: true,
        elevation: 5.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: <Widget>[
            Container(
              height: 25,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.keyboard),
                alignLabelWithHint: false,
                hintStyle: TextStyle(fontSize: 14.0),
                labelStyle: TextStyle(fontSize: 16.0),
                hintText: 'Enter Your Account Name',
                labelText: 'Account Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  account_name = value;
                });
              },
            ),
            Container(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.keyboard),
                alignLabelWithHint: false,
                hintStyle: TextStyle(fontSize: 14.0),
                labelStyle: TextStyle(fontSize: 16.0),
                hintText: 'Enter Your Account Balance',
                labelText: 'Account Balance',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  account_balence = value;
                });
              },
            ),
            Container(
              height: 450,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: FlatButton.icon(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                color: Colors.red,
                textColor: Colors.white,
                icon: Icon(Icons.add_circle_outline),
                label: Text("Add New Account".toUpperCase()),
                onPressed: _addNewAccount
              ),
            )
          ],
        ),
      ),
    );


  }
  _addNewAccount() async {
    users_id = await SQlite().getUserID();
    if (account_name == "") {
      _scaffolkey.currentState
          .showSnackBar(SQlite.errorToast("Please enter your account name"));
    } else if (account_balence == "") {
      _scaffolkey.currentState
          .showSnackBar(SQlite.errorToast("Please enter starting balance"));
    } else {
      try {
        int userID = await SQlite().getUserID();
        var id = await SQlite().addNewAccount({
          'account_name': account_name.toString(),
          'account_balence': double.parse(account_balence.toString()),
          'users_id': userID
        });
        Navigator.pop(context);
      } catch (e) {
        print(e);
      }
    }
  }
}
