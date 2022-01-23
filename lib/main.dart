import 'dart:async';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: <Widget>[
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: LinearProgressIndicator(
                minHeight: 32,
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
                  // onPressed: _busy ? null : _processCompute,
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

// I/flutter (13861): 2022-01-23T14:37:56.012271: processCompute: started...
// I/flutter (13861): 2022-01-23T14:37:56.012857: _createJson: in
// I/flutter (13861): 2022-01-23T14:37:59.558154: _createJson: out, size=148879980
// I/flutter (13861): 2022-01-23T14:37:59.775581: processCompute: fakeJson created
// 220 ms
// I/flutter (13861): 2022-01-23T14:37:59.776229: _parseJson: in
// I/flutter (13861): 2022-01-23T14:38:02.313994: _parseJson: out
// I/flutter (13861): 2022-01-23T14:38:03.023584: _processCommon: finished, jsonMap["500"]=2022-01-23T14:37:56.013481
// 710 ms
Future<void> _processCompute() async {
  await compute(_computeFunc, '');
}

Future<void> _computeFunc(_) async {
  final Map<String, dynamic> jsonMap = await processCompute();

  dbg('_processCommon: finished, jsonMap["500"]=${jsonMap['prefix_500']}');
}
