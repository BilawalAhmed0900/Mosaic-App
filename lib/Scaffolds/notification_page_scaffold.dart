import 'dart:async';

import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:mosaic_app/CommonWidgets/bottom_drawer.dart';

import '../CommonWidgets/common_setting_search_notification.dart';

class NotificationPageScaffold extends StatefulWidget {
  const NotificationPageScaffold({Key? key}) : super(key: key);

  @override
  State<NotificationPageScaffold> createState() => _NotificationPageScaffoldState();
}

class _NotificationPageScaffoldState extends State<NotificationPageScaffold> {
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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.0652,
                ),
                ...commonSettingSearchNotification(context, "Notifications", _controller),
                SizedBox(
                  height: height * 0.0147,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width * 0.914,
                      height: height * 0.0443,
                      child: TextField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          prefixIconColor: Color(0xFF848488),
                          suffixIcon: Icon(Icons.mic),
                          suffixIconColor: Color(0xFF848488),
                          hintText: "Search",
                          fillColor: Color(0x14747480),
                          filled: true,
                          focusColor: Color(0x14747480),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 2),
                        ),
                        textInputAction: TextInputAction.go,
                        onSubmitted: (value) {
                          print(value);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.0369,
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
