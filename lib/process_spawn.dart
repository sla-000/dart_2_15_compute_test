import 'dart:isolate';

import 'dbg.dart';
import 'json_functions.dart';

// https://github.com/dart-lang/samples/blob/master/isolates/bin/send_and_receive.dart
//
// I/flutter (14161): 2022-01-23T14:46:35.686301: processSpawn: started...
// I/flutter (14161): 2022-01-23T14:46:35.687544: _createJson: in
// I/flutter (14161): 2022-01-23T14:46:39.017954: _createJson: out, size=148879911
// I/flutter (14161): 2022-01-23T14:46:39.233823: processSpawn: fakeJson created
// I/flutter (14161): 2022-01-23T14:46:39.236357: _parseJson: in
// I/flutter (14161): 2022-01-23T14:46:41.684313: _parseJson: out
// I/flutter (14161): 2022-01-23T14:46:42.394109: _processCommon: finished, jsonMap["500"]=2022-01-23T14:46:35.688213
//
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
