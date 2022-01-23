import 'dbg.dart';
import 'json_functions.dart';

// I/flutter (14161): 2022-01-23T14:48:08.479280: _processFuture: started...
// I/flutter (14161): 2022-01-23T14:48:08.479402: _createJson: in
// I/flutter (14161): 2022-01-23T14:48:11.051631: _createJson: out, size=148879971
// I/flutter (14161): 2022-01-23T14:48:11.178998: _processFuture: fakeJson created
// I/flutter (14161): 2022-01-23T14:48:11.179135: _parseJson: in
// I/flutter (14161): 2022-01-23T14:48:13.028815: _parseJson: out
// I/flutter (14161): 2022-01-23T14:48:13.028923: _processCommon: finished, jsonMap["500"]=2022-01-23T14:48:08.481289
//
Future<Map<String, dynamic>> processFuture() async {
  dbg('_processFuture: started...');

  final String fakeJson = await createJson('prefix');

  dbg('_processFuture: fakeJson created');

  return await parseJson(fakeJson);
}
