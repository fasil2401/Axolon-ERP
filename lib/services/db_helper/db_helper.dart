
import 'package:axolon_container/model/connection_setting_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  final _databaseName = 'axolon.db';
  final _databaseVersion = 1;
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

   _initDB() async {
    final path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: (db, version) => _onCreate(db));
  }

  _onCreate(Database db) async {
    await db.execute('''
    CREATE TABLE ${ConnectionModelImpNames.tableName}(
        ${ConnectionModelImpNames.connectionName} TEXT,
       ${ConnectionModelImpNames.serverIp} TEXT,
        ${ConnectionModelImpNames.webPort} TEXT,
        ${ConnectionModelImpNames.httpPort} TEXT,
        ${ConnectionModelImpNames.erpPort} TEXT,
        ${ConnectionModelImpNames.databaseName} TEXT
    )
    ''');
  }

  Future<int> insertSettings(ConnectionModel setting) async {
    Database? db = await DbHelper._database;
    return await db!.insert(ConnectionModelImpNames.tableName, {
      ConnectionModelImpNames.connectionName: setting.connectionName,
      ConnectionModelImpNames.serverIp: setting.serverIp,
      ConnectionModelImpNames.webPort: setting.webPort,
      ConnectionModelImpNames.httpPort: setting.httpPort,
      ConnectionModelImpNames.erpPort: setting.erpPort,
      ConnectionModelImpNames.databaseName: setting.databaseName,
    });
  }

  Future<List<Map<String, dynamic>>> queryAllSettings() async {
    Database? db = await DbHelper._database;
    return await db!.query(ConnectionModelImpNames.tableName);
  }

  deleteSettingsTable() async {
    Database? db = await DbHelper._database;
    await db!.delete(ConnectionModelImpNames.tableName);
  }
}