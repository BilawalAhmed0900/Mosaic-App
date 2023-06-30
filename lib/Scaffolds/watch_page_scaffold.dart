import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mosaic_app/CommonFunction/server_functions.dart';
import 'package:mosaic_app/Constants/constants.dart';
import 'package:mosaic_app/Scaffolds/new_post_base_scaffold.dart';
import 'package:mosaic_app/Scaffolds/notification_page_scaffold.dart';
import 'package:mosaic_app/Scaffolds/search_page_scaffold.dart';
import 'package:mosaic_app/Scaffolds/settings_page_scaffold.dart';

import 'package:wheel_chooser/wheel_chooser.dart';
import 'package:bottom_drawer/bottom_drawer.dart';

import '../CommonWidgets/bottom_drawer.dart';
import '../Data/user.dart';

class WatchVideoScaffold extends StatefulWidget {
  const WatchVideoScaffold({Key? key}) : super(key: key);

  @override
  State<WatchVideoScaffold> createState() => _WatchVideoScaffoldState();
}

class _WatchVideoScaffoldState extends State<WatchVideoScaffold> {
  static const List<Icon> icons = [
    Icon(
      Icons.supervised_user_circle_outlined,
      color: Colors.white,
    ),
    Icon(
      Icons.supervised_user_circle_outlined,
      color: Colors.white,
    ),
    Icon(
      Icons.supervised_user_circle_outlined,
      color: Colors.white,
    ),
    Icon(
      Icons.supervised_user_circle_outlined,
      color: Colors.white,
    ),
    Icon(
      Icons.supervised_user_circle_outlined,
      color: Colors.white,
    ),
    Icon(
      Icons.supervised_user_circle_outlined,
      color: Colors.white,
    ),
    Icon(
      Icons.supervised_user_circle_outlined,
      color: Colors.white,
    ),
    Icon(
      Icons.supervised_user_circle_outlined,
      color: Colors.white,
    ),
  ];

  final BottomDrawerController _controller = BottomDrawerController();
  final ValueNotifier<int> _backgroundOpacity = ValueNotifier<int>(0);
  final ValueNotifier<Map<String, dynamic>?> _stance = ValueNotifier<Map<String, dynamic>?>(null);

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
  void initState() {
    super.initState();

    commonGet(
      "$HOST:$PORT/api/stance/home/",
      {
        "authorization": "Bearer ${User.getInstance().token}",
        "userId": User.getInstance().userId.toString(),
      },
      context,
    ).then((value) {
      print(value);
      _stance.value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ValueListenableBuilder(
              valueListenable: _stance,
              builder: (context, value, _) {
                if (value == null) {
                  return Container(
                    color: Colors.black,
                    child: const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  );
                }

                return Container(color: Colors.black,
                  child: const Center(
                    child: Text("Video Here", style: TextStyle(color: Colors.white),),
                  ),);
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.0529,
                ),
                Padding(
                  padding: EdgeInsets.only(right: width * 0.0666),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                            return const SearchPageScaffold();
                          }));
                        },
                        child: Icon(
                          Icons.search,
                          color: const Color(0xFFFFFFFF),
                          size: width * height * 0.0000656,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.072,
                      ),
                      InkWell(
                        onTap: () {
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          //   return const SettingsPageScaffold();
                          // }));
                          _controller.open();
                        },
                        child: Icon(
                          Icons.apps,
                          color: const Color(0xFFFFFFFF),
                          size: width * height * 0.0000656,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.275,
                ),
                Padding(
                  padding: EdgeInsets.only(left: width * 0.069),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        "assets/svgs/arrow_upward.svg",
                        theme: const SvgTheme(
                          currentColor: Color(0xFFFFFFFF),
                        ),
                        width: width * 0.032,
                        height: height * 0.00738,
                      ),
                      SizedBox(
                        width: width * 0.2666,
                        height: height * 0.184,
                        child: WheelChooser<String>(
                          selectTextStyle: TextStyle(
                            color: const Color(0xFFFFFFFF),
                            fontSize: width * height * 0.0000262,
                            fontWeight: FontWeight.w600,
                          ),
                          unSelectTextStyle: TextStyle(
                            color: const Color(0xFFFFFFFF),
                            fontSize: width * height * 0.0000262,
                          ),
                          itemSize: width * height * 0.000131,
                          onValueChanged: (value) {
                            print(value);
                          },
                          datas: TOPICS,
                        ),
                      ),
                      SvgPicture.asset(
                        "assets/svgs/arrow_downward.svg",
                        theme: const SvgTheme(
                          currentColor: Color(0xFFFFFFFF),
                        ),
                        width: width * 0.032,
                        height: height * 0.00738,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.207,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: width * 0.283),
                    SvgPicture.asset(
                      "assets/svgs/arrow_leftward.svg",
                      colorFilter: const ColorFilter.mode(Color(0xFF16D94D), BlendMode.srcIn),
                      width: width * 0.016,
                      height: height * 0.015,
                    ),
                    SizedBox(width: width * 0.021),
                    SizedBox(
                      width: width * 0.36,
                      height: height * 0.037,
                      child: WheelChooser.custom(
                        horizontal: true,
                        perspective: 0.0001,
                        isInfinite: true,
                        itemSize: width * height * 9.852e-5,
                        onValueChanged: (e) {},
                        children: icons,
                      ),
                    ),
                    SizedBox(width: width * 0.021),
                    SvgPicture.asset(
                      "assets/svgs/arrow_rightward.svg",
                      colorFilter: const ColorFilter.mode(Color(0xFF16D94D), BlendMode.srcIn),
                      width: width * 0.016,
                      height: height * 0.015,
                    ),
                    SizedBox(
                      width: width * 0.131,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return const NewPostBaseScaffold();
                        }));
                      },
                      child: CircleAvatar(
                        radius: width * height * 6.568e-5,
                        backgroundColor: const Color(0xFFFCFCFC),
                        child: const Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.043,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.075),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width * 0.117,
                        height: height * 0.085,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: width * height * 7.225e-5,
                              child: SvgPicture.asset(
                                "assets/svgs/share_icon.svg",
                                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                width: width * 0.071,
                                height: height * 0.033,
                              ),
                            ),
                            Text(
                              "1.4k",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: width * height * 4.269e-5,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: width * 0.117,
                        height: height * 0.085,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: width * height * 7.225e-5,
                              child: const Icon(Icons.arrow_upward, color: Colors.green),
                            ),
                            Text(
                              "1.4k",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: width * height * 4.269e-5,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: width * 0.117,
                        height: height * 0.085,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: width * height * 7.225e-5,
                              child: const Icon(Icons.arrow_downward, color: Colors.red),
                            ),
                            Text(
                              "1.4k",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: width * height * 4.269e-5,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: width * 0.117,
                        height: height * 0.085,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: width * height * 7.225e-5,
                              child: SvgPicture.asset(
                                "assets/svgs/reposts_icon.svg",
                                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                width: width * 0.08,
                                height: height * 0.037,
                              ),
                            ),
                            Text(
                              "1.4k",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: width * height * 4.269e-5,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
