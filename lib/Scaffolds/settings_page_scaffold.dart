import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mosaic_app/CommonWidgets/BottomDrawer.dart';
import 'package:mosaic_app/Scaffolds/notification_page_scaffold.dart';

import '../CommonWidgets/common_setting_search_notification.dart';
import '../CommonWidgets/setting_page_portion.dart';
import 'account_page_scaffold.dart';

class SettingsPageScaffold extends StatefulWidget {
  const SettingsPageScaffold({Key? key}) : super(key: key);

  @override
  State<SettingsPageScaffold> createState() => _SettingsPageScaffoldState();
}

class _SettingsPageScaffoldState extends State<SettingsPageScaffold> {
  final BottomDrawerController _controller = BottomDrawerController();
  bool _isControllerOpen = false;

  void setControllerOpenBoolState(bool state) {
    print("_SettingsPageScaffoldState $state");
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
        child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.0652,
                  ),
                  ...commonSettingSearchNotification(context, "Settings", _controller),
                  SizedBox(
                    height: height * 0.0147,
                  ),
                  Expanded(
                    child: Container(
                      color: const Color(0xFFF4F4F5),
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.0172,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: width * 0.0426),
                            child: Container(
                              height: height * 0.290,
                              width: width * 0.914,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: height * 0.008),
                                child: createView(
                                  context,
                                  [
                                    "Your Account",
                                    "Notifications",
                                    "Rate Us",
                                    "Share App",
                                  ],
                                  [
                                    SvgPicture.asset(
                                      "assets/svgs/your_account_icon.svg",
                                      theme: const SvgTheme(
                                        currentColor: Color(0xFFFFFFFF),
                                      ),
                                      width: width * 0.075,
                                      height: height * 0.034,
                                    ),
                                    SvgPicture.asset(
                                      "assets/svgs/notifications_icon.svg",
                                      theme: const SvgTheme(
                                        currentColor: Color(0xFFFFFFFF),
                                      ),
                                      width: width * 0.075,
                                      height: height * 0.034,
                                    ),
                                    SvgPicture.asset(
                                      "assets/svgs/rate_us_icon.svg",
                                      theme: const SvgTheme(
                                        currentColor: Color(0xFFFFFFFF),
                                      ),
                                      width: width * 0.075,
                                      height: height * 0.034,
                                    ),
                                    SvgPicture.asset(
                                      "assets/svgs/share_app_icon.svg",
                                      theme: const SvgTheme(
                                        currentColor: Color(0xFFFFFFFF),
                                      ),
                                      width: width * 0.075,
                                      height: height * 0.034,
                                    ),
                                  ],
                                  [
                                    () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                        return const AccountPageScaffold();
                                      }));
                                    },
                                    () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                        return const NotificationPageScaffold();
                                      }));
                                    },
                                    null,
                                    null,
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.0197),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: width * 0.0426),
                            child: Container(
                              height: height * 0.290,
                              width: width * 0.914,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: height * 0.008),
                                child: createView(
                                  context,
                                  [
                                    "Privacy",
                                    "Help",
                                    "Security",
                                    "About",
                                  ],
                                  [
                                    SvgPicture.asset(
                                      "assets/svgs/privacy_icon.svg",
                                      theme: const SvgTheme(
                                        currentColor: Color(0xFFFFFFFF),
                                      ),
                                      width: width * 0.075,
                                      height: height * 0.034,
                                    ),
                                    SvgPicture.asset(
                                      "assets/svgs/help_icon.svg",
                                      theme: const SvgTheme(
                                        currentColor: Color(0xFFFFFFFF),
                                      ),
                                      width: width * 0.075,
                                      height: height * 0.034,
                                    ),
                                    SvgPicture.asset(
                                      "assets/svgs/security_icon.svg",
                                      theme: const SvgTheme(
                                        currentColor: Color(0xFFFFFFFF),
                                      ),
                                      width: width * 0.075,
                                      height: height * 0.034,
                                    ),
                                    SvgPicture.asset(
                                      "assets/svgs/about_icon.svg",
                                      theme: const SvgTheme(
                                        currentColor: Color(0xFFFFFFFF),
                                      ),
                                      width: width * 0.075,
                                      height: height * 0.034,
                                    ),
                                  ],
                                  [
                                    null,
                                    null,
                                    null,
                                    null,
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
      ),
    );
  }
}
