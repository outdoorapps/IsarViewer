import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:isar_community/isar.dart';
import 'package:isar_viewer/schema_type.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:up_bus_hk_core/isar/up_bus_hk_schema.dart';

class IsarManager {
  // Change definition if necessary, do not include .isar for file names
  static const _appIsarFileName = 'default'; // Do not include .isar
  static const _builderIsarFileName = 'builder'; // For intermediates
  static Isar? _isar;

  /// This must be called before any data is read
  /// For future reference: for any schema change, putting an updated database
  /// in the asset folder will trigger a database rebuild
  static Future<void> init() async {
    final documentDir = await getApplicationDocumentsDirectory();
    await _copyAssetIsarFile(documentDir, _builderIsarFileName);
    await _copyAssetIsarFile(documentDir, _appIsarFileName);
  }

  static Future<void> open(SchemaType schemaType) async {
    await _isar?.close();

    final documentDir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [...UpBusHkSchema.builderSchemas, ...UpBusHkSchema.appSchemas],
      directory: documentDir.path,
      name: schemaType == SchemaType.builder
          ? _builderIsarFileName
          : _appIsarFileName,
    );
  }

  /// Copy the assets isar file to the app's documents directory
  static Future<void> _copyAssetIsarFile(
    Directory documentDir,
    String name,
  ) async {
    final assetPath = join('assets', 'isar', '$name.isar');
    final bytes = await rootBundle.load(assetPath);

    final dbPath = join(documentDir.path, '$name.isar');
    final file = File(dbPath);
    await file.writeAsBytes(bytes.buffer.asUint8List(), flush: true);
  }
}
