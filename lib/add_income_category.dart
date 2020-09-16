import 'package:flutter/material.dart';
import 'libary/SQlite.dart';

class add_income_category extends StatefulWidget {
  @override
  _add_income_categoryState createState() => _add_income_categoryState();
}

class _add_income_categoryState extends State<add_income_category> {



  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();

  String ADD_NEW_INCOME_CATEGORY = ' ';

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
          title: Text("Add Income Category".toUpperCase()),
          backgroundColor: Colors.red,
          centerTitle: true,
          elevation: 5.0,
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(children: <Widget>[
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
                  hintText: 'Enter Income Catagory Name',
                  labelText: 'Add New Income Category',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    ADD_NEW_INCOME_CATEGORY = value;
                  });
                },
              ),

              Container(
                height: 500,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: FlatButton.icon(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    color: Colors.red,
                    textColor: Colors.white,
                    icon: Icon(Icons.add_circle_outline),
                    label: Text("Add New Income Category".toUpperCase()),
                    onPressed: _getincomecategoryList),
              )
            ]))
    );
  }

  _getincomecategoryList() async {
    users_id = await SQlite().getUserID();
    if (ADD_NEW_INCOME_CATEGORY == " ") {
      _scaffolkey.currentState.showSnackBar(
          SQlite.errorToast("Please enter a Income Category Name..."));
    } else {
      try {
        int userID = await SQlite().getUserID();
        var id = await SQlite().addNewincomecategory({
          'category_tite': ADD_NEW_INCOME_CATEGORY.toString(),
          'category_icon': 'icon',
        });
        Navigator.pop(context);
      } catch (e) {
        print(e);
      }
    }
  }
}
