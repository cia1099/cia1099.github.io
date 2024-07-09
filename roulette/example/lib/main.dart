import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:roulette/roulette.dart';

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
        primarySwatch: Colors.blue,
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
  final duration = const Duration(seconds: 5);
  int targetNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) => RouletteAnimation(
            duration: duration,
            diameter: constraints.maxWidth * 0.75,
            targetNumber: targetNumber,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          targetNumber = math.Random().nextInt(37);
        }),
        tooltip: 'Rolling',
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationX(math.pi),
          child: const Icon(Icons.replay_rounded),
        ),
      ),
    );
  }
}
