import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:neptune/theme/default.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/audio.dart';
import 'router/router.dart';

final player = AudioPlayer();
final locator = GetIt.instance;
bool musicIncluded = false;
String musicAssetPath = 'assets/music.mp3';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  if (musicIncluded) {
    player.setAsset(musicAssetPath);
    player.play();
    player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        player.seek(Duration.zero);
        player.play();
      }
    });
  }
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  // locator<SharedPreferences>().clear();
  if (locator<SharedPreferences>().getBool('diff1') == null) {
    await locator<SharedPreferences>().setBool('diff1', true);
    await locator<SharedPreferences>().setBool('diff2', false);
    await locator<SharedPreferences>().setBool('diff3', false);
  }
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: AudioBloc(player: player),
        ),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        ScreenUtil.init(context);
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: MaterialApp.router(
              theme: theme,
              debugShowCheckedModeBanner: false,
              routerConfig: _appRouter.config(),
            ));
      },
    );
  }
}
