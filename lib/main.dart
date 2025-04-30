import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/layout/shop/controller/cubit.dart';
import 'package:shop_app/core/shared/network/remote/shop_helper.dart';
import 'package:shop_app/features/shop/users/login/presentation/screens/login_screen.dart';
import 'core/layout/shop/shop_layout.dart';
import 'core/observer/bloc_observer.dart';
import 'core/shared/const/constance.dart';
import 'core/shared/network/local/cache_helper.dart';
import 'core/shared/theme/controller/cubit.dart';
import 'core/shared/theme/controller/state.dart';
import 'core/shared/theme/theme_mode.dart';
import 'features/shop/onboarding/presentation/screens/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // for sharedPresences run
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  ShopHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  debugPrint(onBoarding.toString());
  token = CacheHelper.getData(key: 'token');
  debugPrint(token.toString());
  String? lang= CacheHelper.getData(key: 'language');
  lang != null ? language = lang : language = 'en';
  Widget widget;
  if (onBoarding != null) {
    if (token != null) {
      widget = ShopLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  runApp(MyApp(isDark: isDark, startWidget: widget));
  // runApp(
  //     DevicePreview(
  //       enabled: !kReleaseMode,
  //       builder: (context) => MyApp(
  //         isDark: isDark,
  //         startWidget: widgets,
  //       ),
  //     ),
  // );
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget startWidget;

  const MyApp({super.key, required this.isDark, required this.startWidget});

  // This widgets is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeModeCubit()..changeThemeMode(fromShared: isDark),
        ),
        //BlocProvider(create: (context) => NewsCubit()..getBusiness()..getSports()..getScience(),),
        BlocProvider(create: (context) => ShopLayoutCubit()..getHome()..getCategory()..getFavorite(),)
      ],
      child: BlocConsumer<ThemeModeCubit, ThemeModeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: getLightMode(),
            // customized theme
            darkTheme: getDarkMode(),
            themeMode:
                ThemeModeCubit.get(context).isDark
                    ? ThemeMode.light
                    : ThemeMode.dark,
            // default theme of system
            home: startWidget,
          );
        },
      ),
    );
  }
}
