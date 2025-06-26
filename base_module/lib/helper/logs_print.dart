// log_helper.dart

void logMessage(dynamic message,
    {String type = 'INFO', String? location, String? tagName}) {
  final timestamp = DateTime.now().toIso8601String();
  final logType = type.toUpperCase();
  final tag = tagName != null ? ' | $tagName' : '';
  final header =
      '[ $logType$tag | $timestamp ]${location != null ? ' @ $location' : ''}';
  final divider = '═' * 60;

  print('''
$divider
$header
${'-' * header.length}
$message
$divider
  ''');
}
