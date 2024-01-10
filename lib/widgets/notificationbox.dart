import 'package:aimlproject/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationBox extends StatelessWidget {
  const NotificationBox({
    Key? key,
    this.onTap,
    this.notifiedNumber = 0,
  }) : super(key: key);

  final GestureTapCallback? onTap;
  final int notifiedNumber;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.appBarColor,
          border: Border.all(color: Colors.grey.withOpacity(.3)),
        ),
        child: SvgPicture.asset("assets/icons/bell.svg"),
      ),
    );
  }
}

// notifiedNumber > 0 ?
//         Badge(
//                 badgeColor: AppColor.actionColor,
//                 padding: EdgeInsets.all(3),
//                 position: BadgePosition.topEnd(top: -3, end: -3),
//                 badgeContent: Text(
//                   '',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 child: SvgPicture.asset(
//                   "assets/icons/bell.svg",
//                   width: 25,
//                   height: 25,
//                 ),
//               )
//             :