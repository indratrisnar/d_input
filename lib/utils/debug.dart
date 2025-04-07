part of '../d_input.dart';

debugInput(String title, String method, data) {
  debugPrint('-' * 60);
  debugPrint('$title->$method:');
  switch (data.runtimeType) {
    case DateTime:
      final date = data as DateTime;
      debugPrint('$date');
    case TimeOfDay:
      final time = data as TimeOfDay;
      debugPrint('$time');
    case XFile:
      final xFile = data as XFile;
      debugPrint(xFile.name);
      break;
    case const (List<XFile>):
      final xFiles = data as List<XFile>;
      debugPrint('${xFiles.map((e) => e.name)}');
      break;
    default:
      debugPrint('$data');
      break;
  }
  debugPrint('-' * 60);
}
