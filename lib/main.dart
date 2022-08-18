import 'package:flutter/material.dart';
import 'package:nested_navigation_demo_flutter/app.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp( // 여기에서 routes 를 사용해도 되었을 텐데 그냥 Navigator 를 따로 만들어서 사용했다.
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: App(),
    );
  }
}

