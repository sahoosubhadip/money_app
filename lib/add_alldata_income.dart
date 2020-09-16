import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_app/ViewIncome.dart';
import 'package:money_app/trans.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'libary/SQlite.dart';

class add_alldata_income extends StatefulWidget {
  @override
  _add_alldata_incomeState createState() => _add_alldata_incomeState();
}

class _add_alldata_incomeState extends State<add_alldata_income> {
  String _image;
  List incomecategory = [];
  String select_income_category = '1';
  final dateController = TextEditingController();

  List accounts = [];
  String select_accounts = '1';

  Future getImage(source) async {
    var image = await ImagePicker.pickImage(source: source);
    print(image.path);

    setState(() {
      _image = image.path.toString();
    });
  }

  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();
  String Income_Amount = '';
  String perpus_transaction = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getincomecategoryList();
    _getAccountList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffolkey,
        appBar: AppBar(
          title: Text("Add New Income".toUpperCase()),
          backgroundColor: Colors.red,
          centerTitle: true,
          elevation: 5.0,
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(children: <Widget>[
              Container(
                height: 20,
              ),
              DropdownButton<String>(
                hint: Text('Please Choose An Account'),
                isExpanded: true,
                value: select_accounts,
                items: accounts.map((accountName) {
                  return DropdownMenuItem<String>(
                    value: accountName['id'].toString(),
                    child: Text(accountName['account_name'].toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    select_accounts = value.toString();
                  });
                },
              ),
              Container(
                height: 20,
              ),
              DropdownButton<String>(
                isExpanded: true,
                value: select_income_category,
                hint: Text('Please Choose a Income Category'),
                items: incomecategory.map((income) {
                  return DropdownMenuItem<String>(
                    value: income['id'].toString(),
                    child: Text(income['category_tite'].toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    select_income_category = value.toString();
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
                  hintText: 'Enter Amount',
                  labelText: 'Income Amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    Income_Amount = value;
                  });
                },
              ),
              Container(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      enabled: false,
                      controller: dateController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.date_range),
                        alignLabelWithHint: false,
                        hintStyle: TextStyle(fontSize: 14.0),
                        labelStyle: TextStyle(fontSize: 16.0),
                        hintText: 'Enter The Date Of Income ',
                        labelText: 'Income Date',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Icon(Icons.date_range),
                    onTap: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(2020, 01, 01),
                          maxTime: DateTime(2050, 12, 30), onChanged: (date) {
                        print('Change $date');
                      }, onConfirm: (date) {
                        var formated_date = date.year.toString() +
                            '-' +
                            date.month.toString() +
                            '-' +
                            date.day.toString();
                        dateController.text = formated_date;
                        print('Confirm $date');
                      });
                    },
                  )
                ],
              ),
              Container(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.question_answer),
                  alignLabelWithHint: false,
                  hintStyle: TextStyle(fontSize: 14.0),
                  labelStyle: TextStyle(fontSize: 16.0),
                  hintText: 'Type Here . . .',
                  labelText: 'Purpose or Note or Remark . . .',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    perpus_transaction = value;
                  });
                },
              ),
              Container(
                height: 40,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: FlatButton.icon(
                  color: Colors.black12,
                  textColor: Colors.black,
                  icon: Icon(Icons.add_a_photo),
                  label: Text("Take a Bill Image".toUpperCase()),
                  onPressed: () {
                    getImage(ImageSource.camera);
                  },
                  //tooltip: 'Pick Image',
                ),
              ),
              Container(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: FlatButton.icon(
                  textColor: Colors.black,

                  icon: Icon(Icons.image),
                  color: Colors.black12,

                  label: Text("Choose Bill Image From Gallery".toUpperCase()),
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                  //tooltip: 'Pick Image',
                ),
              ),
              Container(
                height: 80,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: FlatButton.icon(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10, left: 20, right: 20),
                    color: Colors.red,
                    textColor: Colors.white,
                    icon: Icon(Icons.add_circle_outline),
                    label: Text("Add New Income".toUpperCase()),
                    onPressed: () async {

                      await SQlite().add_accountlog({
                        'amount': Income_Amount,
                        'incom_category_id': select_income_category,
                        'account_id': select_accounts,
                        'transaction_type': 'Credit',
                        'perpus_transaction': perpus_transaction,
                        'transaction_bill_img': _image,
                        'creat_date': dateController.text
                      });
                      Route route = MaterialPageRoute(builder: (context)=> ViewIncome());
                      var returnBack =await Navigator.push(context, route);
                    }

                    ),
              ),
            ])));
  }

  _getincomecategoryList() async {
    final result = await SQlite().getincomecategoryList();
    setState(() {
      incomecategory = result;
    });
  }

  _getAccountList() async {
    final result = await SQlite().getAccountList();
    setState(() {
      accounts = result;
    });
  }
}
