import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String tampilan = '';
  String hasil = '';

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == '=') {
        hasil = calculate();
      } else if (buttonText == 'C') {
        tampilan = '';
        hasil = '';
      } else {
        tampilan += buttonText;
      }
    });
  }

  String calculate() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(tampilan);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      return eval.toString();
    } catch (e) {
      return 'Error';
    }
  }

  Widget buildButton(String buttonText, Color buttonColor, Color textColor) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => buttonPressed(buttonText),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
          foregroundColor: MaterialStateProperty.all<Color>(textColor),
          textStyle: MaterialStateProperty.all<TextStyle>(
            TextStyle(fontSize: 24.0),
          ),
        ),
        child: Text(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kalkulator Sederhana')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(16.0),
              child: Text(
                tampilan,
                style: TextStyle(fontSize: 32.0),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(16.0),
              child: Text(
                hasil,
                style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            children: [
              buildButton('7', Colors.grey[300]!, Colors.black),
              buildButton('8', Colors.grey[300]!, Colors.black),
              buildButton('9', Colors.grey[300]!, Colors.black),
              buildButton('/', Colors.blue, Colors.white),
            ],
          ),
          Row(
            children: [
              buildButton('4', Colors.grey[300]!, Colors.black),
              buildButton('5', Colors.grey[300]!, Colors.black),
              buildButton('6', Colors.grey[300]!, Colors.black),
              buildButton('*', Colors.blue, Colors.white),
            ],
          ),
          Row(
            children: [
              buildButton('1', Colors.grey[300]!, Colors.black),
              buildButton('2', Colors.grey[300]!, Colors.black),
              buildButton('3', Colors.grey[300]!, Colors.black),
              buildButton('-', Colors.blue, Colors.white),
            ],
          ),
          Row(
            children: [
              buildButton('0', Colors.grey[300]!, Colors.black),
              buildButton('.', Colors.grey[300]!, Colors.black),
              buildButton('C', Colors.grey, Colors.white),
              buildButton('+', Colors.blue, Colors.white),
            ],
          ),
          Row(
            children: [
              buildButton('=', Colors.green, Colors.white),
            ],
          ),
        ],
      ),
    );
  }
}
