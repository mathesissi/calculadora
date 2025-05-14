import 'dart:io';

import 'package:calculadora/widgets/BotaoDaCalculadora.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MeuApp());
}

class MeuApp extends StatefulWidget {
  const MeuApp({super.key});

  @override
  State<MeuApp> createState() => _MeuAppState();
}

class _MeuAppState extends State<MeuApp> {
  late TextEditingController _visorController;
  List<String> entrada = [];
  bool resultadoMostrado = false;

  @override
  void initState() {
    super.initState();
    _visorController = TextEditingController();
  }

  @override
  void dispose() {
    _visorController.dispose();
    super.dispose();
  }

  void adicionarValor(String x) {
    setState(() {
      if (resultadoMostrado && '0123456789.'.contains(x)) {
        entrada.clear();
      }
      entrada.add(x);
      _visorController.text = entrada.join();
      resultadoMostrado = false;
    });
  }

  void calcular() {
    String expressao;
    double resultado;
    var sec = const Duration(seconds: 6);
    if (entrada.isEmpty) return;

    if (entrada.last != '+' &&
        entrada.last != '-' &&
        entrada.last != '*' &&
        entrada.last != '/') {
      expressao = entrada.join();
      try {
        ExpressionParser p = GrammarParser();
        Expression exp = p.parse(expressao);
        ContextModel cm = ContextModel();
        resultado = exp.evaluate(EvaluationType.REAL, cm);

        print(resultado);
        _visorController.text = resultado.toString();
        entrada = [resultado.toString()];
        resultadoMostrado = true;
      } catch (erro) {
        print('Expressão matematica inconpleta!');
        _visorController.text = 'erro';
      }
    } else {
      _visorController.text = 'erro';
    }
  }

  void limparTela() {
    entrada.clear();
    _visorController.text = entrada.join();
  }

  void removerUltimoValor() {
    if (entrada.isNotEmpty) {
      entrada.removeLast();
    }
    _visorController.text = entrada.join();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xff002646),
        appBar: AppBar(
          backgroundColor: Color(0xff0066B9),
          title: Text(
            'Calculadora',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Sans',
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: double.infinity,
                height: 300,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextField(
                      readOnly: false,
                      textAlign: TextAlign.right,
                      controller: _visorController,
                      style: TextStyle(fontSize: 100),
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  childAspectRatio: 1.1,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,

                  children: [
                    BotaoDaCalculadora('C', () {
                      limparTela();
                    }),
                    BotaoDaCalculadora('DEL', () {
                      removerUltimoValor();
                    }),
                    BotaoDaCalculadora('(', () {
                      adicionarValor('(');
                    }),
                    BotaoDaCalculadora(')', () {
                      adicionarValor(')');
                    }),

                    BotaoDaCalculadora('7', () {
                      adicionarValor('7');
                    }),
                    BotaoDaCalculadora('8', () {
                      adicionarValor('8');
                    }),
                    BotaoDaCalculadora('9', () {
                      adicionarValor('9');
                    }),
                    BotaoDaCalculadora('/', () {
                      adicionarValor('/');
                    }),
                    BotaoDaCalculadora('4', () {
                      adicionarValor('4');
                    }),
                    BotaoDaCalculadora('5', () {
                      adicionarValor('5');
                    }),
                    BotaoDaCalculadora('6', () {
                      adicionarValor('6');
                    }),
                    BotaoDaCalculadora('*', () {
                      adicionarValor('*');
                    }),
                    BotaoDaCalculadora('1', () {
                      adicionarValor('1');
                    }),
                    BotaoDaCalculadora('2', () {
                      adicionarValor('2');
                    }),
                    BotaoDaCalculadora('3', () {
                      adicionarValor('3');
                    }),
                    BotaoDaCalculadora('-', () {
                      adicionarValor('-');
                    }),
                    BotaoDaCalculadora('0', () {
                      adicionarValor('0');
                    }),
                    BotaoDaCalculadora(',', () {
                      adicionarValor('.');
                    }),
                    BotaoDaCalculadora('=', () {
                      calcular();
                    }),
                    BotaoDaCalculadora('+', () {
                      adicionarValor('+');
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
