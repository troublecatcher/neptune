import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/icon_button.dart';

@RoutePage()
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 15),
              child: CustomIconButton(
                path: 'assets/icons/back.svg',
                callback: context.router.pop,
                radius: 8,
              ),
            ),
            Center(
                child: Text(
              'Privacy Policy goes here',
              style: Theme.of(context).textTheme.displayLarge,
            ))
          ],
        ),
      ),
    );
  }
}
