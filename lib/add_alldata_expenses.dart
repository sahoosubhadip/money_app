import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_app/ViewExpenses.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'libary/SQlite.dart';

class add_alldata_expenses extends StatefulWidget {
  @override
  _add_alldata_expensesState createState() => _add_alldata_expensesState();
}

class _add_alldata_expensesState extends State<add_alldata_expenses> {
  String _image;
  List expensescategory = [];
  String select_expenses_category = '1';
  final dateController = TextEditingController();
  List accounts = [];
  String select_accounts = '1';

  Future getImage(source) async {
    var image = await ImagePicker.pickImage(source: source);

    setState(() {
      _image = image.path;
    });
  }

  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();
  String Expenses_Amount = '';
  String perpus_transaction = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getexpensescategoryList();
    _getAccountList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffolkey,
        appBar: AppBar(
          title: Text("Add New Expenses".toUpperCase()),
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
                height: 25,
              ),
              DropdownButton<String>(
                isExpanded: true,
                value: select_expenses_category,
                hint: Text('Please Choose a Expenses Category'),
                items: expensescategory.map((expenses) {
                  return DropdownMenuItem<String>(
                    value: expenses['id'].toString(),
                    child: Text(expenses['category_name'].toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    select_expenses_category = value.toString();
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
                  labelText: 'Expenses Amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    Expenses_Amount = value;
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
                        print('Confirn $date');
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
                  // padding: EdgeInsets.only(top: 10, bottom: 10),
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
                  // padding: EdgeInsets.only(top: 10, bottom: 10),
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
                    label: Text("Add New Expenses".toUpperCase()),
                    onPressed: ()async {


                      await SQlite().add_accountlog({
                        'amount': Expenses_Amount,
                        'expense_category_id': select_expenses_category,
                        'account_id':select_accounts,
                        'transaction_type':'Debit',
                        'perpus_transaction':perpus_transaction,
                        'transaction_bill_img': _image,
                        'creat_date': dateController.text

                      });

                      Route route = MaterialPageRoute(builder: (context)=> ViewExpenses());
                      var returnBack =await Navigator.push(context, route);


                    }),
              )
            ])));
  }

  _getexpensescategoryList() async {
    final result = await SQlite().getexpensescategoryList();
    setState(() {
      expensescategory = result;
    });
  }

  _getAccountList() async {
    final result = await SQlite().getAccountList();
    setState(() {
      accounts = result;
    });
  }
}
