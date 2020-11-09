import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:nh_calculator/components/CalculatorKeyboard.dart';

class CalculatorPage extends StatefulWidget{
  @override
  CalculatorPageState createState() => CalculatorPageState();
}

class CalculatorPageState extends State<CalculatorPage> {
  static const platform = const MethodChannel('app.channel.shared.data');
  String text = '0';
  String result = '';
  String bracket = ')';
  String dataShared = "No data";
  @override
  void initState() {
    super.initState();
    getSharedText();
  }

  getSharedText() async {
    var sharedData = await platform.invokeMethod("getSharedText");
    if(sharedData.substring(0,4)=='sms:'){
      var number = sharedData.split(':')[1];
      String url = "https://nhentai.net/g/$number/";
      //launch(url);
      print(url);
      if (await canLaunch(url)) {
        await launch(url);
        SystemNavigator.pop();      
      } else {
        print('Could not launch $url');
      }
    }
  }

  void executeMath(){
    try {
      if(text=='0'){
        result='';
      }else{
        Parser p = Parser();
        Expression exp = p.parse(text.replaceAll('x', '*'));
        ContextModel cm = ContextModel();
        double ans = exp.evaluate(EvaluationType.REAL, cm);
        String finalAns = (ans % 1 == 0)? '$ans'.substring(0, '$ans'.length - 2) : '$ans';
        result = finalAns;
      }
    } catch(e) {
      result = '';
    }    
  }

  void delText(){
    setState(() {
      var lastChar = text.substring(text.length - 1);
      if(lastChar==' '){
        text = text.substring(0, text.length - 3);
      }else{
        text = text.substring(0, text.length - 1);
      }

      if(text == ''){
        text = '0';
        bracket = ')';
        result = '';
      }else{
        executeMath();
      }
    });
  }

  void addText(String v){
    setState(() {
      var lastChar = text.substring(text.length - 1);

      if(v=='C'){
        text = '0';
        bracket = ')';
        result = '';
      }else if (v=='='){
        text = result==''?'0':result;
        result = '';
        bracket = ')';
      }else{
        if(lastChar == '0'){
          if(text.length > 2)
          {
            if(text.substring(text.length - 2) == ' 0')
            {
              text = text.substring(0, text.length - 1);
            }
          }else{
            text = text.substring(0, text.length - 1);
          }
        }

        text += v;
        executeMath();
      }
    });
  }

  void addBrackets(){
    bracket = bracket == '(' ? ')' : '(';
    addText(bracket);
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, statusBarHeight, 0, 0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              
              child: Container(
                color: Color.fromARGB(255, 230, 230, 230),
                child:Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      '$text',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  )
                )
              ),
            ),

            Container(
                color: Color.fromARGB(255, 230, 230, 230),
                height: 70,
                child:Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      result,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  )
                )
            ),
            
            CalculatorKeyboard(addBrackets: addBrackets, addText: addText, delText: delText,)
          ],
        ),
      )
    );
  }
}