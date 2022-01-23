import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'dbg.dart';
import 'process_compute.dart';
import 'process_future.dart';
import 'process_spawn.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showPerformanceOverlay: kProfileMode,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _busy = false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double size = min(screenSize.width, screenSize.height);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Center(
              child: SizedBox(
                width: size,
                height: size,
                child: const CircularProgressIndicator(
                  strokeWidth: 32,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  onPressed: _busy ? null : () => _processCommon(processSpawn),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('START SPAWN'),
                  ),
                ),
                TextButton(
                  onPressed: _busy ? null : () => _processCommon(processCompute),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('START COMPUTE'),
                  ),
                ),
                TextButton(
                  onPressed: _busy ? null : () => _processCommon(processFuture),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('START FUTURE'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _processCommon(FutureOr<Map<String, dynamic>> Function() processSpecific) async {
    try {
      setState(() => _busy = true);

      final Map<String, dynamic> jsonMap = await processSpecific();

      dbg('_processCommon: finished, jsonMap["500"]=${jsonMap['prefix_500']}');
    } on Exception catch (error) {
      dbg('_processCommon: error=$error');
    } finally {
      setState(() => _busy = false);
    }
  }
}
