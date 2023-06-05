import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mosaic_app/CommonWidgets/bottom_drawer.dart';

import '../CommonWidgets/common_setting_search_notification.dart';

class SearchPageScaffold extends StatefulWidget {
  const SearchPageScaffold({Key? key}) : super(key: key);

  @override
  State<SearchPageScaffold> createState() => _SearchPageScaffoldState();
}

class _SearchPageScaffoldState extends State<SearchPageScaffold> {
  List<String> recentSearches = [];

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
                ...commonSettingSearchNotification(context, "Search", _controller),
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
                          setState(() {
                            recentSearches.add(value);
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.0369,
                ),
                Padding(
                  padding: EdgeInsets.only(left: width * 0.0426, right: width * 0.0346),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recent",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: width * height * 0.0000656,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          "See All",
                          style: TextStyle(
                            color: const Color(0xFF007AFF),
                            fontSize: width * height * 0.0000558,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.0135,
                ),
                SizedBox(
                  height: height * 0.228,
                  width: width - 1,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(left: width * 0.0506, right: width * 0.0293),
                        child: SizedBox(
                          height: height * 0.057,
                          child: Column(
                            children: [
                              SizedBox(
                                height: height * 0.012,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.search,
                                        size: width * height * 0.0000788,
                                        color: const Color(0xFF848488),
                                      ),
                                      SizedBox(width: width * 0.0613),
                                      Text(
                                        recentSearches[recentSearches.length - index - 1],
                                        style: TextStyle(fontSize: width * height * 0.0000558),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        recentSearches.removeAt(recentSearches.length - index - 1);
                                      });
                                    },
                                    child: CircleAvatar(
                                      radius: width * height * 0.0000246,
                                      backgroundColor: const Color(0xFF979797),
                                      child: Icon(
                                        Icons.close_sharp,
                                        size: width * height * 0.0000331,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.012,
                              ),
                              const Divider(
                                height: 1,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: recentSearches.length > 4 ? 4 : recentSearches.length,
                  ),
                ),
                SizedBox(
                  height: height * 0.0344,
                ),
                Padding(
                  padding: EdgeInsets.only(left: width * 0.0426, right: width * 0.0346),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Suggested",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: width * height * 0.0000656,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          "See All",
                          style: TextStyle(
                            color: const Color(0xFF007AFF),
                            fontSize: width * height * 0.0000558,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: height * 0.0221),
                Padding(
                  padding: EdgeInsets.only(left: width * 0.064),
                  child: SizedBox(
                    height: height * 0.167,
                    width: width * 0.949,
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const VerticalDivider();
                      },
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            CircleAvatar(
                              radius: width * height * 0.000131,
                              child: const Icon(Icons.supervised_user_circle),
                            ),
                            SizedBox(
                              height: height * 0.00985,
                            ),
                            Text(
                              "Name Here",
                              style: TextStyle(
                                fontSize: width * height * 0.0000492,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.00369,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                "Follow",
                                style: TextStyle(
                                  fontSize: width * height * 0.0000426,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF007AFF),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      scrollDirection: Axis.horizontal,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: 4,
                    ),
                  ),
                )
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
