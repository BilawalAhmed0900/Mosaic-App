import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
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

Future<Map<String, dynamic>> commonPost(String uri, Map<String, String> headers, Map<String, dynamic> body, BuildContext context) async {
  Response resp = await post(Uri.parse(uri), body: body, headers: headers);
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

Future<Map<String, dynamic>> commonPostWithFile(String uri, Map<String, String> headers, Map<String, dynamic> body, BuildContext context) async {
  MultipartRequest request = MultipartRequest("POST", Uri.parse(uri));

  for (MapEntry<String, String> entry in headers.entries) {
    request.headers[entry.key] = entry.value;
  }

  for (MapEntry<String, dynamic> entry in body.entries) {
    if (entry.value is File) {
      request.files.add(await MultipartFile.fromPath("video", (entry.value as File).path));
    } else if (entry.value is XFile) {
      request.files.add(await MultipartFile.fromPath("video", (entry.value as XFile).path));
    } else {
      request.fields[entry.key] = entry.value;
    }
  }

  StreamedResponse streamedResponse = await request.send();
  Response response = await Response.fromStream(streamedResponse);
  Map<String, dynamic> jsonBody = json.decode(response.body);
  print(jsonBody);
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

Future<Map<String, dynamic>> commonGet(String uri, Map<String, String> headers, BuildContext context) async {
  Response resp = await get(Uri.parse(uri), headers: headers);
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
