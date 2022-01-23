import 'dbg.dart';
import 'json_functions.dart';

Future<Map<String, dynamic>> processFuture() async {
  dbg('_processFuture: started...');

  final String fakeJson = await createJson('prefix');

  dbg('_processFuture: fakeJson created');

  return await parseJson(fakeJson);
}
