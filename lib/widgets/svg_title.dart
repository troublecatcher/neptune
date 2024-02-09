import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgTitle extends StatelessWidget {
  final String path;

  const SvgTitle({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SvgPicture.asset(
        path,
        height: 50.sp,
      ),
    );
  }
}
