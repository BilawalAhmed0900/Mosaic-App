import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mosaic_app/Scaffolds/account_page_scaffold.dart';
import 'package:mosaic_app/Scaffolds/settings_page_scaffold.dart';

List<Widget> commonSettingSearchNotification(BuildContext context, String heading, [bool isSettingPage = false]) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  return [
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
                SvgPicture.asset("assets/svgs/arrow_leftward.svg", theme: const SvgTheme(currentColor: Color(0xFF007AFF),), width: width * 0.016, height: height * 0.0147),
                SizedBox(width: width * 0.024,),
                Text("Back", style: TextStyle(color: const Color(0xFF007AFF), fontSize: width * height * 0.0000558),),
              ],
            ),
          ),
          InkWell(
            onTap: (!isSettingPage) ? () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const SettingsPageScaffold();
              }));
            } : null,
            child: Icon(
              Icons.apps,
              color: Colors.black,
              size: width * height * 0.0000656,
            ),
          ),
        ],
      ),
    ),
    SizedBox(height: height * 0.0233,),
    Padding(
      padding: EdgeInsets.only(left: width * 0.0426, right: width * 0.0346),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(heading, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: width * height * 0.0000919),),
          InkWell(onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const AccountPageScaffold();
            }));
          }, child: CircleAvatar(radius: width * height * 0.0000525, child: const Icon(Icons.supervised_user_circle_outlined),)),
        ],
      ),
    ),
  ];
}
