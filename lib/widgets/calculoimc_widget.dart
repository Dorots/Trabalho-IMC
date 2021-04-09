import 'dart:math';

import 'package:flutter/material.dart';

class CalculoImcWidget extends StatefulWidget {
  @override
  _CalculoImcWidgetState createState() => _CalculoImcWidgetState();
}

class _CalculoImcWidgetState extends State<CalculoImcWidget> {
  int _radioValue = 0;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController alturaController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  String _resultadoimc;

  void _calcularImc() {
    if (_radioValue == 1) {
      double altura = double.parse(alturaController.text) / 100.0;
      double peso = double.parse(pesoController.text);
      double imc = peso / pow(altura, 2);

      setState(() {
        _resultadoimc = imc.toStringAsFixed(2) + "\n\n" + getClassificacao(imc);
      });
    } else {}
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
    });
  }

  void initState() {
    setState(() {
      _radioValue = 1;
    });
    super.initState();
  }

  String getClassificacao(num imc) {
    String strClassificacao;

    if (_radioValue == 1) {
      if (imc < 18.6) {
        strClassificacao = "Abaixo do peso";
      } else if (imc < 25.0) {
        strClassificacao = "Peso Ideal";
      } else if (imc < 30.0) {
        strClassificacao = "Levemente acima do peso";
      } else if (imc < 35.0) {
        strClassificacao = "Obesidade grau I";
      } else if (imc < 40.0) {
        strClassificacao = "Obesidade grau II";
      } else {
        strClassificacao = "Obesidade grau III";
      }
    }
    {}

    return strClassificacao;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(
                    value: 1,
                    groupValue: _radioValue,
                    onChanged: _handleRadioValueChange,
                  ),
                  new Text("Homem"),
                  Radio(
                    value: 2,
                    groupValue: _radioValue,
                    onChanged: _handleRadioValueChange,
                  ),
                  new Text("Mulher")
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: TextFormField(
                keyboardType: TextInputType.number,
                //Altura
                controller: alturaController,
                validator: (value) {
                  return value.isEmpty ? "Informe a altura" : null;
                },
                decoration: InputDecoration(
                  labelText: "Altura em cm",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: TextFormField(
                keyboardType: TextInputType.number,
                //Peso
                controller: pesoController,
                validator: (value) {
                  return value.isEmpty ? "Informe o peso" : null;
                },
                decoration: InputDecoration(
                  labelText: "Peso em Kg",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: Text(_resultadoimc == null ? "" : "IMC = $_resultadoimc"),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _calcularImc();
                  }
                },
                child: Text("Calcular"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
