import 'dart:io';
import 'dart:convert';

import 'package:product_api/Controller/UserProfileController.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';

class UserProfileRoute {
  Router get router {
    final router = Router();

    var data = {
      "success": true,
      "description": "Operation Successful",
      "data": []
    };
    router.get(
        '/', (Request request) => UserProfileController().getAll(request));
    router.post(
        '/', (Request request) => UserProfileController().post(request));
    router.delete(
        '/<username>',
        (Request request, String username) =>
            UserProfileController().delete(request, username));

    router.put(
        '/<username>',
        (Request request, String username) =>
            UserProfileController().update(request, username));

    return router;
  }
}
