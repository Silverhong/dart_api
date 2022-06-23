import 'dart:io';
import 'dart:convert';

import 'package:product_api/Controller/UserController.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';

class UserRoute {
  Router get router {
    final router = Router();

    var data = {
      "success": true,
      "description": "Operation Successful",
      "data": []
    };
    router.get('/', (Request request) => UserController().getAll(request));
    router.post('/', (Request request) => UserController().post(request));
    router.delete(
        '/<username>',
        (Request request, String username) =>
            UserController().delete(request, username));

    router.put(
        '/<username>',
        (Request request, String username) =>
            UserController().update(request, username));

    return router;
  }
}
