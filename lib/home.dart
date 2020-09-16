import 'package:flutter/material.dart';
import 'package:money_app/account.dart';
import 'package:money_app/settings.dart';
import 'package:money_app/stats.dart';
import 'package:money_app/trans.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  final _pageChooser = [
    trans(),
    stats(),
    account(),
    settings(),
  ];

  TabController _myTabController;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _myTabController = TabController(vsync: this, length: 5);
  }

  var Mydate = "Date";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(child: _pageChooser[_selectedIndex]),
        bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                backgroundColor: Colors.red,

                icon: Icon(Icons.update,color: Colors.white,),
                title: Text('Trans'),

              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.swap_horiz,color: Colors.white,),
                title: Text('Account Log'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet,color: Colors.white,),
                title: Text('Account'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings,color: Colors.white,),
                title: Text('Settings & Mnage'),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            onTap: (index) {
              debugPrint('Current index is $index');
              setState(() {
                _selectedIndex = index;
              });
            }));
  }

  Widget MyDate(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          getDate(context);
        },
        child: Text(Mydate),
      ),
    );
  }

  getDate(BuildContext context) async {
    Future<DateTime> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );

    setState(() {
      Mydate = selectedDate.toString();
    });
  }
}
