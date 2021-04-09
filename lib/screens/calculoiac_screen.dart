import 'package:aula2503/widgets/calculoiac_widget.dart';
import 'package:flutter/material.dart';

class CalculoIacScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cálculo IAC'),
      ),
      body: CalculoIacWidget(),
    );
  }
}