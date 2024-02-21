import 'package:currency_converter/pages/exchange.dart';
import 'package:currency_converter/pages/home_page.dart';
import 'package:flutter/material.dart';


class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _selectedIndex=0;
  List pages=[HomePage(),Exchange()];

  Widget getView(){
    if(_selectedIndex==0){
      return HomePage();
    }
    return Exchange();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.black,
    appBar: AppBar(title: Text("Flutter Currency Exchange"),
      centerTitle: true,
      backgroundColor: Colors.blue.shade400
      ,),
      body: getView(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
          onTap: (index){
          setState(() {
            _selectedIndex=index;
          });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.currency_exchange),label: "Exchange")
          ]),
    );
  }
}
