import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:mosaic_app/CommonWidgets/BottomDrawer.dart';

import '../CommonWidgets/common_setting_search_notification.dart';

class NotificationPageScaffold extends StatefulWidget {
  const NotificationPageScaffold({Key? key}) : super(key: key);

  @override
  State<NotificationPageScaffold> createState() => _NotificationPageScaffoldState();
}

class _NotificationPageScaffoldState extends State<NotificationPageScaffold> {
  final BottomDrawerController _controller = BottomDrawerController();

  bool _isControllerOpen = false;

  void setControllerOpenBoolState(bool state) {
    setState(() {
      _isControllerOpen = state;
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
            (_isControllerOpen)
                ? Container(
                    color: Colors.black.withOpacity(0.5),
                  )
                : Container(),
            buildBottomDrawer(context, _controller, setControllerOpenBoolState),
          ],
        ),
      ),
    );
  }
}
