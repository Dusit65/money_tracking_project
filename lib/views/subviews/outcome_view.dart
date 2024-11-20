// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class OutcomeView extends StatefulWidget {
  const OutcomeView({super.key});

  @override
  State<OutcomeView> createState() => _OutcomeViewState();
}

class _OutcomeViewState extends State<OutcomeView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Text('Outcome View',
        ),
      ),
    );
  }
}