import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'scan_record.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  static const _prefsKey = 'scan_records_v1';

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('qr_scanner.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE scan_records (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        timestamp INTEGER NOT NULL,
        raw_value TEXT NOT NULL,
        format TEXT NOT NULL,
        content_type TEXT NOT NULL,
        source TEXT NOT NULL DEFAULT 'scan'
      )
    ''');
  }

  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(
        "ALTER TABLE scan_records ADD COLUMN source TEXT NOT NULL DEFAULT 'scan'",
      );
    }
  }

  Future<int> insertRecord(ScanRecord record) async {
    if (kIsWeb) {
      final records = await _prefsLoad();
      final id = records.isEmpty
          ? 1
          : records.map((r) => r.id ?? 0).reduce((a, b) => a > b ? a : b) + 1;
      records.insert(0, record.copyWith(id: id));
      await _prefsSave(records);
      return id;
    }
    final db = await database;
    return db.insert('scan_records', record.toMap()..remove('id'));
  }

  Future<List<ScanRecord>> getRecords({
    RecordSource? source,
    int? limit,
    int? offset,
  }) async {
    if (kIsWeb) {
      final records = await _prefsFiltered(source);
      if (limit == null) return records;
      final start = offset ?? 0;
      final end = (start + limit).clamp(0, records.length);
      if (start >= records.length) return [];
      return records.sublist(start, end);
    }
    final db = await database;
    final maps = await db.query(
      'scan_records',
      where: source == null ? null : 'source = ?',
      whereArgs: source == null ? null : [source.name],
      orderBy: 'timestamp DESC',
      limit: limit,
      offset: offset,
    );
    return maps.map(ScanRecord.fromMap).toList();
  }

  Future<int> getRecordCount({RecordSource? source}) async {
    if (kIsWeb) {
      return (await _prefsFiltered(source)).length;
    }
    final db = await database;
    final result = source == null
        ? await db.rawQuery('SELECT COUNT(*) as count FROM scan_records')
        : await db.rawQuery(
            'SELECT COUNT(*) as count FROM scan_records WHERE source = ?',
            [source.name],
          );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<int> deleteRecord(int id) async {
    if (kIsWeb) {
      final records = await _prefsLoad();
      records.removeWhere((r) => r.id == id);
      await _prefsSave(records);
      return 1;
    }
    final db = await database;
    return db.delete('scan_records', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteAllRecords({RecordSource? source}) async {
    if (kIsWeb) {
      if (source == null) {
        await _prefsSave([]);
        return;
      }
      final records = await _prefsLoad();
      records.removeWhere((r) => r.source == source);
      await _prefsSave(records);
      return;
    }
    final db = await database;
    if (source == null) {
      await db.delete('scan_records');
      return;
    }
    await db.delete(
      'scan_records',
      where: 'source = ?',
      whereArgs: [source.name],
    );
  }

  Future<List<ScanRecord>> _prefsFiltered(RecordSource? source) async {
    final records = await _prefsLoad();
    if (source == null) return records;
    return records.where((r) => r.source == source).toList();
  }

  Future<List<ScanRecord>> _prefsLoad() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);
    if (raw == null || raw.isEmpty) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((e) => ScanRecord.fromMap(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  Future<void> _prefsSave(List<ScanRecord> records) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _prefsKey,
      jsonEncode(records.map((r) => r.toMap()).toList()),
    );
  }
}
