import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apple Style Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.black,
        colorScheme: ColorScheme.dark().copyWith(secondary: Colors.orange),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
        ),
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String result = "0";
  String input = "";

  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        input = "";
        result = "0";
      } else if (buttonText == "=") {
        try {
          result = evaluateExpression(input);
          input = "";
        } catch (e) {
          result = "Error";
        }
      } else {
        input += buttonText;
      }
    });
  }

  String evaluateExpression(String expression) {
    try {
      // Simple evaluation for basic arithmetic operations (+, -, *, /)
      List<String> tokens = expression.split(RegExp(r'(\+|\-|\*|\/)')); // Split by operators
      double num1 = double.parse(tokens[0]);
      double num2 = double.parse(tokens[1]);
      String operator = expression.replaceAll(RegExp(r'[^+\-*/]'), '').trim();

      switch (operator) {
        case '+':
          return (num1 + num2).toString();
        case '-':
          return (num1 - num2).toString();
        case '*':
          return (num1 * num2).toString();
        case '/':
          if (num2 != 0) {
            return (num1 / num2).toString();
          } else {
            return "Error";
          }
        default:
          return "Error";
      }
    } catch (e) {
      return "Error";
    }
  }

  Widget buildButton(String buttonText, Color buttonColor, {double fontSize = 30}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => onButtonPressed(buttonText),
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor, // Button color
            padding: const EdgeInsets.all(18.0),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(18)),
            ),
            elevation: 8, // Shadow effect for a more elevated look
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: buttonText == "=" || buttonText == "C" ? Colors.black : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apple Style Calculator'),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Display input and result
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                input,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                result,
                style: const TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          const Divider(thickness: 1, color: Colors.grey),
          
          // Buttons
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildButton("C", Colors.red),
                    buildButton("(", Colors.grey),
                    buildButton(")", Colors.grey),
                    buildButton("/", Colors.orange),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildButton("7", Colors.white, fontSize: 32),
                    buildButton("8", Colors.white, fontSize: 32),
                    buildButton("9", Colors.white, fontSize: 32),
                    buildButton("*", Colors.orange),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildButton("4", Colors.white, fontSize: 32),
                    buildButton("5", Colors.white, fontSize: 32),
                    buildButton("6", Colors.white, fontSize: 32),
                    buildButton("-", Colors.orange),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildButton("1", Colors.white, fontSize: 32),
                    buildButton("2", Colors.white, fontSize: 32),
                    buildButton("3", Colors.white, fontSize: 32),
                    buildButton("+", Colors.orange),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildButton("0", Colors.white, fontSize: 32),
                    buildButton(".", Colors.white, fontSize: 32),
                    buildButton("=", Colors.orange, fontSize: 32),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
