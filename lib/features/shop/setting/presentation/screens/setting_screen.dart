import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/layout/shop/controller/cubit.dart';
import 'package:shop_app/core/shared/widgets/myformfield.dart';

import '../../../../../core/layout/shop/controller/state.dart';
import '../widgets/build_setting_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLayoutCubit()..getProfile(),
      child: BlocConsumer<ShopLayoutCubit, ShopLayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopLayoutCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.profileModel != null,
            builder: (context) => BuildSettingScreen(model: cubit.profileModel!.data!,),
            fallback: (context) => const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
