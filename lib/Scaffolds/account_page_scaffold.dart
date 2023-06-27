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
  final ValueNotifier<int> _selectedTab = ValueNotifier<int>(0);

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
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                print(snapshot.data);

                List<Map<String, dynamic>> userStances =
                    (snapshot.data![0]["data"] as List<dynamic>).map((e) => e as Map<String, dynamic>).toList();
                List<int> userFollowings = (snapshot.data![1]["data"] as List<dynamic>).map((e) => e as int).toList();
                List<int> userFollowers = (snapshot.data![2]["data"] as List<dynamic>).map((e) => e as int).toList();
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
                            child: Stack(
                              children: [
                                Row(
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      User.getInstance().userName,
                                      style: TextStyle(fontSize: width * height * 5.583e-5, fontWeight: FontWeight.w600),
                                    ),
                                  ],
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
                                      setState(() {});
                                    }
                                  }
                                },
                                child: Stack(
                                  children: [
                                    User.getInstance().profilePictureUrl.isNotEmpty
                                        ? CircleAvatar(
                                            radius: width * height * 1.182e-4,
                                            backgroundColor: Colors.transparent,
                                            foregroundImage: Image.network(
                                              User.getInstance().profilePictureUrl,
                                              fit: BoxFit.fitWidth,
                                              width: width * 0.192,
                                              height: height * 0.089,
                                            ).image,
                                          )
                                        : CircleAvatar(
                                            radius: width * height * 1.182e-4,
                                            child: Icon(
                                              Icons.supervised_user_circle_rounded,
                                              size: width * height * 2.365e-4,
                                            ),
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
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Text(
                            "${User.getInstance().firstName} ${User.getInstance().lastName}".length == 1
                                ? User.getInstance().userName
                                : "${User.getInstance().firstName} ${User.getInstance().lastName}",
                            style: TextStyle(fontSize: width * height * 6.568e-5, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: height * 0.007,
                          ),
                          InkWell(
                            onTap: () async {
                              TextEditingController _bioController =
                                  TextEditingController.fromValue(TextEditingValue(text: User.getInstance().bio));
                              String? newBio = await showDialog<String?>(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Edit Bio"),
                                    content: Builder(
                                      builder: (context) {
                                        return SizedBox(
                                          height: height * 0.25,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              TextField(
                                                controller: _bioController,
                                                maxLines: 3,
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  OutlinedButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop(null);
                                                    },
                                                    style: OutlinedButton.styleFrom(
                                                      backgroundColor: Colors.transparent,
                                                      side: const BorderSide(
                                                        color: Colors.black,
                                                      ),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(48),
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  OutlinedButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop(_bioController.text);
                                                    },
                                                    style: OutlinedButton.styleFrom(
                                                      backgroundColor: Colors.transparent,
                                                      side: const BorderSide(
                                                        color: Colors.black,
                                                      ),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(48),
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      "Confirm",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              );

                              if (newBio == null) {
                                return;
                              }

                              if (context.mounted) {
                                Map<String, dynamic> result = await commonPut("$HOST:$PORT/api/user/${User.getInstance().userId}",
                                    {"authorization": "Bearer ${User.getInstance().token}"}, {"bio": newBio}, context);

                                if ((result["status"] as int) == 1) {
                                  User.getInstance().bio = newBio;
                                  setState(() {});
                                }
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: height * 0.074,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        User.getInstance().bio.isEmpty ? "(no bio)" : User.getInstance().bio,
                                        style: TextStyle(fontSize: width * height * 4.926e-5),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.027,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: width * 0.107),
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(userStances.length.toString()),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "STANCES",
                                        style: TextStyle(
                                          fontSize: width * height * 3.284e-5,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF3C3C43).withOpacity(0.6),
                                        ),
                                      ),
                                    ],
                                  ),
                                  VerticalDivider(
                                    width: 1,
                                    thickness: 1,
                                    color: const Color(0xFF3C3C43).withOpacity(0.29),
                                  ),
                                  Column(
                                    children: [
                                      Text(userFollowers.length.toString()),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "FOLLOWERS",
                                        style: TextStyle(
                                          fontSize: width * height * 3.284e-5,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF3C3C43).withOpacity(0.6),
                                        ),
                                      ),
                                    ],
                                  ),
                                  VerticalDivider(
                                    width: 1,
                                    thickness: 1,
                                    color: const Color(0xFF3C3C43).withOpacity(0.29),
                                  ),
                                  Column(
                                    children: [
                                      Text(userFollowings.length.toString()),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "FOLLOWINGS",
                                        style: TextStyle(
                                          fontSize: width * height * 3.284e-5,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF3C3C43).withOpacity(0.6),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.046,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: width * 0.043),
                            child: SizedBox(
                              height: height * 0.067,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          _selectedTab.value = 0;
                                        },
                                        child: ValueListenableBuilder<int>(
                                          valueListenable: _selectedTab,
                                          builder: (context, value, _) {
                                            return Container(
                                              height: height * 0.061,
                                              width: width * 0.299,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(32),
                                                color: value == 0 ? Colors.white : Colors.black,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Instances",
                                                  style: TextStyle(
                                                    color: value != 0 ? Colors.white : Colors.black,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _selectedTab.value = 1;
                                        },
                                        child: ValueListenableBuilder<int>(
                                          valueListenable: _selectedTab,
                                          builder: (context, value, _) {
                                            return Container(
                                              height: height * 0.061,
                                              width: width * 0.299,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(32),
                                                color: value == 1 ? Colors.white : Colors.black,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Replies",
                                                  style: TextStyle(
                                                    color: value != 1 ? Colors.white : Colors.black,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _selectedTab.value = 2;
                                        },
                                        child: ValueListenableBuilder<int>(
                                          valueListenable: _selectedTab,
                                          builder: (context, value, _) {
                                            return Container(
                                              height: height * 0.061,
                                              width: width * 0.299,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(32),
                                                color: value == 2 ? Colors.white : Colors.black,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Likes",
                                                  style: TextStyle(
                                                    color: value != 2 ? Colors.white : Colors.black,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.034,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              future: Future.wait(
                [
                  commonGet(
                    "$HOST:$PORT/api/stance/user",
                    {
                      "authorization": "Bearer ${User.getInstance().token}",
                      "userId": User.getInstance().userId.toString(),
                    },
                    context,
                  ),
                  commonGet(
                    "$HOST:$PORT/api/user/following/${User.getInstance().userId}",
                    {
                      "authorization": "Bearer ${User.getInstance().token}",
                    },
                    context,
                  ),
                  commonGet(
                    "$HOST:$PORT/api/user/followers/${User.getInstance().userId}",
                    {
                      "authorization": "Bearer ${User.getInstance().token}",
                    },
                    context,
                  ),
                ],
              ),
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
