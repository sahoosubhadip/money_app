import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:money_app/add_alldata_expenses.dart';
import 'package:money_app/add_alldata_income.dart';

class trans extends StatefulWidget {
  @override
  _transState createState() => _transState();
}

class _transState extends State<trans> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 4,
          child: Scaffold(
            floatingActionButton: SpeedDial(
                animatedIcon: AnimatedIcons.add_event,
                animatedIconTheme: IconThemeData(size: 20.0),
                closeManually: true,
                curve: Curves.bounceInOut,
                tooltip: 'Income and Expenses Catagory',
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                elevation: 8.0,
                shape: CircleBorder(),
                children: [
                  SpeedDialChild(
                      child: Icon(Icons.monetization_on),
                      backgroundColor: Colors.red,
                      label: 'Add Incomes',
                      labelStyle: TextStyle(fontSize: 18.0),
                      onTap: () async {
                        Route route = MaterialPageRoute(
                            builder: (context) => add_alldata_income());
                        await Navigator.push(context, route);
                      }),
                  SpeedDialChild(
                      child: Icon(Icons.money_off),
                      backgroundColor: Colors.red,
                      label: 'Add Expenses',
                      labelStyle: TextStyle(fontSize: 18.0),
                      onTap: () async {
                        Route route = MaterialPageRoute(
                            builder: (context) => add_alldata_expenses());
                        await Navigator.push(context, route);
                      })
                ]),
            appBar: AppBar(
              leading: FlatButton(
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2020, 01, 01),
                      maxTime: DateTime(2050, 12, 30), onChanged: (date) {
                    print('Change $date');
                  }, onConfirm: (date) {
                    print('Confirn $date');
                  });
                },
                child: Icon(
                  Icons.date_range,
                  color: Colors.white,
                ),
              ),
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: 'DAILY',
                  ),

                  Tab(
                    text: 'WEEKLY',
                  ),
                  Tab(
                    text: 'MONTHLY',
                  ),
                  Tab(
                    text: 'TOTAL',
                  ),
                ],
              ),
              title: Text('Money Manager'),
              backgroundColor: Colors.red,
              centerTitle: false,
              elevation: 5.0,
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.share), onPressed: () {}),
              ],
            ),
          ),
        ));
  }
}
