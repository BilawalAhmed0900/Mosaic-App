import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

ListView createView(BuildContext context, List<String> labels, List<Icon> icons, List<VoidCallback?> actions) {
  assert(labels.length == icons.length);
  assert(labels.length == actions.length);
  assert(labels.length == 4);

  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  return ListView.separated(
    itemBuilder: (context, index) {
      return Padding(
        padding: EdgeInsets.only(left: width * 0.0426, right: width * 0.0693, top: height * 0.00985, bottom: height * 0.00985,),
        child: InkWell(
          onTap: actions[index],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  icons[index],
                  SizedBox(width: width * 0.0373),
                  Text(labels[index]),
                ],
              ),
              SvgPicture.asset("assets/svgs/arrow_rightward.svg"),
            ],
          ),
        ),
      );
    },
    physics: const NeverScrollableScrollPhysics(),
    separatorBuilder: (context, index) {
      return const Divider();
    },
    itemCount: labels.length,
  );
}
