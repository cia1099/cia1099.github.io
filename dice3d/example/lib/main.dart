import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zflutter/zflutter.dart';

import 'package:dice3d/dice3d.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var points = [1, 1, 1, 1];

  void _incrementCounter() {
    setState(() {
      points = List.generate(points.length, (index) => Random().nextInt(5) + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            // width: 150,
            height: 300,
            color: Colors.green,
            child: Stack(
              children: [
                ZDragDetector(
                  builder: (context, controller) => Dice3D(
                    duration: Duration(seconds: 2),
                    points: points,
                  ),
                ),
                // Dices(),
                Text("Shit")
              ],
            ),
          ),
          Text("current point = $points"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
