import 'package:product_api/Controller/UserController.dart';
import 'package:product_api/Instrastructor/Singleton.dart';
import 'package:product_api/Route/ProductRoute.dart';
import 'package:product_api/Route/UserRoute.dart';
import 'package:product_api/Route/UserProfileRoute.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

void main(List<String> arguments) async {
  Singleton singleton = Singleton.instance;
  Singleton.instance.connectDb();

  final app = Router();

  app.mount('/user', UserRoute().router);

  app.mount('/user/profile', UserProfileRoute().router);

  app.mount('/product', ProductRoute().router);

  await io.serve(app, '51.79.251.248', 8081);
  // await io.serve(app, 'localhost', 8081);
}
