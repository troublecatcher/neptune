import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neptune/router/router.dart';
import 'package:neptune/widgets/custom_text_button.dart';
import 'package:neptune/widgets/icon_button.dart';
import 'package:neptune/widgets/svg_title.dart';
import 'package:neptune/widgets/widget_padding.dart';
import 'package:share_plus/share_plus.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg/lod.png'), fit: BoxFit.cover)),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Color.fromRGBO(0, 0, 0, 0.5),
              ],
            ),
            backgroundBlendMode: BlendMode.darken,
          ),
          child: SafeArea(
            child: WidgetPadding(
              child: Stack(
                children: [
                  CustomIconButton(
                    path: 'assets/icons/back.svg',
                    callback: context.router.pop,
                  ),
                  const SvgTitle(path: 'assets/titles/settings.svg'),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Builder(builder: (_) {
                            return CustomTextButton(
                                callback: (p0) {
                                  final box =
                                      _.findRenderObject() as RenderBox?;
                                  Share.share('Check out this pirate game!',
                                      sharePositionOrigin:
                                          box!.localToGlobal(Offset.zero) &
                                              box.size);
                                },
                                children: [
                                  Text('Share with friends',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge)
                                ]);
                          }),
                        ),
                        CustomTextButton(
                            callback: (_) {
                              context.router.push(const PrivacyPolicyRoute());
                            },
                            children: [
                              Text('Privacy Policy',
                                  style:
                                      Theme.of(context).textTheme.displayLarge)
                            ]),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CustomTextButton(
                              callback: (_) {
                                context.router.push(const TermsOfUseRoute());
                              },
                              children: [
                                Text('Terms of use',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge)
                              ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
