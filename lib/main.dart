import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = TextEditingController();
  List<bool> _selection = [true, false, false];
  String tip = ''; // Initialize tip to an empty string

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (tip.isNotEmpty)
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    tip,
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              Text('Total Amount'),
              SizedBox(
                width: 50,
                child: TextField(
                  controller: controller,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(hintText: '\$100.00'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: ToggleButtons(
                  children: [
                    Text('10%'),
                    Text('15%'),
                    Text('20%'),
                  ],
                  isSelected: _selection,
                  onPressed: updateSelection,
                ),
              ),
              ElevatedButton(
                onPressed: calculateTip,
                child: Text('Calculate Tip'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateSelection(int selectedIndex) {
    setState(
          () {
        for (int i = 0; i < _selection.length; i++) {
          _selection[i] = selectedIndex == i;
        }
      },
    );
  }

  void calculateTip() {
    final totalAmount = double.parse(controller.text);
    final selectedIndex = _selection.indexWhere((element) => element);
    final tipPercentage = [0.1, 0.15, 0.2][selectedIndex];

    final tipTotal = (totalAmount * tipPercentage).toStringAsFixed(2);

    setState(() {
      tip = '\$$tipTotal';
    });
  }
}
