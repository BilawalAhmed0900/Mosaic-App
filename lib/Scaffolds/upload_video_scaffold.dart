import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadVideoScaffold extends StatefulWidget {
  final XFile file;
  const UploadVideoScaffold({Key? key, required this.file}) : super(key: key);

  @override
  State<UploadVideoScaffold> createState() => _UploadVideoScaffoldState();
}

class _UploadVideoScaffoldState extends State<UploadVideoScaffold> {
  @override
  Widget build(BuildContext context) {
    // AwsS3.uploadFile(accessKey: accessKey, secretKey: secretKey, bucket: bucket, file: file)
    return Scaffold(
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}

