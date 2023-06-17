import 'package:flutter/material.dart';

class InterestSelectionWidget extends StatefulWidget {
  final String interestName;
  final Color unselectedColor, selectedColor;
  final VoidCallback onTap;

  const InterestSelectionWidget(this.interestName,
      {Key? key, required this.unselectedColor, required this.selectedColor, required this.onTap})
      : super(key: key);

  @override
  State<InterestSelectionWidget> createState() => _InterestSelectionWidgetState();
}

class _InterestSelectionWidgetState extends State<InterestSelectionWidget> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () {
        setState(() {
          _checked = !_checked;
        });

        widget.onTap();
      },
      splashFactory: NoSplash.splashFactory,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        height: width * height * 1.314e-4,
        decoration: BoxDecoration(
          color: _checked ? widget.selectedColor : widget.unselectedColor,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 4, right: 20),
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: _checked ? Colors.black : Colors.white,
                child: _checked
                    ? const Icon(
                        Icons.check,
                        color: Colors.white,
                      )
                    : Container(),
              ),
              const SizedBox(width: 10),
              Text(
                widget.interestName,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: width * height * 5.255e-5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
