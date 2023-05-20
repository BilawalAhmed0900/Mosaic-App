import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.0652,
              ),
              ...commonSettingSearchNotification(context, "Settings", isSettingPage: true),
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
                            padding: EdgeInsets.symmetric(vertical: height * 0.0123),
                            child: createView(
                              context,
                              [
                                "Your Account",
                                "Notifications",
                                "Rate Us",
                                "Share App",
                              ],
                              const [
                                Icon(Icons.account_box),
                                Icon(Icons.notifications_active),
                                Icon(Icons.star_rate),
                                Icon(Icons.share),
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
                            padding: EdgeInsets.symmetric(vertical: height * 0.0123),
                            child: createView(
                              context,
                              [
                                "Privacy",
                                "Help",
                                "Security",
                                "About",
                              ],
                              const [
                                Icon(Icons.privacy_tip_outlined),
                                Icon(Icons.help),
                                Icon(Icons.security),
                                Icon(Icons.info),
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
        ),
      ),
    );
  }
}
