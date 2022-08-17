
class ConnectionModelImpNames {
  static const String connectionName = 'connectionName';
  static const String serverIp = 'serverIp';
  static const String webPort = 'webPort';
  static const String httpPort = 'httpPort';
  static const String erpPort = 'erpPort';
  static const String databaseName = 'databaseName';
  static const String tableName = 'connectionSetting';
}




class ConnectionModel {
  String? connectionName;
  String? serverIp;
  String? webPort;
  String? httpPort;
  String? erpPort;
  String? databaseName;

  ConnectionModel({
    this.connectionName,
    this.serverIp,
    this.webPort,
    this.httpPort,
    this.erpPort,
    this.databaseName,
  });

  Map<String, dynamic> toMap() {
    return {
      'connectionName': connectionName,
      'serverIp': serverIp,
      'webPort': webPort,
      'httpPort': httpPort,
      'erpPort': erpPort,
      'databaseName': databaseName,
    };
  }

  ConnectionModel.fromMap(Map<String, dynamic> map) {
    this.connectionName = map['connectionName'];
    this.serverIp = map['serverIp'];
    this.webPort = map['webPort'];
    this.httpPort = map['httpPort'];
    this.erpPort = map['erpPort'];
    this.databaseName = map['databaseName'];
  }
}
