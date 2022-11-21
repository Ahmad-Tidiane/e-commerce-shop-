import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/layout/home_layout/home_layout.dart';
import 'package:ecommerce/layout/splash_screen/spalsh_screen.dart';
import 'package:ecommerce/modules/SettingScreens/screens/profile_screen/bloc/cubit.dart';
import 'package:ecommerce/modules/on_boarding_screen/on_boardin_screen.dart';
import 'package:ecommerce/shared/Constans/constans.dart';
import 'package:ecommerce/shared/Network/local/cacheHelper.dart';
import 'package:ecommerce/shared/Styles/theme/cubit/cubit.dart';
import 'package:ecommerce/shared/Styles/theme/cubit/states.dart';
import 'package:ecommerce/shared/Styles/theme/theme.dart';

import 'layout/Bloc/observer_bloc.dart';
import 'modules/search_screen/bloc/cubit.dart';
import 'modules/Register_Screens/welcome_screen/welcome_screen.dart';
import 'package:ecommerce/layout/Bloc/cubit.dart';
import 'package:ecommerce/layout/Bloc/states.dart';
import 'shared/Network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();

  await CacheHelper.init();

  bool IsDark = CacheHelper.getDate(key: 'IsDark');

  Widget RightScreen;
  //bool onBoarding =CacheHelper.getDate(key: 'onBoarding');
  //token =CacheHelper.getDate(key: 'token');
  print("onBoarding : ${onBoarding}");
  print("shoptoken : ${shoptoken}");

  BlocOverrides.runZoned(
    () {
      runApp(MyApp((IsDark != null) ? IsDark : false, RightScreen));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool IsDark;
  // bool onBoarding;
  final Widget RightScreen;
  MyApp(this.IsDark, this.RightScreen);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: ((context) => AppCubit()
              ..getHomeData()
              ..getFavoritesData()
              ..getSettings()
              ..getCartData()
              ..getCategoriesData()
              ..getCategoriesDetails()
              ..getContctUs)),
        BlocProvider(
            create: (BuildContext context) =>
                ThemeAppCubit()..ChangeAppMode(fromShared: IsDark)),
        BlocProvider(
          create: (context) => SearchCubit()..SearchProduct,
        ),
        BlocProvider(
          create: (context) => ProfileCubit()..getProfileData(),
        ),
      ],
      child: BlocConsumer<ThemeAppCubit, ThemeAppStates>(
        listener: (themecontext, state) {},
        builder: (themecontext, state) {
          return MaterialApp(
            theme: lightthemes..bottomNavigationBarTheme,
            darkTheme: darkthemes..bottomNavigationBarTheme,
            themeMode: ThemeAppCubit.get(themecontext).IsDark
                ? ThemeMode.dark
                : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            //home:RightScreen,
            home: SplashSCreen(),
          );
        },
      ),
    );
  }
}
