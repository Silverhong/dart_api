import 'package:product_api/Controller/UserController.dart';
import 'package:product_api/Instrastructor/Singleton.dart';
import 'package:product_api/Route/ProductRoute.dart';
import 'package:product_api/Route/UserRoute.dart';
import 'package:product_api/Route/UserProfileRoute.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

void main(List<String> arguments) async {
  Singleton singleton = Singleton.instance;
  Singleton.instance.connectDb();

  const port = 8081;
  final app = Router();

  app.mount('/user', UserRoute().router);

  app.mount('/user/profile', UserProfileRoute().router);

  app.mount('/product', ProductRoute().router);

  // CORS Settings
  const headers = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, DELETE, PUT,OPTIONS',
    'Access-Control-Allow-Headers': '*',
  };

  // Enable CORS
  final handler =
      Pipeline().addMiddleware(corsHeaders(headers: headers)).addHandler(app);

  await io.serve(handler, '51.79.251.248', port);
  // await io.serve(handler, 'localhost', port);
}
