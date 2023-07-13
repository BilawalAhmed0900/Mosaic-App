import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:aws_s3_upload/aws_s3_upload.dart';
import 'package:aws_s3_upload/enum/acl.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mosaic_app/Scaffolds/new_post_published_scaffold.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../CommonFunction/estimate_time.dart';
import '../CommonFunction/file_size.dart';
import '../CommonFunction/server_functions.dart';
import '../Constants/constants.dart';
import '../Data/user.dart';

class UploadVideoScaffold extends StatefulWidget {
  final XFile file;

  const UploadVideoScaffold({Key? key, required this.file}) : super(key: key);

  @override
  State<UploadVideoScaffold> createState() => _UploadVideoScaffoldState();
}

class _UploadVideoScaffoldState extends State<UploadVideoScaffold> {
  final ValueNotifier<bool> _thumbnailSpinner = ValueNotifier<bool>(true);
  final ValueNotifier<double?> _progressBarValue = ValueNotifier<double?>(null);
  final ValueNotifier<bool> _postButtonEnabled = ValueNotifier<bool>(false);
  final ValueNotifier<String> _estimateSpeed = ValueNotifier<String>("Estimating speed");
  final ValueNotifier<String> _videoUrl = ValueNotifier<String>("");
  final ValueNotifier<int> _stanceId = ValueNotifier<int>(-1);

  final TextEditingController _descriptionController = TextEditingController();

  Future<String?> uploadVideo(String filePath) async {
    return await AwsS3.uploadFile(
      accessKey: const String.fromEnvironment("AwsAccessKey"),
      secretKey: const String.fromEnvironment("AwsSecretKey"),
      bucket: "mosaic-app",
      file: File(filePath),
      region: "eu-north-1",
      acl: ACL.public_read,
    );
  }

  @override
  void initState() {
    super.initState();

    getTemporaryDirectory().then((tempDirectory) async {
      const int tempFileSize = 100000;
      File tempFile = File("${tempDirectory.path}/1");
      tempFile.writeAsBytesSync(List<int>.filled(tempFileSize, 0), flush: true);

      final stopWatch = Stopwatch()..start();
      await uploadVideo(tempFile.path);
      double speed = tempFileSize * 1e6 / stopWatch.elapsed.inMicroseconds;

      String estimation = estimateTime(File(widget.file.path).lengthSync(), speed);
      if (estimation.isNotEmpty) {
        _estimateSpeed.value = "Almost $estimation";
      } else {
        _estimateSpeed.value = "Cannot estimate.";
      }

      print({"authorization": "Bearer ${User.getInstance().token}"});
      Future.delayed(const Duration(seconds: 0)).then((value) {
        uploadVideo(widget.file.path).then((value) {
          _videoUrl.value = value!;
          commonPostWithFile(
            "$HOST:$PORT/api/stance/",
            {"authorization": "Bearer ${User.getInstance().token}"},
            {
              "title": widget.file.name,
              "content": "",
              "video": widget.file,
              "videoUrl": _videoUrl.value,
              "userId": User.getInstance().userId.toString()
            },
            context,
          ).then((value) {
            _stanceId.value = (value["data"] as Map)["id"] as int;
            _postButtonEnabled.value = true;
            _progressBarValue.value = 1.0;
            _thumbnailSpinner.value = false;
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.0652,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.043),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "New Post",
                    style: TextStyle(
                      fontSize: width * height * 9.195e-5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: width * 0.253,
                        height: height * 0.034,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFFE8E8E8),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.public,
                                    size: width * height * 5.255e-5,
                                    color: const Color(0xFF969696),
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    "Public",
                                    style: TextStyle(
                                      fontSize: width * height * 4.269e-5,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF1C1C1C),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.arrow_drop_down,
                                    size: width * height * 5.255e-5,
                                    color: const Color(0xFF969696),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      User.getInstance().profilePictureUrl.isNotEmpty
                          ? CircleAvatar(
                              radius: width * height * 5.255e-5,
                              backgroundColor: Colors.transparent,
                              foregroundImage: Image.network(
                                User.getInstance().profilePictureUrl,
                                fit: BoxFit.fitWidth,
                                width: width * 0.085,
                                height: height * 0.039,
                              ).image,
                            )
                          : CircleAvatar(
                              radius: width * height * 5.255e-5,
                              child: Icon(
                                Icons.supervised_user_circle_rounded,
                                size: width * height * 1.051e-4,
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.033,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.043),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width * 0.16,
                    height: height * 0.074,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FutureBuilder<Uint8List?>(
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator.adaptive(
                            backgroundColor: Colors.transparent,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          );
                        }

                        return Stack(
                          children: [
                            Image.memory(
                              snapshot.data!,
                              width: width * 0.16,
                              height: height * 0.074,
                            ),
                            ValueListenableBuilder(
                                valueListenable: _thumbnailSpinner,
                                builder: (context, value, _) {
                                  if (value) {
                                    return Container(
                                      width: width * 0.16,
                                      height: height * 0.074,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black.withOpacity(0.33),
                                      ),
                                      child: SizedBox(
                                        width: width * 0.053,
                                        height: height * 0.025,
                                        child: const Center(
                                          child: CircularProgressIndicator.adaptive(
                                            backgroundColor: Colors.transparent,
                                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                          ),
                                        ),
                                      ),
                                    );
                                  }

                                  return Container();
                                }),
                          ],
                        );
                      },
                      future: VideoThumbnail.thumbnailData(video: widget.file.path),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.715,
                    height: height * 0.071,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(widget.file.name.length > 18 ? "${widget.file.name.substring(0, 15)}..." : widget.file.name),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: width * 0.128,
                              height: height * 0.02,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color(0xFFE8E8E8),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  getFileSize(widget.file.path, 1),
                                  style: TextStyle(
                                    fontSize: width * height * 2.627e-5,
                                    color: const Color(0xFF1C1C1C),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.012,
                        ),
                        SizedBox(
                          width: width * 0.715,
                          child: ValueListenableBuilder(
                              valueListenable: _progressBarValue,
                              builder: (context, value, _) {
                                return LinearProgressIndicator(
                                  backgroundColor: Colors.black.withOpacity(0.04),
                                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
                                  value: value,
                                );
                              }),
                        ),
                        SizedBox(
                          width: width * 0.715,
                          child: ValueListenableBuilder(
                              valueListenable: _estimateSpeed,
                              builder: (context, value, _) {
                                return Text(
                                  value,
                                  style: TextStyle(
                                    color: const Color(0xFF969696),
                                    fontSize: width * height * 4.269e-5,
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.025),
            Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.015),
              child: SizedBox(
                width: width * 0.915,
                height: height * 0.187,
                child: TextField(
                  minLines: 10,
                  maxLines: 100,
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    hintText: "What's on your mind, ${User.getInstance().userName}?",
                    fillColor: const Color(0x14747480),
                    filled: true,
                    focusColor: const Color(0x14747480),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.401,
            ),
            SizedBox(
              width: width * 0.914,
              height: height * 0.0665,
              child: ValueListenableBuilder(
                  valueListenable: _postButtonEnabled,
                  builder: (context, value, _) {
                    return OutlinedButton(
                      onPressed: !value
                          ? null
                          : () async {
                              Map<String, dynamic> result = await commonPut(
                                "$HOST:$PORT/api/stance/update/",
                                {"authorization": "Bearer ${User.getInstance().token}"},
                                {
                                  "id": _stanceId.value.toString(),
                                  "content": _descriptionController.text,
                                },
                                context,
                              );

                              if (context.mounted) {
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                                  return NewPostPublishedScaffold(post: result);
                                }));
                              }
                            },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: !value ? Colors.white : Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(48),
                        ),
                      ),
                      child: Text(
                        "Post",
                        style: TextStyle(
                          color: !value ? Colors.black.withOpacity(0.5) : Colors.white,
                          fontSize: width * height * 0.0000591,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
