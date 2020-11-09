import 'package:flutter/material.dart';

import 'package:nh_calculator/screens/CalculatorPage.dart';
import 'package:permission_handler/permission_handler.dart';

void askSmsPermission() async {
  if(await Permission.sms.request().isDenied){
    askSmsPermission();
  }
}

void main(){
  runApp(MyApp());
  askSmsPermission();
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => CalculatorPage(),
      },
    );
  }
}
