import 'dart:isolate';

import 'dbg.dart';
import 'json_functions.dart';

// https://github.com/dart-lang/samples/blob/master/isolates/bin/send_and_receive.dart
Future<Map<String, dynamic>> processSpawn() async {
  dbg('processSpawn: started...');

  final String fakeJson = await _spawnCreate('prefix');

  dbg('processSpawn: fakeJson created');

  return await _spawnParse(fakeJson);
}

Future<String> _spawnCreate(String prefix) async {
  final p = ReceivePort();
  await Isolate.spawn(_createJsonInIsolate, [p.sendPort, prefix]);
  return (await p.first) as String;
}

void _createJsonInIsolate(List<dynamic> args) async {
  SendPort responsePort = args[0];
  String prefix = args[1];

  final String jsonStr = await createJson(prefix);

  Isolate.exit(responsePort, jsonStr);
}

Future<Map<String, dynamic>> _spawnParse(String jsonStr) async {
  final p = ReceivePort();
  await Isolate.spawn(_parseJsonInIsolate, [p.sendPort, jsonStr]);
  return (await p.first) as Map<String, dynamic>;
}

void _parseJsonInIsolate(List<dynamic> args) async {
  SendPort responsePort = args[0];
  String jsonStr = args[1];

  final Map<String, dynamic> jsonMap = await parseJson(jsonStr);

  Isolate.exit(responsePort, jsonMap);
}
