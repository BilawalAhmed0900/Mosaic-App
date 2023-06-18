import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:mosaic_app/CommonWidgets/InterestSelectionWidget.dart';
import 'package:mosaic_app/Scaffolds/sign_in_scaffold.dart';
import 'package:mosaic_app/Scaffolds/watch_page_scaffold.dart';
import 'package:mosaic_app/Scaffolds/welcome_back_scaffold.dart';

import '../Constants/constants.dart';
import '../Data/user.dart';

class InitialInterestUser extends StatefulWidget {
  const InitialInterestUser({Key? key}) : super(key: key);

  @override
  State<InitialInterestUser> createState() => _InitialInterestUserState();
}

class _InitialInterestUserState extends State<InitialInterestUser> {
  final Map<int, bool> _selectedInterests = {};

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
            FutureBuilder<Response>(
              future: get(
                Uri.parse("$HOST:$PORT/$INTEREST_GET_ALL_PATH"),
                headers: {"authorization": "Bearer ${User.getInstance().token}"},
              ),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }

                Map<String, dynamic> jsonBody = json.decode(snapshot.data!.body);
                List<Map<String, dynamic>> interestsDataJson = (jsonBody["data"] as List<dynamic>).map((e) {
                  return (e as Map).map((key, value) {
                    return MapEntry(key as String, value);
                  });
                }).toList();

                Map<int, String> idToInterestName = {};
                Map<String, int> interestNameToId = {};
                for (Map<String, dynamic> entry in interestsDataJson) {
                  idToInterestName[entry["id"] as int] = entry["name"] as String;
                  interestNameToId[entry["name"] as String] = entry["id"] as int;
                }

                int countTrue = 0;
                for (MapEntry<int, bool> entry in _selectedInterests.entries) {
                  countTrue += entry.value ? 1 : 0;
                }

                bool enableNext = countTrue >= 3;
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.043),
                      child: Row(
                        children: [
                          InterestSelectionWidget(
                            "Health",
                            unselectedColor: const Color(0xFF747480).withOpacity(0.08),
                            selectedColor: const Color(0xFFFFDD9B),
                            onTap: (state) {
                              _selectedInterests[interestNameToId["Health"]!] = state;
                              setState(() {});
                            },
                          ),
                          SizedBox(
                            width: width * 0.021,
                          ),
                          InterestSelectionWidget(
                            "Sports",
                            unselectedColor: const Color(0xFF747480).withOpacity(0.08),
                            selectedColor: const Color(0xFFD8CEFF),
                            onTap: (state) {
                              _selectedInterests[interestNameToId["Sports"]!] = state;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.043),
                      child: Row(
                        children: [
                          InterestSelectionWidget(
                            "Business and finance",
                            unselectedColor: const Color(0xFF747480).withOpacity(0.08),
                            selectedColor: const Color(0xFFFFDD9B),
                            onTap: (state) {
                              _selectedInterests[interestNameToId["Business and Finance"]!] = state;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.043),
                      child: Row(
                        children: [
                          InterestSelectionWidget(
                            "Science",
                            unselectedColor: const Color(0xFF747480).withOpacity(0.08),
                            selectedColor: const Color(0xFFFFDD9B),
                            onTap: (state) {
                              _selectedInterests[interestNameToId["Science"]!] = state;
                              setState(() {});
                            },
                          ),
                          SizedBox(
                            width: width * 0.021,
                          ),
                          InterestSelectionWidget(
                            "Environment",
                            unselectedColor: const Color(0xFF747480).withOpacity(0.08),
                            selectedColor: const Color(0xFFD8CEFF),
                            onTap: (state) {
                              _selectedInterests[interestNameToId["Environment"]!] = state;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.043),
                      child: Row(
                        children: [
                          InterestSelectionWidget(
                            "Politics",
                            unselectedColor: const Color(0xFF747480).withOpacity(0.08),
                            selectedColor: const Color(0xFFC6FFC5),
                            onTap: (state) {
                              _selectedInterests[interestNameToId["Politics"]!] = state;
                              setState(() {});
                            },
                          ),
                          SizedBox(
                            width: width * 0.021,
                          ),
                          InterestSelectionWidget(
                            "Human interest",
                            unselectedColor: const Color(0xFF747480).withOpacity(0.08),
                            selectedColor: const Color(0xFFFFDD9B),
                            onTap: (state) {
                              _selectedInterests[interestNameToId["Human interest"]!] = state;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.043),
                      child: Row(
                        children: [
                          InterestSelectionWidget(
                            "Technology",
                            unselectedColor: const Color(0xFF747480).withOpacity(0.08),
                            selectedColor: const Color(0xFFC6FFC5),
                            onTap: (state) {
                              _selectedInterests[interestNameToId["Technology"]!] = state;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.043),
                      child: Row(
                        children: [
                          InterestSelectionWidget(
                            "Entertainment and lifestyle",
                            unselectedColor: const Color(0xFF747480).withOpacity(0.08),
                            selectedColor: const Color(0xFFCEEFFF),
                            onTap: (state) {
                              _selectedInterests[interestNameToId["Entertainment and Lifestyle"]!] = state;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.2,
                    ),
                    SizedBox(
                      width: width * 0.914,
                      height: height * 0.0665,
                      child: OutlinedButton(
                        onPressed: !enableNext
                            ? null
                            : () {
                                List<int> interestIds = [];
                                for (MapEntry<int, bool> entry in _selectedInterests.entries) {
                                  if (entry.value) {
                                    interestIds.add(entry.key);
                                  }
                                }

                                Map<String, dynamic> map = {"userId": User.getInstance().userId, "interestIds": interestIds};

                                String jsonString = json.encode(map);
                                Map<String, String> headers = {
                                  "Content-Type": "application/json",
                                  "authorization": "Bearer ${User.getInstance().token}"
                                };
                                Uri uri = Uri.parse("$HOST:$PORT/$INTEREST_ADD_USER_INTEREST");
                                Encoding encoding = Encoding.getByName("utf-8")!;

                                post(uri, headers: headers, body: jsonString, encoding: encoding).then((value) {
                                  Map<String, dynamic> jsonBody = json.decode(value.body);
                                  if (jsonBody["status"] == 0) {
                                    User.getInstance().userName = "";
                                    User.getInstance().email = "";
                                    User.getInstance().firstName = "";
                                    User.getInstance().lastName = "";
                                    User.getInstance().token = "";
                                    User.getInstance().interests.clear();

                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const AlertDialog(
                                          title: Text("Token Expired"),
                                          content: Text("Please login again"),
                                        );
                                      },
                                    ).then((value) {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                        return const WelcomeBackScaffold();
                                      }));
                                    });
                                  } else {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                      return const WatchVideoScaffold();
                                    }));
                                  }
                                });
                              },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: !enableNext ? const Color(0xFFF4F4F5) : Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(48),
                          ),
                        ),
                        child: Text(
                          "Next",
                          style: TextStyle(
                            color: !enableNext ? Colors.black : Colors.white,
                            fontSize: width * height * 0.0000591,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
