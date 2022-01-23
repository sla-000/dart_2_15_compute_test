import 'package:flutter/foundation.dart';

import 'dbg.dart';
import 'json_functions.dart';

Future<Map<String, dynamic>> processCompute() async {
  dbg('processCompute: started...');

  final String fakeJson = await compute(createJson, 'prefix');

  dbg('processCompute: fakeJson created');

  return await compute(parseJson, fakeJson);
}
