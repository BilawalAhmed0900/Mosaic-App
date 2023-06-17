import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mosaic_app/CommonWidgets/InterestSelectionWidget.dart';

class InitialInterestUser extends StatefulWidget {
  const InitialInterestUser({Key? key}) : super(key: key);

  @override
  State<InitialInterestUser> createState() => _InitialInterestUserState();
}

class _InitialInterestUserState extends State<InitialInterestUser> {
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
            SizedBox(
              height: height * 0.074,
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.043),
              child: SvgPicture.asset(
                "assets/svgs/mini_logo.svg",
                width: width * 0.093,
                height: height * 0.032,
              ),
            ),
            SizedBox(height: height * 0.037),
            Padding(
              padding: EdgeInsets.only(left: width * 0.043),
              child: Text(
                "What do you want to see",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: width * height * 8.21e-5,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.043),
              child: Row(
                children: [
                  Text(
                    "on ",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: width * height * 8.21e-5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: SvgPicture.asset(
                      "assets/svgs/mosaic_written.svg",
                      width: width * 0.256,
                      height: height * 0.022,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.012),
            Padding(
              padding: EdgeInsets.only(left: width * 0.043),
              child: Text(
                "Select at least 3 interests to personalize",
                style: TextStyle(
                  fontSize: width * height * 4.926e-5,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.043),
              child: Text(
                "your mosaic experience.",
                style: TextStyle(
                  fontSize: width * height * 4.926e-5,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.037,
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.043),
              child: Row(
                children: [
                  InterestSelectionWidget(
                    "Health",
                    unselectedColor: const Color(0xFF747480).withOpacity(0.08),
                    selectedColor: const Color(0xFFFFDD9B),
                    onTap: () {},
                  ),
                  SizedBox(width: width * 0.021,),
                  InterestSelectionWidget(
                    "Sports",
                    unselectedColor: const Color(0xFF747480).withOpacity(0.08),
                    selectedColor: const Color(0xFFD8CEFF),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.01,),
            Padding(
              padding: EdgeInsets.only(left: width * 0.043),
              child: Row(
                children: [
                  InterestSelectionWidget(
                    "Business and finance",
                    unselectedColor: const Color(0xFF747480).withOpacity(0.08),
                    selectedColor: const Color(0xFFFFDD9B),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.01,),
            Padding(
              padding: EdgeInsets.only(left: width * 0.043),
              child: Row(
                children: [
                  InterestSelectionWidget(
                    "Science",
                    unselectedColor: const Color(0xFF747480).withOpacity(0.08),
                    selectedColor: const Color(0xFFFFDD9B),
                    onTap: () {},
                  ),
                  SizedBox(width: width * 0.021,),
                  InterestSelectionWidget(
                    "Environment",
                    unselectedColor: const Color(0xFF747480).withOpacity(0.08),
                    selectedColor: const Color(0xFFD8CEFF),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.01,),
            Padding(
              padding: EdgeInsets.only(left: width * 0.043),
              child: Row(
                children: [
                  InterestSelectionWidget(
                    "Politics",
                    unselectedColor: const Color(0xFF747480).withOpacity(0.08),
                    selectedColor: const Color(0xFFC6FFC5),
                    onTap: () {},
                  ),
                  SizedBox(width: width * 0.021,),
                  InterestSelectionWidget(
                    "Human interest",
                    unselectedColor: const Color(0xFF747480).withOpacity(0.08),
                    selectedColor: const Color(0xFFFFDD9B),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.01,),
            Padding(
              padding: EdgeInsets.only(left: width * 0.043),
              child: Row(
                children: [
                  InterestSelectionWidget(
                    "Technology",
                    unselectedColor: const Color(0xFF747480).withOpacity(0.08),
                    selectedColor: const Color(0xFFC6FFC5),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.01,),
            Padding(
              padding: EdgeInsets.only(left: width * 0.043),
              child: Row(
                children: [
                  InterestSelectionWidget(
                    "Entertainment and lifestyle",
                    unselectedColor: const Color(0xFF747480).withOpacity(0.08),
                    selectedColor: const Color(0xFFCEEFFF),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
