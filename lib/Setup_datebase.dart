import 'package:flutter/material.dart';
import 'package:money_app/home.dart';
import 'package:money_app/login.dart';
import 'libary/SQlite.dart';

class Setup_datebase extends StatefulWidget {
  @override
  _Setup_datebaseState createState() => _Setup_datebaseState();
}

class _Setup_datebaseState extends State<Setup_datebase> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDatebase();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  initDatebase() async {
    var datebase = SQlite();
    await datebase.setup();
    bool is_login = await SQlite().is_login();
    print(is_login);
    if (is_login){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }
    else{
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }



  }
}
