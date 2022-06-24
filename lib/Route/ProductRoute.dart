import 'dart:io';
import 'dart:convert';

import 'package:product_api/Controller/ProductController.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';

class ProductRoute {
  Router get router {
    final router = Router();

    var data = {
      "success": true,
      "description": "Operation Successful",
      "data": []
    };
    router.get('/', (Request request) => ProductController().getAll(request));
    router.post('/', (Request request) => ProductController().post(request));
    router.delete(
        '/<id>',
        (Request request, String id) =>
            ProductController().delete(request, id));

    router.put(
        '/<id>',
        (Request request, String id) =>
            ProductController().update(request, id));

    return router;
  }
}
