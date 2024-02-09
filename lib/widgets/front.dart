import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

import '../theme/default.dart';

class FrontImage extends StatelessWidget {
  const FrontImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: Image.asset(
                  'assets/cards/card1.png',
                  fit: BoxFit.fill,
                  colorBlendMode: BlendMode.colorBurn,
                  color: textBrownColor,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/cards/card1.png')),
                border: Border.all(width: 2, color: buttonTextColor),
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(2, 2),
                    blurRadius: 10,
                    color: Colors.black,
                    inset: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
