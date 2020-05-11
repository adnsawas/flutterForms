import 'package:flutter/material.dart';
import 'package:flutter_forms/add_emp_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Forms',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forms Demo"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Add Employee"),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => FormPage(), fullscreenDialog: true),
            );
          },
        ),
      ),
    );
  }
}
