import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:isar_community/isar.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:up_bus_hk_core/isar/data_builder_models/bus_fare.dart';
import 'package:up_bus_hk_core/isar/data_builder_models/company_bus_route.dart';
import 'package:up_bus_hk_core/isar/data_builder_models/gov_bus_route.dart';
import 'package:up_bus_hk_core/isar/data_builder_models/gov_route_stop.dart';
import 'package:up_bus_hk_core/isar/models/bus_route.dart';
import 'package:up_bus_hk_core/isar/models/bus_stop.dart';
import 'package:up_bus_hk_core/isar/models/minibus_route.dart';
import 'package:up_bus_hk_core/isar/models/minibus_stop.dart';
import 'package:up_bus_hk_core/isar/models/track.dart';

class IsarManager {
  // Change definition if necessary
  static const isarFileName = 'default'; // Do not include .isar
  static final isarAssetPath = join('assets', 'isar', '$isarFileName.isar');

  /// This must be called before any data is read
  /// For future reference: for any schema change, putting an updated database
  /// in the asset folder will trigger a database rebuild
  static Future<void> init() async {
    final documentDir = await getApplicationDocumentsDirectory();
    await _copyAssetIsarFile(documentDir);

    await Isar.open(
      [
        CompanyBusRouteSchema,
        BusFareSchema,
        GovRouteStopSchema,
        GovBusRouteSchema,
        BusRouteSchema,
        BusStopSchema,
        MinibusRouteSchema,
        MinibusStopSchema,
        TrackSchema,
      ],
      directory: documentDir.path,
      name: isarFileName,
    );
  }

  /// Copy the assets isar file to the app's documents directory
  static Future<void> _copyAssetIsarFile(Directory documentDir) async {
    final bytes = await rootBundle.load(isarAssetPath);

    final dbPath = join(documentDir.path, '$isarFileName.isar');
    final file = File(dbPath);
    await file.writeAsBytes(bytes.buffer.asUint8List(), flush: true);
  }
}
