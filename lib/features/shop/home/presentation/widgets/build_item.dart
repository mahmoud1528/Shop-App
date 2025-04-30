import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/core/layout/shop/controller/cubit.dart';
import 'package:shop_app/features/shop/home/data/model/category_home_model.dart';
import 'package:shop_app/features/shop/home/presentation/widgets/build_product_item.dart';

import '../../data/model/shop_home_model.dart';
import 'build_category_home.dart';

class BuildItem extends StatelessWidget {
  final ShopHomeModel model;

  const BuildItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items:
                model.data!.banners
                    .map(
                      (ele) => ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                          imageUrl: ele.image,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder:
                              (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor: Colors.white,
                                child: Container(color: Colors.black),
                              ),
                          errorWidget:
                              (context, url, error) => Icon(
                                Icons.error_outline,
                                size: 100.0,
                                color: Colors.grey[300],
                              ),
                        ),
                      ),
                    )
                    .toList(),
            options: CarouselOptions(
              height: 250,
              viewportFraction: 1.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: 30),
                SizedBox(
                  height: 150,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder:
                        (context, index) => BuildCategoryHome(
                          model:
                              ShopLayoutCubit.get(
                                context,
                              ).categoryHomeModel!.data.data[index],
                        ),
                    separatorBuilder: (context, index) => SizedBox(width: 20.0),
                    itemCount:
                        ShopLayoutCubit.get(
                          context,
                        ).categoryHomeModel!.data.data.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'New Products',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
          ),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
            childAspectRatio: 1 / 1.5,
            children: List.generate(
              model.data!.products.length,
              (index) => BuildProductItem(
                model: ShopLayoutCubit.get(context).shopHomeModel!.data!.products[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}