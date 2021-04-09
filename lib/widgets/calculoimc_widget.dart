import 'dart:math';

import 'package:flutter/material.dart';

class CAlculoImcWidget extends StatefulWidget {
  @override
  _CAlculoImcWidgetState createState() => _CAlculoImcWidgetState();
}

class _CAlculoImcWidgetState extends State<CAlculoImcWidget> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController alturacontroller = TextEditingController();
  TextEditingController pesocontroller = TextEditingController();
  String _resultadoimc;

  void _calcularimc() {
    double altura = double.parse(alturacontroller.text) / 100.0;
    double peso = double.parse(pesocontroller.text);
    double imc = peso / pow(altura, 2);

    setState(() {
      _resultadoimc = imc.toStringAsFixed(2) + "\n\n" + getClassificao(imc);
    });
  }

  String getClassificao(num imc) {
    String strclassificacao;
    if (imc < 18.6)
      strclassificacao = "Abaixo do peso";
    else if (imc < 25.0)
      strclassificacao = "Peso ideal";
    else if (imc < 30.0)
      strclassificacao = "Levemente acima do peso";
    else if (imc < 35.0)
      strclassificacao = "Obesidade I";
    else if (imc < 40.0)
      strclassificacao = "Obesidade II";
    else
      strclassificacao = "besidade III";
    return strclassificacao;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(16.0),
              //Altura
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: alturacontroller,
                validator: (value) {
                  return value.isEmpty ? "Informe a altura" : null;
                },
                decoration: InputDecoration(
                  labelText: "Altua em cm",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16.0),
              //Peso
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: pesocontroller,
                validator: (value) {
                  return value.isEmpty ? "Informe a peso" : null;
                },
                decoration: InputDecoration(
                  labelText: "Peso em Kg",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: Text(_resultadoimc == null ? "" : "IMC :$_resultadoimc"),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState.validate()) {
                    _calcularimc();
                  }
                },
                child: Text('Calcular'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
