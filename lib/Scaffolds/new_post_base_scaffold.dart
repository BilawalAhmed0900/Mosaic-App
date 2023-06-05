import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mosaic_app/CommonWidgets/bottom_drawer.dart';
import 'package:mosaic_app/Scaffolds/edit_video_scaffold.dart';
import 'package:video_editor/video_editor.dart';

import '../CommonWidgets/common_setting_search_notification.dart';

Future<XFile?> editVideo(BuildContext context, XFile? file) async {
  if (file == null) return null;

  return await Navigator.of(context)
      .push<XFile?>(MaterialPageRoute(builder: (context) {
    return EditVideoScaffold(
      originalVideo: file,
    );
  }));
}

class NewPostBaseScaffold extends StatefulWidget {
  const NewPostBaseScaffold({Key? key}) : super(key: key);

  @override
  State<NewPostBaseScaffold> createState() => _NewPostBaseScaffoldState();
}

class _NewPostBaseScaffoldState extends State<NewPostBaseScaffold> {
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
                ...commonSettingSearchNotification(
                    context, "New Post", _controller,
                    showAccountIcon: false, showSettingIcon: false),
                SizedBox(
                  height: height * 0.044,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.043),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          ImagePicker()
                              .pickVideo(
                                  source: ImageSource.camera,
                                  preferredCameraDevice: CameraDevice.front)
                              .then((value) {
                            editVideo(context, value).then((value) {
                              print(value?.path);
                            });
                          });
                        },
                        child: Container(
                          width: width * 0.445,
                          height: height * 0.283,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFDD9B),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt,
                                size: width * height * 7.882e-5,
                              ),
                              SizedBox(
                                height: height * 0.018,
                              ),
                              const Text(
                                "Camera",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          ImagePicker()
                              .pickVideo(source: ImageSource.gallery)
                              .then((value) {
                            editVideo(context, value).then((value) {
                              print(value?.path);
                            });
                          });
                        },
                        child: Container(
                          width: width * 0.445,
                          height: height * 0.283,
                          decoration: BoxDecoration(
                            color: const Color(0xFFC6FFC5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/svgs/gallery_icon.svg",
                                theme: const SvgTheme(
                                  currentColor: Color(0xFFFFFFFF),
                                ),
                                width: width * 0.08,
                                height: height * 0.037,
                              ),
                              SizedBox(
                                height: height * 0.018,
                              ),
                              const Text(
                                "Gallery",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
    );
  }
}
