import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:isar_community/isar.dart';
import 'package:isar_viewer/isar/models/bus_route.dart';
import 'package:isar_viewer/isar/models/bus_stop.dart';
import 'package:isar_viewer/isar/models/minibus_route.dart';
import 'package:isar_viewer/isar/models/minibus_stop.dart';
import 'package:isar_viewer/isar/models/track.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'models/company_bus_route.dart';

class IsarManager {
  // Change definition if necessary
  static const isarFileName = 'default.isar';
  static final isarAssetPath = join('assets', 'isar', isarFileName);

  /// This must be called before any data is read
  /// For future reference: for any schema change, putting an updated database
  /// in the asset folder will trigger a database rebuild
  static Future<void> init() async {
    final bytes = await rootBundle.load(isarAssetPath);

    // A writable directory for Isar
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = join(dir.path, isarFileName);

    // If DB doesn't exist yet, write it
    final file = File(dbPath);
    if (!await file.exists()) {
      await file.writeAsBytes(bytes.buffer.asUint8List(), flush: true);
    }

    await Isar.open(
      [
        CompanyBusRouteSchema,
        BusRouteSchema,
        BusStopSchema,
        MinibusRouteSchema,
        MinibusStopSchema,
        TrackSchema,
      ],
      directory: dir.path,
      name: isarFileName,
    );
  }
}
