import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SQlite {
  SQlite();

  setup() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'money_app.db');

    await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE [user_money] (id integer NOT NULL PRIMARY KEY AUTOINCREMENT,mobile text,password text,profile_Img text,name text)');

      await db.execute(
          'CREATE TABLE [incom_category] (id integer NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,category_tite text,category_icon text,creat_a_date date)');

      await db.execute(
          'CREATE TABLE [expense_category] (id integer NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,category_name text,category_icon text,creat_a_date date)');

      await db.execute(
          'CREATE TABLE [accounts] (id integer NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,account_name text,account_balence double,users_id integer)');

      await db.execute(
          'CREATE TABLE [account_log] (id integer NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,amount double,incom_category_id integer,expense_category_id integer,account_id integer,transaction_type text,perpus_transaction text,transaction_bill_img text,creat_date date)');

      await db.execute(
          "INSERT INTO user_money (mobile,password,name) VALUES ('7001194275','0987654321','subhadip')");
    });
  }

  delete() async {}

  connect() async {
    var databasespath = await getDatabasesPath();
    String path = join(databasespath, 'money_app.db');
    Database db = await openDatabase(path, version: 1);
    return db;
  }

  static successToast(String msg) {
    return SnackBar(
      content: Text(
        msg,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
    );
  }

  static errorToast(String msg) {
    return SnackBar(
      content: Text(
        msg,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
    );
  }

  login(String mobile, String password) async {
    final db = await connect();
    try {
      final users = await db.rawQuery(
          " SELECT * FROM user_money WHERE mobile = '$mobile' AND password = '$password'  ");
      return users;
    } catch (e) {
      print(e);
    }
  }

  storeLoginInfo(
    String mobile,
    String password,
    int user_id,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('mobile', mobile);
    await prefs.setString('password', password);
    await prefs.setBool('is_login', true);
    await prefs.setInt('user_id', user_id);
  }

  is_login() async {
    var is_login = false;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var foundUser = await prefs.getBool('is_login');
    print('foundUser');
    print(foundUser);
    if (foundUser == null) {
      is_login = false;
    } else {
      is_login = true;
    }
    return is_login;
  }

  getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

  addNewAccount(data) async {
    final db = await connect();
    try {
      var id = await db.insert('accounts', data);
      return id;
    } catch (e) {
      print(e);
    }
  }

  getAccountList() async {
    final db = await connect();
    final userID = await getUserID();
    final users =
        await db.rawQuery("SELECT * FROM accounts WHERE users_id = '$userID'");
    return users;
  }

  getincomecategoryList() async {
    final db = await connect();
    final incom_category = await db.rawQuery("SELECT * FROM incom_category");
    print(incom_category);

    return incom_category;
  }

  addNewincomecategory(data) async {
    final db = await connect();
    try {
      var id = await db.insert('incom_category', data);
      return id;
    } catch (e) {
      print(e);
    }
  }

  getexpensescategoryList() async {
    final db = await connect();
    final expenses_category =
        await db.rawQuery("SELECT * FROM expense_category");
    print(expenses_category);

    return expenses_category;
  }

  addNewexpensescategory(data) async {
    final db = await connect();
    try {
      var id = await db.insert('expense_category', data);
      return id;
    } catch (e) {
      print(e);
    }
  }

  add_accountlog(data) async {
    final db = await connect();
    try {
      var id = await db.insert('account_log', data);
      return id;
    } catch (e) {
      print(e);
    }
  }

  get_accountlog(t_type) async {
    final db = await connect();
    final userID = await getUserID();
    final users = await db.rawQuery(
        "SELECT * FROM account_log WHERE transaction_type = '$t_type'");
    return users;
  }

  getCategoryNameID(ID, TableName) async {
    final db = await connect();
    final userID = await getUserID();
    final users = await db.rawQuery("SELECT * FROM $TableName WHERE id = '$ID'");
    if (TableName== 'expense_category'){
      return users[0]["category_name"];
    }
    return users[0]["category_tite"];
  }



  daily() async {
    var date = new DateTime.now();
    var formated_date = date.year.toString() +
        '-' +
        date.month.toString() +
        '-' +
        date.day.toString();

    final db = await connect();
    final users =
    await db.rawQuery("SELECT * FROM account_log WHERE creat_date = '$formated_date'");
    return users;
  }

  weekly() async {
    final db = await connect();
    final userID = await getUserID();
    final users =
    await db.rawQuery("SELECT * FROM accounts WHERE users_id = '$userID'");
    return users;
  }

  monthly() async {
    var date = new DateTime.now();
    var start_date = date.year.toString() +
        '-' +
        date.month.toString() +
        '-01' ;
    var end_date = date.year.toString() +
        '-' +
        date.month.toString() +
        '-31' ;


    final db = await connect();

    final users =
    await db.rawQuery("SELECT * FROM account_log WHERE creat_date BETWEEN $start_date AND $end_date");
    return users;
  }

  total() async {
    final db = await connect();
    final users =
    await db.rawQuery("SELECT * FROM account_log ");
    return users;
  }

}
