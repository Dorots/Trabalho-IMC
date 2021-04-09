import 'dart:math';

import 'package:flutter/material.dart';

class CalculoIacWidget extends StatefulWidget {
  @override
  _CalculoIacWidgetState createState() => _CalculoIacWidgetState();
}

class _CalculoIacWidgetState extends State<CalculoIacWidget> {
  int _radioValue = 0;
  String tipo = "", _strClassificacao = "";
  String informativo = "";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController alturaController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  String _resultadoimc;

  void _calcularImc() {
    double altura = double.parse(alturaController.text) / 100;
    double circunferencia = double.parse(pesoController.text);
    double imc = (circunferencia / altura) * sqrt(altura);
    getClassificacao(imc);
    setState(() {
      _resultadoimc =
          "IAC = " + imc.toStringAsFixed(2) + "\n\n" + _strClassificacao;
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
      tipo = "Altura em cm";
      informativo = "Circunferncia em cm";
    });
    super.initState();
  }

  void getClassificacao(num imc) {
    String strClassificacao = "";

    {
      if (_radioValue == 1) {
        if (imc < 21) {
          strClassificacao = "Abaixo do normal";
        } else if (imc < 32.9) {
          strClassificacao = "Adiposidade normal";
        } else if (imc < 38) {
          strClassificacao = "Sobrepeso";
        } else {
          strClassificacao = "Obesidade";
        }
      } else {
        if (imc < 8) {
          strClassificacao = "Abaixo do normal";
        } else if (imc < 20.9) {
          strClassificacao = "Adiposidade normal";
        } else if (imc < 25) {
          strClassificacao = "Sobrepeso";
        } else {
          strClassificacao = "Obesidade";
        }
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    
                      new Text("IAC")
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
