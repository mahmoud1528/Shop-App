import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/layout/shop/controller/cubit.dart';
import 'package:shop_app/core/layout/shop/controller/state.dart';
import 'package:shop_app/core/shared/network/local/cache_helper.dart';
import 'package:shop_app/core/shared/theme/controller/cubit.dart';
import 'package:shop_app/main.dart';
import '../../shared/const/constance.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopLayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
              style: Theme.of(context).textTheme.titleLarge,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  cubit.changeLanguage();
                  CacheHelper.setData(key: 'language', value: language).then((
                    value,
                  ) {
                    if (context.mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => MyApp(
                                isDark: ThemeModeCubit.get(context).isDark,
                                startWidget: ShopLayout(),
                              ),
                        ),
                      );
                    }
                  });
                },
                icon: CircleAvatar(
                  radius: 16.0,
                  backgroundColor: Colors.grey,
                  child: CircleAvatar(
                    radius: 15.0,
                    backgroundColor: Colors.white,
                    child: Text(
                      language.toUpperCase(),
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  ThemeModeCubit.get(context).changeThemeMode();
                },
                icon: Icon(Icons.brightness_4_outlined),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.items,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
