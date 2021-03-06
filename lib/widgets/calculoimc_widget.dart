import 'dart:math';

import 'package:flutter/material.dart';

class CalculoImcWidget extends StatefulWidget {
  @override
  _CalculoImcWidgetState createState() => _CalculoImcWidgetState();
}

class _CalculoImcWidgetState extends State<CalculoImcWidget> {
  int _radioValue = 0;
  String tipo = "", _strClassificacao = "";
  String informativo = "";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController alturaController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  String _resultadoimc;

  void _calcularImc() {
    double altura = double.parse(alturaController.text) / 100.0;
    double peso = double.parse(pesoController.text);
    double imc = peso / pow(altura, 2);
    setState(() {
      getClassificacao(imc);
      _resultadoimc =
          "IMC = " + imc.toStringAsFixed(2) + "\n\n" + _strClassificacao;
    });
  }

  void _valueSexochange(int value) {
    setState(() {
      _radioValue = value;
      _resultadoimc = "";
      _strClassificacao = "";
    });
  }

  void initState() {
    setState(() {
      _radioValue = 1;

      tipo = "Peso em kg";
      informativo = "Informe o peso";
    });
    super.initState();
  }

  void getClassificacao(num imc) {
    String strClassificacao = "";

    if (_radioValue == 1) {
      if (imc < 20) {
        strClassificacao = "Abaixo do peso";
      } else if (imc < 26.4) {
        strClassificacao = "Peso Ideal";
      } else if (imc < 27.8) {
        strClassificacao = "Levemente acima do peso";
      } else if (imc < 31.1) {
        strClassificacao = "Acima do Peso";
      } else if (imc > 31.1) {
        strClassificacao = "Obesidade";
      }
    } else {
      if (imc < 18.5) {
        strClassificacao = "Abaixo do peso";
      } else if (imc < 24.9) {
        strClassificacao = "Peso Ideal";
      } else if (imc < 29.9) {
        strClassificacao = "Levemente acima do peso";
      } else if (imc < 34.9) {
        strClassificacao = "Obesidade grau I";
      } else if (imc < 39.9) {
        strClassificacao = "Obesidade grau II";
      } else {
        strClassificacao = "Obesidade grau III";
      }
    }

    _strClassificacao = strClassificacao;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Container(
          child: Column(
            children: [
              Container(
                margin:
                    EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 6),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 1,
                        groupValue: _radioValue,
                        onChanged: _valueSexochange,
                      ),
                      new Text("Homem"),
                      Radio(
                        value: 2,
                        groupValue: _radioValue,
                        onChanged: _valueSexochange,
                      ),
                      new Text("Mulher")
                    ],
                  ),
                ]),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 6),
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
                margin:
                    EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 6),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  //Peso
                  controller: pesoController,
                  validator: (value) {
                    return value.isEmpty ? informativo : null;
                  },
                  decoration: InputDecoration(
                    labelText: tipo,
                  ),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 6),
                child: Text(_resultadoimc == null ? "" : _resultadoimc),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 6),
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
      ),
    );
  }
}
