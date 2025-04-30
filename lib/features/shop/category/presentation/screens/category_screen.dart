import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/layout/shop/controller/cubit.dart';
import 'package:shop_app/core/layout/shop/controller/state.dart';
import 'package:shop_app/core/shared/theme/controller/cubit.dart';
import 'package:shop_app/features/shop/home/data/model/category_home_model.dart';

import '../widgets/build_category_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopLayoutCubit.get(context);
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder:
              (context, index) =>
              BuildCategoryScreen(
                model: cubit.categoryHomeModel!.data.data[index],
              ),
          itemCount: cubit.categoryHomeModel!.data.data.length,
        );
      },
    );
  }
}