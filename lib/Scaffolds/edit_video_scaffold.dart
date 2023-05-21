import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:video_editor/domain/bloc/controller.dart';
import 'package:video_editor/ui/cover/cover_viewer.dart';
import 'package:video_editor/ui/trim/trim_slider.dart';
import 'package:video_editor/ui/trim/trim_timeline.dart';

class EditVideoScaffold extends StatefulWidget {
  final XFile originalVideo;

  const EditVideoScaffold({Key? key, required this.originalVideo}) : super(key: key);

  @override
  State<EditVideoScaffold> createState() => _EditVideoScaffoldState();
}

class _EditVideoScaffoldState extends State<EditVideoScaffold> {
  late VideoEditorController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoEditorController.file(File(widget.originalVideo.path), maxDuration: const Duration(days: 1));
    _controller.initialize().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if (!_controller.initialized) {
      return Scaffold(
        body: SafeArea(
          child: Container(
            color: Colors.black,
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: Stack(
            children: [
              Center(
                child: CoverViewer(controller: _controller),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.809,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _controller.videoDuration.toString(),
                        style: TextStyle(color: Colors.white, fontSize: width * height * 4.269e-5),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.012,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width * 0.824,
                        child: TrimSlider(
                          controller: _controller,
                          height: height * 0.037,
                          child: TrimTimeline(
                            controller: _controller,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.043),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.of(context).pop<XFile?>(null);
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: width * height * 5.911e-5,
                              ),
                            ),),
                        InkWell(
                          onTap: () {
                            _controller.exportVideo(onCompleted: (file) {
                              Navigator.of(context).pop<XFile?>(XFile(file.path));
                            });
                          },
                          child: Text(
                            "Done",
                            style: TextStyle(
                              color: const Color(0xFFFFAF00),
                              fontWeight: FontWeight.w600,
                              fontSize: width * height * 5.911e-5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
