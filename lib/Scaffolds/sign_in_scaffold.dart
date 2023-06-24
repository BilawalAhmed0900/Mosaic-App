import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:mosaic_app/Data/user.dart';
import 'package:mosaic_app/Scaffolds/initial_interest_user_scaffold.dart';
import 'package:mosaic_app/Scaffolds/sign_up_scaffold.dart';
import 'package:mosaic_app/Scaffolds/watch_page_scaffold.dart';

import '../Constants/constants.dart';

class SignInScaffold extends StatefulWidget {
  const SignInScaffold({Key? key}) : super(key: key);

  @override
  State<SignInScaffold> createState() => _SignInScaffoldState();
}

class _SignInScaffoldState extends State<SignInScaffold> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: /*const Color(0xFFBBBBBB)*/ Colors.white,
          child: Padding(
            padding: EdgeInsets.only(top: height * 0.0738, left: width * 0.0426, right: width * 0.0426),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      "assets/svgs/mini_logo.svg",
                      width: width * 0.0919,
                      height: height * 0.0320,
                    )
                  ],
                ),
                SizedBox(height: height * 0.0369),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome to ",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: width * height * 0.0000919),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.00739),
                      child: SvgPicture.asset(
                        "assets/svgs/mosaic_written.svg",
                        height: height * 0.0246,
                        width: width * 0.256,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.0123),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Please use your email address and",
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: width * height * 0.0000525),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "password to login",
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: width * height * 0.0000525),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.0615),
                SizedBox(
                  width: width * 0.914,
                  height: height * 0.0541,
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: "Email",
                      fillColor: Color(0x14747480),
                      filled: true,
                      focusColor: Color(0x14747480),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.0123),
                SizedBox(
                  width: width * 0.914,
                  height: height * 0.0541,
                  child: TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: "Password",
                      fillColor: Color(0x14747480),
                      filled: true,
                      focusColor: Color(0x14747480),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    obscureText: true,
                  ),
                ),
                SizedBox(height: height * 0.0246),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: width * height * 0.0000525),
                      ),
                    )
                  ],
                ),
                SizedBox(height: height * 0.0369),
                SizedBox(
                  width: width * 0.914,
                  height: height * 0.0665,
                  child: OutlinedButton(
                    onPressed: () {
                      Map<String, dynamic> map = {"email": _emailController.text, "password": _passwordController.text};

                      String jsonString = json.encode(map);
                      Map<String, String> headers = {"Content-Type": "application/json"};
                      Uri uri = Uri.parse("$HOST:$PORT/$SIGNIN_PATH");
                      Encoding encoding = Encoding.getByName("utf-8")!;

                      post(uri, headers: headers, body: jsonString, encoding: encoding).then((value) {
                        Map<String, dynamic> jsonBody = json.decode(value.body);
                        if (jsonBody["status"] as int == 0) {
                          User.getInstance().clearUser();
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  title: Text("Check your credentials"),
                                  content: Text(""),
                                );
                              });

                          return;
                        }

                        print(jsonBody);
                        User.getInstance().userId = jsonBody["data"]["id"] as int;
                        User.getInstance().userName = jsonBody["data"]["userName"] as String;
                        User.getInstance().email = jsonBody["data"]["email"] as String;
                        User.getInstance().firstName = (jsonBody["data"]["firstName"] as String?) ?? "";
                        User.getInstance().lastName = (jsonBody["data"]["lastName"] as String?) ?? "";
                        User.getInstance().token = (jsonBody["token"]["token"] as String?) ?? "";
                        User.getInstance().interests.clear();

                        get(Uri.parse("$HOST:$PORT/$INTEREST_GET_USER_PATH"),
                            headers: {"authorization": "Bearer ${User.getInstance().token}"}).then((value) {
                          Map<String, dynamic> jsonBody = json.decode(value.body);
                          if ((jsonBody["data"] as List).isEmpty) {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return const InitialInterestUser();
                            }));
                          } else {
                            User.getInstance().interests.addEntries(
                                  (jsonBody["data"] as List<dynamic>).map(
                                    (e) {
                                      return MapEntry<int, String>(jsonBody["data"]["id"] as int, jsonBody["data"]["name"] as String);
                                    },
                                  ),
                                );

                            print(User.getInstance().interests);
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return const WatchVideoScaffold();
                            }));
                          }
                        });
                      }).onError((error, stackTrace) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Check your credentials"),
                                content: Text(error.toString()),
                              );
                            });
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(48),
                      ),
                    ),
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: width * height * 0.0000591,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.0123),
                SizedBox(
                  width: width * 0.914,
                  height: height * 0.0665,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xFFF4F4F5),
                      shape: RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadius.circular(48),
                      ),
                    ),
                    child: Text(
                      "Guest login",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: width * height * 0.0000591,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.0369),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "OR",
                      style: TextStyle(color: const Color(0xFF3C3C43), fontSize: width * height * 0.0000426),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.0418),
                Padding(
                  padding: EdgeInsets.only(left: width * 0.0933, right: width * 0.0933),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: width * height * 0.000114,
                        backgroundColor: const Color(0xFFF0F0F0),
                        child: SvgPicture.asset(
                          "assets/svgs/google-icon.svg",
                          width: min(width * 0.064, height * 0.0295),
                          height: min(width * 0.064, height * 0.0295),
                        ),
                      ),
                      CircleAvatar(
                        radius: width * height * 0.000114,
                        backgroundColor: const Color(0xFFF0F0F0),
                        child: SvgPicture.asset(
                          "assets/svgs/facebook-icon.svg",
                          width: min(width * 0.064, height * 0.0295),
                          height: min(width * 0.064, height * 0.0295),
                        ),
                      ),
                      CircleAvatar(
                        radius: width * height * 0.000114,
                        backgroundColor: const Color(0xFFF0F0F0),
                        child: SvgPicture.asset(
                          "assets/svgs/apple-icon.svg",
                          width: min(width * 0.064, height * 0.0295),
                          height: min(width * 0.064, height * 0.0295),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.0652),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: const Color(0x4C3C3C43), fontWeight: FontWeight.w600, fontSize: width * height * 0.0000426),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return const SignUpScaffold();
                        }));
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: width * height * 0.0000426),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
