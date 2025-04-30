import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/layout/shop/controller/cubit.dart';
import '../../model/product_details_model.dart';

class BuildProductDetails extends StatelessWidget {
  final ProductDetailsModelData model;
  const BuildProductDetails({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                CarouselSlider(
                  items:
                  model.images
                      .map(
                        (e) => ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: CachedNetworkImage(
                        imageUrl: e,
                        fit: BoxFit.fill,
                        width: double.infinity,
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
                    viewportFraction: 1.1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: false,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      ShopLayoutCubit.get(context).changeSmoothIndicator(index);
                    },
                  ),
                ),
                AnimatedSmoothIndicator(
                  activeIndex:  ShopLayoutCubit.get(context).current,
                  count:  ShopLayoutCubit.get(context).productDetailsModel!.data!.images.length,
                  effect: const JumpingDotEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      jumpScale: .7,
                      verticalOffset: 20,
                      activeDotColor: Colors.indigo,
                      dotColor: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Text(
                  model.price.round().toString(),
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(color: Colors.blue),
                ),
                Spacer(),
                if (model.discount != 0)
                  Text(
                    model.oldPrice.round().toString(),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.red,
                      decorationThickness: 4.0,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 20,),
            Divider(color: Colors.grey,height: 1.0,thickness: 2.0,),
            SizedBox(height: 20,),
            Text(
              model.name,
              style: Theme.of(context).textTheme.titleLarge,),
            SizedBox(height: 20,),
            Text(
              model.description,
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleMedium,),
          ],
        ),
      ),
    );
  }
}
