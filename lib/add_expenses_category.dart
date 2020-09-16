import 'package:flutter/material.dart';
import 'libary/SQlite.dart';

class add_expenses_category extends StatefulWidget {
  @override
  _add_expenses_categoryState createState() => _add_expenses_categoryState();
}

class _add_expenses_categoryState extends State<add_expenses_category> {
  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();

    String ADD_NEW_EXPENSES_CATAGORY =' ';

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
        title: Text("Add Expenses Category".toUpperCase()),
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
                        hintText: 'Enter Expenses Catagory Name',
                        labelText: 'Add New Expenses Category',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(),
                        ),
                      ),
                    onChanged: (value) {
                     setState(() {
                        ADD_NEW_EXPENSES_CATAGORY = value;
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
                      label: Text("Add New Expenses Category".toUpperCase()),
                      onPressed:_getexpensescategoryList),
                    )]
                  )


            )
        );

  }

  _getexpensescategoryList()async {
    users_id = await SQlite().getUserID();
    if (ADD_NEW_EXPENSES_CATAGORY == " ") {
      _scaffolkey.currentState.showSnackBar(
          SQlite.errorToast("Please enter a Expenses Category Name..."));
    }
    else {
      try {
        int userID = await SQlite().getUserID();
        var id = await SQlite().addNewexpensescategory({
          'category_name': ADD_NEW_EXPENSES_CATAGORY.toString(),
          'category_icon': 'icon',
        });
        Navigator.pop(context);
      } catch (e) {
        print(e);
      }
    }
  }
}
