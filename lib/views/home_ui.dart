// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_tracking_project/views/subviews/income_view.dart';
import 'package:money_tracking_project/views/subviews/main_view.dart';
import 'package:money_tracking_project/views/subviews/outcome_view.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  int _selectedIndex = 1;
  //Vareiables View to work with bottomNavigationBar
  List<Widget> _showView = [
    IncomeView(),
    MainView(),
    OutcomeView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showView[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.indent),
            label: 'Income',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Main',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.outdent),
            label: 'Outcome',
          ),
        ],
        
        backgroundColor: const Color.fromARGB(255, 54, 137, 131), // Main Color
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false, //Hide labels
        showUnselectedLabels: false, //Hide labels
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;            
          });
        },
      ),
    );
  }
}
