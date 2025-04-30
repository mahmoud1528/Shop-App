import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/core/layout/shop/controller/cubit.dart';
import 'package:shop_app/core/layout/shop/controller/state.dart';
import 'package:shop_app/features/shop/favorite/presentation/widgets/build_favorite_screen.dart';
import '../../../../../core/shared/theme/controller/cubit.dart';
import '../../../../../core/shared/widgets/shop_widgets/toast_state.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutState>(
      listener: (context, state) {
        if (state is ShopChangeFavoriteSuccessState) {
          if (state.changeFavoriteModel.status) {
            showToast(
              msg: state.changeFavoriteModel.message,
              state: ToastStates.success,
            );
          }else{
            showToast(
              msg: state.changeFavoriteModel.message,
              state: ToastStates.error,
            );
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopLayoutCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.favoriteModel != null,
          builder:
              (context) => ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder:
                    (context, index) => BuildFavoriteScreen(
                      model: cubit.favoriteModel!.data!.data[index].product,
                    ),
                itemCount: cubit.favoriteModel!.data!.data.length,
              ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
