import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mosaic_app/Constants/constants.dart';

import 'package:wheel_chooser/wheel_chooser.dart';

class WatchVideoScaffold extends StatefulWidget {
  const WatchVideoScaffold({Key? key}) : super(key: key);

  @override
  State<WatchVideoScaffold> createState() => _WatchVideoScaffoldState();
}

class _WatchVideoScaffoldState extends State<WatchVideoScaffold> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: Colors.black,
              child: const Center(
                child: Text(
                  "Video Here",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
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
                        onTap: () {},
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
                        onTap: () {},
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
                  height: height * 0.328,
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
                          )),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
