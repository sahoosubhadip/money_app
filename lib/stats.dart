import 'package:flutter/material.dart';
import 'ViewIncome.dart';
import 'ViewExpenses.dart';

class stats extends StatefulWidget {
  @override
  _statsState createState() => _statsState();
}

class _statsState extends State<stats> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(" Account Log "),
          backgroundColor: Colors.red,
          centerTitle: true,
          elevation: 5.0,
          bottom: TabBar(
            tabs: [
              Tab( text: 'Income',
                icon: Icon(Icons.assignment_returned),),
              Tab(text: 'Expenses',
                icon: Icon(Icons.unarchive),),
            ],
          ),

        ),
        body: TabBarView(
          children: [
            ViewIncome(),
            ViewExpenses()

          ],
        ),
      ),
    );


  }
}
