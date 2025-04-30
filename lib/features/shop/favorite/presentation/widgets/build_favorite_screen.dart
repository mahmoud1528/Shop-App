import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/features/shop/favorite/data/model/favorite_model.dart';

import '../../../../../core/layout/shop/controller/cubit.dart';

class BuildFavoriteScreen extends StatelessWidget {
  final FavoriteProductModel model;

  const BuildFavoriteScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey[300],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: model.image,
                    height: 150.0,
                    width: 150.0,
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
                          color: Colors.grey[300],
                          size: 100.0,
                        ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 150.0,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(
                            model.name,
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(color: Colors.black),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Text(
                                model.price.round().toString(),
                                style: Theme.of(context).textTheme.titleMedium!
                                    .copyWith(color: Colors.blue),
                              ),
                              SizedBox(width: 10.0),
                              if(model.discount != 0)
                              Text(
                                model.oldPrice.round().toString(),
                                style: Theme.of(
                                  context,
                                ).textTheme.bodySmall!.copyWith(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.red,
                                  decorationThickness: 2,
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  ShopLayoutCubit.get(
                                    context,
                                  ).changeFavorite(model.id);
                                },
                                icon: CircleAvatar(
                                  radius: 14.0,
                                  backgroundColor:
                                      ShopLayoutCubit.get(
                                                context,
                                              ).favorites[model.id] ==
                                              true
                                          ? Colors.blue
                                          : Colors.grey,
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                    size: 14.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
