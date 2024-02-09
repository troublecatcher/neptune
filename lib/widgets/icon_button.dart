import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/default.dart';

class CustomIconButton extends StatelessWidget {
  final String path;
  final Function(dynamic) callback;

  const CustomIconButton({
    Key? key,
    required this.path,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback('Argument'),
      child: Container(
        width: 60,
        height: 60,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: buttonTextColor),
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: textBrownColor,
          boxShadow: const [
            BoxShadow(
              offset: Offset(2, 2),
              blurRadius: 10,
              color: Colors.black,
              inset: true,
            ),
          ],
        ),
        child: SvgPicture.asset(
          path,
        ),
      ),
    );
  }
}
