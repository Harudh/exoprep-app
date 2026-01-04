import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class FlashCardFileHelper {
  /// Moves a temporary file to permanent storage to prevent "dead links" on restart.
  static Future<String> persistImage(String tempPath) async {
    if (tempPath.contains('http')) return tempPath; // Skip if already a URL

    final appDocDir = await getApplicationDocumentsDirectory();
    final fileName = p.basename(tempPath);
    final permanentPath = p.join(appDocDir.path, fileName);

    final tempFile = File(tempPath);
    if (await tempFile.exists()) {
      final permanentFile = await tempFile.copy(permanentPath);
      return permanentFile.path;
    }
    return tempPath;
  }
}
