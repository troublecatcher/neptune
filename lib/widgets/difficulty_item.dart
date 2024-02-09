import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neptune/theme/default.dart';

class DifficultyItem extends StatelessWidget {
  final String imagePath;
  final SvgPicture svg;
  final Function(dynamic) callback;
  final bool isUnlocked;

  const DifficultyItem(
      {super.key,
      required this.imagePath,
      required this.svg,
      required this.callback,
      required this.isUnlocked});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback(1),
      child: Opacity(
        opacity: isUnlocked ? 1.0 : 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: MediaQuery.of(context).size.width / 6,
              width: MediaQuery.of(context).size.width / 6,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  border: const Border(
                      top: BorderSide(width: 4, color: buttonTextColor),
                      right: BorderSide(width: 4, color: buttonTextColor),
                      left: BorderSide(width: 4, color: buttonTextColor))),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14)),
                child: Container(
                  color: isUnlocked
                      ? Colors.transparent
                      : Colors.red.withOpacity(0.5),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.width / 12,
                width: MediaQuery.of(context).size.width / 6,
                decoration: BoxDecoration(
                  border: Border.all(width: 4, color: buttonTextColor),
                ),
                child: svg),
          ],
        ),
      ),
    );
  }
}
