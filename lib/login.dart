import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:money_app/libary/SQlite.dart';
import 'package:money_app/trans.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String mobile='';
  String password='';

  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      key: _scaffolkey,
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
      Container(
        padding: EdgeInsets.fromLTRB(40.0, 50.0, 0.0, 0.0),
        child: Text('MONEY MANAGER',
            style: TextStyle(
                fontSize: 60.0,
                fontWeight: FontWeight.w800,
                color: Colors.red)),
      ),
      Container(
        padding: EdgeInsets.fromLTRB(15.0, 60.0, 200.0, 10.0),
        child: Text('LOG IN HERE ',
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.orange)),
      ),
      Container(
          padding: EdgeInsets.only(top: 85.0, left: 20.0, right: 20.0),
          child: Column(children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintStyle: TextStyle(fontSize: 14.0),
                hintText: 'Please Enter Your Register Mobile No...',
                labelText: 'mobile',
                labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              onChanged: (value) {
                setState(() {
                  mobile = value;
                });
              },
            ),
            SizedBox(height: 20.0),
            TextField(
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 14.0),
                  hintText: 'Please Enter Your Password...',
                  labelText: 'Password',
                  labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
            ),
            Center(
                child: RaisedButton(
              color: Colors.red,
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
                    // Within the `FirstRoute` widget
                    onPressed:_loginCheck
                ))
          ])),
    ])));
  }
  _loginCheck()async{
      if(mobile == "") {
        _scaffolkey.currentState.showSnackBar(SQlite.errorToast("Please enter your mobile number"));
      } else if ( password == ""){
        _scaffolkey.currentState.showSnackBar(SQlite.errorToast("Please enter your password"));
      } else{
        final result = await SQlite().login(mobile, password);
        if(result.length > 0){
          var user_id = result[0]['id'];
          print(user_id);
          await SQlite().storeLoginInfo(mobile, password, user_id);
          Route route = MaterialPageRoute(builder: (context)=>Home());
          Navigator.pushReplacement(context, route);
        } else{
          _scaffolkey.currentState.showSnackBar(SQlite.errorToast('NO USER FOUND'));
        }

      }
    }
  }

