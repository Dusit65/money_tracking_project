// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:intl/message_format.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          
          children: [
            // Container(
            //   width: MediaQuery.of(context).size.width *1,
            //   height: MediaQuery.of(context).size.height *0.5,
            //   color: const Color.fromARGB(255, 54, 137, 131), // Main Color
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(30)
            //   ),
            // ),
            Container(
              width: MediaQuery.of(context).size.width *1,
              height: MediaQuery.of(context).size.height *0.33,
              decoration: BoxDecoration(
                color: const Color(0xFF3E7C78), // Main Color
                borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                            MediaQuery.of(context).size.width, 100.0),

                      )
              ),
                
            )
          ],
        )
      ),
    );
  }
}