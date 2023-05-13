import 'package:flutter/material.dart';

import '../CommonWidgets/common_setting_search_notification.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.0652,),
            ...commonSettingSearchNotification(context, "Settings", true),
            SizedBox(height: height * 0.0147,),

          ],
        ),
      ),
    );
  }
}

