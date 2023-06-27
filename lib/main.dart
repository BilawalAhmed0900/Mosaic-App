import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:mosaic_app/Scaffolds/splash_screen_scaffold.dart';

import 'amplifyconfiguration.dart';

void main() async {
  await Amplify.addPlugin(AmplifyStorageS3());
  await Amplify.addPlugin(AmplifyAuthCognito());
  await Amplify.configure(amplifyconfig);

  runApp(MaterialApp(
    theme: ThemeData(
      brightness: Brightness.light,
      fontFamily: "Inter",
    ),
    home: const SplashScreenPageScaffold(),
  ));
}
