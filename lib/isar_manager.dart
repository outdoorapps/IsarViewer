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
import 'package:up_bus_hk_core/isar/data_builder_models/gov_stop_coordinate.dart';
import 'package:up_bus_hk_core/isar/models/bus_route.dart';
import 'package:up_bus_hk_core/isar/models/bus_stop.dart';
import 'package:up_bus_hk_core/isar/models/minibus_route.dart';
import 'package:up_bus_hk_core/isar/models/minibus_stop.dart';
import 'package:up_bus_hk_core/isar/models/track.dart';

class IsarManager {
  // Change definition if necessary, do not include .isar for file names
  static const isarFileName = 'default'; // Do not include .isar
  static const builderIsarFileName = 'builder'; // For intermediates

  /// This must be called before any data is read
  /// For future reference: for any schema change, putting an updated database
  /// in the asset folder will trigger a database rebuild
  static Future<void> init() async {
    final documentDir = await getApplicationDocumentsDirectory();
    await _copyAssetIsarFile(documentDir, builderIsarFileName);
    await _copyAssetIsarFile(documentDir, isarFileName);

    await Isar.open(
      [
        CompanyBusRouteSchema,
        BusFareSchema,
        GovRouteStopSchema,
        GovStopCoordinateSchema,
        GovBusRouteSchema,
      ],
      directory: documentDir.path,
      name: builderIsarFileName,
    );

    await Isar.open(
      [
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
  static Future<void> _copyAssetIsarFile(Directory documentDir, String name) async {
    final assetPath = join('assets', 'isar', '$name.isar');
    final bytes = await rootBundle.load(assetPath);

    final dbPath = join(documentDir.path, '$name.isar');
    final file = File(dbPath);
    await file.writeAsBytes(bytes.buffer.asUint8List(), flush: true);
  }
}
