import 'dart:async';

import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter/material.dart';

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

