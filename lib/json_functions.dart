import 'dart:convert';

import 'dbg.dart';

const int kCount = 10000000;

Future<String> createJson(String prefix) async {
  dbg('_createJson: in');
  final StringBuffer fakeJsonBuffer = StringBuffer();

  fakeJsonBuffer.writeln('{');

  for (int count = 0; count < kCount; ++count) {
    fakeJsonBuffer.write('  "${prefix}_$count": "${DateTime.now().toIso8601String()}"');

    if (count == kCount - 1) {
      fakeJsonBuffer.writeln('');
    } else {
      fakeJsonBuffer.writeln(',');
    }
  }

  fakeJsonBuffer.writeln('}');

  dbg('_createJson: out');
  return fakeJsonBuffer.toString();
}

Future<Map<String, dynamic>> parseJson(String jsonStr) async {
  dbg('_parseJson: in');

  final Map<String, dynamic> jsonMap = json.decode(jsonStr);

  dbg('_parseJson: out');
  return jsonMap;
}
