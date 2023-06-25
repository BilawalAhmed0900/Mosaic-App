import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mosaic_app/Scaffolds/welcome_back_scaffold.dart';

Future<Map<String, dynamic>> commonPut(String uri, Map<String, String> headers, Map<String, dynamic> body, BuildContext context) async {
  Response resp = await put(Uri.parse(uri), body: body, headers: headers);
  Map<String, dynamic> jsonBody = json.decode(resp.body);
  if ((jsonBody["status"] as int) == 0) {
    if (context.mounted) {
      await showDialog(context: context, builder: (context) {
        return const AlertDialog(title: Text("User timed-out"), content: Text("Please login again"),);
      });

      if (context.mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
          return const WelcomeBackScaffold();
        }));
      }
    }
  }

  return jsonBody;
}
