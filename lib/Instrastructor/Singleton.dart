import 'package:mysql1/mysql1.dart';

class Singleton {
  static final Singleton instance = Singleton.internal();

  late MySqlConnection connection;

  Future connectDb() async {
    var settings = new ConnectionSettings(
        host: '51.79.251.248',
        port: 3306,
        user: 'root',
        password: 'Bc@dmin168',
        db: 'sample_db');
    connection = await MySqlConnection.connect(settings);
    print(connection);
  }

  factory Singleton() {
    return instance;
  }

  Singleton.internal() {
    print('Instance Singleton Created.');
  }
}
