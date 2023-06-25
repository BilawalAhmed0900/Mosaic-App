import 'dart:async';
import 'dart:io';

import 'package:aws_s3_upload/aws_s3_upload.dart';
import 'package:aws_s3_upload/enum/acl.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mosaic_app/Constants/constants.dart';
import 'package:mosaic_app/Data/user.dart';

import '../CommonFunction/server_functions.dart';
import '../CommonWidgets/bottom_drawer.dart';
import '../CommonWidgets/common_setting_search_notification.dart';

class AccountPageScaffold extends StatefulWidget {
  const AccountPageScaffold({Key? key}) : super(key: key);

  @override
  State<AccountPageScaffold> createState() => _AccountPageScaffoldState();
}

class _AccountPageScaffoldState extends State<AccountPageScaffold> {
  final BottomDrawerController _controller = BottomDrawerController();

  final ValueNotifier<int> _backgroundOpacity = ValueNotifier<int>(0);

  void setControllerOpenBoolState(bool state) {
    if (state) {
      int i = 0;
      Timer.periodic(const Duration(milliseconds: 1), (timer) {
        if (i > 250) {
          timer.cancel();
          return;
        }

        _backgroundOpacity.value = i++;
      });
    } else {
      int i = 250;
      Timer.periodic(const Duration(milliseconds: 1), (timer) {
        if (i < 0) {
          timer.cancel();
          return;
        }

        _backgroundOpacity.value = i--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            FutureBuilder(
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: const Color(0xFFC6FFC5),
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.0652,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: width * 0.0426, right: width * 0.0346),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/svgs/arrow_leftward.svg",
                                        theme: const SvgTheme(
                                          currentColor: Color(0xFF007AFF),
                                        ),
                                        width: width * 0.016,
                                        height: height * 0.0147,
                                      ),
                                      SizedBox(
                                        width: width * 0.024,
                                      ),
                                      Text(
                                        "Back",
                                        style: TextStyle(
                                          color: const Color(0xFF007AFF),
                                          fontSize: width * height * 0.0000558,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(User.getInstance().userName),
                                InkWell(
                                  onTap: () {
                                    _controller.open();
                                  },
                                  child: Icon(
                                    Icons.apps,
                                    color: Colors.black,
                                    size: width * height * 0.0000656,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.033,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
                                  if (file == null) return;

                                  String? uri = await AwsS3.uploadFile(
                                    accessKey: const String.fromEnvironment("AwsAccessKey"),
                                    secretKey: const String.fromEnvironment("AwsSecretKey"),
                                    bucket: "mosaic-app",
                                    file: File(file.path),
                                    region: "eu-north-1",
                                    acl: ACL.public_read,
                                  );

                                  if (uri == null) return;

                                  if (context.mounted) {
                                    Map<String, dynamic> result = await commonPut("$HOST:$PORT/api/user/${User.getInstance().userId}",
                                        {"authorization": "Bearer ${User.getInstance().token}"}, {"profile_picture": uri}, context);

                                    if ((result["status"] as int) == 1) {
                                      User.getInstance().profilePictureUrl = uri;
                                      setState(() {

                                      });
                                    }
                                  }
                                },
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: width * height * 1.182e-4,
                                      backgroundColor: Colors.transparent,
                                      child: User.getInstance().profilePictureUrl.isEmpty
                                          ? Icon(
                                              Icons.supervised_user_circle_rounded,
                                              size: width * height * 2.365e-4,
                                            )
                                          : Image.network(User.getInstance().profilePictureUrl, fit: BoxFit.scaleDown,),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: height * 0.054, left: width * 0.117),
                                      child: CircleAvatar(
                                        radius: width * height * 4.598e-5,
                                        backgroundColor: Colors.white,
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              future: Future.wait([]),
            ),
            ValueListenableBuilder<int>(
              valueListenable: _backgroundOpacity,
              builder: (context, value, _) {
                if (value == 0) {
                  return Container();
                }
                return Container(
                  color: Colors.black.withOpacity(value / 250.0 * 0.33),
                );
              },
            ),
            buildBottomDrawer(context, _controller, setControllerOpenBoolState),
          ],
        ),
      ),
    );
  }
}
