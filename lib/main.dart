import 'package:flutter/material.dart';
import 'package:flutter_app/Model1Compoenent/Model1List.dart';

import 'Model2Component/Model2List.dart';
import 'Model3Compoenent/Model3List.dart';
import 'Model4Compoenent/Model4List.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter DB App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title as String),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Model 1
            RaisedButton(
              child: const Text("Model 1"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Model1List();
                    },
                  ),
                );
              },
            ),
            //Model 2
            RaisedButton(
              child: const Text("Model 2"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Model2List();
                    },
                  ),
                );
              },
            ),
            //Model 3
            RaisedButton(
              child: const Text("Model 3"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Model3List();
                    },
                  ),
                );
              },
            ),
            //Model 4
            RaisedButton(
              child: const Text("Model 4"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Model4List();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
