import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mosaic_app/Scaffolds/account_page_scaffold.dart';

import '../Scaffolds/new_post_base_scaffold.dart';
import '../Scaffolds/notification_page_scaffold.dart';
import '../Scaffolds/settings_page_scaffold.dart';

Widget buildBottomDrawer(BuildContext context,
    BottomDrawerController controller, void Function(bool) callback) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  List<String> labels = [
    "Create Stance",
    "Profile",
    "Notifications",
    "Settings",
    "Search",
    "Rate Us",
  ];

  List<Widget> icons = [
    CircleAvatar(
      radius: width * height * 3.284e-5,
      backgroundColor: const Color(0xFFCCCCCC),
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: width * height * 6.568e-5,
      ),
    ),
    SvgPicture.asset(
      "assets/svgs/profile_icon.svg",
      width: width * 0.053,
      height: height * 0.025,
    ),
    SvgPicture.asset(
      "assets/svgs/notification_with_dot.svg",
      width: width * 0.053,
      height: height * 0.025,
    ),
    Icon(
      Icons.settings,
      color: const Color(0xFFCCCCCC),
      size: width * height * 6.568e-5,
    ),
    Icon(
      Icons.search,
      color: const Color(0xFFCCCCCC),
      size: width * height * 6.568e-5,
    ),
    Icon(
      Icons.star,
      color: const Color(0xFFCCCCCC),
      size: width * height * 6.568e-5,
    ),
  ];

  List<VoidCallback> callbacks = [
    () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const NewPostBaseScaffold();
      }));
    },
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
    () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const SettingsPageScaffold();
      }));
    },
    () {},
    () {},
  ];

  return BottomDrawer(
    callback: callback,
    header: Container(),
    body: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height * 0.027,
          ),
          Padding(
            padding: EdgeInsets.only(right: width * 0.059),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    controller.close();
                  },
                  child: Icon(
                    Icons.close,
                    size: width * height * 5.911e-5,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: height * 0.031,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/svgs/mini_logo.svg",
                  width: width * 0.085, height: height * 0.031),
              SizedBox(width: width * 0.029),
              SvgPicture.asset("assets/svgs/mosaic_written.svg",
                  width: width * 0.344, height: height * 0.027),
            ],
          ),
          SizedBox(
            height: height * 0.081,
          ),
          SizedBox(
            height: height * 0.324,
            child: ListView.separated(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: callbacks[index],
                  child: SizedBox(
                    height: height * 0.054,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.059),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              icons[index],
                              SizedBox(
                                width: width * 0.051,
                              ),
                              Text(
                                labels[index],
                                style: TextStyle(
                                    fontSize: width * height * 5.583e-5),
                              ),
                            ],
                          ),
                          SvgPicture.asset("assets/svgs/arrow_rightward.svg"),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 1,
                );
              },
              itemCount: labels.length,
              physics: const NeverScrollableScrollPhysics(),
            ),
          ),
          SizedBox(
            height: height * 0.206,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width * 0.818,
                height: height * 0.0665,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFFF4F4F5),
                    shape: RoundedRectangleBorder(
                      side: BorderSide.none,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.logout,
                        color: Color(0xFFF40636),
                      ),
                      SizedBox(width: width * 0.024),
                      Text(
                        "Log out",
                        style: TextStyle(
                          color: const Color(0xFFF40636),
                          fontSize: width * height * 0.0000591,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    headerHeight: 0,
    drawerHeight: height * 0.885,
    controller: controller,
  );
}
