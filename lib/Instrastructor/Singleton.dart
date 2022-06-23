import 'package:mysql1/mysql1.dart';

class Singleton {
  static final Singleton instance = Singleton.internal();

  late MySqlConnection connection;

  void connectDb() async {
    var settings = new ConnectionSettings(
        host: 'localhost',
        port: 3306,
        user: 'root',
        password: 'silverhong',
        db: 'sample_db');
    connection = await MySqlConnection.connect(settings);
    print('connected');
  }

  factory Singleton() {
    return instance;
  }

  Singleton.internal() {
    print('Instance Singleton Created.');
  }
}
