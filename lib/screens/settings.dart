import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neptune/router/router.dart';
import 'package:neptune/widgets/icon_button.dart';
import 'package:share_plus/share_plus.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height / 15),
                child: CustomIconButton(
                  path: 'assets/icons/back.svg',
                  callback: context.router.pop,
                  radius: 8,
                )),
            Center(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height / 3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Settings',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ElevatedButton(
                          onPressed: () {
                            Share.share('Check out this Neptune game!');
                          },
                          child: Text('Share with friends',
                              style: Theme.of(context).textTheme.displaySmall)),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          context.router.push(const PrivacyPolicyRoute());
                        },
                        child: Text('Privacy Policy',
                            style: Theme.of(context).textTheme.displaySmall)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ElevatedButton(
                          onPressed: () {
                            context.router.push(const TermsOfUseRoute());
                          },
                          child: Text('Terms of use',
                              style: Theme.of(context).textTheme.displaySmall)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
