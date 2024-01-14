import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neptune/const/color.dart';

class CustomIconButton extends StatelessWidget {
  final String path;
  final Function(dynamic) callback;
  final double radius;

  const CustomIconButton({
    Key? key,
    required this.path,
    required this.callback,
    required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;
    final buttonSize = isTablet ? 60.0 : 50.0;
    final paddingSize = 15.0;

    return GestureDetector(
      onTap: () => callback('Argument'),
      child: Container(
        width: buttonSize,
        height: buttonSize,
        padding: EdgeInsets.all(paddingSize),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          color: color1,
        ),
        child: SvgPicture.asset(
          path,
          color: Colors.white,
        ),
      ),
    );
  }
}
