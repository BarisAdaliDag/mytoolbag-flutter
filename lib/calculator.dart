import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String result = "0";

  String equation = "0";
  String res = "0";
  String expression = "";
  double num1 = 0.0;
  double num2 = 0.0;
  String opr = "";

  buttonPressed(String btnVal) {
    setState(() {
      if (btnVal == "C") {
        equation = "0";
        result = "0";
      } else if (btnVal == "<-") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (btnVal == "=") {
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = btnVal;
        } else {
          equation = equation + btnVal;
        }
      }
    });
  }

  Widget valbutton(String btnVal, Color btncolor) {
    return Container(
      child: RaisedButton(
        child: Text(
          btnVal,
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        color: btncolor,
        padding: EdgeInsets.all(30),
        onPressed: () {
          buttonPressed(btnVal);
        },
      ),
      decoration: BoxDecoration(
        border: Border.all(
            width: 2, //
            style: BorderStyle.solid),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      body: Container(
        color: Colors.grey[700],
        child: Column(
          children: <Widget>[
            Container(
                width: double.infinity,
                height: 40,
                color: Colors.black,
                alignment: Alignment.bottomRight,
                child: Text(
                  equation,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                )),
            Container(
                width: double.infinity,
                height: 60,
                color: Colors.black,
                alignment: Alignment.bottomRight,
                child: Text(
                  result,
                  style: TextStyle(color: Colors.white, fontSize: 40),
                )),
            Container(
              alignment: Alignment.centerLeft,
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    valbutton('7', Colors.grey),
                    valbutton('8', Colors.grey),
                    valbutton('9', Colors.grey),
                    valbutton('*', Colors.amber),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    valbutton('4', Colors.grey),
                    valbutton('5', Colors.grey),
                    valbutton('6', Colors.grey),
                    valbutton('/', Colors.amber)
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    valbutton('1', Colors.grey),
                    valbutton('2', Colors.grey),
                    valbutton('3', Colors.grey),
                    valbutton('+', Colors.amber)
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    valbutton('0', Colors.grey),
                    valbutton('<-', Colors.amber),
                    valbutton('.', Colors.amber),
                    valbutton('-', Colors.amber),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(child: valbutton('C', Colors.amber)),
                Expanded(child: valbutton('=', Colors.red)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
