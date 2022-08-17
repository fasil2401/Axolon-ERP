
class ConnectionModelImpNames {
  static const String serverIp = 'serverIp';
  static const String webPort = 'webPort';
  static const String httpPort = 'httpPort';
  static const String erpPort = 'erpPort';
  static const String databaseName = 'databaseName';
  static const String tableName = 'connectionSetting';
}




class ConnectionModel {
  String? serverIp;
  String? webPort;
  String? httpPort;
  String? erpPort;
  String? databaseName;

  ConnectionModel({
    this.serverIp,
    this.webPort,
    this.httpPort,
    this.erpPort,
    this.databaseName,
  });

  Map<String, dynamic> toMap() {
    return {
      'serverIp': serverIp,
      'webPort': webPort,
      'httpPort': httpPort,
      'erpPort': erpPort,
      'databaseName': databaseName,
    };
  }

  ConnectionModel.fromMap(Map<String, dynamic> map) {
    this.serverIp = map['serverIp'];
    this.webPort = map['webPort'];
    this.httpPort = map['httpPort'];
    this.erpPort = map['erpPort'];
    this.databaseName = map['databaseName'];
  }
}
