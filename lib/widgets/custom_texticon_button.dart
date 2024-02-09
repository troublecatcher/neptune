import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/default.dart';

class CustomTextIconButton extends StatelessWidget {
  final List<Widget> children;
  final Function(dynamic) callback;

  const CustomTextIconButton({
    Key? key,
    required this.children,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback('Argument'),
      child: FittedBox(
        child: Container(
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
          child: Row(
            children: [...children],
          ),
        ),
      ),
    );
  }
}
