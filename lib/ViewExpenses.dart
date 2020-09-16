import 'package:flutter/material.dart';

import 'libary/SQlite.dart';

class ViewExpenses extends StatefulWidget {
  @override
  _ViewExpensesState createState() => _ViewExpensesState();
}

class _ViewExpensesState extends State<ViewExpenses> {
  List account_log = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: account_log.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(account_log[index]['category_name'].toString()),
              subtitle: Text(account_log[index]['creat_date'].toString()),
              trailing:
              Text("Rs." + account_log[index]['amount'].toString()),
            ),
          );
        });
  }

  _getExpenses() async {
    final result = await SQlite().get_accountlog('Debit');
    for (var i = 0; i < result.length; i++) {
      account_log.add({
        'creat_date': result[i] ['creat_date'],
        'amount': result[i]['amount'],
        'category_name': await SQlite().getCategoryNameID(
            result[i]['expense_category_id'], 'expense_category')
      });
      print(await SQlite().getCategoryNameID(
          result[i]['expense_category_id'], 'expense_category'));

    }
    print(result);
    setState(() {

    });
  }

}
