import 'package:flutter/material.dart';


class CalculatorKeyboard extends StatelessWidget{

  final Function(String) addText;
  final Function() delText;
  final Function() addBrackets;

  CalculatorKeyboard({Key key, this.addText, this.delText, this.addBrackets}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        Container(
              color: Color.fromARGB(255, 200, 200, 200),
              child:Row(
                children: [
                  CalculatorButton(title: 'C', flex:1, callback: (){ addText('C'); },),
                  CalculatorButton(title: '()', flex:1, callback: (){ addBrackets(); },),
                  CalculatorButton(title: 'del', flex:1, callback: (){ delText(); },),
                  CalculatorButton(title: '/', flex:1, callback: (){ addText(' / '); },),
                ],
              )
            ),
            Container(
              color: Color.fromARGB(255, 200, 200, 200),
              child:Row(
                children: [
                  CalculatorButton(title: '7', flex:1, callback: (){ addText('7'); },),
                  CalculatorButton(title: '8', flex:1, callback: (){ addText('8'); },),
                  CalculatorButton(title: '9', flex:1, callback: (){ addText('9'); },),
                  CalculatorButton(title: '*', flex:1, callback: (){ addText(' * '); },),
                ],
              )
            ),
            Container(
              color: Color.fromARGB(255, 200, 200, 200),
              child:Row(
                children: [
                  CalculatorButton(title: '4', flex:1, callback: (){ addText('4'); },),
                  CalculatorButton(title: '5', flex:1, callback: (){ addText('5'); },),
                  CalculatorButton(title: '6', flex:1, callback: (){ addText('6'); },),
                  CalculatorButton(title: '-', flex:1, callback: (){ addText(' - '); },),
                ],
              )
            ),
            Container(
              color: Color.fromARGB(255, 200, 200, 200),
              child:Row(
                children: [
                  CalculatorButton(title: '1', flex:1, callback: (){ addText('1'); },),
                  CalculatorButton(title: '2', flex:1, callback: (){ addText('2'); },),
                  CalculatorButton(title: '3', flex:1, callback: (){ addText('3'); },),
                  CalculatorButton(title: '+', flex:1, callback: (){ addText(' + '); },),
                ],
              )
            ),
            Container(
              color: Color.fromARGB(255, 200, 200, 200),
              child:Row(
                children: [
                  CalculatorButton(title: '0', flex:2, callback: (){ addText('0'); },),
                  CalculatorButton(title: '.', flex:1, callback: (){ addText('.'); },),
                  CalculatorButton(title: '=', flex:1, callback: (){ addText('='); },),
                ],
              )
            ),
      ],
    );
  }
}

class CalculatorButton extends StatelessWidget {

  final String title;
  final int flex;
  final Function callback;
  CalculatorButton({Key key, this.title, this.flex, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('button build');
    return Expanded(
      flex:flex,
      child: Container(
        color: Color.fromARGB(255, 255, 255, 255),
        height: 80,
        margin: EdgeInsets.all(1),
        child: Material(
          child: InkWell(
            onTap: (){callback();},
            child: Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 25,
                  color: Color.fromARGB(255, 120, 120, 120)
                ),
              ),
            )
          ),
        ),
      )
      
    );
  }
}
