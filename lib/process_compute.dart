import 'package:flutter/foundation.dart';

import 'dbg.dart';
import 'json_functions.dart';

// I/flutter (14161): 2022-01-23T14:47:18.410061: processCompute: started...
// I/flutter (14161): 2022-01-23T14:47:18.412532: _createJson: in
// I/flutter (14161): 2022-01-23T14:47:22.038294: _createJson: out, size=148880016
// I/flutter (14161): 2022-01-23T14:47:22.274643: processCompute: fakeJson created
// I/flutter (14161): 2022-01-23T14:47:22.276319: _parseJson: in
// I/flutter (14161): 2022-01-23T14:47:24.908486: _parseJson: out
// I/flutter (14161): 2022-01-23T14:47:25.736870: _processCommon: finished, jsonMap["500"]=2022-01-23T14:47:18.414178
//
Future<Map<String, dynamic>> processCompute() async {
  dbg('processCompute: started...');

  final String fakeJson = await compute(createJson, 'prefix');

  dbg('processCompute: fakeJson created');

  return await compute(parseJson, fakeJson);
}
