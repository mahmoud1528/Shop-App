import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/core/layout/shop/controller/cubit.dart';
import 'package:shop_app/core/layout/shop/shop_layout.dart';
import 'package:shop_app/features/shop/products_details/model/product_details_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/layout/shop/controller/state.dart';
import '../widgets/build_product_details.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int id;

  const ProductDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLayoutCubit()..productsDetails(id),
      child: BlocConsumer<ShopLayoutCubit, ShopLayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopLayoutCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
            ),
            body: ConditionalBuilder(
              condition: cubit.productDetailsModel != null,
              builder:
                  (context) => BuildProductDetails(
                    model: cubit.productDetailsModel!.data!,
                  ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}
