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

  // CORS Settings
  const headers = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, DELETE, PUT,OPTIONS',
    'Access-Control-Allow-Headers': '*',
  };

  app.mount('/user', UserRoute().router);

  app.mount('/user/profile', UserProfileRoute().router);

  app.mount('/product', ProductRoute().router);

  // Set CORS headers with every request
  // final handler = Pipeline().addMiddleware((innerHandler) {
  //   return (request) async {
  //     final response = await innerHandler(request);
  //     print(request.headers);

  //     // Set CORS when responding to OPTIONS request
  //     if (request.method == 'OPTIONS') {
  //       return Response.ok('', headers: corsHeaders);
  //     }

  //     // Move onto handler
  //     return response;
  //   };
  // }).addHandler(app);

  final handler =
      Pipeline().addMiddleware(corsHeaders(headers: headers)).addHandler(app);

  await io.serve(app, '51.79.251.248', port);
  // await io.serve(app, 'localhost', port);
}
